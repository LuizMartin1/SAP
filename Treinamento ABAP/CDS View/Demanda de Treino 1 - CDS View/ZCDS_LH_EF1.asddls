@AbapCatalog.sqlViewName: 'ZLHPERFVOO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS view - Demanda Treino 1'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_LH_EF1
  as select from spfli   as horario
    inner join   sflight as voo on  horario.carrid = voo.carrid
                                and horario.connid = voo.connid
{
  key horario.carrid                                 as Carrid,
  key horario.connid                                 as Connid,
  key voo.fldate                                     as DataVoo,
      horario.cityfrom                               as Origem,
      horario.cityto                                 as Destino,
      
      @Semantics.amount.currencyCode: 'Moeda'
      voo.price                                      as Preco,
      voo.currency                                   as Moeda,

      voo.seatsocc + voo.seatsocc_b + voo.seatsocc_f as OcupacaoTotal
}
