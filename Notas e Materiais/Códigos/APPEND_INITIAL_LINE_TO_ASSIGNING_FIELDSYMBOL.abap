REPORT zlh_testes.

*&---------------------------------------------------------------------*
*& Programa 1 - Testando APPEND INITIAL LINE TO ASSIGNING FIELD-SYMBOL
*&---------------------------------------------------------------------*

DATA: t_e071 TYPE TABLE OF e071.

APPEND INITIAL LINE TO t_e071 ASSIGNING FIELD-SYMBOL(<fs_e071>).
<fs_e071>-trkorr    = 'E07K912345'.          
<fs_e071>-pgmid     = 'R3TR'.                 
<fs_e071>-object    = 'TABL'.                
<fs_e071>-obj_name  = 'ZSD_SALES_DATA'.       

cl_demo_output=>display( t_e071 ).

<fs_e071>-trkorr    = 'TESTE'.                
<fs_e071>-pgmid     = 'TESTE'.               
<fs_e071>-object    = 'TESTE'.                
<fs_e071>-obj_name  = 'ZSD_TESTE'.            

cl_demo_output=>display( t_e071 ).