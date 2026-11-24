@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZADOBE_STORE'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_DTADOBE_STORE
  as select from zdt_adobe_store
{
  key formtemplate       as Formtemplate,

      //      @Semantics.mimeType: true
      mimetype           as Mimetype,
      @Semantics.mimeType: true
      filename           as Filename,
      @Semantics.largeObject:{
               mimeType: 'Mimetype',
               fileName: 'Filename',
               contentDispositionPreference: #ATTACHMENT
             }
      @EndUserText.label: 'XDP'
      attachment         as Attachment,
      @Semantics.largeObject:{
               mimeType: 'Mimetype',
               fileName: 'Filename',
               contentDispositionPreference: #ATTACHMENT
             }

      @EndUserText.label: 'XSD'
      zschema            as Zschema,
      @Semantics.largeObject:{
               mimeType: 'Mimetype',
               fileName: 'Filename',
               contentDispositionPreference: #ATTACHMENT
             }
      @EndUserText.label: 'XML'
      xml                as Xml,
      note               as Note,
      @Semantics.user.createdBy: true
      createdby          as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat          as Createdat,
      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby      as Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat      as Lastchangedat,
      @Semantics.systemDateTime.lastChangedAt: true
      locallastchangedat as Locallastchangedat
}
