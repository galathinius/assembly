 FAF 182
 Plesca Anisoara-Ionela

 Assembly code that writes using 4 modes
 INT 10H
    ah 13h
    ah 09h
    ah 0Ah
    ah 0Eh


 NASM version 2.13.02
 gcc version 7.4.0


compile the assembly code using 
 nasm try1.asm -f bin -o try1.bin


compile the appender code using 
 g++ -o myfile file.cpp


to make an img file using the appender
 ./myfile try1.bin try.img


to use the command line to start a vm, qemu is used
 qemu-system-i386 -fda try1.bin


 bibliography:
 https://en.wikipedia.org/wiki/INT_10H
 http://vitaly_filatov.tripod.com/ng/asm/asm_023.20.html
 https://jbwyatt.com/253/emu/8086_bios_and_dos_interrupts.html
 https://stackoverflow.com/questions/41196376/int-10h-13h-bios-string-output-not-working
 https://stackoverflow.com/questions/23716647/why-isnt-the-text-colored-when-using-the-0eh-10h-interrupt