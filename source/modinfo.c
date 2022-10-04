
#include <stdint.h>
#include <ppu-lv2.h>
#include "opd.h"
//#include <sys/prx.h>

#define LIBRARY_NAME "empty_prx"

#define MODULE_NAME_MAX_LEN 27

typedef struct sceModuleInfo_common { // size is 0x20
  unsigned short modattr;
  unsigned char modver[2];
  char modname[MODULE_NAME_MAX_LEN];
  unsigned char infover;
} sceModuleInfo_common;

typedef struct sceModuleInfo_v0 { // size is 0x34
  sceModuleInfo_common c;
  void *gp_value;
  void *libent_top;
  void *libent_btm;
  void *libstub_top;
  void *libstub_btm;
} sceModuleInfo_v0;

static const int __begin_of_section_lib_ent[1]                             
       __attribute__((aligned(4),section(".lib.ent.top"),unused)) = {0};   
static const int __end_of_section_lib_ent[1]                               
       __attribute__((aligned(4),section(".lib.ent.btm"),unused)) = {0};   


static const int __begin_of_section_lib_stub[1]                            
       __attribute__((aligned(4),section(".lib.stub.top"),unused)) = {0};  
static const int __end_of_section_lib_stub[1]                              
       __attribute__((aligned(4),section(".lib.stub.btm"),unused)) = {0};


const uint8_t bss_stub_data[256] __attribute__((section(".bss")));
       

static const const sceModuleInfo_v0 modInfo __attribute__((aligned(0),section(".rodata.sceModuleInfo.modInfo#"))) = {
    {0, {0, 1}, LIBRARY_NAME, 0}, (void *)(&bss_stub_data), (void *)(&__begin_of_section_lib_ent + 1), (void *)(&__end_of_section_lib_ent),  (void *)(&__begin_of_section_lib_stub + 1), (void *)(&__end_of_section_lib_stub)
};