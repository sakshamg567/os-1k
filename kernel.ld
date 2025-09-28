/* marks boot() as entry point */
ENTRY(boot)

SECTIONS {
  /* program starts from this memory address */
  . = 0x80200000;

  .text :{
    KEEP(*(.text.boot));
    *(.text .text.*);
  }
  /* read only data */
  .rodata : ALIGN(4) {
    *(.rodata .rodata.*);
  }

  .data : ALIGN(4) {
    *(.data .data.*);
  }
  /* zero initialised global/static variables */
  .bss : ALIGN(4) {
    __bss = .;
    *(.bss .bss.* .sbss .sbss.*);
    __bss_end = .;
  }


  /* 128 kb stack memory*/
  . = ALIGN(4);
  . += 128 * 1024; /* 128KB */
  __stack_top = .;


  /* dynamic data space (RAM)*/
  /* reserves 64 mb for dynamic allocation */
  /* 4kb alignment as 4096 = 0x1000 in hexadecimal */
  . = ALIGN(4096);
  __free_ram = .;
  . += 64 * 1024 * 1024; /* 64MB RAM */
  __free_ram_end = .;
}
