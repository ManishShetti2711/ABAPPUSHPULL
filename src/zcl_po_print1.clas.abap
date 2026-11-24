CLASS zcl_po_print1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PO_PRINT1 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA: ls_form_data TYPE zce_purchase_print1,
          gt_form_data TYPE TABLE OF zce_purchase_print1,
          lt_form_data TYPE TABLE OF zce_purchase_print1,
          lo_reader    TYPE REF TO if_fp_form_base_reader,
          lo_fdp_api   TYPE REF TO if_fp_fdp_api,
          lv_po_number TYPE ebeln.
    TRY.
        TRY.
            DATA(lv_filters) = io_request->get_filter( )->get_as_sql_string( ).
          CATCH cx_rap_query_filter_no_range INTO DATA(cx_mg).
            DATA(filterexception_message) = cl_message_helper=>get_latest_t100_exception( cx_mg )->if_message~get_longtext( ).
        ENDTRY.

        SELECT *
            FROM zi_purchase_order
            WHERE (lv_filters)
            INTO TABLE @DATA(lt_podata).

        TRY.
            "Initiate the Fore Template Reader
            lo_reader = cl_fp_form_reader=>create_form_reader( 'ZFRM_PURCHASE_ORDER' ).

            DATA(lv_layout) = lo_reader->get_layout( ).
          CATCH cx_fp_form_reader INTO DATA(ls_cx_fp_form_reader).
        ENDTRY.

        TRY.
            lo_fdp_api = cl_fp_fdp_services=>get_instance(
                                        iv_service_definition = 'ZSD_PURCHASE_ORDER'
                                        iv_max_depth          = 1 ).

            " Corrected: Use 'lt_keys' for the table
            DATA(lt_keys) = lo_fdp_api->get_keys( ).

            LOOP AT lt_podata INTO DATA(ls_podata).
              " Update the key value for the specific PO
              IF line_exists( lt_keys[ name = 'PURCHASEORDER' ] ).
                lt_keys[ name = 'PURCHASEORDER' ]-value = ls_podata-PurchaseOrder.
              ENDIF.

              " Retrieve XML data
              DATA(lv_xml_data) = lo_fdp_api->read_to_xml_v2(
                                      it_select = lt_keys
                                  ).

              TRY.
                  cl_fp_ads_util=>render_pdf(
                      EXPORTING
                        iv_xml_data   = lv_xml_data
                        iv_xdp_layout = lv_layout
                        iv_locale     = 'en_US'
                      IMPORTING
                        ev_pdf        = DATA(lv_pdf_raw)
                  ).
                CATCH cx_fp_ads_util INTO DATA(lx_ads).

              ENDTRY.


              APPEND VALUE #(
                PurchaseOrder          = ls_podata-PurchaseOrder
                PurchaseOrderDate      = ls_podata-PurchaseOrderDate
                CreatedByUser          = ls_podata-CreatedByUser
                CreationDate           = ls_podata-CreationDate
                PurchaseOrderType      = ls_podata-PurchaseOrderType
                PurchasingGroup        = ls_podata-PurchasingGroup
                PurchasingOrganization = ls_podata-PurchasingOrganization
                Form                   = lv_pdf_raw
                FileName               = |PO_{ ls_podata-PurchaseOrder }.pdf|
                MimyType               = 'application/pdf'
               ) TO lt_form_data.

            ENDLOOP.
          CATCH cx_fp_fdp_error INTO DATA(lx_fdp).
            " Handle FDP error here
        ENDTRY.

        DATA(lv_top) = io_request->get_paging( )->get_page_size( ).

        IF lv_top < 0.
          lv_top = 1.
        ENDIF.

        DATA(lv_skip) = io_request->get_paging( )->get_offset( ).

        DATA(lv_start) = lv_skip + 1.
        DATA(lv_end) = lv_skip + lv_top.

        APPEND LINES OF lt_form_data FROM lv_start TO lv_end TO gt_form_data.

        io_response->set_total_number_of_records( lines( lt_form_data ) ).
        io_response->set_data( gt_form_data ).


      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
