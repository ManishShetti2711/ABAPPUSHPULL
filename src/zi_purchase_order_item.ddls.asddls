@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Item Details'
//@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_PURCHASE_ORDER_ITEM
  as select from I_PurchaseOrderItemAPI01 as Item
  association to parent ZI_PURCHASE_ORDER as _Header on $projection.PurchaseOrder = _Header.PurchaseOrder
{
  key Item.PurchaseOrder,
  key Item.PurchaseOrderItem,
      Item.Material,
      _ProductText[Language = $session.system_language].ProductName,
      Item.ProductType,
      Item.PurchaseOrderItemText,
      Item.BaseUnit,
      Item.DocumentCurrency,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Item.OrderQuantity,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      Item.NetPriceAmount,
      _Header
}
