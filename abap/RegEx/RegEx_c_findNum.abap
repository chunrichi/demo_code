*&---------------------------------------------------------------------*
*& Report RegEx
*&---------------------------------------------------------------------*
*&    文件                    ：RegEx --> RegEx_c_findNum.abap
*&    作者                    ：Lei
*&    日期                    ：2019年12月19日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - 正则匹配 + 数字类型 （浮点数 + 整数）
*&     - 类匹配
*&     - 
*&---------------------------------------------------------------------*
REPORT RegEx.

DATA: lv_in TYPE string VALUE '-1.23'. " oder 1.23E-10 oder -1
DATA: lv_out TYPE f.

DATA(matcher) = cl_abap_matcher=>create( pattern = '^[-+]?[0-9]*[.]?[0-9]+([eE][-+]?[0-9]+)?$'
                                         text = lv_in
                                         ignore_case = abap_true ).

IF matcher->match( ) = abap_true.
  lv_out = lv_in.
  WRITE: / lv_out.
ENDIF.