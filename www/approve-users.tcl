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
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set context [list "Add rule"]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]
 if { [exists_and_not_null rule] } {
set rule_admin [permission::permission_p -object_id $rule -party_id $user_id -privilege "admin"]
}

if  { $rule_admin == 0 && $admin == 0 } {
    doc_return 200 text/html  "<h3>Permission Denied</h3>
                               You don't have permission to admin this Rule. "
    ad_script_abort


}


    set rules_count [llength $rha_id]
    for { set i 0} { $i < $rules_count } { incr i } {
        set r_id [lindex $rha_id $i]
        set group_id [db_string community { *SQL* }] 
        if { $group_id != -1 } {
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
