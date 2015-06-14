#ifndef __MPC_CONFIG_H
#define __MPC_CONFIG_H

#define spim 1
#define nasm 2


#ifndef GEN_ASSEMBLER
    #define GEN_ASSEMBLER spim
#endif


#ifdef GEN_ASSEMBLER_EXT 
    #undef GEN_ASSEMBLER_EXT
#endif

#if GEN_ASSEMBLER == spim
    #define GEN_ASSEMBLER_EXT "spim"
#elif GEN_ASSEMBLER == nasm
    #define GEN_ASSEMBLER_EXT "asm"
#endif

#endif
