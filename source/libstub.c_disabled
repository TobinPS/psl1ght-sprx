
#include <stdio.h>
#include <stdint.h>

typedef struct _scelibstub_common { // size is 0xC
	unsigned short size;
	unsigned short version;
	unsigned short attribute;
	unsigned short nfunc;
	unsigned short nvar;
	unsigned short ntls;
} sceKernelLibraryStubTable_common;

typedef struct _scelibstub_2C { // size is 0x2C
	sceKernelLibraryStubTable_common c;
	unsigned char reserved[4];
	void *libname;
	void *func_nid_table;
	void *func_entry_table;
	void *var_nid_table;
	void *var_entry_table;
	void *tls_nid_table;
	void *tls_entry_table;
} sceKernelLibraryStubTable_2C;

static uint32_t sysPrxImportVersion[] __attribute__((section(".rodata.sceResident.importVersion#"),unused)) = {0};
static char sysPrxImportName[] __attribute__((section(".rodata.sceResident.importName#"))) = "sysPrxForUser";


static const uint32_t importNidTable[] __attribute__((aligned(4),section(".rodata.sceFNID"),unused)) = {
    0x9f04f7af
    //0xbc9a0086, //module_start,
    //0xab779874 //module_stop
};

void __attribute__((aligned(4),section(".sceStub.text.temp_export_stub"),unused))  temp_export_stub () {
    //return 1;
}


static const void* importEntryTable[] __attribute__((aligned(4),section(".data.sceFStub"),unused)) = {
    &temp_export_stub
    //0xbc9a0086, //module_start,
    //0xab779874 //module_stop
};


static const sceKernelLibraryStubTable_2C libstub_table                              
       __attribute__((aligned(4),section(".lib.stub"),unused)) = {
		{11264, 1, 9, 1, 0, 0}, {0,0,0,0}, &sysPrxImportName, &importNidTable, &importEntryTable, NULL, NULL
	   };

