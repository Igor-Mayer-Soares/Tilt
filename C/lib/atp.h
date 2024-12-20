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
#ifndef ATP_H
#define ATP_H

#include "pid.h"
#include "stdio.h"

#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * GLOBAL VARIABLES
************************************************/

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

typedef struct
{
    Vector3f ribi;
    Vector3f vibi;
    Vector3f aibi;
    float32_t Target_H;
} AP_Input_t;

typedef struct
{
    float32_t posz_c;
    float32_t posz_m;
    float32_t posz_e;
    float32_t velz_c;
    float32_t velz_m;
    float32_t velz_e;
    float32_t accz_c;
    float32_t accz_m;
    float32_t accz_e;
    PID_toTelemetryOutput pPosZ_PID;
    PID_toTelemetryOutput pVelZ_PID;
    PID_toTelemetryOutput pAccZ_PID;
} AP_toTelemetryOutput;

typedef struct
{
    float32_t aileron;
    float32_t elevator;
    float32_t rudder;
    float32_t thr1;
    float32_t thr2;
    float32_t thr3;
    float32_t thr4;
    float32_t lambda1;
    float32_t lambda2;
    AP_toTelemetryOutput telem;
} AP_Output_t;

typedef struct
{
    /* Altitude Controller - External Loop */
    PID_State_t PIDposZ;

    /* Altitude Controller - Medium Loop */
    PID_State_t PIDvelZ;

    /* Altitude Controller - Internal Loop */
    PID_State_t PIDaccZ;

} AP_State_t;

/***********************************************
 * LOCAL FUNCTIONS
************************************************/

GNC_Status_t AP_posZ(float32_t const *posz_c, float32_t const *ribi_z, float32_t const *vibi_z, float32_t const *aibi_z, 
                     AP_State_t *pApState, AP_toTelemetryOutput *telem, bool_t *reset, float32_t *cmd);

/***********************************************
 * GLOBAL FUNCTIONS
************************************************/

void AP_Init(AP_State_t *pApState);

GNC_Status_t AP_Update(AP_Input_t const *pApInput,AP_State_t *pApState,AP_Output_t *pApOutput);

#ifdef __cplusplus
}
#endif

#endif