define hierarchy ZCDS_LH_M3A1
  as parent child hierarchy(
    source ZCDS_LH_M3A1_MAIN
    child to parent association _manager
    siblings order by
      IdEmployee ascending
  )
{
  IdEmployee,
  EmployeeName,
  ManagerId,
  CostCenter,
  $node.hierarchy_level       as hier_lvl,
  $node.hierarchy_rank        as hier_rank,
  $node.hierarchy_is_orphan   as is_orphan,
  $node.hierarchy_parent_rank as hier_parent_rank,
  $node.hierarchy_tree_size   as hier_tree_size,
  $node.node_id               as id_node,
  $node.parent_id             as id_parent

}
