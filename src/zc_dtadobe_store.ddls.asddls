@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZADOBE_STORE'
}
@AccessControl.authorizationCheck: #MANDATORY
@ObjectModel.semanticKey: [ 'Formtemplate' ]
define root view entity ZC_DTADOBE_STORE
  provider contract transactional_query
  as projection on ZR_DTADOBE_STORE
  association [1..1] to ZR_DTADOBE_STORE as _BaseEntity on $projection.Formtemplate = _BaseEntity.Formtemplate
{
  key Formtemplate,
  Attachment,
    Xml,
  Zschema,
  Mimetype,
  Filename,
  Note,
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  Createdat,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  Lastchangedby,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Lastchangedat,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  Locallastchangedat,
  _BaseEntity
}
