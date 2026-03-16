@AbapCatalog.sqlViewName: 'ZVLHM2A4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS com Parametros'
define view ZCDS_PSILVA_M2A4
  with parameters
    p_moeda : abap.char( 3 )
  as select from scarr
{
  key carrid   as Carrid,
      carrname as Carrname,
      currcode as Currcode,
      url      as Url
}
where
  currcode = $parameters.p_moeda
