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
permission::require_permission -object_id $rule -privilege "admin"
set context [list "Add rule"]

    set rules_count [llength $rha_id]
    for { set i 0} { $i < $rules_count } { incr i } {
        set r_id [lindex $rha_id $i]
        set group_id [db_string community { *SQL* }] 
        if { $group_id != 0 } {
        set user_id  [db_string user { *SQL* }] 
        set today [db_string today { *SQL* }]
        if {![dotlrn::user_is_community_member_p  -user_id $user_id   -community_id $group_id]} {
        dotlrn_community::add_user $group_id $user_id
	}
          
		db_transaction {
                 
		    db_dml add_history { }
		}

	}
}

    ad_returnredirect "admin-request?interval=$interval&community=$community&specific_date=$specific_date&rule=$rule&state=$state"
