.section ".opd.zz"
.global test_entry_func_opd
test_entry_func_opd:
.long test_entry_func
.long __toc_location
.global test_entry_stop_opd
test_entry_stop_opd:
.long test_entry_stop
.long __toc_location


.section ".rodata.sceResident"
.global _nidTable
_nidTable:
.long 0xbc9a0086 
.long 0xab779874 

.global __exportEntryTable
__exportEntryTable:
.long test_entry_func_opd
.long test_entry_stop_opd


.section ".lib.ent"
.align 0
.long 0x0
.long _nidTable
.long __exportEntryTable
