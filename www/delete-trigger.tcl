ad_page_contract {
    Delete  rules
} {
    rule_def_id:integer,notnull,multiple
    rule_id:integer,notnull
}
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set context [list "Add rule"]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]
if { [exists_and_not_null rule_id] } {
set rule_admin [permission::permission_p -object_id $rule_id -party_id $user_id -privilege "admin"]
}

if  { $rule_admin == 0 && $admin == 0 } {
    doc_return 200 text/html  "<h3>Permission Denied</h3>
                               You don't have permission to admin this Rule. "
    ad_script_abort


}
 
    set rules_count [llength $rule_def_id]
    for { set i 0} { $i < $rules_count } { incr i } {
	rules::rule::delete_trigger -rule_def_id [lindex $rule_def_id $i]
     }

    ad_returnredirect "one-rule?rule_id=$rule_id"




