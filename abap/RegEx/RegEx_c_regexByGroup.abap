*&---------------------------------------------------------------------*
*& Report RegEx
*&---------------------------------------------------------------------*
*&    文件                    ：RegEx --> RegEx_regexByGroup.abap
*&    作者                    ：Lei
*&    日期                    ：2019年12月19日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - 正则匹配 + 分组正则
*&     - 类匹配(c)
*&     - 
*&---------------------------------------------------------------------*
REPORT RegEx.

* 匹配出字符串中含有 定长数字的内容
DATA(matcher) = cl_abap_matcher=>create( pattern     = '^/category/([0-9]{1,5})/item/([0-9]{1,2})$'
                                         text        = '/category/12345/item/12'
                                         ignore_case = abap_true ).

IF abap_true = matcher->match( ).
* 第一组获取的
  WRITE: / matcher->get_submatch( 1 ).
* 第二组获取的
  WRITE: / matcher->get_submatch( 2 ).
ENDIF.