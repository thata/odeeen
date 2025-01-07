	.data
	.align 2
l.4921:	 # 128.000000
	.long	1124073472
	.align 2
l.4910:	 # 40000.000000
	.long	1193033728
	.align 2
l.4858:	 # -2.000000
	.long	-1073741824
	.align 2
l.4857:	 # 0.100000
	.long	1036831949
	.align 2
l.4856:	 # 0.200000
	.long	1045220557
	.align 2
l.4828:	 # 20.000000
	.long	1101004800
	.align 2
l.4827:	 # 0.050000
	.long	1028443341
	.align 2
l.4823:	 # 0.250000
	.long	1048576000
	.align 2
l.4819:	 # 10.000000
	.long	1092616192
	.align 2
l.4815:	 # 0.300000
	.long	1050253722
	.align 2
l.4814:	 # 255.000000
	.long	1132396544
	.align 2
l.4813:	 # 0.500000
	.long	1056964608
	.align 2
l.4812:	 # 0.150000
	.long	1041865114
	.align 2
l.4810:	 # 3.141593
	.long	1078530011
	.align 2
l.4809:	 # 30.000000
	.long	1106247680
	.align 2
l.4808:	 # 15.000000
	.long	1097859072
	.align 2
l.4807:	 # 0.000100
	.long	953267991
	.align 2
l.4761:	 # 100000000.000000
	.long	1287568416
	.align 2
l.4757:	 # 1000000000.000000
	.long	1315859240
	.align 2
l.4724:	 # -0.100000
	.long	-1110651699
	.align 2
l.4709:	 # 0.010000
	.long	1008981770
	.align 2
l.4708:	 # -0.200000
	.long	-1102263091
	.align 2
l.4682:	 # 4.000000
	.long	1082130432
	.align 2
l.4481:	 # -200.000000
	.long	-1018691584
	.align 2
l.4467:	 # 0.017453
	.long	1016003125
	.align 2
l.4466:	 # -1.000000
	.long	-1082130432
	.align 2
l.4465:	 # 1.000000
	.long	1065353216
	.align 2
l.4464:	 # 0.000000
	.long	0
	.align 2
l.4440:	 # 2.000000
	.long	1073741824
	.text
	.globl min_caml_start
	.align 2
xor.1977:
	li t0, 0
	bne a0, t0, beq_else.5685
	mv a0, a1
	ret
beq_else.5685:
	li t0, 0
	bne a1, t0, beq_else.5686
	li	a0, 1
	ret
beq_else.5686:
	li	a0, 0
	ret
fsqr.1980:
	fmul.s fa0, fa0, fa0
	ret
fhalf.1982:
	lui t0, %hi(l.4440)
	flw fa1, %lo(l.4440)(t0)
	fdiv.s fa0, fa0, fa1
	ret
o_texturetype.1984:
	lw a0, 0(a0)
	ret
o_form.1986:
	lw a0, 4(a0)
	ret
o_reflectiontype.1988:
	lw a0, 8(a0)
	ret
o_isinvert.1990:
	lw a0, 24(a0)
	ret
o_isrot.1992:
	lw a0, 12(a0)
	ret
o_param_a.1994:
	lw a0, 16(a0)
	flw fa0, 0(a0)
	ret
o_param_b.1996:
	lw a0, 16(a0)
	flw fa0, 4(a0)
	ret
o_param_c.1998:
	lw a0, 16(a0)
	flw fa0, 8(a0)
	ret
o_param_x.2000:
	lw a0, 20(a0)
	flw fa0, 0(a0)
	ret
o_param_y.2002:
	lw a0, 20(a0)
	flw fa0, 4(a0)
	ret
o_param_z.2004:
	lw a0, 20(a0)
	flw fa0, 8(a0)
	ret
o_diffuse.2006:
	lw a0, 28(a0)
	flw fa0, 0(a0)
	ret
o_hilight.2008:
	lw a0, 28(a0)
	flw fa0, 4(a0)
	ret
o_color_red.2010:
	lw a0, 32(a0)
	flw fa0, 0(a0)
	ret
o_color_green.2012:
	lw a0, 32(a0)
	flw fa0, 4(a0)
	ret
o_color_blue.2014:
	lw a0, 32(a0)
	flw fa0, 8(a0)
	ret
o_param_r1.2016:
	lw a0, 36(a0)
	flw fa0, 0(a0)
	ret
o_param_r2.2018:
	lw a0, 36(a0)
	flw fa0, 4(a0)
	ret
o_param_r3.2020:
	lw a0, 36(a0)
	flw fa0, 8(a0)
	ret
normalize_vector.2022:
	flw fa0, 0(a0)
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call fsqr.1980
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 4(a0)
	fsw fa0, 8(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 20(s10)
	addi s10, s10, 24
	call fsqr.1980
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 4(s10)
	flw fa1, 8(a0)
	fsw fa0, 16(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 28(s10)
	addi s10, s10, 32
	call fsqr.1980
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_sqrt
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 0(s10)
	li t0, 0
	bne a0, t0, beq_else.5687
	j beq_cont.5688
beq_else.5687:
	fneg.s fa0, fa0
beq_cont.5688:
	lw a0, 4(s10)
	flw fa1, 0(a0)
	fdiv.s fa1, fa1, fa0
	fsw fa1, 0(a0)
	flw fa1, 4(a0)
	fdiv.s fa1, fa1, fa0
	fsw fa1, 4(a0)
	flw fa1, 8(a0)
	fdiv.s fa0, fa1, fa0
	fsw fa0, 8(a0)
	ret
sgn.2025:
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5690
	lui t0, %hi(l.4466)
	flw fa0, %lo(l.4466)(t0)
	ret
beq_else.5690:
	lui t0, %hi(l.4465)
	flw fa0, %lo(l.4465)(t0)
	ret
rad.2027:
	lui t0, %hi(l.4467)
	flw fa1, %lo(l.4467)(t0)
	fmul.s fa0, fa0, fa1
	ret
read_environ.2029:
	la a0, min_caml_screen
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_read_float
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	lw a0, 0(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_screen
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call min_caml_read_float
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_screen
	sw a0, 8(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call min_caml_read_float
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 8(s10)
	fsw fa0, 8(a0)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call min_caml_read_float
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call rad.2027
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	la a0, min_caml_cos_v
	fsw fa0, 16(s10)
	sw a0, 24(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_cos
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 24(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_sin_v
	flw fa0, 16(s10)
	sw a0, 28(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call min_caml_sin
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	lw a0, 28(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call min_caml_read_float
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call rad.2027
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	la a0, min_caml_cos_v
	fsw fa0, 32(s10)
	sw a0, 40(s10)
	mv t0, ra
	sw t0, 44(s10)
	addi s10, s10, 48
	call min_caml_cos
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	lw a0, 40(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_sin_v
	flw fa0, 32(s10)
	sw a0, 44(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_sin
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 44(s10)
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call rad.2027
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	fsw fa0, 48(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_sin
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	la a0, min_caml_light
	fneg.s fa0, fa0
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_read_float
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call rad.2027
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fsw fa0, 56(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 68(s10)
	addi s10, s10, 72
	call min_caml_cos
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	flw fa1, 56(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 76(s10)
	addi s10, s10, 80
	call min_caml_sin
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	la a0, min_caml_light
	flw fa1, 64(s10)
	fmul.s fa0, fa1, fa0
	fsw fa0, 0(a0)
	flw fa0, 56(s10)
	mv t0, ra
	sw t0, 76(s10)
	addi s10, s10, 80
	call min_caml_cos
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	la a0, min_caml_light
	flw fa1, 64(s10)
	fmul.s fa0, fa1, fa0
	fsw fa0, 8(a0)
	la a0, min_caml_beam
	sw a0, 72(s10)
	mv t0, ra
	sw t0, 76(s10)
	addi s10, s10, 80
	call min_caml_read_float
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	lw a0, 72(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_vp
	la a1, min_caml_cos_v
	flw fa0, 0(a1)
	la a1, min_caml_sin_v
	flw fa1, 4(a1)
	fmul.s fa0, fa0, fa1
	lui t0, %hi(l.4481)
	flw fa1, %lo(l.4481)(t0)
	fmul.s fa0, fa0, fa1
	fsw fa0, 0(a0)
	la a0, min_caml_vp
	la a1, min_caml_sin_v
	flw fa0, 0(a1)
	fneg.s fa0, fa0
	lui t0, %hi(l.4481)
	flw fa1, %lo(l.4481)(t0)
	fmul.s fa0, fa0, fa1
	fsw fa0, 4(a0)
	la a0, min_caml_vp
	la a1, min_caml_cos_v
	flw fa0, 0(a1)
	la a1, min_caml_cos_v
	flw fa1, 4(a1)
	fmul.s fa0, fa0, fa1
	lui t0, %hi(l.4481)
	flw fa1, %lo(l.4481)(t0)
	fmul.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	la a0, min_caml_view
	la a1, min_caml_vp
	flw fa0, 0(a1)
	la a1, min_caml_screen
	flw fa1, 0(a1)
	fadd.s fa0, fa0, fa1
	fsw fa0, 0(a0)
	la a0, min_caml_view
	la a1, min_caml_vp
	flw fa0, 4(a1)
	la a1, min_caml_screen
	flw fa1, 4(a1)
	fadd.s fa0, fa0, fa1
	fsw fa0, 4(a0)
	la a0, min_caml_view
	la a1, min_caml_vp
	flw fa0, 8(a1)
	la a1, min_caml_screen
	flw fa1, 8(a1)
	fadd.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	ret
read_nth_object.2031:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_read_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a1, 1
	neg	a1, a1
	bne a0, a1, beq_else.5693
	li	a0, 0
	ret
beq_else.5693:
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call min_caml_read_int
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	sw a0, 8(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call min_caml_read_int
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	sw a0, 12(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call min_caml_read_int
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li	a1, 3
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	sw a0, 16(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 20(s10)
	addi s10, s10, 24
	call min_caml_create_float_array
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	sw a0, 20(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 20(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 20(s10)
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 20(s10)
	fsw fa0, 8(a0)
	li	a1, 3
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	mv t0, ra
	mv a0, a1
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_create_float_array
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	sw a0, 24(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 24(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 24(s10)
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_read_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 24(s10)
	fsw fa0, 8(a0)
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 32(s10)
	mv t0, ra
	sw t0, 44(s10)
	addi s10, s10, 48
	call min_caml_read_float
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	flw fa1, 32(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5695
	li	a0, 0
	j beq_cont.5696
beq_else.5695:
	li	a0, 1
beq_cont.5696:
	li	a1, 2
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	sw a0, 40(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 44(s10)
	addi s10, s10, 48
	call min_caml_create_float_array
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	sw a0, 44(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 44(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 44(s10)
	fsw fa0, 4(a0)
	li	a1, 3
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	mv t0, ra
	mv a0, a1
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_create_float_array
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	sw a0, 48(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 48(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 48(s10)
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_read_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 48(s10)
	fsw fa0, 8(a0)
	li	a1, 3
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	mv t0, ra
	mv a0, a1
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_create_float_array
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a1, 16(s10)
	li t0, 0
	bne a1, t0, beq_else.5697
	j beq_cont.5698
beq_else.5697:
	sw a0, 52(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_read_float
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call rad.2027
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	lw a0, 52(s10)
	fsw fa0, 0(a0)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_read_float
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call rad.2027
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	lw a0, 52(s10)
	fsw fa0, 4(a0)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_read_float
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call rad.2027
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	lw a0, 52(s10)
	fsw fa0, 8(a0)
beq_cont.5698:
	lw a1, 8(s10)
	li t0, 2
	bne a1, t0, beq_else.5699
	li	a2, 1
	j beq_cont.5700
beq_else.5699:
	lw a2, 40(s10)
beq_cont.5700:
	mv a3, s11
	addi	s11, s11, 40
	sw a0, 36(a3)
	lw a4, 48(s10)
	sw a4, 32(a3)
	lw a4, 44(s10)
	sw a4, 28(a3)
	sw a2, 24(a3)
	lw a2, 24(s10)
	sw a2, 20(a3)
	lw a2, 20(s10)
	sw a2, 16(a3)
	lw a4, 16(s10)
	sw a4, 12(a3)
	lw a5, 12(s10)
	sw a5, 8(a3)
	sw a1, 4(a3)
	lw a5, 4(s10)
	sw a5, 0(a3)
	la a5, min_caml_objects
	lw a6, 0(s10)
	slli a6, a6, 2
	add t0, a5, a6
	sw a3, 0(t0)
	sw a0, 52(s10)
	li t0, 3
	bne a1, t0, beq_else.5701
	flw fa0, 0(a2)
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	feq.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5703
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	j beq_cont.5704
beq_else.5703:
	fsw fa0, 56(s10)
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call sgn.2025
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	flw fa1, 56(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 76(s10)
	addi s10, s10, 80
	call fsqr.1980
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fdiv.s fa0, fa1, fa0
beq_cont.5704:
	lw a0, 20(s10)
	fsw fa0, 0(a0)
	flw fa0, 4(a0)
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	feq.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5705
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	j beq_cont.5706
beq_else.5705:
	fsw fa0, 72(s10)
	mv t0, ra
	sw t0, 84(s10)
	addi s10, s10, 88
	call sgn.2025
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fsw fa0, 80(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 92(s10)
	addi s10, s10, 96
	call fsqr.1980
	addi s10, s10, -96
	lw t0, 92(s10)
	mv ra, t0
	flw fa1, 80(s10)
	fdiv.s fa0, fa1, fa0
beq_cont.5706:
	lw a0, 20(s10)
	fsw fa0, 4(a0)
	flw fa0, 8(a0)
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	feq.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5707
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	j beq_cont.5708
beq_else.5707:
	fsw fa0, 88(s10)
	mv t0, ra
	sw t0, 100(s10)
	addi s10, s10, 104
	call sgn.2025
	addi s10, s10, -104
	lw t0, 100(s10)
	mv ra, t0
	flw fa1, 88(s10)
	fsw fa0, 96(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 108(s10)
	addi s10, s10, 112
	call fsqr.1980
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	flw fa1, 96(s10)
	fdiv.s fa0, fa1, fa0
beq_cont.5708:
	lw a0, 20(s10)
	fsw fa0, 8(a0)
	j beq_cont.5702
beq_else.5701:
	li t0, 2
	bne a1, t0, beq_else.5709
	lw a1, 40(s10)
	li t0, 0
	bne a1, t0, beq_else.5711
	li	a1, 1
	j beq_cont.5712
beq_else.5711:
	li	a1, 0
beq_cont.5712:
	mv t0, ra
	mv a0, a2
	sw t0, 108(s10)
	addi s10, s10, 112
	call normalize_vector.2022
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	j beq_cont.5710
beq_else.5709:
beq_cont.5710:
beq_cont.5702:
	lw a0, 16(s10)
	li t0, 0
	bne a0, t0, beq_else.5713
	j beq_cont.5714
beq_else.5713:
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 0(a1)
	sw a0, 104(s10)
	mv t0, ra
	sw t0, 108(s10)
	addi s10, s10, 112
	call min_caml_cos
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	lw a0, 104(s10)
	fsw fa0, 40(a0)
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 0(a1)
	sw a0, 108(s10)
	mv t0, ra
	sw t0, 116(s10)
	addi s10, s10, 120
	call min_caml_sin
	addi s10, s10, -120
	lw t0, 116(s10)
	mv ra, t0
	lw a0, 108(s10)
	fsw fa0, 44(a0)
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 4(a1)
	sw a0, 112(s10)
	mv t0, ra
	sw t0, 116(s10)
	addi s10, s10, 120
	call min_caml_cos
	addi s10, s10, -120
	lw t0, 116(s10)
	mv ra, t0
	lw a0, 112(s10)
	fsw fa0, 48(a0)
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 4(a1)
	sw a0, 116(s10)
	mv t0, ra
	sw t0, 124(s10)
	addi s10, s10, 128
	call min_caml_sin
	addi s10, s10, -128
	lw t0, 124(s10)
	mv ra, t0
	lw a0, 116(s10)
	fsw fa0, 52(a0)
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 8(a1)
	sw a0, 120(s10)
	mv t0, ra
	sw t0, 124(s10)
	addi s10, s10, 128
	call min_caml_cos
	addi s10, s10, -128
	lw t0, 124(s10)
	mv ra, t0
	lw a0, 120(s10)
	fsw fa0, 56(a0)
	la a0, min_caml_cs_temp
	lw a1, 52(s10)
	flw fa0, 8(a1)
	sw a0, 124(s10)
	mv t0, ra
	sw t0, 132(s10)
	addi s10, s10, 136
	call min_caml_sin
	addi s10, s10, -136
	lw t0, 132(s10)
	mv ra, t0
	lw a0, 124(s10)
	fsw fa0, 60(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 48(a1)
	la a1, min_caml_cs_temp
	flw fa1, 56(a1)
	fmul.s fa0, fa0, fa1
	fsw fa0, 0(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 44(a1)
	la a1, min_caml_cs_temp
	flw fa1, 52(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 56(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 40(a1)
	la a1, min_caml_cs_temp
	flw fa2, 60(a1)
	fmul.s fa1, fa1, fa2
	fsub.s fa0, fa0, fa1
	fsw fa0, 4(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 40(a1)
	la a1, min_caml_cs_temp
	flw fa1, 52(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 56(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 44(a1)
	la a1, min_caml_cs_temp
	flw fa2, 60(a1)
	fmul.s fa1, fa1, fa2
	fadd.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 48(a1)
	la a1, min_caml_cs_temp
	flw fa1, 60(a1)
	fmul.s fa0, fa0, fa1
	fsw fa0, 12(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 44(a1)
	la a1, min_caml_cs_temp
	flw fa1, 52(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 60(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 40(a1)
	la a1, min_caml_cs_temp
	flw fa2, 56(a1)
	fmul.s fa1, fa1, fa2
	fadd.s fa0, fa0, fa1
	fsw fa0, 16(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 40(a1)
	la a1, min_caml_cs_temp
	flw fa1, 52(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 60(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_cs_temp
	flw fa1, 44(a1)
	la a1, min_caml_cs_temp
	flw fa2, 56(a1)
	fmul.s fa1, fa1, fa2
	fsub.s fa0, fa0, fa1
	fsw fa0, 20(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 52(a1)
	fneg.s fa0, fa0
	fsw fa0, 24(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 44(a1)
	la a1, min_caml_cs_temp
	flw fa1, 48(a1)
	fmul.s fa0, fa0, fa1
	fsw fa0, 28(a0)
	la a0, min_caml_cs_temp
	la a1, min_caml_cs_temp
	flw fa0, 40(a1)
	la a1, min_caml_cs_temp
	flw fa1, 48(a1)
	fmul.s fa0, fa0, fa1
	fsw fa0, 32(a0)
	lw a0, 20(s10)
	flw fa0, 0(a0)
	flw fa1, 4(a0)
	flw fa2, 8(a0)
	la a1, min_caml_cs_temp
	flw fa3, 0(a1)
	fsw fa2, 128(s10)
	fsw fa1, 136(s10)
	fsw fa0, 144(s10)
	mv t0, ra
	fmv.s fa0, fa3
	sw t0, 156(s10)
	addi s10, s10, 160
	call fsqr.1980
	addi s10, s10, -160
	lw t0, 156(s10)
	mv ra, t0
	flw fa1, 144(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_cs_temp
	flw fa2, 12(a0)
	fsw fa0, 152(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 164(s10)
	addi s10, s10, 168
	call fsqr.1980
	addi s10, s10, -168
	lw t0, 164(s10)
	mv ra, t0
	flw fa1, 136(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 152(s10)
	fadd.s fa0, fa2, fa0
	la a0, min_caml_cs_temp
	flw fa2, 24(a0)
	fsw fa0, 160(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 172(s10)
	addi s10, s10, 176
	call fsqr.1980
	addi s10, s10, -176
	lw t0, 172(s10)
	mv ra, t0
	flw fa1, 128(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 160(s10)
	fadd.s fa0, fa2, fa0
	lw a0, 20(s10)
	fsw fa0, 0(a0)
	la a1, min_caml_cs_temp
	flw fa0, 4(a1)
	mv t0, ra
	sw t0, 172(s10)
	addi s10, s10, 176
	call fsqr.1980
	addi s10, s10, -176
	lw t0, 172(s10)
	mv ra, t0
	flw fa1, 144(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_cs_temp
	flw fa2, 16(a0)
	fsw fa0, 168(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 180(s10)
	addi s10, s10, 184
	call fsqr.1980
	addi s10, s10, -184
	lw t0, 180(s10)
	mv ra, t0
	flw fa1, 136(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 168(s10)
	fadd.s fa0, fa2, fa0
	la a0, min_caml_cs_temp
	flw fa2, 28(a0)
	fsw fa0, 176(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 188(s10)
	addi s10, s10, 192
	call fsqr.1980
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	flw fa1, 128(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 176(s10)
	fadd.s fa0, fa2, fa0
	lw a0, 20(s10)
	fsw fa0, 4(a0)
	la a1, min_caml_cs_temp
	flw fa0, 8(a1)
	mv t0, ra
	sw t0, 188(s10)
	addi s10, s10, 192
	call fsqr.1980
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	flw fa1, 144(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_cs_temp
	flw fa2, 20(a0)
	fsw fa0, 184(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 196(s10)
	addi s10, s10, 200
	call fsqr.1980
	addi s10, s10, -200
	lw t0, 196(s10)
	mv ra, t0
	flw fa1, 136(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 184(s10)
	fadd.s fa0, fa2, fa0
	la a0, min_caml_cs_temp
	flw fa2, 32(a0)
	fsw fa0, 192(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 204(s10)
	addi s10, s10, 208
	call fsqr.1980
	addi s10, s10, -208
	lw t0, 204(s10)
	mv ra, t0
	flw fa1, 128(s10)
	fmul.s fa0, fa1, fa0
	flw fa2, 192(s10)
	fadd.s fa0, fa2, fa0
	lw a0, 20(s10)
	fsw fa0, 8(a0)
	lui t0, %hi(l.4440)
	flw fa0, %lo(l.4440)(t0)
	la a0, min_caml_cs_temp
	flw fa2, 4(a0)
	flw fa3, 144(s10)
	fmul.s fa2, fa3, fa2
	la a0, min_caml_cs_temp
	flw fa4, 8(a0)
	fmul.s fa2, fa2, fa4
	la a0, min_caml_cs_temp
	flw fa4, 16(a0)
	flw fa5, 136(s10)
	fmul.s fa4, fa5, fa4
	la a0, min_caml_cs_temp
	flw fa6, 20(a0)
	fmul.s fa4, fa4, fa6
	fadd.s fa2, fa2, fa4
	la a0, min_caml_cs_temp
	flw fa4, 28(a0)
	fmul.s fa4, fa1, fa4
	la a0, min_caml_cs_temp
	flw fa6, 32(a0)
	fmul.s fa4, fa4, fa6
	fadd.s fa2, fa2, fa4
	fmul.s fa0, fa0, fa2
	lw a0, 52(s10)
	fsw fa0, 0(a0)
	lui t0, %hi(l.4440)
	flw fa0, %lo(l.4440)(t0)
	la a1, min_caml_cs_temp
	flw fa2, 0(a1)
	fmul.s fa2, fa3, fa2
	la a1, min_caml_cs_temp
	flw fa4, 8(a1)
	fmul.s fa2, fa2, fa4
	la a1, min_caml_cs_temp
	flw fa4, 12(a1)
	fmul.s fa4, fa5, fa4
	la a1, min_caml_cs_temp
	flw fa6, 20(a1)
	fmul.s fa4, fa4, fa6
	fadd.s fa2, fa2, fa4
	la a1, min_caml_cs_temp
	flw fa4, 24(a1)
	fmul.s fa4, fa1, fa4
	la a1, min_caml_cs_temp
	flw fa6, 32(a1)
	fmul.s fa4, fa4, fa6
	fadd.s fa2, fa2, fa4
	fmul.s fa0, fa0, fa2
	fsw fa0, 4(a0)
	lui t0, %hi(l.4440)
	flw fa0, %lo(l.4440)(t0)
	la a1, min_caml_cs_temp
	flw fa2, 0(a1)
	fmul.s fa2, fa3, fa2
	la a1, min_caml_cs_temp
	flw fa3, 4(a1)
	fmul.s fa2, fa2, fa3
	la a1, min_caml_cs_temp
	flw fa3, 12(a1)
	fmul.s fa3, fa5, fa3
	la a1, min_caml_cs_temp
	flw fa4, 16(a1)
	fmul.s fa3, fa3, fa4
	fadd.s fa2, fa2, fa3
	la a1, min_caml_cs_temp
	flw fa3, 24(a1)
	fmul.s fa1, fa1, fa3
	la a1, min_caml_cs_temp
	flw fa3, 28(a1)
	fmul.s fa1, fa1, fa3
	fadd.s fa1, fa2, fa1
	fmul.s fa0, fa0, fa1
	fsw fa0, 8(a0)
beq_cont.5714:
	li	a0, 1
	ret
read_object.2033:
	li t0, 61
	blt a0, t0, bge_else.5715
	ret
bge_else.5715:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_nth_object.2031
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5717
	ret
beq_else.5717:
	lw a0, 0(s10)
	addi	a0, a0, 1
	j read_object.2033
read_all_object.2035:
	li	a0, 0
	j read_object.2033
read_net_item.2037:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_read_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a1, 1
	neg	a1, a1
	bne a0, a1, beq_else.5719
	lw a0, 0(s10)
	addi	a0, a0, 1
	li	a1, 1
	neg	a1, a1
	j min_caml_create_array
beq_else.5719:
	lw a1, 0(s10)
	addi	a2, a1, 1
	sw a0, 4(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 12(s10)
	addi s10, s10, 16
	call read_net_item.2037
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a1, 0(s10)
	slli a1, a1, 2
	lw a2, 4(s10)
	add t0, a0, a1
	sw a2, 0(t0)
	ret
read_or_network.2039:
	li	a1, 0
	sw a0, 0(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_net_item.2037
	addi s10, s10, -8
	lw t0, 4(s10)
	mv a1, a0
	mv ra, t0
	lw a0, 0(a1)
	li	a2, 1
	neg	a2, a2
	bne a0, a2, beq_else.5720
	lw a0, 0(s10)
	addi	a0, a0, 1
	j min_caml_create_array
beq_else.5720:
	lw a0, 0(s10)
	addi	a2, a0, 1
	sw a1, 4(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 12(s10)
	addi s10, s10, 16
	call read_or_network.2039
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a1, 0(s10)
	slli a1, a1, 2
	lw a2, 4(s10)
	add t0, a0, a1
	sw a2, 0(t0)
	ret
read_and_network.2041:
	li	a1, 0
	sw a0, 0(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_net_item.2037
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	lw a1, 0(a0)
	li	a2, 1
	neg	a2, a2
	bne a1, a2, beq_else.5721
	ret
beq_else.5721:
	la a1, min_caml_and_net
	lw a2, 0(s10)
	slli a3, a2, 2
	add t0, a1, a3
	sw a0, 0(t0)
	addi	a0, a2, 1
	j read_and_network.2041
read_parameter.2043:
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_environ.2029
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_all_object.2035
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 0
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_and_network.2041
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_or_net
	li	a1, 0
	sw a0, 0(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_or_network.2039
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	lw a1, 0(s10)
	sw a0, 0(a1)
	ret
solver_rect.2045:
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	flw fa1, 0(a1)
	sw a0, 0(s10)
	sw a1, 4(s10)
	feq.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5724
	li	a0, 0
	j beq_cont.5725
beq_else.5724:
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_isinvert.1990
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a1, 4(s10)
	flw fa1, 0(a1)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5726
	li	a2, 0
	j beq_cont.5727
beq_else.5726:
	li	a2, 1
beq_cont.5727:
	mv t0, ra
	mv a1, a2
	sw t0, 12(s10)
	addi s10, s10, 16
	call xor.1977
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5728
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_param_a.1994
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	fneg.s fa0, fa0
	j beq_cont.5729
beq_else.5728:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_param_a.1994
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
beq_cont.5729:
	la a0, min_caml_solver_w_vec
	flw fa1, 0(a0)
	fsub.s fa0, fa0, fa1
	lw a0, 4(s10)
	flw fa1, 0(a0)
	fdiv.s fa0, fa0, fa1
	lw a1, 0(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_b.1996
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 4(a0)
	flw fa2, 8(s10)
	fmul.s fa1, fa2, fa1
	la a1, min_caml_solver_w_vec
	flw fa3, 4(a1)
	fadd.s fa1, fa1, fa3
	fsw fa0, 16(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_abs_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5730
	li	a0, 0
	j beq_cont.5731
beq_else.5730:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_c.1998
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 8(a0)
	flw fa2, 8(s10)
	fmul.s fa1, fa2, fa1
	la a1, min_caml_solver_w_vec
	flw fa3, 8(a1)
	fadd.s fa1, fa1, fa3
	fsw fa0, 24(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 36(s10)
	addi s10, s10, 40
	call min_caml_abs_float
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5732
	li	a0, 0
	j beq_cont.5733
beq_else.5732:
	la a0, min_caml_solver_dist
	flw fa0, 8(s10)
	fsw fa0, 0(a0)
	li	a0, 1
beq_cont.5733:
beq_cont.5731:
beq_cont.5725:
	li t0, 0
	bne a0, t0, beq_else.5734
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a0, 4(s10)
	flw fa1, 4(a0)
	feq.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5735
	li	a0, 0
	j beq_cont.5736
beq_else.5735:
	lw a1, 0(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_isinvert.1990
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a1, 4(s10)
	flw fa1, 4(a1)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5737
	li	a2, 0
	j beq_cont.5738
beq_else.5737:
	li	a2, 1
beq_cont.5738:
	mv t0, ra
	mv a1, a2
	sw t0, 36(s10)
	addi s10, s10, 40
	call xor.1977
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5739
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_b.1996
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	fneg.s fa0, fa0
	j beq_cont.5740
beq_else.5739:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_b.1996
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
beq_cont.5740:
	la a0, min_caml_solver_w_vec
	flw fa1, 4(a0)
	fsub.s fa0, fa0, fa1
	lw a0, 4(s10)
	flw fa1, 4(a0)
	fdiv.s fa0, fa0, fa1
	lw a1, 0(s10)
	fsw fa0, 32(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 44(s10)
	addi s10, s10, 48
	call o_param_c.1998
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 8(a0)
	flw fa2, 32(s10)
	fmul.s fa1, fa2, fa1
	la a1, min_caml_solver_w_vec
	flw fa3, 8(a1)
	fadd.s fa1, fa1, fa3
	fsw fa0, 40(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 52(s10)
	addi s10, s10, 56
	call min_caml_abs_float
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5741
	li	a0, 0
	j beq_cont.5742
beq_else.5741:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_a.1994
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 0(a0)
	flw fa2, 32(s10)
	fmul.s fa1, fa2, fa1
	la a1, min_caml_solver_w_vec
	flw fa3, 0(a1)
	fadd.s fa1, fa1, fa3
	fsw fa0, 48(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 60(s10)
	addi s10, s10, 64
	call min_caml_abs_float
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5743
	li	a0, 0
	j beq_cont.5744
beq_else.5743:
	la a0, min_caml_solver_dist
	flw fa0, 32(s10)
	fsw fa0, 0(a0)
	li	a0, 1
beq_cont.5744:
beq_cont.5742:
beq_cont.5736:
	li t0, 0
	bne a0, t0, beq_else.5745
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a0, 4(s10)
	flw fa1, 8(a0)
	feq.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5746
	li	a0, 0
	j beq_cont.5747
beq_else.5746:
	lw a1, 0(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_isinvert.1990
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a1, 4(s10)
	flw fa1, 8(a1)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5748
	li	a2, 0
	j beq_cont.5749
beq_else.5748:
	li	a2, 1
beq_cont.5749:
	mv t0, ra
	mv a1, a2
	sw t0, 60(s10)
	addi s10, s10, 64
	call xor.1977
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5750
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_c.1998
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	fneg.s fa0, fa0
	j beq_cont.5751
beq_else.5750:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_c.1998
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
beq_cont.5751:
	la a0, min_caml_solver_w_vec
	flw fa1, 8(a0)
	fsub.s fa0, fa0, fa1
	lw a0, 4(s10)
	flw fa1, 8(a0)
	fdiv.s fa0, fa0, fa1
	lw a1, 0(s10)
	fsw fa0, 56(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 68(s10)
	addi s10, s10, 72
	call o_param_a.1994
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 0(a0)
	flw fa2, 56(s10)
	fmul.s fa1, fa2, fa1
	la a1, min_caml_solver_w_vec
	flw fa3, 0(a1)
	fadd.s fa1, fa1, fa3
	fsw fa0, 64(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 76(s10)
	addi s10, s10, 80
	call min_caml_abs_float
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5752
	li	a0, 0
	j beq_cont.5753
beq_else.5752:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 76(s10)
	addi s10, s10, 80
	call o_param_b.1996
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	lw a0, 4(s10)
	flw fa1, 4(a0)
	flw fa2, 56(s10)
	fmul.s fa1, fa2, fa1
	la a0, min_caml_solver_w_vec
	flw fa3, 4(a0)
	fadd.s fa1, fa1, fa3
	fsw fa0, 72(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 84(s10)
	addi s10, s10, 88
	call min_caml_abs_float
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5754
	li	a0, 0
	j beq_cont.5755
beq_else.5754:
	la a0, min_caml_solver_dist
	flw fa0, 56(s10)
	fsw fa0, 0(a0)
	li	a0, 1
beq_cont.5755:
beq_cont.5753:
beq_cont.5747:
	li t0, 0
	bne a0, t0, beq_else.5756
	li	a0, 0
	ret
beq_else.5756:
	li	a0, 3
	ret
beq_else.5745:
	li	a0, 2
	ret
beq_else.5734:
	li	a0, 1
	ret
solver_surface.2048:
	flw fa0, 0(a1)
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_a.1994
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 4(s10)
	flw fa1, 4(a0)
	lw a1, 0(s10)
	fsw fa0, 16(s10)
	fsw fa1, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_b.1996
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 4(s10)
	flw fa1, 8(a0)
	lw a0, 0(s10)
	fsw fa0, 32(s10)
	fsw fa1, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_c.1998
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5757
	li	a0, 0
	ret
beq_else.5757:
	la a0, min_caml_solver_w_vec
	flw fa1, 0(a0)
	lw a0, 0(s10)
	fsw fa0, 48(s10)
	fsw fa1, 56(s10)
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call o_param_a.1994
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	flw fa1, 56(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 4(a0)
	lw a0, 0(s10)
	fsw fa0, 64(s10)
	fsw fa1, 72(s10)
	mv t0, ra
	sw t0, 84(s10)
	addi s10, s10, 88
	call o_param_b.1996
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 64(s10)
	fadd.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 8(a0)
	lw a0, 0(s10)
	fsw fa0, 80(s10)
	fsw fa1, 88(s10)
	mv t0, ra
	sw t0, 100(s10)
	addi s10, s10, 104
	call o_param_c.1998
	addi s10, s10, -104
	lw t0, 100(s10)
	mv ra, t0
	flw fa1, 88(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 80(s10)
	fadd.s fa0, fa1, fa0
	flw fa1, 48(s10)
	fdiv.s fa0, fa0, fa1
	la a0, min_caml_solver_dist
	fneg.s fa0, fa0
	fsw fa0, 0(a0)
	li	a0, 1
	ret
in_prod_sqr_obj.2051:
	flw fa0, 0(a1)
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call fsqr.1980
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_a.1994
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 0(s10)
	flw fa1, 4(a0)
	fsw fa0, 16(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 28(s10)
	addi s10, s10, 32
	call fsqr.1980
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 24(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_b.1996
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 0(s10)
	flw fa1, 8(a0)
	fsw fa0, 32(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 44(s10)
	addi s10, s10, 48
	call fsqr.1980
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_c.1998
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
	ret
in_prod_co_objrot.2054:
	flw fa0, 4(a1)
	flw fa1, 8(a1)
	fmul.s fa0, fa0, fa1
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_r1.2016
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 4(s10)
	flw fa1, 0(a0)
	flw fa2, 8(a0)
	fmul.s fa1, fa1, fa2
	lw a1, 0(s10)
	fsw fa0, 16(s10)
	fsw fa1, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_r2.2018
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 4(s10)
	flw fa1, 0(a0)
	flw fa2, 4(a0)
	fmul.s fa1, fa1, fa2
	lw a0, 0(s10)
	fsw fa0, 32(s10)
	fsw fa1, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_r3.2020
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
	ret
solver2nd_mul_b.2057:
	la a2, min_caml_solver_w_vec
	flw fa0, 0(a2)
	flw fa1, 0(a1)
	fmul.s fa0, fa0, fa1
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_a.1994
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 4(a0)
	lw a0, 4(s10)
	flw fa2, 4(a0)
	fmul.s fa1, fa1, fa2
	lw a1, 0(s10)
	fsw fa0, 16(s10)
	fsw fa1, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_b.1996
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 8(a0)
	lw a0, 4(s10)
	flw fa2, 8(a0)
	fmul.s fa1, fa1, fa2
	lw a0, 0(s10)
	fsw fa0, 32(s10)
	fsw fa1, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_c.1998
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
	ret
solver2nd_rot_b.2060:
	la a2, min_caml_solver_w_vec
	flw fa0, 8(a2)
	flw fa1, 4(a1)
	fmul.s fa0, fa0, fa1
	la a2, min_caml_solver_w_vec
	flw fa1, 4(a2)
	flw fa2, 8(a1)
	fmul.s fa1, fa1, fa2
	fadd.s fa0, fa0, fa1
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_r1.2016
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 0(a0)
	lw a0, 4(s10)
	flw fa2, 8(a0)
	fmul.s fa1, fa1, fa2
	la a1, min_caml_solver_w_vec
	flw fa2, 8(a1)
	flw fa3, 0(a0)
	fmul.s fa2, fa2, fa3
	fadd.s fa1, fa1, fa2
	lw a1, 0(s10)
	fsw fa0, 16(s10)
	fsw fa1, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_r2.2018
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	la a0, min_caml_solver_w_vec
	flw fa1, 0(a0)
	lw a0, 4(s10)
	flw fa2, 4(a0)
	fmul.s fa1, fa1, fa2
	la a1, min_caml_solver_w_vec
	flw fa2, 4(a1)
	flw fa3, 0(a0)
	fmul.s fa2, fa2, fa3
	fadd.s fa1, fa1, fa2
	lw a0, 0(s10)
	fsw fa0, 32(s10)
	fsw fa1, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_r3.2020
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
	ret
solver_second.2063:
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call in_prod_sqr_obj.2051
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_isrot.1992
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5758
	flw fa0, 8(s10)
	j beq_cont.5759
beq_else.5758:
	lw a0, 4(s10)
	lw a1, 0(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call in_prod_co_objrot.2054
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fadd.s fa0, fa1, fa0
beq_cont.5759:
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	feq.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5760
	li	a0, 0
	ret
beq_else.5760:
	lui t0, %hi(l.4440)
	flw fa1, %lo(l.4440)(t0)
	lw a0, 4(s10)
	lw a1, 0(s10)
	fsw fa0, 16(s10)
	fsw fa1, 24(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call solver2nd_mul_b.2057
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 32(s10)
	mv t0, ra
	sw t0, 44(s10)
	addi s10, s10, 48
	call o_isrot.1992
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5761
	flw fa0, 32(s10)
	j beq_cont.5762
beq_else.5761:
	lw a0, 4(s10)
	lw a1, 0(s10)
	mv t0, ra
	sw t0, 44(s10)
	addi s10, s10, 48
	call solver2nd_rot_b.2060
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	flw fa1, 32(s10)
	fadd.s fa0, fa1, fa0
beq_cont.5762:
	la a1, min_caml_solver_w_vec
	lw a0, 4(s10)
	fsw fa0, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call in_prod_sqr_obj.2051
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 48(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_isrot.1992
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5763
	flw fa0, 48(s10)
	j beq_cont.5764
beq_else.5763:
	la a1, min_caml_solver_w_vec
	lw a0, 4(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call in_prod_co_objrot.2054
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fadd.s fa0, fa1, fa0
beq_cont.5764:
	lw a0, 4(s10)
	fsw fa0, 56(s10)
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call o_form.1986
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	li t0, 3
	bne a0, t0, beq_else.5765
	lui t0, %hi(l.4465)
	flw fa0, %lo(l.4465)(t0)
	flw fa1, 56(s10)
	fsub.s fa0, fa1, fa0
	j beq_cont.5766
beq_else.5765:
	flw fa0, 56(s10)
beq_cont.5766:
	lui t0, %hi(l.4682)
	flw fa1, %lo(l.4682)(t0)
	flw fa2, 16(s10)
	fmul.s fa1, fa1, fa2
	fmul.s fa0, fa1, fa0
	flw fa1, 40(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 76(s10)
	addi s10, s10, 80
	call fsqr.1980
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fsub.s fa0, fa0, fa1
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5767
	li	a0, 0
	ret
beq_else.5767:
	mv t0, ra
	sw t0, 76(s10)
	addi s10, s10, 80
	call min_caml_sqrt
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	lw a0, 4(s10)
	fsw fa0, 72(s10)
	mv t0, ra
	sw t0, 84(s10)
	addi s10, s10, 88
	call o_isinvert.1990
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5768
	flw fa0, 72(s10)
	fneg.s fa0, fa0
	j beq_cont.5769
beq_else.5768:
	flw fa0, 72(s10)
beq_cont.5769:
	la a0, min_caml_solver_dist
	flw fa1, 40(s10)
	fsub.s fa0, fa0, fa1
	lui t0, %hi(l.4440)
	flw fa1, %lo(l.4440)(t0)
	fdiv.s fa0, fa0, fa1
	flw fa1, 16(s10)
	fdiv.s fa0, fa0, fa1
	fsw fa0, 0(a0)
	li	a0, 1
	ret
solver.2066:
	la a3, min_caml_objects
	slli a0, a0, 2
	add t0, a3, a0
	lw a0, 0(t0)
	la a3, min_caml_solver_w_vec
	flw fa0, 0(a2)
	sw a1, 0(s10)
	sw a0, 4(s10)
	sw a2, 8(s10)
	sw a3, 12(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_x.2000
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 12(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_solver_w_vec
	lw a1, 8(s10)
	flw fa0, 4(a1)
	lw a2, 4(s10)
	sw a0, 24(s10)
	fsw fa0, 32(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 44(s10)
	addi s10, s10, 48
	call o_param_y.2002
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	flw fa1, 32(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 24(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_solver_w_vec
	lw a1, 8(s10)
	flw fa0, 8(a1)
	lw a1, 4(s10)
	sw a0, 40(s10)
	fsw fa0, 48(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_z.2004
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 40(s10)
	fsw fa0, 8(a0)
	lw a0, 4(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_form.1986
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	li t0, 1
	bne a0, t0, beq_else.5772
	lw a0, 4(s10)
	lw a1, 0(s10)
	j solver_rect.2045
beq_else.5772:
	li t0, 2
	bne a0, t0, beq_else.5773
	lw a0, 4(s10)
	lw a1, 0(s10)
	j solver_surface.2048
beq_else.5773:
	lw a0, 4(s10)
	lw a1, 0(s10)
	j solver_second.2063
is_rect_outside.2070:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call o_param_a.1994
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 0(a0)
	fsw fa0, 8(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 20(s10)
	addi s10, s10, 24
	call min_caml_abs_float
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5775
	li	a0, 0
	j beq_cont.5776
beq_else.5775:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_b.1996
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 4(a0)
	fsw fa0, 16(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 28(s10)
	addi s10, s10, 32
	call min_caml_abs_float
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5777
	li	a0, 0
	j beq_cont.5778
beq_else.5777:
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_c.1998
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 8(a0)
	fsw fa0, 24(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 36(s10)
	addi s10, s10, 40
	call min_caml_abs_float
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5779
	li	a0, 0
	j beq_cont.5780
beq_else.5779:
	li	a0, 1
beq_cont.5780:
beq_cont.5778:
beq_cont.5776:
	li t0, 0
	bne a0, t0, beq_else.5781
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_isinvert.1990
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5782
	li	a0, 1
	ret
beq_else.5782:
	li	a0, 0
	ret
beq_else.5781:
	lw a0, 0(s10)
	j o_isinvert.1990
is_plane_outside.2072:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call o_param_a.1994
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 0(a0)
	fmul.s fa0, fa0, fa1
	lw a0, 0(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_b.1996
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 4(a0)
	fmul.s fa0, fa0, fa1
	flw fa1, 8(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 0(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_c.1998
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	la a0, min_caml_isoutside_q
	flw fa1, 8(a0)
	fmul.s fa0, fa0, fa1
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5784
	li	a0, 0
	j beq_cont.5785
beq_else.5784:
	li	a0, 1
beq_cont.5785:
	lw a1, 0(s10)
	sw a0, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_isinvert.1990
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a1, 24(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call xor.1977
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5786
	li	a0, 1
	ret
beq_else.5786:
	li	a0, 0
	ret
is_second_outside.2074:
	la a1, min_caml_isoutside_q
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call in_prod_sqr_obj.2051
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	lw a0, 0(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_form.1986
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 3
	bne a0, t0, beq_else.5788
	lui t0, %hi(l.4465)
	flw fa0, %lo(l.4465)(t0)
	flw fa1, 8(s10)
	fsub.s fa0, fa1, fa0
	j beq_cont.5789
beq_else.5788:
	flw fa0, 8(s10)
beq_cont.5789:
	lw a0, 0(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_isrot.1992
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5790
	flw fa0, 16(s10)
	j beq_cont.5791
beq_else.5790:
	la a1, min_caml_isoutside_q
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call in_prod_co_objrot.2054
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fadd.s fa0, fa1, fa0
beq_cont.5791:
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5792
	li	a0, 0
	j beq_cont.5793
beq_else.5792:
	li	a0, 1
beq_cont.5793:
	lw a1, 0(s10)
	sw a0, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_isinvert.1990
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a1, 24(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call xor.1977
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5794
	li	a0, 1
	ret
beq_else.5794:
	li	a0, 0
	ret
is_outside.2076:
	la a1, min_caml_isoutside_q
	la a2, min_caml_chkinside_p
	flw fa0, 0(a2)
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_x.2000
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_isoutside_q
	la a1, min_caml_chkinside_p
	flw fa0, 4(a1)
	lw a1, 0(s10)
	sw a0, 16(s10)
	fsw fa0, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_y.2002
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 16(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_isoutside_q
	la a1, min_caml_chkinside_p
	flw fa0, 8(a1)
	lw a1, 0(s10)
	sw a0, 32(s10)
	fsw fa0, 40(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_z.2004
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 32(s10)
	fsw fa0, 8(a0)
	lw a0, 0(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_form.1986
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	li t0, 1
	bne a0, t0, beq_else.5797
	lw a0, 0(s10)
	j is_rect_outside.2070
beq_else.5797:
	li t0, 2
	bne a0, t0, beq_else.5798
	lw a0, 0(s10)
	j is_plane_outside.2072
beq_else.5798:
	lw a0, 0(s10)
	j is_second_outside.2074
check_all_inside.2078:
	slli a2, a0, 2
	add t0, a1, a2
	lw a2, 0(t0)
	li	a3, 1
	neg	a3, a3
	bne a2, a3, beq_else.5799
	li	a0, 1
	ret
beq_else.5799:
	la a3, min_caml_objects
	slli a2, a2, 2
	add t0, a3, a2
	lw a2, 0(t0)
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 12(s10)
	addi s10, s10, 16
	call is_outside.2076
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5800
	lw a0, 4(s10)
	addi	a0, a0, 1
	lw a1, 0(s10)
	j check_all_inside.2078
beq_else.5800:
	li	a0, 0
	ret
shadow_check_and_group.2081:
	slli a3, a0, 2
	add t0, a1, a3
	lw a3, 0(t0)
	li	a4, 1
	neg	a4, a4
	bne a3, a4, beq_else.5801
	li	a0, 0
	ret
beq_else.5801:
	slli a3, a0, 2
	add t0, a1, a3
	lw a3, 0(t0)
	la a4, min_caml_light
	sw a2, 0(s10)
	sw a1, 4(s10)
	sw a0, 8(s10)
	sw a3, 12(s10)
	mv t0, ra
	mv a1, a4
	mv a0, a3
	sw t0, 20(s10)
	addi s10, s10, 24
	call solver.2066
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	la a1, min_caml_solver_dist
	flw fa0, 0(a1)
	li t0, 0
	bne a0, t0, beq_else.5802
	li	a0, 0
	j beq_cont.5803
beq_else.5802:
	lui t0, %hi(l.4708)
	flw fa1, %lo(l.4708)(t0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5804
	li	a0, 0
	j beq_cont.5805
beq_else.5804:
	li	a0, 1
beq_cont.5805:
beq_cont.5803:
	li t0, 0
	bne a0, t0, beq_else.5806
	la a0, min_caml_objects
	lw a1, 12(s10)
	slli a1, a1, 2
	add t0, a0, a1
	lw a0, 0(t0)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_isinvert.1990
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5807
	li	a0, 0
	ret
beq_else.5807:
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_and_group.2081
beq_else.5806:
	lui t0, %hi(l.4709)
	flw fa1, %lo(l.4709)(t0)
	fadd.s fa0, fa0, fa1
	la a0, min_caml_chkinside_p
	la a1, min_caml_light
	flw fa1, 0(a1)
	fmul.s fa1, fa1, fa0
	lw a1, 0(s10)
	flw fa2, 0(a1)
	fadd.s fa1, fa1, fa2
	fsw fa1, 0(a0)
	la a0, min_caml_chkinside_p
	la a2, min_caml_light
	flw fa1, 4(a2)
	fmul.s fa1, fa1, fa0
	flw fa2, 4(a1)
	fadd.s fa1, fa1, fa2
	fsw fa1, 4(a0)
	la a0, min_caml_chkinside_p
	la a2, min_caml_light
	flw fa1, 8(a2)
	fmul.s fa0, fa1, fa0
	flw fa1, 8(a1)
	fadd.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	li	a0, 0
	lw a2, 4(s10)
	mv t0, ra
	mv a1, a2
	sw t0, 20(s10)
	addi s10, s10, 24
	call check_all_inside.2078
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5808
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_and_group.2081
beq_else.5808:
	li	a0, 1
	ret
shadow_check_one_or_group.2085:
	slli a3, a0, 2
	add t0, a1, a3
	lw a3, 0(t0)
	li	a4, 1
	neg	a4, a4
	bne a3, a4, beq_else.5809
	li	a0, 0
	ret
beq_else.5809:
	la a4, min_caml_and_net
	slli a3, a3, 2
	add t0, a4, a3
	lw a3, 0(t0)
	li	a4, 0
	sw a2, 0(s10)
	sw a1, 4(s10)
	sw a0, 8(s10)
	mv t0, ra
	mv a1, a3
	mv a0, a4
	sw t0, 12(s10)
	addi s10, s10, 16
	call shadow_check_and_group.2081
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5810
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_one_or_group.2085
beq_else.5810:
	li	a0, 1
	ret
shadow_check_one_or_matrix.2089:
	slli a3, a0, 2
	add t0, a1, a3
	lw a3, 0(t0)
	lw a4, 0(a3)
	li	a5, 1
	neg	a5, a5
	bne a4, a5, beq_else.5811
	li	a0, 0
	ret
beq_else.5811:
	li t0, 99
	bne a4, t0, beq_else.5812
	li	a4, 1
	sw a2, 0(s10)
	sw a1, 4(s10)
	sw a0, 8(s10)
	mv t0, ra
	mv a1, a3
	mv a0, a4
	sw t0, 12(s10)
	addi s10, s10, 16
	call shadow_check_one_or_group.2085
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5813
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_one_or_matrix.2089
beq_else.5813:
	li	a0, 1
	ret
beq_else.5812:
	la a5, min_caml_light
	sw a3, 12(s10)
	sw a2, 0(s10)
	sw a1, 4(s10)
	sw a0, 8(s10)
	mv t0, ra
	mv a1, a5
	mv a0, a4
	sw t0, 20(s10)
	addi s10, s10, 24
	call solver.2066
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5814
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_one_or_matrix.2089
beq_else.5814:
	lui t0, %hi(l.4724)
	flw fa0, %lo(l.4724)(t0)
	la a0, min_caml_solver_dist
	flw fa1, 0(a0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5815
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_one_or_matrix.2089
beq_else.5815:
	li	a0, 1
	lw a1, 12(s10)
	lw a2, 0(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call shadow_check_one_or_group.2085
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5816
	lw a0, 8(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	lw a2, 0(s10)
	j shadow_check_one_or_matrix.2089
beq_else.5816:
	li	a0, 1
	ret
solve_each_element.2093:
	slli a2, a0, 2
	add t0, a1, a2
	lw a2, 0(t0)
	li	a3, 1
	neg	a3, a3
	bne a2, a3, beq_else.5817
	ret
beq_else.5817:
	la a3, min_caml_vscan
	la a4, min_caml_viewpoint
	sw a0, 0(s10)
	sw a1, 4(s10)
	sw a2, 8(s10)
	mv t0, ra
	mv a1, a3
	mv a0, a2
	mv a2, a4
	sw t0, 12(s10)
	addi s10, s10, 16
	call solver.2066
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5819
	la a0, min_caml_objects
	lw a1, 8(s10)
	slli a1, a1, 2
	add t0, a0, a1
	lw a0, 0(t0)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_isinvert.1990
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5821
	la a0, min_caml_end_flag
	li	a1, 1
	sw a1, 0(a0)
	j beq_cont.5822
beq_else.5821:
beq_cont.5822:
	j beq_cont.5820
beq_else.5819:
	la a1, min_caml_solver_dist
	flw fa0, 0(a1)
	lui t0, %hi(l.4724)
	flw fa1, %lo(l.4724)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5823
	j beq_cont.5824
beq_else.5823:
	la a1, min_caml_tmin
	flw fa1, 0(a1)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5825
	j beq_cont.5826
beq_else.5825:
	lui t0, %hi(l.4709)
	flw fa1, %lo(l.4709)(t0)
	fadd.s fa0, fa0, fa1
	la a1, min_caml_chkinside_p
	la a2, min_caml_vscan
	flw fa1, 0(a2)
	fmul.s fa1, fa1, fa0
	la a2, min_caml_viewpoint
	flw fa2, 0(a2)
	fadd.s fa1, fa1, fa2
	fsw fa1, 0(a1)
	la a1, min_caml_chkinside_p
	la a2, min_caml_vscan
	flw fa1, 4(a2)
	fmul.s fa1, fa1, fa0
	la a2, min_caml_viewpoint
	flw fa2, 4(a2)
	fadd.s fa1, fa1, fa2
	fsw fa1, 4(a1)
	la a1, min_caml_chkinside_p
	la a2, min_caml_vscan
	flw fa1, 8(a2)
	fmul.s fa1, fa1, fa0
	la a2, min_caml_viewpoint
	flw fa2, 8(a2)
	fadd.s fa1, fa1, fa2
	fsw fa1, 8(a1)
	li	a1, 0
	lw a2, 4(s10)
	sw a0, 12(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	mv a0, a1
	mv a1, a2
	sw t0, 28(s10)
	addi s10, s10, 32
	call check_all_inside.2078
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5827
	j beq_cont.5828
beq_else.5827:
	la a0, min_caml_tmin
	flw fa0, 16(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_crashed_point
	la a1, min_caml_chkinside_p
	flw fa0, 0(a1)
	fsw fa0, 0(a0)
	la a0, min_caml_crashed_point
	la a1, min_caml_chkinside_p
	flw fa0, 4(a1)
	fsw fa0, 4(a0)
	la a0, min_caml_crashed_point
	la a1, min_caml_chkinside_p
	flw fa0, 8(a1)
	fsw fa0, 8(a0)
	la a0, min_caml_intsec_rectside
	lw a1, 12(s10)
	sw a1, 0(a0)
	la a0, min_caml_crashed_object
	lw a1, 8(s10)
	sw a1, 0(a0)
beq_cont.5828:
beq_cont.5826:
beq_cont.5824:
beq_cont.5820:
	la a0, min_caml_end_flag
	lw a0, 0(a0)
	li t0, 0
	bne a0, t0, beq_else.5829
	lw a0, 0(s10)
	addi	a0, a0, 1
	lw a1, 4(s10)
	j solve_each_element.2093
beq_else.5829:
	ret
solve_one_or_network.2096:
	slli a2, a0, 2
	add t0, a1, a2
	lw a2, 0(t0)
	li	a3, 1
	neg	a3, a3
	bne a2, a3, beq_else.5831
	ret
beq_else.5831:
	la a3, min_caml_and_net
	slli a2, a2, 2
	add t0, a3, a2
	lw a2, 0(t0)
	la a3, min_caml_end_flag
	li	a4, 0
	sw a4, 0(a3)
	li	a3, 0
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	mv a1, a2
	mv a0, a3
	sw t0, 12(s10)
	addi s10, s10, 16
	call solve_each_element.2093
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	lw a0, 4(s10)
	addi	a0, a0, 1
	lw a1, 0(s10)
	j solve_one_or_network.2096
trace_or_matrix.2099:
	slli a2, a0, 2
	add t0, a1, a2
	lw a2, 0(t0)
	lw a3, 0(a2)
	li	a4, 1
	neg	a4, a4
	bne a3, a4, beq_else.5833
	ret
beq_else.5833:
	sw a1, 0(s10)
	sw a0, 4(s10)
	li t0, 99
	bne a3, t0, beq_else.5835
	li	a3, 1
	mv t0, ra
	mv a1, a2
	mv a0, a3
	sw t0, 12(s10)
	addi s10, s10, 16
	call solve_one_or_network.2096
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	j beq_cont.5836
beq_else.5835:
	la a4, min_caml_vscan
	la a5, min_caml_viewpoint
	sw a2, 8(s10)
	mv t0, ra
	mv a2, a5
	mv a1, a4
	mv a0, a3
	sw t0, 12(s10)
	addi s10, s10, 16
	call solver.2066
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5837
	j beq_cont.5838
beq_else.5837:
	la a0, min_caml_solver_dist
	flw fa0, 0(a0)
	la a0, min_caml_tmin
	flw fa1, 0(a0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5839
	j beq_cont.5840
beq_else.5839:
	li	a0, 1
	lw a1, 8(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call solve_one_or_network.2096
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
beq_cont.5840:
beq_cont.5838:
beq_cont.5836:
	lw a0, 4(s10)
	addi	a0, a0, 1
	lw a1, 0(s10)
	j trace_or_matrix.2099
tracer.2102:
	la a0, min_caml_tmin
	lui t0, %hi(l.4757)
	flw fa0, %lo(l.4757)(t0)
	fsw fa0, 0(a0)
	li	a0, 0
	la a1, min_caml_or_net
	lw a1, 0(a1)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call trace_or_matrix.2099
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_tmin
	flw fa0, 0(a0)
	lui t0, %hi(l.4724)
	flw fa1, %lo(l.4724)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5841
	li	a0, 0
	ret
beq_else.5841:
	lui t0, %hi(l.4761)
	flw fa1, %lo(l.4761)(t0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5842
	li	a0, 0
	ret
beq_else.5842:
	li	a0, 1
	ret
get_nvector_rect.2105:
	la a0, min_caml_intsec_rectside
	lw a0, 0(a0)
	li t0, 1
	bne a0, t0, beq_else.5843
	la a0, min_caml_nvector
	la a1, min_caml_vscan
	flw fa0, 0(a1)
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call sgn.2025
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 0(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 8(a0)
	ret
beq_else.5843:
	li t0, 2
	bne a0, t0, beq_else.5845
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	la a1, min_caml_vscan
	flw fa0, 4(a1)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call sgn.2025
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 4(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 8(a0)
	ret
beq_else.5845:
	li t0, 3
	bne a0, t0, beq_else.5847
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	la a1, min_caml_vscan
	flw fa0, 8(a1)
	sw a0, 8(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call sgn.2025
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 8(s10)
	fsw fa0, 8(a0)
	ret
beq_else.5847:
	ret
get_nvector_plane.2107:
	la a1, min_caml_nvector
	sw a0, 0(s10)
	sw a1, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_param_a.1994
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 4(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	lw a1, 0(s10)
	sw a0, 8(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_param_b.1996
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 8(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	lw a1, 0(s10)
	sw a0, 12(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_param_c.1998
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lw a0, 12(s10)
	fsw fa0, 8(a0)
	ret
get_nvector_second_norot.2109:
	la a2, min_caml_nvector
	flw fa0, 0(a1)
	sw a1, 0(s10)
	sw a2, 4(s10)
	sw a0, 8(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_x.2000
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 8(s10)
	fsw fa0, 24(s10)
	mv t0, ra
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_a.1994
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	lw a1, 0(s10)
	flw fa0, 4(a1)
	lw a2, 8(s10)
	sw a0, 32(s10)
	fsw fa0, 40(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 52(s10)
	addi s10, s10, 56
	call o_param_y.2002
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	flw fa1, 40(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 8(s10)
	fsw fa0, 48(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_b.1996
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 32(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	lw a1, 0(s10)
	flw fa0, 8(a1)
	lw a1, 8(s10)
	sw a0, 56(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 76(s10)
	addi s10, s10, 80
	call o_param_z.2004
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 8(s10)
	fsw fa0, 72(s10)
	mv t0, ra
	sw t0, 84(s10)
	addi s10, s10, 88
	call o_param_c.1998
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 56(s10)
	fsw fa0, 8(a0)
	la a0, min_caml_nvector
	lw a1, 8(s10)
	sw a0, 80(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 84(s10)
	addi s10, s10, 88
	call o_isinvert.1990
	addi s10, s10, -88
	lw t0, 84(s10)
	mv a1, a0
	mv ra, t0
	lw a0, 80(s10)
	j normalize_vector.2022
get_nvector_second_rot.2112:
	la a2, min_caml_nvector_w
	flw fa0, 0(a1)
	sw a0, 0(s10)
	sw a1, 4(s10)
	sw a2, 8(s10)
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_param_x.2000
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 8(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector_w
	lw a1, 4(s10)
	flw fa0, 4(a1)
	lw a2, 0(s10)
	sw a0, 24(s10)
	fsw fa0, 32(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 44(s10)
	addi s10, s10, 48
	call o_param_y.2002
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	flw fa1, 32(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 24(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector_w
	lw a1, 4(s10)
	flw fa0, 8(a1)
	lw a1, 0(s10)
	sw a0, 40(s10)
	fsw fa0, 48(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_z.2004
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 40(s10)
	fsw fa0, 8(a0)
	la a0, min_caml_nvector
	la a1, min_caml_nvector_w
	flw fa0, 0(a1)
	lw a1, 0(s10)
	sw a0, 56(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 76(s10)
	addi s10, s10, 80
	call o_param_a.1994
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 4(a0)
	lw a0, 0(s10)
	fsw fa0, 72(s10)
	fsw fa1, 80(s10)
	mv t0, ra
	sw t0, 92(s10)
	addi s10, s10, 96
	call o_param_r3.2020
	addi s10, s10, -96
	lw t0, 92(s10)
	mv ra, t0
	flw fa1, 80(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 8(a0)
	lw a0, 0(s10)
	fsw fa0, 88(s10)
	fsw fa1, 96(s10)
	mv t0, ra
	sw t0, 108(s10)
	addi s10, s10, 112
	call o_param_r2.2018
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	flw fa1, 96(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 88(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 108(s10)
	addi s10, s10, 112
	call fhalf.1982
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 56(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_nvector
	la a1, min_caml_nvector_w
	flw fa0, 4(a1)
	lw a1, 0(s10)
	sw a0, 104(s10)
	fsw fa0, 112(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 124(s10)
	addi s10, s10, 128
	call o_param_b.1996
	addi s10, s10, -128
	lw t0, 124(s10)
	mv ra, t0
	flw fa1, 112(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 0(a0)
	lw a0, 0(s10)
	fsw fa0, 120(s10)
	fsw fa1, 128(s10)
	mv t0, ra
	sw t0, 140(s10)
	addi s10, s10, 144
	call o_param_r3.2020
	addi s10, s10, -144
	lw t0, 140(s10)
	mv ra, t0
	flw fa1, 128(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 8(a0)
	lw a0, 0(s10)
	fsw fa0, 136(s10)
	fsw fa1, 144(s10)
	mv t0, ra
	sw t0, 156(s10)
	addi s10, s10, 160
	call o_param_r1.2016
	addi s10, s10, -160
	lw t0, 156(s10)
	mv ra, t0
	flw fa1, 144(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 136(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 156(s10)
	addi s10, s10, 160
	call fhalf.1982
	addi s10, s10, -160
	lw t0, 156(s10)
	mv ra, t0
	flw fa1, 120(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 104(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_nvector
	la a1, min_caml_nvector_w
	flw fa0, 8(a1)
	lw a1, 0(s10)
	sw a0, 152(s10)
	fsw fa0, 160(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 172(s10)
	addi s10, s10, 176
	call o_param_c.1998
	addi s10, s10, -176
	lw t0, 172(s10)
	mv ra, t0
	flw fa1, 160(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 0(a0)
	lw a0, 0(s10)
	fsw fa0, 168(s10)
	fsw fa1, 176(s10)
	mv t0, ra
	sw t0, 188(s10)
	addi s10, s10, 192
	call o_param_r2.2018
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	flw fa1, 176(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_nvector_w
	flw fa1, 4(a0)
	lw a0, 0(s10)
	fsw fa0, 184(s10)
	fsw fa1, 192(s10)
	mv t0, ra
	sw t0, 204(s10)
	addi s10, s10, 208
	call o_param_r1.2016
	addi s10, s10, -208
	lw t0, 204(s10)
	mv ra, t0
	flw fa1, 192(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 184(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 204(s10)
	addi s10, s10, 208
	call fhalf.1982
	addi s10, s10, -208
	lw t0, 204(s10)
	mv ra, t0
	flw fa1, 168(s10)
	fadd.s fa0, fa1, fa0
	lw a0, 152(s10)
	fsw fa0, 8(a0)
	la a0, min_caml_nvector
	lw a1, 0(s10)
	sw a0, 200(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 204(s10)
	addi s10, s10, 208
	call o_isinvert.1990
	addi s10, s10, -208
	lw t0, 204(s10)
	mv a1, a0
	mv ra, t0
	lw a0, 200(s10)
	j normalize_vector.2022
get_nvector.2115:
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_form.1986
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 1
	bne a0, t0, beq_else.5860
	j get_nvector_rect.2105
beq_else.5860:
	li t0, 2
	bne a0, t0, beq_else.5861
	lw a0, 4(s10)
	j get_nvector_plane.2107
beq_else.5861:
	lw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_isrot.1992
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5862
	lw a0, 4(s10)
	lw a1, 0(s10)
	j get_nvector_second_norot.2109
beq_else.5862:
	lw a0, 4(s10)
	lw a1, 0(s10)
	j get_nvector_second_rot.2112
utexture.2118:
	sw a1, 0(s10)
	sw a0, 4(s10)
	mv t0, ra
	sw t0, 12(s10)
	addi s10, s10, 16
	call o_texturetype.1984
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	la a1, min_caml_texture_color
	lw a2, 4(s10)
	sw a0, 8(s10)
	sw a1, 12(s10)
	mv t0, ra
	mv a0, a2
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_color_red.2010
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	lw a0, 12(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_texture_color
	lw a1, 4(s10)
	sw a0, 16(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 20(s10)
	addi s10, s10, 24
	call o_color_green.2012
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	lw a0, 16(s10)
	fsw fa0, 4(a0)
	la a0, min_caml_texture_color
	lw a1, 4(s10)
	sw a0, 20(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 28(s10)
	addi s10, s10, 32
	call o_color_blue.2014
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	lw a0, 20(s10)
	fsw fa0, 8(a0)
	lw a0, 8(s10)
	li t0, 1
	bne a0, t0, beq_else.5863
	lw a0, 0(s10)
	flw fa0, 0(a0)
	lw a1, 4(s10)
	fsw fa0, 24(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 36(s10)
	addi s10, s10, 40
	call o_param_x.2000
	addi s10, s10, -40
	lw t0, 36(s10)
	mv ra, t0
	flw fa1, 24(s10)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4827)
	flw fa1, %lo(l.4827)(t0)
	fmul.s fa1, fa0, fa1
	fsw fa0, 32(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 44(s10)
	addi s10, s10, 48
	call min_caml_floor
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	lui t0, %hi(l.4828)
	flw fa1, %lo(l.4828)(t0)
	fmul.s fa0, fa0, fa1
	lui t0, %hi(l.4819)
	flw fa1, %lo(l.4819)(t0)
	flw fa2, 32(s10)
	fsub.s fa0, fa2, fa0
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5864
	li	a0, 0
	j beq_cont.5865
beq_else.5864:
	li	a0, 1
beq_cont.5865:
	lw a1, 0(s10)
	flw fa0, 8(a1)
	lw a1, 4(s10)
	sw a0, 40(s10)
	fsw fa0, 48(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_param_z.2004
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4827)
	flw fa1, %lo(l.4827)(t0)
	fmul.s fa1, fa0, fa1
	fsw fa0, 56(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 68(s10)
	addi s10, s10, 72
	call min_caml_floor
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	lui t0, %hi(l.4828)
	flw fa1, %lo(l.4828)(t0)
	fmul.s fa0, fa0, fa1
	lui t0, %hi(l.4819)
	flw fa1, %lo(l.4819)(t0)
	flw fa2, 56(s10)
	fsub.s fa0, fa2, fa0
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5867
	li	a0, 0
	j beq_cont.5868
beq_else.5867:
	li	a0, 1
beq_cont.5868:
	la a1, min_caml_texture_color
	lw a2, 40(s10)
	li t0, 0
	bne a2, t0, beq_else.5869
	li t0, 0
	bne a0, t0, beq_else.5871
	lui t0, %hi(l.4814)
	flw fa0, %lo(l.4814)(t0)
	j beq_cont.5872
beq_else.5871:
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
beq_cont.5872:
	j beq_cont.5870
beq_else.5869:
	li t0, 0
	bne a0, t0, beq_else.5873
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	j beq_cont.5874
beq_else.5873:
	lui t0, %hi(l.4814)
	flw fa0, %lo(l.4814)(t0)
beq_cont.5874:
beq_cont.5870:
	fsw fa0, 4(a1)
	ret
beq_else.5863:
	li t0, 2
	bne a0, t0, beq_else.5876
	lw a0, 0(s10)
	flw fa0, 4(a0)
	lui t0, %hi(l.4823)
	flw fa1, %lo(l.4823)(t0)
	fmul.s fa0, fa0, fa1
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call min_caml_sin
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call fsqr.1980
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	la a0, min_caml_texture_color
	lui t0, %hi(l.4814)
	flw fa1, %lo(l.4814)(t0)
	fmul.s fa1, fa1, fa0
	fsw fa1, 0(a0)
	la a0, min_caml_texture_color
	lui t0, %hi(l.4814)
	flw fa1, %lo(l.4814)(t0)
	lui t0, %hi(l.4465)
	flw fa2, %lo(l.4465)(t0)
	fsub.s fa0, fa2, fa0
	fmul.s fa0, fa1, fa0
	fsw fa0, 4(a0)
	ret
beq_else.5876:
	li t0, 3
	bne a0, t0, beq_else.5878
	lw a0, 0(s10)
	flw fa0, 0(a0)
	lw a1, 4(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 76(s10)
	addi s10, s10, 80
	call o_param_x.2000
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 0(s10)
	flw fa1, 8(a0)
	lw a0, 4(s10)
	fsw fa0, 72(s10)
	fsw fa1, 80(s10)
	mv t0, ra
	sw t0, 92(s10)
	addi s10, s10, 96
	call o_param_z.2004
	addi s10, s10, -96
	lw t0, 92(s10)
	mv ra, t0
	flw fa1, 80(s10)
	fsub.s fa0, fa1, fa0
	flw fa1, 72(s10)
	fsw fa0, 88(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 100(s10)
	addi s10, s10, 104
	call fsqr.1980
	addi s10, s10, -104
	lw t0, 100(s10)
	mv ra, t0
	flw fa1, 88(s10)
	fsw fa0, 96(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 108(s10)
	addi s10, s10, 112
	call fsqr.1980
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	flw fa1, 96(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 108(s10)
	addi s10, s10, 112
	call min_caml_sqrt
	addi s10, s10, -112
	lw t0, 108(s10)
	mv ra, t0
	lui t0, %hi(l.4819)
	flw fa1, %lo(l.4819)(t0)
	fdiv.s fa0, fa0, fa1
	fsw fa0, 104(s10)
	mv t0, ra
	sw t0, 116(s10)
	addi s10, s10, 120
	call min_caml_floor
	addi s10, s10, -120
	lw t0, 116(s10)
	mv ra, t0
	flw fa1, 104(s10)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4810)
	flw fa1, %lo(l.4810)(t0)
	fmul.s fa0, fa0, fa1
	mv t0, ra
	sw t0, 116(s10)
	addi s10, s10, 120
	call min_caml_cos
	addi s10, s10, -120
	lw t0, 116(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 116(s10)
	addi s10, s10, 120
	call fsqr.1980
	addi s10, s10, -120
	lw t0, 116(s10)
	mv ra, t0
	la a0, min_caml_texture_color
	lui t0, %hi(l.4814)
	flw fa1, %lo(l.4814)(t0)
	fmul.s fa1, fa0, fa1
	fsw fa1, 4(a0)
	la a0, min_caml_texture_color
	lui t0, %hi(l.4465)
	flw fa1, %lo(l.4465)(t0)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4814)
	flw fa1, %lo(l.4814)(t0)
	fmul.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	ret
beq_else.5878:
	li t0, 4
	bne a0, t0, beq_else.5880
	lw a0, 0(s10)
	flw fa0, 0(a0)
	lw a1, 4(s10)
	fsw fa0, 112(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 124(s10)
	addi s10, s10, 128
	call o_param_x.2000
	addi s10, s10, -128
	lw t0, 124(s10)
	mv ra, t0
	flw fa1, 112(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 120(s10)
	mv t0, ra
	sw t0, 132(s10)
	addi s10, s10, 136
	call o_param_a.1994
	addi s10, s10, -136
	lw t0, 132(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 132(s10)
	addi s10, s10, 136
	call min_caml_sqrt
	addi s10, s10, -136
	lw t0, 132(s10)
	mv ra, t0
	flw fa1, 120(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 0(s10)
	flw fa1, 8(a0)
	lw a1, 4(s10)
	fsw fa0, 128(s10)
	fsw fa1, 136(s10)
	mv t0, ra
	mv a0, a1
	sw t0, 148(s10)
	addi s10, s10, 152
	call o_param_z.2004
	addi s10, s10, -152
	lw t0, 148(s10)
	mv ra, t0
	flw fa1, 136(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 144(s10)
	mv t0, ra
	sw t0, 156(s10)
	addi s10, s10, 160
	call o_param_c.1998
	addi s10, s10, -160
	lw t0, 156(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 156(s10)
	addi s10, s10, 160
	call min_caml_sqrt
	addi s10, s10, -160
	lw t0, 156(s10)
	mv ra, t0
	flw fa1, 144(s10)
	fmul.s fa0, fa1, fa0
	flw fa1, 128(s10)
	fsw fa0, 152(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 164(s10)
	addi s10, s10, 168
	call fsqr.1980
	addi s10, s10, -168
	lw t0, 164(s10)
	mv ra, t0
	flw fa1, 152(s10)
	fsw fa0, 160(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 172(s10)
	addi s10, s10, 176
	call fsqr.1980
	addi s10, s10, -176
	lw t0, 172(s10)
	mv ra, t0
	flw fa1, 160(s10)
	fadd.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 172(s10)
	addi s10, s10, 176
	call min_caml_sqrt
	addi s10, s10, -176
	lw t0, 172(s10)
	mv ra, t0
	lui t0, %hi(l.4807)
	flw fa1, %lo(l.4807)(t0)
	flw fa2, 128(s10)
	fsw fa0, 168(s10)
	fsw fa1, 176(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 188(s10)
	addi s10, s10, 192
	call min_caml_abs_float
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	flw fa1, 176(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5881
	flw fa0, 128(s10)
	flw fa1, 152(s10)
	fdiv.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 188(s10)
	addi s10, s10, 192
	call min_caml_abs_float
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 188(s10)
	addi s10, s10, 192
	call min_caml_atan
	addi s10, s10, -192
	lw t0, 188(s10)
	mv ra, t0
	lui t0, %hi(l.4809)
	flw fa1, %lo(l.4809)(t0)
	lui t0, %hi(l.4810)
	flw fa2, %lo(l.4810)(t0)
	fdiv.s fa1, fa1, fa2
	fmul.s fa0, fa0, fa1
	j beq_cont.5882
beq_else.5881:
	lui t0, %hi(l.4808)
	flw fa0, %lo(l.4808)(t0)
beq_cont.5882:
	fsw fa0, 184(s10)
	mv t0, ra
	sw t0, 196(s10)
	addi s10, s10, 200
	call min_caml_floor
	addi s10, s10, -200
	lw t0, 196(s10)
	mv ra, t0
	flw fa1, 184(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 0(s10)
	flw fa2, 4(a0)
	lw a0, 4(s10)
	fsw fa0, 192(s10)
	fsw fa2, 200(s10)
	mv t0, ra
	sw t0, 212(s10)
	addi s10, s10, 216
	call o_param_y.2002
	addi s10, s10, -216
	lw t0, 212(s10)
	mv ra, t0
	flw fa1, 200(s10)
	fsub.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 208(s10)
	mv t0, ra
	sw t0, 220(s10)
	addi s10, s10, 224
	call o_param_b.1996
	addi s10, s10, -224
	lw t0, 220(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 220(s10)
	addi s10, s10, 224
	call min_caml_sqrt
	addi s10, s10, -224
	lw t0, 220(s10)
	mv ra, t0
	flw fa1, 208(s10)
	fmul.s fa0, fa1, fa0
	lui t0, %hi(l.4807)
	flw fa1, %lo(l.4807)(t0)
	flw fa2, 184(s10)
	fsw fa0, 216(s10)
	fsw fa1, 224(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 236(s10)
	addi s10, s10, 240
	call min_caml_abs_float
	addi s10, s10, -240
	lw t0, 236(s10)
	mv ra, t0
	flw fa1, 224(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5883
	flw fa0, 168(s10)
	flw fa1, 216(s10)
	fdiv.s fa0, fa1, fa0
	mv t0, ra
	sw t0, 236(s10)
	addi s10, s10, 240
	call min_caml_abs_float
	addi s10, s10, -240
	lw t0, 236(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 236(s10)
	addi s10, s10, 240
	call min_caml_atan
	addi s10, s10, -240
	lw t0, 236(s10)
	mv ra, t0
	lui t0, %hi(l.4809)
	flw fa1, %lo(l.4809)(t0)
	lui t0, %hi(l.4810)
	flw fa2, %lo(l.4810)(t0)
	fdiv.s fa1, fa1, fa2
	fmul.s fa0, fa0, fa1
	j beq_cont.5884
beq_else.5883:
	lui t0, %hi(l.4808)
	flw fa0, %lo(l.4808)(t0)
beq_cont.5884:
	fsw fa0, 232(s10)
	mv t0, ra
	sw t0, 244(s10)
	addi s10, s10, 248
	call min_caml_floor
	addi s10, s10, -248
	lw t0, 244(s10)
	mv ra, t0
	flw fa1, 232(s10)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4812)
	flw fa1, %lo(l.4812)(t0)
	lui t0, %hi(l.4813)
	flw fa2, %lo(l.4813)(t0)
	flw fa3, 192(s10)
	fsub.s fa2, fa2, fa3
	fsw fa0, 240(s10)
	fsw fa1, 248(s10)
	mv t0, ra
	fmv.s fa0, fa2
	sw t0, 260(s10)
	addi s10, s10, 264
	call fsqr.1980
	addi s10, s10, -264
	lw t0, 260(s10)
	mv ra, t0
	flw fa1, 248(s10)
	fsub.s fa0, fa1, fa0
	lui t0, %hi(l.4813)
	flw fa1, %lo(l.4813)(t0)
	flw fa2, 240(s10)
	fsub.s fa1, fa1, fa2
	fsw fa0, 256(s10)
	mv t0, ra
	fmv.s fa0, fa1
	sw t0, 268(s10)
	addi s10, s10, 272
	call fsqr.1980
	addi s10, s10, -272
	lw t0, 268(s10)
	mv ra, t0
	flw fa1, 256(s10)
	fsub.s fa0, fa1, fa0
	la a0, min_caml_texture_color
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5885
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	j beq_cont.5886
beq_else.5885:
	lui t0, %hi(l.4814)
	flw fa1, %lo(l.4814)(t0)
	lui t0, %hi(l.4815)
	flw fa2, %lo(l.4815)(t0)
	fdiv.s fa1, fa1, fa2
	fmul.s fa0, fa0, fa1
beq_cont.5886:
	fsw fa0, 8(a0)
	ret
beq_else.5880:
	ret
in_prod.2121:
	flw fa0, 0(a0)
	flw fa1, 0(a1)
	fmul.s fa0, fa0, fa1
	flw fa1, 4(a0)
	flw fa2, 4(a1)
	fmul.s fa1, fa1, fa2
	fadd.s fa0, fa0, fa1
	flw fa1, 8(a0)
	flw fa2, 8(a1)
	fmul.s fa1, fa1, fa2
	fadd.s fa0, fa0, fa1
	ret
accumulate_vec_mul.2124:
	flw fa1, 0(a0)
	flw fa2, 0(a1)
	fmul.s fa2, fa0, fa2
	fadd.s fa1, fa1, fa2
	fsw fa1, 0(a0)
	flw fa1, 4(a0)
	flw fa2, 4(a1)
	fmul.s fa2, fa0, fa2
	fadd.s fa1, fa1, fa2
	fsw fa1, 4(a0)
	flw fa1, 8(a0)
	flw fa2, 8(a1)
	fmul.s fa0, fa0, fa2
	fadd.s fa0, fa1, fa0
	fsw fa0, 8(a0)
	ret
raytracing.2128:
	la a1, min_caml_viewpoint
	la a2, min_caml_vscan
	fsw fa0, 0(s10)
	sw a0, 8(s10)
	mv t0, ra
	mv a0, a1
	mv a1, a2
	sw t0, 12(s10)
	addi s10, s10, 16
	call tracer.2102
	addi s10, s10, -16
	lw t0, 12(s10)
	mv ra, t0
	sw a0, 12(s10)
	li t0, 0
	bne a0, t0, beq_else.5890
	lw a1, 8(s10)
	li t0, 0
	bne a1, t0, beq_else.5892
	j beq_cont.5893
beq_else.5892:
	la a2, min_caml_vscan
	la a3, min_caml_light
	mv t0, ra
	mv a1, a3
	mv a0, a2
	sw t0, 20(s10)
	addi s10, s10, 24
	call in_prod.2121
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5894
	j beq_cont.5895
beq_else.5894:
	fsw fa0, 16(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call fsqr.1980
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	flw fa1, 16(s10)
	fmul.s fa0, fa0, fa1
	flw fa1, 0(s10)
	fmul.s fa0, fa0, fa1
	la a0, min_caml_beam
	flw fa2, 0(a0)
	fmul.s fa0, fa0, fa2
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa2, 0(a1)
	fadd.s fa2, fa2, fa0
	fsw fa2, 0(a0)
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa2, 4(a1)
	fadd.s fa2, fa2, fa0
	fsw fa2, 4(a0)
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa2, 8(a1)
	fadd.s fa0, fa2, fa0
	fsw fa0, 8(a0)
beq_cont.5895:
beq_cont.5893:
	j beq_cont.5891
beq_else.5890:
beq_cont.5891:
	lw a0, 12(s10)
	li t0, 0
	bne a0, t0, beq_else.5896
	ret
beq_else.5896:
	la a0, min_caml_objects
	la a1, min_caml_crashed_object
	lw a1, 0(a1)
	slli a1, a1, 2
	add t0, a0, a1
	lw a0, 0(t0)
	la a1, min_caml_crashed_point
	sw a0, 24(s10)
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call get_nvector.2115
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li	a0, 0
	la a1, min_caml_or_net
	lw a1, 0(a1)
	la a2, min_caml_crashed_point
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call shadow_check_one_or_matrix.2089
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	li t0, 0
	bne a0, t0, beq_else.5898
	la a0, min_caml_nvector
	la a1, min_caml_light
	mv t0, ra
	sw t0, 28(s10)
	addi s10, s10, 32
	call in_prod.2121
	addi s10, s10, -32
	lw t0, 28(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5900
	lui t0, %hi(l.4856)
	flw fa1, %lo(l.4856)(t0)
	fadd.s fa0, fa0, fa1
	j beq_cont.5901
beq_else.5900:
	lui t0, %hi(l.4856)
	flw fa0, %lo(l.4856)(t0)
beq_cont.5901:
	flw fa1, 0(s10)
	fmul.s fa0, fa0, fa1
	lw a0, 24(s10)
	fsw fa0, 32(s10)
	mv t0, ra
	sw t0, 44(s10)
	addi s10, s10, 48
	call o_diffuse.2006
	addi s10, s10, -48
	lw t0, 44(s10)
	mv ra, t0
	flw fa1, 32(s10)
	fmul.s fa0, fa1, fa0
	j beq_cont.5899
beq_else.5898:
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
beq_cont.5899:
	la a1, min_caml_crashed_point
	lw a0, 24(s10)
	fsw fa0, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call utexture.2118
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	la a0, min_caml_rgb
	la a1, min_caml_texture_color
	flw fa0, 40(s10)
	mv t0, ra
	sw t0, 52(s10)
	addi s10, s10, 56
	call accumulate_vec_mul.2124
	addi s10, s10, -56
	lw t0, 52(s10)
	mv ra, t0
	lw a0, 8(s10)
	li t0, 4
	bgt a0, t0, ble_else.5903
	lui t0, %hi(l.4857)
	flw fa0, %lo(l.4857)(t0)
	flw fa1, 0(s10)
	fle.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5904
	ret
beq_else.5904:
	lui t0, %hi(l.4858)
	flw fa0, %lo(l.4858)(t0)
	la a1, min_caml_vscan
	la a2, min_caml_nvector
	fsw fa0, 48(s10)
	mv t0, ra
	mv a0, a1
	mv a1, a2
	sw t0, 60(s10)
	addi s10, s10, 64
	call in_prod.2121
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	flw fa1, 48(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_vscan
	la a1, min_caml_nvector
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call accumulate_vec_mul.2124
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	lw a0, 24(s10)
	mv t0, ra
	sw t0, 60(s10)
	addi s10, s10, 64
	call o_reflectiontype.1988
	addi s10, s10, -64
	lw t0, 60(s10)
	mv ra, t0
	li t0, 1
	bne a0, t0, beq_else.5906
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	lw a0, 24(s10)
	fsw fa0, 56(s10)
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call o_hilight.2008
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	flw fa1, 56(s10)
	feq.s t0, fa1, fa0
	addi t1, zero, 1
	bne t0, t1, beq_else.5907
	ret
beq_else.5907:
	la a0, min_caml_vscan
	la a1, min_caml_light
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call in_prod.2121
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	fneg.s fa0, fa0
	lui t0, %hi(l.4464)
	flw fa1, %lo(l.4464)(t0)
	fle.s t0, fa0, fa1
	addi t1, zero, 1
	bne t0, t1, beq_else.5909
	ret
beq_else.5909:
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call fsqr.1980
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 68(s10)
	addi s10, s10, 72
	call fsqr.1980
	addi s10, s10, -72
	lw t0, 68(s10)
	mv ra, t0
	flw fa1, 0(s10)
	fmul.s fa0, fa0, fa1
	flw fa1, 40(s10)
	fmul.s fa0, fa0, fa1
	lw a0, 24(s10)
	fsw fa0, 64(s10)
	mv t0, ra
	sw t0, 76(s10)
	addi s10, s10, 80
	call o_hilight.2008
	addi s10, s10, -80
	lw t0, 76(s10)
	mv ra, t0
	flw fa1, 64(s10)
	fmul.s fa0, fa1, fa0
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa1, 0(a1)
	fadd.s fa1, fa1, fa0
	fsw fa1, 0(a0)
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa1, 4(a1)
	fadd.s fa1, fa1, fa0
	fsw fa1, 4(a0)
	la a0, min_caml_rgb
	la a1, min_caml_rgb
	flw fa1, 8(a1)
	fadd.s fa0, fa1, fa0
	fsw fa0, 8(a0)
	ret
beq_else.5906:
	li t0, 2
	bne a0, t0, beq_else.5912
	la a0, min_caml_viewpoint
	la a1, min_caml_crashed_point
	flw fa0, 0(a1)
	fsw fa0, 0(a0)
	la a0, min_caml_viewpoint
	la a1, min_caml_crashed_point
	flw fa0, 4(a1)
	fsw fa0, 4(a0)
	la a0, min_caml_viewpoint
	la a1, min_caml_crashed_point
	flw fa0, 8(a1)
	fsw fa0, 8(a0)
	lui t0, %hi(l.4465)
	flw fa0, %lo(l.4465)(t0)
	lw a0, 24(s10)
	fsw fa0, 72(s10)
	mv t0, ra
	sw t0, 84(s10)
	addi s10, s10, 88
	call o_diffuse.2006
	addi s10, s10, -88
	lw t0, 84(s10)
	mv ra, t0
	flw fa1, 72(s10)
	fsub.s fa0, fa1, fa0
	flw fa1, 0(s10)
	fmul.s fa0, fa1, fa0
	lw a0, 8(s10)
	addi	a0, a0, 1
	j raytracing.2128
beq_else.5912:
	ret
ble_else.5903:
	ret
write_rgb.2131:
	la a0, min_caml_rgb
	flw fa0, 0(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_int_of_float
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li t0, 255
	bgt a0, t0, ble_else.5915
	j ble_cont.5916
ble_else.5915:
	li	a0, 255
ble_cont.5916:
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_rgb
	flw fa0, 4(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_int_of_float
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li t0, 255
	bgt a0, t0, ble_else.5917
	j ble_cont.5918
ble_else.5917:
	li	a0, 255
ble_cont.5918:
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_rgb
	flw fa0, 8(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_int_of_float
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li t0, 255
	bgt a0, t0, ble_else.5919
	j ble_cont.5920
ble_else.5919:
	li	a0, 255
ble_cont.5920:
	j min_caml_print_byte
write_ppm_header.2133:
	li	a0, 80
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 48
	addi	a0, a0, 6
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 10
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_size
	lw a0, 0(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 32
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_size
	lw a0, 4(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 10
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_byte
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 255
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_print_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	li	a0, 10
	j min_caml_print_byte
scan_point.2135:
	la a1, min_caml_size
	lw a1, 0(a1)
	bgt a1, a0, ble_else.5921
	ret
ble_else.5921:
	sw a0, 0(s10)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_float_of_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_scan_offset
	flw fa1, 0(a0)
	fsub.s fa0, fa0, fa1
	la a0, min_caml_scan_d
	flw fa1, 0(a0)
	fmul.s fa0, fa0, fa1
	la a0, min_caml_vscan
	la a1, min_caml_cos_v
	flw fa1, 4(a1)
	fmul.s fa1, fa0, fa1
	la a1, min_caml_wscan
	flw fa2, 0(a1)
	fadd.s fa1, fa1, fa2
	fsw fa1, 0(a0)
	la a0, min_caml_vscan
	la a1, min_caml_scan_sscany
	flw fa1, 0(a1)
	la a1, min_caml_cos_v
	flw fa2, 0(a1)
	fmul.s fa1, fa1, fa2
	la a1, min_caml_vp
	flw fa2, 4(a1)
	fsub.s fa1, fa1, fa2
	fsw fa1, 4(a0)
	la a0, min_caml_vscan
	fneg.s fa1, fa0
	la a1, min_caml_sin_v
	flw fa2, 4(a1)
	fmul.s fa1, fa1, fa2
	la a1, min_caml_wscan
	flw fa2, 8(a1)
	fadd.s fa1, fa1, fa2
	fsw fa1, 8(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call fsqr.1980
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_scan_met1
	flw fa1, 0(a0)
	fadd.s fa0, fa0, fa1
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_sqrt
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_vscan
	la a1, min_caml_vscan
	flw fa1, 0(a1)
	fdiv.s fa1, fa1, fa0
	fsw fa1, 0(a0)
	la a0, min_caml_vscan
	la a1, min_caml_vscan
	flw fa1, 4(a1)
	fdiv.s fa1, fa1, fa0
	fsw fa1, 4(a0)
	la a0, min_caml_vscan
	la a1, min_caml_vscan
	flw fa1, 8(a1)
	fdiv.s fa0, fa1, fa0
	fsw fa0, 8(a0)
	la a0, min_caml_viewpoint
	la a1, min_caml_view
	flw fa0, 0(a1)
	fsw fa0, 0(a0)
	la a0, min_caml_viewpoint
	la a1, min_caml_view
	flw fa0, 4(a1)
	fsw fa0, 4(a0)
	la a0, min_caml_viewpoint
	la a1, min_caml_view
	flw fa0, 8(a1)
	fsw fa0, 8(a0)
	la a0, min_caml_rgb
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 0(a0)
	la a0, min_caml_rgb
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 4(a0)
	la a0, min_caml_rgb
	lui t0, %hi(l.4464)
	flw fa0, %lo(l.4464)(t0)
	fsw fa0, 8(a0)
	li	a0, 0
	lui t0, %hi(l.4465)
	flw fa0, %lo(l.4465)(t0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call raytracing.2128
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call write_rgb.2131
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	lw a0, 0(s10)
	addi	a0, a0, 1
	j scan_point.2135
scan_line.2137:
	la a1, min_caml_size
	lw a1, 0(a1)
	bgt a1, a0, ble_else.5923
	ret
ble_else.5923:
	la a1, min_caml_scan_sscany
	la a2, min_caml_scan_offset
	flw fa0, 0(a2)
	lui t0, %hi(l.4465)
	flw fa1, %lo(l.4465)(t0)
	fsub.s fa0, fa0, fa1
	sw a0, 0(s10)
	sw a1, 4(s10)
	fsw fa0, 8(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call min_caml_float_of_int
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	flw fa1, 8(s10)
	fsub.s fa0, fa1, fa0
	la a0, min_caml_scan_d
	flw fa1, 0(a0)
	fmul.s fa0, fa1, fa0
	lw a0, 4(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_scan_met1
	la a1, min_caml_scan_sscany
	flw fa0, 0(a1)
	sw a0, 16(s10)
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call fsqr.1980
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	lui t0, %hi(l.4910)
	flw fa1, %lo(l.4910)(t0)
	fadd.s fa0, fa0, fa1
	lw a0, 16(s10)
	fsw fa0, 0(a0)
	la a0, min_caml_scan_sscany
	flw fa0, 0(a0)
	la a0, min_caml_sin_v
	flw fa1, 0(a0)
	fmul.s fa0, fa0, fa1
	la a0, min_caml_wscan
	la a1, min_caml_sin_v
	flw fa1, 4(a1)
	fmul.s fa1, fa0, fa1
	la a1, min_caml_vp
	flw fa2, 0(a1)
	fsub.s fa1, fa1, fa2
	fsw fa1, 0(a0)
	la a0, min_caml_wscan
	la a1, min_caml_cos_v
	flw fa1, 4(a1)
	fmul.s fa0, fa0, fa1
	la a1, min_caml_vp
	flw fa1, 8(a1)
	fsub.s fa0, fa0, fa1
	fsw fa0, 8(a0)
	li	a0, 0
	mv t0, ra
	sw t0, 20(s10)
	addi s10, s10, 24
	call scan_point.2135
	addi s10, s10, -24
	lw t0, 20(s10)
	mv ra, t0
	lw a0, 0(s10)
	addi	a0, a0, 1
	j scan_line.2137
scan_start.2139:
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call write_ppm_header.2133
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_size
	lw a0, 0(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call min_caml_float_of_int
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	la a0, min_caml_scan_d
	lui t0, %hi(l.4921)
	flw fa1, %lo(l.4921)(t0)
	fdiv.s fa1, fa1, fa0
	fsw fa1, 0(a0)
	la a0, min_caml_scan_offset
	lui t0, %hi(l.4440)
	flw fa1, %lo(l.4440)(t0)
	fdiv.s fa0, fa0, fa1
	fsw fa0, 0(a0)
	li	a0, 0
	j scan_line.2137
rt.2141:
	la a3, min_caml_size
	sw a0, 0(a3)
	la a0, min_caml_size
	sw a1, 4(a0)
	la a0, min_caml_dbg
	sw a2, 0(a0)
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call read_parameter.2043
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
	j scan_start.2139
min_caml_start: # main entry point
	mv s10, a0
	mv s11, a1
	addi s10, s10, 16
	sw ra, -8(s10)
	sw s0, -4(s10)
	addi s0, s10, -16
#	main program starts
	li	a0, 128
	li	a1, 128
	li	a2, 0
	mv t0, ra
	sw t0, 4(s10)
	addi s10, s10, 8
	call rt.2141
	addi s10, s10, -8
	lw t0, 4(s10)
	mv ra, t0
#	main program ends
	lw ra, -8(s10)
	lw s0, -4(s10)
	addi s10, s10, -16
	ret
