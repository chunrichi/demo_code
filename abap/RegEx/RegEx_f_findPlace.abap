*&---------------------------------------------------------------------*
*& Report RegEx
*&---------------------------------------------------------------------*
*&    文件                    ：RegEx --> RegEx_f_findPlace.abap
*&    作者                    ：Lei
*&    日期                    ：2019年12月19日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - 正则匹配 + 找到对应数据的位置（起始位置 + 结束位置)
*&     - 方法匹配
*&     - 
*&---------------------------------------------------------------------*
REPORT RegEx.

DATA(lv_regex) = '^/category/([0-9]{1,5})/item/([0-9]{1,2})$'.
DATA(lv_text) = '/category/12345/item/12'.

FIND REGEX lv_regex IN lv_text RESULTS DATA(ls_results).

LOOP AT ls_results-submatches ASSIGNING FIELD-SYMBOL(<s>).
  WRITE: / substring( val = lv_text off = <s>-offset len = <s>-length ).
ENDLOOP.

" 下面方法类似上面的
" DATA(lv_regex) = '^/category/([0-9]{1,5})/item/([0-9]{1,2})$'.
" DATA(lv_text) = '/category/12345/item/12'.

" FIND ALL OCCURRENCES OF REGEX lv_regex IN lv_text RESULTS DATA(it_results).

" LOOP AT it_results ASSIGNING FIELD-SYMBOL(<r>).
"   LOOP AT <r>-submatches ASSIGNING FIELD-SYMBOL(<s>).
"     WRITE: / substring( val = lv_text off = <s>-offset len = <s>-length ).
"   ENDLOOP.
" ENDLOOP.