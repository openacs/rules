ad_page_contract {
    Delete  rules
} {
    rule_def_id:integer,notnull,multiple
    rule_id:integer,notnull
}
 
    set rules_count [llength $rule_def_id]
    for { set i 0} { $i < $rules_count } { incr i } {
	rules::rule::delete_trigger -rule_def_id [lindex $rule_def_id $i]
     }

    ad_returnredirect "one-rule?rule_id=$rule_id"




