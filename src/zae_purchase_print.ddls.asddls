@EndUserText.label: 'Purchase Order Print Abstract View'
define abstract entity ZAE_PURCHASE_PRINT
{
      FileName : abap.char(50);
      MimeType : abap.char(50);

      @Semantics.largeObject: {
        mimeType    : 'MimeType',
        fileName    : 'FileName',
        contentDispositionPreference: #INLINE
      }
      Form     : abap.rawstring(0);
}
