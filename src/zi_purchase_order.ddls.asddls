@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_PURCHASE_ORDER
  as select from    I_PurchaseOrderAPI01 as Header
    left outer join zdt_po_print2        as po on po.purchaseorder = Header.PurchaseOrder
  composition [0..*] of ZI_PURCHASE_ORDER_ITEM as _Item
{
  key Header.PurchaseOrder,
      Header.PurchaseOrderDate,
      Header.CreatedByUser,
      Header.CreationDate,
      Header.PurchaseOrderType,
      Header.PurchasingGroup,
      Header.PurchasingOrganization,
      concat( '/sap/opu/odata4/sap/zsb_purchase_print_api/srvd_a2x/sap/zsd_purchase_print1/0001/ZCE_PURCHASE_PRINT1(''', concat( Header.PurchaseOrder, ''')/Form' )) as FormURL,

      'Print PDF'                                                                                                                                                    as Form,
      _Item
}
