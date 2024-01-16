
SELECT target_name, client_addr, sent_lsn, replay_lsn, replay_lag, replay_lag_bytes, replay_lag_size FROM bdr.node_slots;
