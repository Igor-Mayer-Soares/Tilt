#ifndef TYPES_H
#define TYPES_H

#include <stdint.h> 
#include <stdbool.h>

typedef float float32_t; 
typedef double float64_t;

typedef int8_t int8;   
typedef int16_t int16; 
typedef int32_t int32; 
typedef int64_t int64; 

typedef uint8_t uint8;   
typedef uint16_t uint16; 
typedef uint32_t uint32; 
typedef uint64_t uint64; 

typedef bool bool_t;

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define SUCCESS 0
#define ERROR   -1

#define PI 3.14159265358979323846f
#define TWO_PI (2.0f * PI)

#define DEG_TO_RAD(deg) ((deg) * (PI / 180.0f))
#define RAD_TO_DEG(rad) ((rad) * (180.0f / PI))

#define EPSILON 1e-6f

#endif 