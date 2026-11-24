@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_PURCHASE_ORDER
  provider contract transactional_query
  as projection on ZI_PURCHASE_ORDER
{
          @EndUserText.label: 'Purchase Order'
  key     PurchaseOrder,
          @EndUserText.label: 'PO Date'
          PurchaseOrderDate,
          @EndUserText.label: 'Created By'
          CreatedByUser,
          @EndUserText.label: 'Creation Date'
          CreationDate,
          @EndUserText.label: 'Purchase Order Type'
          PurchaseOrderType,
          @EndUserText.label: 'Purchasing Group'
          PurchasingGroup,
          @EndUserText.label: 'Purchasing Organization'
          PurchasingOrganization,
          Form,
          FormURL,
          /* Associations */
          _Item : redirected to composition child ZC_PURCHASE_ORDER_ITEM
}
