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
#ifndef GNC_H
#define GNC_H

#include "atp.h"

#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * STRUCTURES
************************************************/

typedef struct 
{
    Vector3f ribi;
    Vector3f vibi;
    Vector3f aibi;
    float32_t Target_H;
} GNC_Input_t;

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
} GNC_Output_t;

typedef struct
{
    AP_State_t pApState;
    GNC_Status_t status;
    int32_t count_time;
    float32_t gncTime;
} GNC_State_t;

/***********************************************
 * LOCAL FUNCTIONS
************************************************/

/***********************************************
 * GLOBAL FUNCTIONS
************************************************/

void GNC_Init(GNC_State_t *pGncStates, GNC_Output_t *pGncOutput);

GNC_Status_t GNC_Update(GNC_Input_t const *pGncInput, GNC_State_t *pGncState, GNC_Output_t *pGncOutput);

#ifdef __cplusplus
}
#endif

#endif
