*&---------------------------------------------------------------------*
*& Report SelectScreen
*&---------------------------------------------------------------------*
*&    文件                    ：SelectScreen --> select_p_dropdownBox.abap
*&    作者                    ：Lei
*&    日期                    ：2019年12月20日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - 选择下拉框 + 单行空格显示
*&     - 
*&     - 
*&---------------------------------------------------------------------*
REPORT SelectScreen.

TABLES: mara.
TYPE-POOLS: vrm.

DATA: gs_matnr TYPE RANGES OF mara-matnr.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (10) ff_text.
PARAMETERS: p_fld1 TYPE mara-matnr AS LISTBOX VISIBLE LENGTH 20.

SELECTION-SCREEN POSITION 40.

SELECTION-SCREEN COMMENT (10) tf_text.
PARAMETERS: p_fld2 TYPE mara-matnr AS LISTBOX VISIBLE LENGTH 20.
SELECTION-SCREEN END OF LINE.

INITIALIZATION.

  ff_text = 'From Field'.
  tf_text = 'To Field'.

  PERFORM build_user_drop_down_list.

START-OF-SELECTION.

  gs_matnr-sign = 'I'.
  gs_matnr-option = 'BT'.
  gs_matnr-low = p_fld1.
  gs_matnr-high = p_fld2.
  APPEND gs_matnr.

* Now you can use the R_MATNR in a select statement.


************************************************************************
* build user_drop_down_list
************************************************************************
FORM build_user_drop_down_list.

  DATA: name  TYPE vrm_id,
        list  TYPE vrm_values,
        value LIKE LINE OF list.

  CLEAR list. REFRESH list.

  CLEAR value.
  value-key = 'MATA'.
  value-text = 'Material A'.
  APPEND value TO list.
  CLEAR value.
  value-key = 'MATB'.
  value-text = 'Material B'.
  APPEND value TO list.
  CLEAR value.
  value-key = 'MATC'.
  value-text = 'Material C'.
  APPEND value TO list.
  CLEAR value.
  value-key = 'MATD'.
  value-text = 'Material D'.
  APPEND value TO list.
  CLEAR value.
  value-key = 'MATE'.
  value-text = 'Material E'.
  APPEND value TO list.


* Set the values for P_FLD1
  name = 'P_FLD1'.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = name
      values = list.

* Set values for P_FLD2
  name = 'P_FLD2'.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = name
      values = list.

ENDFORM.