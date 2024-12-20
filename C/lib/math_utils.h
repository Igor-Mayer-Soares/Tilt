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
#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#include <math.h>
#include "types.h"


#ifdef __cplusplus
extern "C" {
#endif

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

typedef struct {
    float32_t x;  // Componente x do vetor
    float32_t y;  // Componente y do vetor
    float32_t z;  // Componente z do vetor
} Vector3f;

/***********************************************
 * FUNCTIONS
************************************************/
/**
 * @brief Saturate the input u
 * @param min Lower Limit
 * @param max Upper Limit
 * @param u Input
 * @return 0 if no error, 1 if error
*/
int32_t GNC_Saturate(float32_t min, float32_t max, float32_t *u);

int32_t GNC_CheckSign(float32_t const *x, bool_t *isPositive);

int32_t GNC_Vector_Init(const float32_t *x, const float32_t *y, const float32_t *z, Vector3f *vec);

#ifdef __cplusplus
}
#endif

#endif
