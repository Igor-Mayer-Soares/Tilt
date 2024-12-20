/***********************************************
 * Sao Jose dos Campos - SP - Brasil
 *
 * Igor Mayer Soares
 *
 * Guidance, Navigation and Control
 ************************************************/

/***********************************************
 * INCLUDES
 ************************************************/
#include <stdio.h>
#include "gnc.h"

/***********************************************
 * LOCAL VARIABLES
************************************************/

static float32_t const GNC_UPDATETIME = 0.0025f;

/***********************************************
 * GLOBAL FUNCTIONS
 ************************************************/

void GNC_Init(GNC_State_t *pGncState, GNC_Output_t *pGncOutput)
{
    pGncState->pApState.PIDposZ.gainDerivative = 0.0f;
    pGncState->pApState.PIDposZ.gainIntegral = 0.0f;
    pGncState->pApState.PIDposZ.gainProportional = 1.0f;
    pGncState->pApState.PIDposZ.filterInit = 0.0f;
    pGncState->pApState.PIDposZ.filterN = 0.0f;
    pGncState->pApState.PIDposZ.integratorInit = 0.0f;
    pGncState->pApState.PIDposZ.integratorLimitLower = -5.0f;
    pGncState->pApState.PIDposZ.integratorLimitUpper = 5.0f;
    pGncState->pApState.PIDposZ.outputLimitLower = -2.5f;
    pGncState->pApState.PIDposZ.outputLimitUpper = 2.5f;
    pGncState->pApState.PIDposZ.DT = GNC_UPDATETIME;
    pGncState->pApState.PIDposZ.kp = 0.0f;
    pGncState->pApState.PIDposZ.ki = 0.0f;
    pGncState->pApState.PIDposZ.kd = 0.0f;
    pGncState->pApState.PIDposZ.integratorState = 0.0f;
    pGncState->pApState.PIDposZ.filterState = 0.0f;
    pGncState->pApState.PIDposZ.antiWindUpCheck1 = FALSE;
    pGncState->pApState.PIDposZ.antiWindUpCheck2 = FALSE;

    /* Altitude Controller - Medium Loop */
    pGncState->pApState.PIDvelZ.gainDerivative = 0.0f;
    pGncState->pApState.PIDvelZ.gainIntegral = 0.0f;
    pGncState->pApState.PIDvelZ.gainProportional = 1.0f;
    pGncState->pApState.PIDvelZ.filterInit = 0.0f;
    pGncState->pApState.PIDvelZ.filterN = 0.0f;
    pGncState->pApState.PIDvelZ.integratorInit = 0.0f;
    pGncState->pApState.PIDvelZ.integratorLimitLower = -10.0f;
    pGncState->pApState.PIDvelZ.integratorLimitUpper = 10.0f;
    pGncState->pApState.PIDvelZ.outputLimitLower = -50.0f;
    pGncState->pApState.PIDvelZ.outputLimitUpper = 50.0f;
    pGncState->pApState.PIDvelZ.DT = GNC_UPDATETIME;
    pGncState->pApState.PIDvelZ.kp = 0.0f;
    pGncState->pApState.PIDvelZ.ki = 0.0f;
    pGncState->pApState.PIDvelZ.kd = 0.0f;
    pGncState->pApState.PIDvelZ.integratorState = 0.0f;
    pGncState->pApState.PIDvelZ.filterState = 0.0f;
    pGncState->pApState.PIDvelZ.antiWindUpCheck1 = FALSE;
    pGncState->pApState.PIDvelZ.antiWindUpCheck2 = FALSE;

    /* Altitude Controller - Internal Loop */
    pGncState->pApState.PIDaccZ.gainDerivative = 0.0f;
    pGncState->pApState.PIDaccZ.gainIntegral = 0.0f;
    pGncState->pApState.PIDaccZ.gainProportional = 1.0f;
    pGncState->pApState.PIDaccZ.filterInit = 0.0f;
    pGncState->pApState.PIDaccZ.filterN = 0.0f;
    pGncState->pApState.PIDaccZ.integratorInit = 0.0f;
    pGncState->pApState.PIDaccZ.integratorLimitLower = -2.0f;
    pGncState->pApState.PIDaccZ.integratorLimitUpper = 2.0f;
    pGncState->pApState.PIDaccZ.outputLimitLower = 0.0f;
    pGncState->pApState.PIDaccZ.outputLimitUpper = 1.0f;
    pGncState->pApState.PIDaccZ.DT = GNC_UPDATETIME;
    pGncState->pApState.PIDaccZ.kp = 0.0f;
    pGncState->pApState.PIDaccZ.ki = 0.0f;
    pGncState->pApState.PIDaccZ.kd = 0.0f;
    pGncState->pApState.PIDaccZ.integratorState = 0.0f;
    pGncState->pApState.PIDaccZ.filterState = 0.0f;
    pGncState->pApState.PIDaccZ.antiWindUpCheck1 = FALSE;
    pGncState->pApState.PIDaccZ.antiWindUpCheck2 = FALSE;

    AP_Init(&pGncState->pApState);

    pGncOutput->aileron = 0.0f;
    pGncOutput->elevator = 0.0f;
    pGncOutput->rudder = 0.0f;
    pGncOutput->thr1 = 0.0f;
    pGncOutput->thr2 = 0.0f;
    pGncOutput->thr3 = 0.0f;
    pGncOutput->thr4 = 0.0f;
    pGncOutput->lambda1 = 0.0f;
    pGncOutput->lambda2 = 0.0f;
}

GNC_Status_t GNC_Update(GNC_Input_t const *pGncInput, GNC_State_t *pGncState, GNC_Output_t *pGncOutput)
{
    AP_Input_t apInput;
    AP_Output_t apOutput;

    apInput.Target_H = pGncInput->Target_H;

    if (0 != GNC_Vector_Init(&pGncInput->ribi.x, &pGncInput->ribi.y, &pGncInput->ribi.z,
                             &apInput.ribi))
    {
        pGncState->status = GNC_MATHERROR;
    }

    if (GNC_NOERROR == pGncState->status)
    {
        if (0 != GNC_Vector_Init(&pGncInput->vibi.x, &pGncInput->vibi.y, &pGncInput->vibi.z,
                                 &apInput.vibi))
        {
            pGncState->status = GNC_MATHERROR;
        }
    }

    if (GNC_NOERROR == pGncState->status)
    {
        if (0 != GNC_Vector_Init(&pGncInput->aibi.x, &pGncInput->aibi.y, &pGncInput->aibi.z,
                                 &apInput.aibi))
        {
            pGncState->status = GNC_MATHERROR;
        }
    }

    pGncState->status = AP_Update(&apInput,&pGncState->pApState,&apOutput);

    if (GNC_NOERROR == pGncState->status)
    {
        pGncOutput->thr1 = apOutput.thr1;
        pGncOutput->thr2 = apOutput.thr2;
        pGncOutput->thr3 = apOutput.thr3;
        pGncOutput->thr4 = apOutput.thr4;
    }

    pGncState->count_time = pGncState->count_time + 1;
    pGncState->gncTime = pGncState->count_time * GNC_UPDATETIME;

    return pGncState->status;
}

int main() 
{
    printf("Hello, World!\n"); // Imprime "Hello, World!" na tela
    
    GNC_Status_t status = GNC_NOERROR;

    GNC_State_t gncState;
    GNC_Output_t gncOutput;
    GNC_Input_t gncInput;

    gncInput.ribi.x = 0.0f;
    gncInput.ribi.y = 0.0f;
    gncInput.ribi.z = 0.0f;
    gncInput.aibi.x = 0.0f;
    gncInput.aibi.y = 0.0f;
    gncInput.aibi.z = 0.0f;
    gncInput.vibi.x = 0.0f;
    gncInput.vibi.y = 0.0f;
    gncInput.vibi.z = 0.0f;
    gncInput.Target_H = 30.0f;

    GNC_Init(&gncState,&gncOutput);

    status = GNC_Update(&gncInput,&gncState,&gncOutput);

    printf("T %f\n",gncOutput.thr1);
    printf("status %u\n",status);
    
    return 0; // Indica que o programa foi executado com sucesso
}