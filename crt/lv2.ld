OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
OUTPUT_ARCH(powerpc:common)

PHDRS
{
	hdr_text	PT_LOAD 	FLAGS(0x01 | 0x04 | 0x400000);
	hdr_data	PT_LOAD		FLAGS(0x02 | 0x04 | 0x600000);
	hdr_rela	0x700000a4					FLAGS(0x00);
}

SECTIONS
{
	. = SIZEOF_HEADERS;
  	.rodata.sceModuleInfo : { 
		KEEP (*(.rodata.sceModuleInfo.*)) 
		*(SORT(.rodata.sceModuleInfo.*))
   	} : hdr_text
	.text           : {
		*(.text .stub .text.* .gnu.linkonce.t.*)
		KEEP (*(.text.*personality*))
		/* .gnu.warning sections are handled specially by elf32.em.  */
		*(.gnu.warning)
		*(.sfpr .glink)
	} : hdr_text
	.fini           : {
		KEEP (*(.fini))
	}
	.sceStub.text   : {
		*(.sceStub.text)
		*(SORT(.sceStub.text.*))
	}
	PROVIDE (__etext = .);
	PROVIDE (_etext = .);
	PROVIDE (etext = .);

	.eh_frame_hdr : { *(.eh_frame_hdr) }
	.eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) }
	.gcc_except_table   : ONLY_IF_RO { *(.gcc_except_table .gcc_except_table.*) }

	
	.rodata.sceResident : { KEEP (*(.rodata.sceResident.*)) } : hdr_text
	.rodata.sceFNID     : { KEEP (*(.rodata.sceFNID .rodata.sceFNID.*)) } : hdr_text
	.rodata.sceVNID     : { KEEP (*(.rodata.sceVNID .rodata.sceVNID.*)) } : hdr_text
	.rodata.sceTNID     : { KEEP (*(.rodata.sceTNID .rodata.sceTNID.*)) } : hdr_text
	.rodata.sceVStub    : { KEEP (*(.rodata.sceVStub)) KEEP (*(SORT(.rodata.sceVStub.*))) } : hdr_data



	
	.lib.ent.top : { KEEP (*(.lib.ent.top)) } : hdr_text
	PROVIDE (__libentstart = .);
	.lib.ent	 : {
		KEEP (*(.lib.ent)) 
	} : hdr_text
	PROVIDE (__libentend = .);
	.lib.ent.btm : { KEEP (*(.lib.ent.btm)) } : hdr_text
	

	
	.lib.stub.top : { KEEP (*(.lib.stub.top)) } : hdr_text
	PROVIDE (__libstubstart = .);
	.lib.stub	  : { KEEP (*(.lib.stub)) } : hdr_text
	PROVIDE (__libstubend = .);
	.lib.stub.btm : { KEEP (*(.lib.stub.btm)) } : hdr_text
	


	.data.sceFStub      : { KEEP (*(.data.sceFStub)) KEEP (*(SORT(.data.sceFStub.*))) } : hdr_data
	
	.toc1		  : ALIGN(8) { *(.toc1) } : hdr_text
	.opd		  : ALIGN(8) { KEEP (*(.opd.*)) } : hdr_data
	.branch_lt	  : ALIGN(8) { *(.branch_lt) } : hdr_data
	.got		  : ALIGN(8) { *(.got .toc) } : hdr_data
	.toc.sceStub  : { KEEP (*(.toc.sceStub)) KEEP (*(SORT(.toc.sceStub.*))) } : hdr_text
	
	/* Thread Local Storage sections  */
	.tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) } : hdr_data : hdr_tls
	.tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) } : hdr_data : hdr_tls
	
	.rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) } : hdr_text
	.rodata1        : { *(.rodata1) } : hdr_text

	.spu_image		: { *(.spu_image .spu_image.*) } : hdr_srodata

	.rela : {
	    KEEP (*(.rela.*))
  	} : hdr_rela


	.data           :
	{
		*(.data .data.* .gnu.linkonce.d.*)
		KEEP (*(.gnu.linkonce.d.*personality*))
		SORT(CONSTRUCTORS)
	} : hdr_data
	.data1          : { *(.data1) }

  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
	.sdata          : {
		*(.sdata .sdata.* .gnu.linkonce.s.*)
	}
	_edata = .;
	PROVIDE (edata = .);

	__bss_start = .;
	.tocbss	  : ALIGN(8) { *(.tocbss)}
	.sbss           :
	{
		PROVIDE (__sbss_start = .);
		PROVIDE (___sbss_start = .);
		*(.dynsbss)
		*(.sbss .sbss.* .gnu.linkonce.sb.*)
		*(.scommon)
		PROVIDE (__sbss_end = .);
		PROVIDE (___sbss_end = .);
	}
	.plt            : { *(.plt) }

	PROVIDE (__toc_location = .);
	.bss            :
	{
		*(.dynbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
		/* Align here to ensure that the .bss section occupies space up to
		   _end.  Align after .bss to ensure correct alignment even if the
		   .bss section disappears because there are no input sections.
		   FIXME: Why do we need it? When there is no .bss section, we don't
		   pad the .data section.  */
	}
	

	.rsx_image	: { *(.rsx_*) } : hdr_rsx
		
	_end = .;
	__end = .;
	PROVIDE (end = .);
	
	
	/* Stabs debugging sections.  */
	.stab          0 : { *(.stab) }
	.stabstr       0 : { *(.stabstr) }
	.stab.excl     0 : { *(.stab.excl) }
	.stab.exclstr  0 : { *(.stab.exclstr) }
	.stab.index    0 : { *(.stab.index) }
	.stab.indexstr 0 : { *(.stab.indexstr) }
	.comment       0 : { *(.comment) }
	/* DWARF debug sections.
	   Symbols in the DWARF debugging sections are relative to the beginning
	   of the section so we begin them at 0.  */
	/* DWARF 1 */
	.debug          0 : { *(.debug) }
	.line           0 : { *(.line) }
	/* GNU DWARF 1 extensions */
	.debug_srcinfo  0 : { *(.debug_srcinfo) }
	.debug_sfnames  0 : { *(.debug_sfnames) }
	/* DWARF 1.1 and DWARF 2 */
	.debug_aranges  0 : { *(.debug_aranges) }
	.debug_pubnames 0 : { *(.debug_pubnames) }
	/* DWARF 2 */
	.debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
	.debug_abbrev   0 : { *(.debug_abbrev) }
	.debug_line     0 : { *(.debug_line) }
	.debug_frame    0 : { *(.debug_frame) }
	.debug_str      0 : { *(.debug_str) }
	.debug_loc      0 : { *(.debug_loc) }
	.debug_macinfo  0 : { *(.debug_macinfo) }
	/* SGI/MIPS DWARF 2 extensions */
	.debug_weaknames 0 : { *(.debug_weaknames) }
	.debug_funcnames 0 : { *(.debug_funcnames) }
	.debug_typenames 0 : { *(.debug_typenames) }
	.debug_varnames  0 : { *(.debug_varnames) }
	/* DWARF 3 */
	.debug_pubtypes 0 : { *(.debug_pubtypes) }
	.debug_ranges   0 : { *(.debug_ranges) }
	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
	/DISCARD/ : { *(.note.GNU-stack) *(.gnu_debuglink) }
}
