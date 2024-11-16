/***********************************************
 * São José dos Campos - SP - Brasil
 * 
 * Igor Mayer Soares
 * 
 * Motor Mixing Algorithm
************************************************/

/***********************************************
 * INCLUDES
************************************************/
#ifndef MMA_H
#define MMA_H

#include <math.h>
#include "../Libraries/rtwtypes.h"
#include "../Libraries/gnc.h"

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

typedef struct
{
    real32_T T; /* Command to Hover [%/100] */
    real32_T R; /* Command to Roll  [%/100] */
    real32_T P; /* Command to Pitch [%/100] */
    real32_T Y; /* Command to Yaw   [%/100] */    
} MMA_input;

typedef struct
{
    real32_T thr1; /* Command to Motor 1 [0-1] */ 
    real32_T thr2; /* Command to Motor 2 [0-1] */
    real32_T thr3; /* Command to Motor 3 [0-1] */
    real32_T thr4; /* Command to Motor 4 [0-1] */  
} MMA_output;

/***********************************************
 * FUNCTIONS
************************************************/

/** @brief
 * This function computes the throttle output for
 * each motor based on commands for Hover, Roll,
 * Pitch or Yaw
 */
GNC_status MMA_Update(MMA_input const *pMMAInput, MMA_output *pMMAOutput);

#endif /* ifndef MMA.h*/