*&---------------------------------------------------------------------*
*& Report SelectScreen
*&---------------------------------------------------------------------*
*&    文件                    ：SelectScreen --> popup_demo.abap
*&    作者                    ：Lei
*&    日期                    ：2020年01月17日
*&---------------------------------------------------------------------*
*& 摘要：
*&     - popup系列函数的demo
*&     -
*&     -
*&---------------------------------------------------------------------*
REPORT selectscreen.

TABLES sscrfields.

DEFINE ggg.
  SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT (40) text&1.
  PARAMETERS &1 TYPE flag RADIOBUTTON GROUP rb1.
  SELECTION-SCREEN END OF LINE.
END-OF-DEFINITION.

DATA:ans(8) TYPE c.
DATA r TYPE c LENGTH 12.

SELECTION-SCREEN FUNCTION KEY 1.
PARAMETERS r1 TYPE flag RADIOBUTTON GROUP rb1 USER-COMMAND dis.

ggg : r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12.

INITIALIZATION.
  textr2 = 'POPUP_WITH_TABLE_DISPLAY'.
  textr3 = 'POPUP_TO_CONFIRM_STEP'.
  textr4 = 'POPUP_TO_DECIDE_WITH_MESSAGE'.
  textr5 = 'POPUP_TO_DECIDE'.
  textr6 = 'POPUP_TO_SELECT_MONTH'.
  textr7 = 'POPUP_TO_CONFIRM_WITH_VALUE'.
  textr8 = 'POPUP_TO_CONFIRM_WITH_MESSAGE'.
  textr9 = 'POPUP_TO_DISPLAY_TEXT'.
  textr10 = 'POPUP_TO_CONFIRM'.
  textr11 = 'POPUP_TO_CONTINUE_YES_NO'.
  textr12 = 'POPUP_TO_CONFIRM_DATA_LOSS'.

*AT SELECTION-SCREEN OUTPUT.
  sscrfields-functxt_01 = 'NEXT'.

AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC01'.
      SHIFT r RIGHT BY 1 PLACES.
      DATA x TYPE i.
      DEFINE hhh.
        x = &1 - 1.
        r&1 = r+x(1).
      END-OF-DEFINITION.
      hhh : 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12.
      IF r IS INITIAL. r = 'X'. r1 = 'X'. ENDIF.
      PERFORM process.
*    when 'EXIT'.
*    Leave program.
    WHEN 'DIS'.
      PERFORM process.
  ENDCASE.

*&---------------------------------------------------------------------*
*&      Form  PROCESS
*&---------------------------------------------------------------------*
FORM process.
  IF r1 EQ 'X'.
    PERFORM popup_to_inform.
  ENDIF.
  IF r2 EQ 'X'.
    PERFORM popup_with_table_display.
  ENDIF.
  IF r3 EQ 'X'.
    PERFORM popup_to_confirm_step.
  ENDIF.
  IF r4 EQ 'X'.
*---popup_to_decide_with_message
    PERFORM popup_to_deci_with_mess.
  ENDIF.
  IF r5 EQ 'X'.
*---popup_to_decide
    PERFORM popup_to_decide.
  ENDIF.
  IF r6 EQ 'X'.
*---popup_to_select_month
    PERFORM popup_to_select_month.
  ENDIF.
  IF r7 EQ 'X'.
*---popup_to_confirm_with_value
    PERFORM popup_to_confirm_with_val.
  ENDIF.
  IF r8 EQ 'X'.
*---popup_to_confirm_with_message
    PERFORM popup_to_confirm_with_message.
  ENDIF.
  IF r9 EQ 'X'.
*---popup to display text
    PERFORM popup_to_display_text.
  ENDIF.
  IF r10 EQ 'X'.
*---popup_to_confirm
    PERFORM popup_to_confirm.
  ENDIF.
  IF r11 EQ 'X'.
*---popup_to_continue_yes_no
    PERFORM popup_to_cont_yes_no.
  ENDIF.
  IF r12 EQ 'X'.
*---popup_to_confirm_data_loss
    PERFORM popup_to_confirm_data_loss.
  ENDIF.
ENDFORM.                    "process
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_INFORM
*&---------------------------------------------------------------------*
FORM popup_to_inform .
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'Title Information'
      txt1  = 'Use of'
      txt2  = 'POPUP_TO_INFORM'
      txt3  = 'Text 3'
      txt4  = 'Text 4'.
ENDFORM.                    " POPUP_TO_INFORM
*&---------------------------------------------------------------------*
*&      Form  POPUP_WITH_TABLE_DISPLAY
*&---------------------------------------------------------------------*
FORM popup_with_table_display .
  DATA: BEGIN OF itab OCCURS 0,
          name(10)   TYPE c,
          tel_no(12) TYPE c,
          mob_no(12) TYPE c,
        END OF itab.
  itab-name    = 'Jitender'.
  itab-tel_no  = '0114556654' .
  itab-mob_no  = '981145'.
  APPEND itab .
  CLEAR itab.
  itab-name    = 'Narender'.
  itab-tel_no  = '0114588954' .
  itab-mob_no  = '987745'.
  APPEND itab .
  CLEAR itab.
  itab-name    = 'Priyank'.
  itab-tel_no  = '0118996654' .
  itab-mob_no  = '984545'.
  APPEND itab .
  CLEAR itab.
  CALL FUNCTION 'POPUP_WITH_TABLE_DISPLAY'
    EXPORTING
      endpos_col   = 80
      endpos_row   = 25
      startpos_col = 1
      startpos_row = 1
      titletext    = 'Title POPUP_WITH_TABLE_DISPLAY'
*   IMPORTING
*     CHOISE       =
    TABLES
      valuetab     = itab
    EXCEPTIONS
      break_off    = 1
      OTHERS       = 2.
ENDFORM.                    " POPUP_WITH_TABLE_DISPLAY
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_STEP
*&---------------------------------------------------------------------*
FORM popup_to_confirm_step .
  CALL FUNCTION 'POPUP_TO_CONFIRM_STEP'
    EXPORTING
      defaultoption  = 'Y'
      textline1      = 'Title Line1'
      textline2      = 'Title Line2'
      titel          = 'Title POPUP_TO_CONFIRM_STEP'
      start_column   = 25
      start_row      = 6
      cancel_display = ' '
*---if you want to display the cancel button put X in above
    IMPORTING
      answer         = ans.
  IF ans = 'J' .
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed Yes'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ELSE.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed No'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ENDIF.
ENDFORM.                    " POPUP_TO_CONFIRM_STEP
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_DECI_WITH_MESS
*&---------------------------------------------------------------------*
FORM popup_to_deci_with_mess .
  CALL FUNCTION 'POPUP_TO_DECIDE_WITH_MESSAGE'
    EXPORTING
      defaultoption     = '1'
      diagnosetext1     = 'this is text1'
      diagnosetext2     = 'this is text2 '
      diagnosetext3     = 'this is text3 '
      textline1         = 'this is test4'
      textline2         = 'this is text5 '
      textline3         = 'this is text6 '
      text_option1      = 'YES'
      text_option2      = 'NO'
      icon_text_option1 = 'icon_okay'
      icon_text_option2 = 'icon_cancel'
      titel             = 'Title POPUP_TO_DECIDE_WITH_MESSAGE'
      start_column      = 25
      start_row         = 6
*----for the display of cancel button  do like this.
      cancel_display    = ' '
    IMPORTING
      answer            = ans.
  IF ans = '1' .
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed Yes'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ELSE.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed No'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ENDIF.
ENDFORM.                    " POPUP_TO_DECI_WITH_MESS
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_DECIDE
*&---------------------------------------------------------------------*
FORM popup_to_decide .
  CALL FUNCTION 'POPUP_TO_DECIDE'
    EXPORTING
      defaultoption     = '1'
      textline1         = 'this is text1'
      textline2         = 'this is text2'
      textline3         = 'this is text3'
      text_option1      = 'YES'
      text_option2      = 'NO'
      icon_text_option1 = 'icon_okay'
      icon_text_option2 = 'icon_cancel '
      titel             = 'Title POPUP_TO_DECIDE'
      start_column      = 30
      start_row         = 7
*----for the display of cancel button  do like this.
      cancel_display    = ' '
    IMPORTING
      answer            = ans.
  IF ans = 1 .
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed Yes'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ELSE.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed No'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ENDIF.
ENDFORM.                    " POPUP_TO_DECIDE
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_SELECT_MONTH
*&---------------------------------------------------------------------*
FORM popup_to_select_month .
  DATA: sel_mon TYPE isellist-month .
  CALL FUNCTION 'POPUP_TO_SELECT_MONTH'
    EXPORTING
      actual_month   = '200812'
    IMPORTING
      selected_month = sel_mon.
  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'Information'
      txt1  = 'Month'
      txt2  = sel_mon+4(2)
      txt3  = 'Year'
      txt4  = sel_mon+0(4).
ENDFORM.                    " POPUP_TO_SELECT_MONTH
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_WITH_VAL
*&---------------------------------------------------------------------*
FORM popup_to_confirm_with_val .
  CALL FUNCTION 'POPUP_TO_CONFIRM_WITH_VALUE'
    EXPORTING
      defaultoption  = 'Y'
      objectvalue    = '10000000'
      text_after     = 'This is after the value '
      text_before    = 'This is before the value '
      titel          = 'Title POPUP_TO_CONFIRM_WITH_VALUE'
      start_column   = 25
      start_row      = 6
*----for the display of cancel button  do like this.
      cancel_display = ' '
    IMPORTING
      answer         = ans
    EXCEPTIONS
      text_too_long  = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  IF ans = 'J' .
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed Yes'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ELSE.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Information'
        txt1  = 'You have pressed No'
        txt2  = ' '
        txt3  = ' '
        txt4  = ' '.
  ENDIF.
ENDFORM.                    " POPUP_TO_CONFIRM_WITH_VAL
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_WITH_MESSAGE
*&---------------------------------------------------------------------*
FORM popup_to_confirm_with_message .
  CALL FUNCTION 'POPUP_TO_CONFIRM_WITH_MESSAGE'
    EXPORTING
      defaultoption  = 'Y'
      diagnosetext1  = 'This is Testing'
      diagnosetext2  = ' '
      diagnosetext3  = ' '
      textline1      = 'Do You want to Exit'
      textline2      = ' '
      titel          = 'POPUP_TO_CONFIRM_WITH_MESSAGE'
      start_column   = 25
      start_row      = 6
*----for the display of cancel button  do like this.
      cancel_display = ' '
    IMPORTING
      answer         = ans.
  IF ans = 'J' .
*---put code on selecting yes
  ELSE.
*---put code on selecting no
  ENDIF.
ENDFORM.                    " POPUP_TO_CONFIRM_WITH_MESSAGE
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_DISPLAY_TEXT
*&---------------------------------------------------------------------*
FORM popup_to_display_text .
  CALL FUNCTION 'POPUP_TO_DISPLAY_TEXT'
    EXPORTING
      titel        = 'Title POPUP_TO_DISPLAY_TEXT'
      textline1    = 'Message to display'
      textline2    = ' '
      start_column = 25
      start_row    = 6.
ENDFORM.                    " POPUP_TO_DISPLAY_TEXT
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM
*&---------------------------------------------------------------------*
FORM popup_to_confirm .
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Title POPUP_TO_CONFIRM'
      text_question         = 'Click Cancel to Exit'
      text_button_1         = 'OK'
      icon_button_1         = 'ICON_CHECKED'
      text_button_2         = 'CANCEL'
      icon_button_2         = 'ICON_CANCEL'
      display_cancel_button = ' '
      popup_type            = 'ICON_MESSAGE_ERROR'
    IMPORTING
      answer                = ans.
  IF ans = 2.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.                    " POPUP_TO_CONFIRM
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONT_YES_NO
*&---------------------------------------------------------------------*
FORM popup_to_cont_yes_no .
  CALL FUNCTION 'POPUP_CONTINUE_YES_NO'
    EXPORTING
      textline1 = 'Click OK to leave program'
      titel     = 'POPUP_CONTINUE_YES_NO'
    IMPORTING
      answer    = ans.
  IF ans = 'J'.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.                    " POPUP_TO_CONT_YES_NO
*&---------------------------------------------------------------------*
*&      Form  POPUP_TO_CONFIRM_DATA_LOSS
*&---------------------------------------------------------------------*
FORM popup_to_confirm_data_loss .
  CALL FUNCTION 'POPUP_TO_CONFIRM_DATA_LOSS'
    EXPORTING
      defaultoption = 'J'
      titel         = 'CONFIRMATION'
*     START_COLUMN  = 25
*     START_ROW     = 6
    IMPORTING
      answer        = ans.
  IF ans = 'J'.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.                    " POPUP_TO_CONFIRM_DATA_LOSS