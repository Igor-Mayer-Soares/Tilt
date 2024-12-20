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
#ifndef PID_H
#define PID_H

#include <math.h>
#include "math_utils.h"
#include "types.h"
#include "gnc_common.h"

#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/
typedef struct
{
    float32_t trackingError;
    float32_t DT;
    float32_t kp;
    float32_t ki;
    float32_t kd;
    float32_t filterState;
    float32_t integratorState;
    int32_t errorStatus;
    float32_t cmd;
} PID_toTelemetryOutput;

typedef struct
{
    float32_t gainDerivative;
    float32_t gainIntegral;
    float32_t gainProportional;
    float32_t filterInit;
    float32_t filterN;
    float32_t integratorInit;
    float32_t integratorLimitLower;
    float32_t integratorLimitUpper;
    float32_t outputLimitLower;
    float32_t outputLimitUpper;
    float32_t DT;
} PID_Input_t;

typedef struct
{
    float32_t kp;
    float32_t ki;
    float32_t kd;
    float32_t integratorState;
    float32_t filterState;
    bool_t    antiWindUpCheck1;
    bool_t    antiWindUpCheck2;
    float32_t gainDerivative;
    float32_t gainIntegral;
    float32_t gainProportional;
    float32_t filterN;
    float32_t filterInit;
    float32_t integratorInit;
    float32_t integratorLimitLower;
    float32_t integratorLimitUpper;
    float32_t outputLimitLower;
    float32_t outputLimitUpper;
    float32_t DT;
} PID_State_t;

/***********************************************
 * LOCAL FUNCTIONS
************************************************/

void PID_reset(PID_State_t *pPidState);

/***********************************************
 * GLOBAL FUNCTIONS
************************************************/

/**
 * @brief PID Update
 * @param trackingError Tracking error
 * @param telem Telemetry structure
 * @param reset Reset flag
 * @param cmd Command output
 * @return 0 if no error, 1 otherwise
*/ 
GNC_Status_t PID_Update(float32_t const *trackingError,
                        PID_toTelemetryOutput *telem, bool_t reset,
                        PID_State_t *pPidState, float32_t *cmd);

#ifdef __cplusplus
}
#endif

#endif
