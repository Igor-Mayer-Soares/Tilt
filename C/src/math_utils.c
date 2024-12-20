/***********************************************
 * Sao Jose dos Campos - SP - Brasil
 * 
 * Igor Mayer Soares
 * 
 * Mission Definition
************************************************/

/***********************************************
 * INCLUDES
************************************************/
#include "math_utils.h"

#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

/***********************************************
 * FUNCTIONS
************************************************/

int32_t GNC_Saturate(float32_t min, float32_t max, float32_t *u)
{
    int32_t error = 0;

    if (u == NULL) {
        error = 1;
    }
    else if (min > max) {
        error = 1;
    }
    else
    {
        if (*u < min && error < 1) 
        {
            *u = min;
        } 
        else if (*u > max && error < 1) 
        {
            *u = max;
        }
    }

    return error;
}

int32_t GNC_CheckSign(float32_t const *x, bool_t *isPositive)
{
    int32_t error = 0;
    
    if (x == NULL) {
        error = 1;
    }

    if ((*x < -1.0e6f) || (*x > 1.0e6f)) {
        error = 1;
    }

    if (*x > 0.0f) 
    {
        *isPositive = TRUE;
    } 
    else
    {
        *isPositive = FALSE;
    }

    return error;
}

int32_t GNC_Vector_Init(const float32_t *x, const float32_t *y, const float32_t *z, Vector3f *vec)
{
    int32_t error = 0;

    if (vec == NULL) {
        error = 1;
    }

    if (x == NULL || y == NULL || z == NULL) {
        error = 1;
    }

    vec->x = *x;
    vec->y = *y;
    vec->z = *z;

    return error;
}

