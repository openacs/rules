ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Delete rules
} {
    rule_id
}

set rules_count [llength $rule_id]
    for { set i 0} { $i < $rules_count } { incr i } {
	rules::rule::delete_rule -rule_id [lindex $rule_id $i]
      }

ad_returnredirect "index"