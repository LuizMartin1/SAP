@AbapCatalog.sqlViewAppendName: 'ZVLHM3A3'
@EndUserText.label: 'Extensão de CDS'
extend view ZCDS_LH_M2A2 with ZCDS_LH_M3A3
{
  _scarr_to_spfli.cityfrom,
  _scarr_to_spfli.cityto
}
