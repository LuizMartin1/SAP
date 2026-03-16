@EndUserText.label: 'Acess Control - Demanda Treino 1'
@MappingRole: true
define role ZAC_LH_EF1 {
    grant
        select
            on
                ZCDS_LH_EF1
                    where
                        ( Carrid ) = aspect pfcg_auth( ZTST_AUTH, ZFLD_CARRI, ACTVT = '03' ); 
                        
}