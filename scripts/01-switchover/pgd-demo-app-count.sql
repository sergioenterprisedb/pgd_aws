\pset footer off
select node_name CONNECTED_TO from bdr.local_node_summary;
select * from ping order by 3 desc limit 10;
