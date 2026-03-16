@AbapCatalog.sqlViewName: 'ZVLHM3A1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS hierarquica'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_LH_M3A1_MAIN
  as select from zempregados
  association [0..1] to ZCDS_LH_M3A1_MAIN as _manager on $projection.ManagerId = _manager.IdEmployee
{
  key id_employee   as IdEmployee,
      employee_name as EmployeeName,
      manager_id    as ManagerId,
      cost_center   as CostCenter,
      _manager
}
