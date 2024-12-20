/***********************************************
 * Sao Jose dos Campos - SP - Brasil
 * 
 * Igor Mayer Soares
 * 
 * Guidance, Navigation and Control Commons
************************************************/

/***********************************************
 * INCLUDES
************************************************/
#ifndef GNC_COMMON_H
#define GNC_COMMON_H

#include <math.h>
#include "math_utils.h"
#include "types.h"

#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * STRUCTURES
************************************************/

typedef enum
{
    GNC_NOERROR,
    GNC_MATHERROR,
    GNC_INPUTERROR,
    GNC_TRANSITIONERROR
} GNC_Status_t;

#ifdef __cplusplus
}
#endif

#endif