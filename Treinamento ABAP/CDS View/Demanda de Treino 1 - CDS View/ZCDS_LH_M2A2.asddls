@AbapCatalog.sqlViewName: 'ZVLHM2A2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '${ddl_source_description}'
define view ZCDS_LH_M2A2
  as select from scarr
  association [1] to spfli as _scarr_to_spfli on $projection.Carrid = _scarr_to_spfli.carrid
{
  key carrid   as Carrid,
      carrname as Carrname,
      currcode as Currcode,
      url      as Url,

      _scarr_to_spfli // Make association public
}
