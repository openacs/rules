ad_page_contract {
   
    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Delete  actions
} {
    rule_action_id:integer,notnull,multiple
    rule_id:integer,notnull
}
permission::require_permission -object_id $rule_id -privilege "admin"
 
    set rules_count [llength $rule_action_id]
    for { set i 0} { $i < $rules_count } { incr i } {
	
	rules::rule::delete_action -rule_action_id [lindex $rule_action_id $i]
     }

    ad_returnredirect "one-rule?rule_id=$rule_id"
