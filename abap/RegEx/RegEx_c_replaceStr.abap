*&---------------------------------------------------------------------*
*& Report RegEx
*&---------------------------------------------------------------------*
*&    文件                    ：RegEx --> RegEx_replaceStr.abap
*&    作者                    ：Lei
*&    日期                    ：2019年12月19日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - 正则匹配 + 替换所有匹配的内容
*&     - 类匹配(c)
*&     - 
*&---------------------------------------------------------------------*
REPORT RegEx.

* placeholder: 通配符，要替换掉的字符串
DATA(lv_placeholder) = |<>|.
* Replacement: 替换字符
DATA(lv_replacement) = | and |.

* 查找字符串中所有出现的占位符
DATA(matcher) = cl_abap_matcher=>create( pattern     = lv_placeholder
                                         text        = 'the bast you <> world.'
                                         ignore_case = abap_true ).

* 替换所有的占位符
IF matcher->replace_all( lv_replacement ) > 0.
  WRITE: / matcher->text.
ELSE.
  WRITE: / |{ lv_placeholder } is not exists in the string.|.
ENDIF.