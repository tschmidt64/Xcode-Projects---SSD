.ORIG x3000

l3000 add r0, r1, r2
l3002 add r0, r1, #15
l3004 add r0, r1, x1
l3006 and r0, r1, r2
l3008 and r0, r1, #1
l300A and r0, r1, x2
l300C br l3010
l300E brnzp l3010
l3010 brn l3012
l3012 brz l3014
l3014 brp l3018
l3016 brzp l3010
l3018 brnp l3010
l301A brnz l3010
l301C jmp r7
l301E ret
l3020 jsr l302C
l3022 jsrr r5
l3024 ldb r2,r3,#3
l3026 ldb r2,r3,x4
l3028 ldw r4,r5, #4
l302A ldw r4,r5, #6
l302C lea r2, l3038
l302E not r4,r2
l3030 rti
l3032 lshf r0,r1,#1
l3034 lshf r0,r1,x2
l3036 rshfl r0,r1,#1
l3038 rshfl r0,r1,x3
l303A rshfa r0,r1,#1
l303C rshfa r0,r1,x5
l303E stb r0,r1,#9
l3040 stb r0,r1,xb
l3042 stw r0,r1,#8
l3044 stw r0,r1,xc
l3046 trap x20
l3048 trap #32
l304A xor r5, r4, r3
l304C xor r0, r1, #3
l304E xor r0, r1, x4
l3050 getc
l3052 out
l3054 puts
l3056 in
l3058 halt

.END
