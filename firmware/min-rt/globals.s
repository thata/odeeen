        # firmware.hex に変換する際に変な感じになるので、text セクションに入れている
        .text
        .align 4
        .global min_caml_objects
min_caml_objects:
        .space 480
        .global min_caml_size
min_caml_size:
        .space 16
        .global min_caml_dbg
min_caml_dbg:
        .space 8
        .global min_caml_screen
min_caml_screen:
        .space 24
        .global min_caml_vp
min_caml_vp:
        .space 24
        .global min_caml_view
min_caml_view:
        .space 24
        .global min_caml_light
min_caml_light:
        .space 24
        .global min_caml_cos_v
min_caml_cos_v:
        .space 16
        .global min_caml_sin_v
min_caml_sin_v:
        .space 16
        .global min_caml_beam
min_caml_beam:
        .space 8
        .global min_caml_and_net
min_caml_and_net:
        .space 400
        .global min_caml_or_net
min_caml_or_net:
        .space 8
        .global min_caml_temp
min_caml_temp:
        .space 112
        .global min_caml_cs_temp
min_caml_cs_temp:
        .space 128
        .global min_caml_solver_dist
min_caml_solver_dist:
        .space 8
        .global min_caml_vscan
min_caml_vscan:
        .space 24
        .global min_caml_intsec_rectside
min_caml_intsec_rectside:
        .space 8
        .global min_caml_tmin
min_caml_tmin:
        .space 8
        .global min_caml_crashed_point
min_caml_crashed_point:
        .space 24
        .global min_caml_crashed_object
min_caml_crashed_object:
        .space 8
        .global min_caml_end_flag
min_caml_end_flag:
        .space 8
        .global min_caml_viewpoint
min_caml_viewpoint:
        .space 24
        .global min_caml_nvector
min_caml_nvector:
        .space 24
        .global min_caml_rgb
min_caml_rgb:
        .space 24
        .global min_caml_texture_color
min_caml_texture_color:
        .space 24
        .global min_caml_solver_w_vec
min_caml_solver_w_vec:
        .space 24
        .global min_caml_chkinside_p
min_caml_chkinside_p:
        .space 24
        .global min_caml_isoutside_q
min_caml_isoutside_q:
        .space 24
        .global min_caml_nvector_w
min_caml_nvector_w:
        .space 24
        .global min_caml_scan_d
min_caml_scan_d:
        .space 8
        .global min_caml_scan_offset
min_caml_scan_offset:
        .space 8
        .global min_caml_scan_sscany
min_caml_scan_sscany:
        .space 8
        .global min_caml_scan_met1
min_caml_scan_met1:
        .space 8
        .global min_caml_wscan
min_caml_wscan:
        .space 24
