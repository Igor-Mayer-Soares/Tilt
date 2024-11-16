
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
#include "MMA.h"

/***********************************************
 * LOCAL VARIABLES
************************************************/

/***********************************************
 * STRUCTURES
************************************************/

/***********************************************
 * FUNCTIONS
************************************************/

GNC_status MMA_Update(MMA_input const *pMMAInput, MMA_output *pMMAOutput)
{
    pMMAOutput->thr1 = pMMAInput->T - pMMAInput->R + pMMAInput->P - pMMAInput->Y;
    if (pMMAOutput->thr1 > 1.0f)
    {
        pMMAOutput->thr1 = 1.0f;
    }
    else if (pMMAOutput->thr1 < 0.0f)
    {
        pMMAOutput->thr1 = 0.0f;
    }

    pMMAOutput->thr2 = pMMAInput->T + pMMAInput->R + pMMAInput->P + pMMAInput->Y;
    if (pMMAOutput->thr2 > 1.0f)
    {
        pMMAOutput->thr2 = 1.0f;
    }
    else if (pMMAOutput->thr2 < 0.0f)
    {
        pMMAOutput->thr2 = 0.0f;
    }

    pMMAOutput->thr3 = pMMAInput->T + pMMAInput->R - pMMAInput->P - pMMAInput->Y;
    if (pMMAOutput->thr3 > 1.0f)
    {
        pMMAOutput->thr3 = 1.0f;
    }
    else if (pMMAOutput->thr3 < 0.0f)
    {
        pMMAOutput->thr3 = 0.0f;
    }

    pMMAOutput->thr4 = pMMAInput->T - pMMAInput->R - pMMAInput->P + pMMAInput->Y;
    if (pMMAOutput->thr4 > 1.0f)
    {
        pMMAOutput->thr4 = 1.0f;
    }
    else if (pMMAOutput->thr4 < 0.0f)
    {
        pMMAOutput->thr4 = 0.0f;
    }    
} 




