/***********************************************
 * Sao Jose dos Campos - SP - Brasil
 * 
 * Igor Mayer Soares
 * 
 * PID Library
************************************************/

/***********************************************
 * INCLUDES
************************************************/
#include "pid.h"

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

/***********************************************
 * LOCAL FUNCTIONS
************************************************/

void PID_reset(PID_State_t *pPidState)
{
    pPidState->kp = 0.0f;
    pPidState->ki = 0.0f;
    pPidState->kd = 0.0f;
    pPidState->integratorState = 0.0f;
    pPidState->filterState = 0.0f;
    pPidState->antiWindUpCheck1 = FALSE;
    pPidState->antiWindUpCheck2 = FALSE;
}

/***********************************************
 * GLOBAL FUNCTIONS
************************************************/

GNC_Status_t PID_Update(float32_t const *trackingError,
                        PID_toTelemetryOutput *telem, bool_t reset,
                        PID_State_t *pPidState, float32_t *cmd)
{
    GNC_Status_t status = GNC_NOERROR;
    bool_t trackingErrorIsPositive = FALSE;
    bool_t cmdIsPositive = FALSE;

    *cmd = 0.0f;

    if (reset)
    {
        PID_reset(pPidState);
    }

    /* Proportional */
    pPidState->kp = pPidState->gainProportional * *trackingError;

    /* Derivative */
    pPidState->kd = (pPidState->gainDerivative * *trackingError - pPidState->filterState) * pPidState->filterN;

    /* Integrator */
    pPidState->ki = pPidState->integratorState;

    /* Output */
    *cmd = pPidState->kp + pPidState->ki + pPidState->kd; 

    /*Anti-Windup checks */
    if (*cmd > pPidState->outputLimitUpper || *cmd < pPidState->outputLimitUpper)
    {
        pPidState->antiWindUpCheck1 = TRUE;
    }
    else
    {
        pPidState->antiWindUpCheck1 = FALSE;
    }

    if (0 != GNC_CheckSign(trackingError,&trackingErrorIsPositive))
    {
        status = GNC_MATHERROR;
    }

    if (GNC_NOERROR == status)
    {
        if (0 != GNC_CheckSign(cmd,&cmdIsPositive))
        {
            status = GNC_MATHERROR;
        }
    }
        
    pPidState->antiWindUpCheck2 = (trackingErrorIsPositive == cmdIsPositive);

    if (GNC_NOERROR == status)
    {
        status = GNC_Saturate(pPidState->outputLimitLower,
                              pPidState->outputLimitUpper,
                              cmd);
    }
    
    /* To Telemetry Output at this step */
    telem->trackingError = *trackingError; 
    telem->DT = pPidState->DT; 
    telem->kp = pPidState->kp; 
    telem->ki = pPidState->ki; 
    telem->kd = pPidState->kd; 
    telem->filterState = pPidState->filterState; 
    telem->integratorState = pPidState->integratorState;
    telem->cmd = *cmd;

    /* Integrator */
    pPidState->ki = pPidState->gainIntegral * *trackingError;

    if (pPidState->antiWindUpCheck1 && pPidState->antiWindUpCheck2)
    {
        pPidState->integratorState = 0.0f; 
    }
    else
    {
        pPidState->integratorState = pPidState->integratorState + pPidState->ki;
    }

    /* Limit Integrator */
    if (GNC_NOERROR == status)
    {
        status = GNC_Saturate(pPidState->integratorLimitLower,
                              pPidState->integratorLimitUpper,
                              &pPidState->integratorState);
    }

    /* Update Filter State */
    pPidState->filterState = pPidState->filterState + (pPidState->kd * pPidState->DT); 

    /* To Telemetry Output at this step */
    telem->errorStatus = status;

    return status;
}