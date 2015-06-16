#ifndef __MPC_CONFIG_H
#define __MPC_CONFIG_H

#define spim 1
#define nasm 2


#ifndef GEN_ASSEMBLER
    #define GEN_ASSEMBLER_EXT "" 
    #error Your GEN_ASSEMBLER is undefined.
    #error Please check your Makefile or compiler option is correct.
#else

    #ifdef GEN_ASSEMBLER_EXT 
        #undef GEN_ASSEMBLER_EXT
    #endif


    #if (GEN_ASSEMBLER + 0) == spim
        #define GEN_ASSEMBLER_EXT "spim"
    #elif (GEN_ASSEMBLER + 0) == nasm
        #define GEN_ASSEMBLER_EXT "asm"
    #else
        #define GEN_ASSEMBLER_EXT "" 
        #error Your GEN_ASSEMBLER is unkown.
        #error Please check your Makefile or compiler option is correct.
    #endif
#endif

#endif
