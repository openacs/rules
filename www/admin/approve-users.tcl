ad_page_contract {
    Delete  rules
} {
    rha_id:integer,notnull,multiple
    interval
    specific_date
    state
    community
    rule

    
}
 
    set rules_count [llength $rha_id]
    for { set i 0} { $i < $rules_count } { incr i } {
        set r_id [lindex $rha_id $i]
        set group_id [db_string community { select group_id from rule_history_actions where rha_id=:r_id}] 
        if { $group_id != -1 } {
        set user_id  [db_string user { select user_id from rule_history_actions where rha_id=:r_id}] 
        set today [db_string today { select to_date (sysdate,'YYYY-MM-DD') from dual}]
        dotlrn_community::add_user $group_id $user_id
          
		db_transaction {
                 
	    db_dml add_history { update rule_history_actions set processing_date=:today, approved_p='y' where rha_id=:r_id} 
		}
	}

     }

    ad_returnredirect "admin-request?interval=$interval&community=$community&specific_date=$specific_date&rule=$rule&state=$state"
