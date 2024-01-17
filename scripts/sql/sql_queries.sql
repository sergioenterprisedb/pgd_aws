
-- Node group
select node_group_name,node_group_enable_proxy_routing,node_group_enable_raft from bdr.node_group;

-- Node summary
select node_name,node_group_name,interface_connstr,peer_state_name,peer_target_state_name,node_seq_id,node_local_dbname,node_id,node_group_id,node_kind_name from bdr.node_summary;

