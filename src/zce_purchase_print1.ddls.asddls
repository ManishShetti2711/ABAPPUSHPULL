@EndUserText.label: 'Download the Form at Column Level'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_PO_PRINT1'
@UI.headerInfo:{
    typeName: 'Purchase Order Print',
    typeNamePlural: 'Purchase Order Prints',
    title.value: 'PurchaseOrder',
    description.value: 'CreatedByUser'
}
define custom entity ZCE_PURCHASE_PRINT1
{
      @UI.facet              : [{
          id                 : 'ZCL_PO_PRINT1',
          purpose            : #STANDARD,
          type               : #IDENTIFICATION_REFERENCE,
          label              : 'Purchase Order Print',
          position           : 10
       }]

      @UI.lineItem           : [{ position: 10, label: 'Purchase Order' }]
      @UI.identification     : [{ position: 10, label: 'Purchase Order' }]
      @UI.selectionField     : [{ position: 10 }]
      @Consumption.valueHelpDefinition: [
                                { entity: {
                                    name: 'I_PurchaseOrderAPI01',
                                    element: 'PurchaseOrder' }
                                 } ]
      @EndUserText.label     : 'Purchase Order'
      @Consumption.filter.mandatory: true
  key PurchaseOrder          : ebeln;

      @UI.lineItem           : [{ position: 20, label:'Purchase Order Date' }]
      @UI.identification     : [{ position: 20, label:'Purchase Order Date' }]
      @UI.selectionField     : [{ position: 20 }]
      @EndUserText.label     : 'Purchase Order Date'
      PurchaseOrderDate      : bedat;

      @UI.lineItem           : [{ position: 30, label:'Created By' }]
      @UI.identification     : [{ position: 30, label:'Created By' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Created By'
      CreatedByUser          : ernam;

      @UI.lineItem           : [{ position: 40, label:'Creation Date' }]
      @UI.identification     : [{ position: 40, label:'Creation Date' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Creation Date'
      CreationDate           : erdat;

      @UI.lineItem           : [{ position: 50, label:'PO Type' }]
      @UI.identification     : [{ position: 50, label:'PO Type' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'PO Type'
      PurchaseOrderType      : abap.char(4);

      @UI.lineItem           : [{ position: 60, label:'Purchasing Group' }]
      @UI.identification     : [{ position: 60, label:'Purchasing Group' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Purchasing Group'
      PurchasingGroup        : abap.char(3);

      @UI.lineItem           : [{ position: 70, label:'Purchasing Organization' }]
      @UI.identification     : [{ position: 70, label:'Purchasing Organization' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Purchasing Organization'
      PurchasingOrganization : ekorg;

      @Semantics.largeObject : { mimeType: 'MimyType',
                                 fileName: 'FileName',
                                 contentDispositionPreference: #INLINE }
      @UI.lineItem           : [{ position: 80, label:'Form' }]
      @UI.identification     : [{ position: 80, label:'Form' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Form'
      Form                   : abap.rawstring( 0 );

      @UI.lineItem           : [{ position: 90, label:'File Name' }]
      @UI.identification     : [{ position: 90, label:'File Name' }]
      @Consumption.filter.hidden  : true
      @UI.hidden             : true
      FileName               : abap.char(50);

      @UI.lineItem           : [{ position: 100, label:'Mimy Type' }]
      @UI.identification     : [{ position: 100, label:'Mimy Type' }]
      @Consumption.filter.hidden  : true
      @EndUserText.label     : 'Mimy Type'
      @UI.hidden: true
      MimyType               : abap.char( 50 );
}
