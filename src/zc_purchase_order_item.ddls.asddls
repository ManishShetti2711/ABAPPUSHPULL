@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_PURCHASE_ORDER_ITEM
  as projection on ZI_PURCHASE_ORDER_ITEM
{
      @EndUserText.label: 'Purchase Order'
  key PurchaseOrder,
      @EndUserText.label: 'PO Item'
  key PurchaseOrderItem,
      @EndUserText.label: 'Product'
      Material,
      @EndUserText.label: 'Product Description'
      ProductName,
      @EndUserText.label: 'Product Type'
      ProductType,
      @EndUserText.label: 'PO Item Text'
      PurchaseOrderItemText,
      @EndUserText.label: 'Base Unit'
      BaseUnit,
      @EndUserText.label: 'Currency'
      DocumentCurrency,
      @EndUserText.label: 'Order Quantity'
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      OrderQuantity,
      @EndUserText.label: 'Net Price Amount'
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      NetPriceAmount,
      /* Associations */
      _Header: redirected to parent ZC_PURCHASE_ORDER
}
