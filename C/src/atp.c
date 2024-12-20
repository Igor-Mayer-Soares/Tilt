/***********************************************
 * Sao Jose dos Campos - SP - Brasil
 * 
 * Igor Mayer Soares
 * 
 * Control Algorithms
************************************************/

/***********************************************
 * INCLUDES
************************************************/
#include "atp.h"

/***********************************************
 * LOCAL VARIABLES
************************************************/

/* Position Controller*/

static float32_t _posz_c;
static float32_t _posz_m;
static float32_t _posz_e;
static float32_t _velz_c;
static float32_t _velz_m;
static float32_t _velz_e;
static float32_t _accz_c;
static float32_t _accz_m;
static float32_t _accz_e;

static float32_t _T;

/***********************************************
 * GLOBAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

/***********************************************
 * LOCAL FUNCTIONS
************************************************/

GNC_Status_t AP_posZ(float32_t const *posz_c, float32_t const *ribi_z, float32_t const *vibi_z, float32_t const *aibi_z, 
                     AP_State_t *pApState, AP_toTelemetryOutput *telem, bool_t *reset, float32_t *cmd)
{
    GNC_Status_t status = GNC_NOERROR;

    *cmd = 0.0;

    /* Inputs */
    _posz_c = *posz_c;
    _posz_m = -*ribi_z;
    _velz_m = -*vibi_z;
    _accz_m = -*aibi_z;

    /* External Loop - Position Update */
    _posz_e = _posz_c - _posz_m;

    status = PID_Update(&_posz_e, 
                        &telem->pPosZ_PID, reset,
                        &pApState->PIDposZ,&_velz_c);

    /* Middle Loop - Velocity Update */
    _velz_e = _velz_c - _velz_m;

    if (GNC_NOERROR == status)
    {
        status = PID_Update(&_velz_e,
                            &telem->pVelZ_PID, reset,
                            &pApState->PIDvelZ,&_accz_c);
    }

    /* Internal Loop - Acceleration Update */
    _accz_e = _accz_c - _accz_m;

    if (GNC_NOERROR == status)
    {
        status = PID_Update(&_accz_e,
                            &telem->pAccZ_PID, reset,
                            &pApState->PIDaccZ,cmd);
    }
    
    /* Limit Output */
    if (GNC_NOERROR == status)
    {
        status = GNC_Saturate(EPSILON, 1.0f, cmd);
    }
    
    /* Telemetry */
    telem->posz_c = _posz_c;
    telem->posz_m = _posz_m;
    telem->posz_e = _posz_e;
    telem->velz_c = _velz_c;
    telem->velz_m = _velz_m;
    telem->velz_e = _velz_e;
    telem->accz_c = _accz_c;
    telem->accz_m = _accz_m;
    telem->accz_e = _accz_e;

    return status;
}

/***********************************************
 * GLOBAL FUNCTIONS
************************************************/

void AP_Init(AP_State_t *pApState)
{
    _posz_c = 0.0f;
    _posz_m = 0.0f;
    _posz_e = 0.0f;
    _velz_c = 0.0f;
    _velz_m = 0.0f;
    _velz_e = 0.0f;
    _accz_c = 0.0f;
    _accz_m = 0.0f;
    _accz_e = 0.0f;
}

GNC_Status_t AP_Update(AP_Input_t const *pApInput,AP_State_t *pApState,AP_Output_t *pApOutput)
{
    GNC_Status_t status = GNC_NOERROR;

    _posz_c = pApInput->Target_H;
    _posz_m = -pApInput->ribi.z;
    _velz_m = -pApInput->vibi.z;
    _accz_m = -pApInput->aibi.z;

    status = AP_posZ(&_posz_c, &_posz_m, &_velz_m, &_accz_m, 
                     pApState,&pApOutput->telem, FALSE, &_T);

    pApOutput->aileron = 0.0f;
    pApOutput->elevator = 0.0f;
    pApOutput->rudder = 0.0f;
    pApOutput->thr1 = _T;
    pApOutput->thr2 = _T;
    pApOutput->thr3 = _T;
    pApOutput->thr4 = _T;
    pApOutput->lambda1 = 0.0f;
    pApOutput->lambda2 = 0.0f;

    return status;
}

