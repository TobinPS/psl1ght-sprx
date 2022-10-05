.global _ppu_exit_thread
_ppu_exit_thread:
    li %r11, 41
    li %r3, 0
    sc
.global _ppu_exit_process
_ppu_exit_process:
    li %r11, 3
    li %r3, 0
    sc

.global _ppu_led_test
_ppu_led_test:
    li %r11, 386
    li %r3, 2
    li %r4, 2
    sc