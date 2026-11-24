CLASS lhc_ZI_PURCHASE_ORDER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_purchase_order RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchase_order RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_purchase_order.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ zi_purchase_order\_Item FULL result_requested RESULT result LINK association_links.

    METHODS Print FOR MODIFY
      IMPORTING keys FOR ACTION zi_purchase_order~Print RESULT result.

ENDCLASS.

CLASS lhc_ZI_PURCHASE_ORDER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Item.
  ENDMETHOD.



  METHOD Print.
    LOOP AT keys INTO DATA(ls_key).
      TRY.
          " 1. FDP Instance
          DATA(lo_fdp_api) = cl_fp_fdp_services=>get_instance(
              iv_service_definition = 'ZSD_PURCHASE_ORDER'
              iv_max_depth          = 1 ).

          DATA(lt_fdp_keys) = lo_fdp_api->get_keys( ).
          lt_fdp_keys[ name = 'PURCHASEORDER' ]-value = ls_key-purchaseorder.

          " 2. Generate XML
          DATA(lv_xml_data) = lo_fdp_api->read_to_xml_v2( it_select = lt_fdp_keys ).

          " 3. Render PDF
          DATA(lo_reader) = cl_fp_form_reader=>create_form_reader( 'ZFRM_PURCHASE_ORDER' ).
          DATA(lv_layout) = lo_reader->get_layout( ).

          cl_fp_ads_util=>render_pdf(
              EXPORTING
                iv_xml_data   = lv_xml_data
                iv_xdp_layout = lv_layout
                iv_locale     = 'en_US'
              IMPORTING
                ev_pdf        = DATA(lv_pdf_raw)
          ).

          " 4. Return PDF directly in %param → triggers popup
          APPEND VALUE #(
                %tky   = ls_key-%tky
                %param = VALUE #(
                    FileName = |PO_{ ls_key-PurchaseOrder }.pdf|
                    MimeType = 'application/pdf'
                    Form     = lv_pdf_raw
                )
            ) TO result.

        CATCH cx_root INTO DATA(lx_error).
          APPEND VALUE #(
              %tky        = ls_key-%tky
              %fail-cause = if_abap_behv=>cause-unspecific
          ) TO failed-zi_purchase_order.
          APPEND VALUE #(
              %tky = ls_key-%tky
              %msg = new_message_with_text(
                       severity = if_abap_behv_message=>severity-error
                       text     = lx_error->get_text( ) )
          ) TO reported-zi_purchase_order.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.

CLASS lhc_ZI_PURCHASE_ORDER_ITEM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_purchase_order_item RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ zi_purchase_order_item\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_PURCHASE_ORDER_ITEM IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_PURCHASE_ORDER DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_PURCHASE_ORDER IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
