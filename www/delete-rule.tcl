ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Delete  rules
} {
    rule_id:integer,notnull,multiple

}

set rules $rule_id
set rules_count [llength $rule_id]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]


set rules_table "<table class=list><tr class=list-header><th class=list>Rule Name</th><th class=list>Assessment Related</th></tr>"

for { set i 0} { $i < $rules_count } { incr i } {

set rule_admin [permission::permission_p -object_id [lindex $rule_id $i] -party_id $user_id -privilege "admin"]

if  { $rule_admin == 0 && $admin == 0 } {
    doc_return 200 text/html  "<h3>Permission Denied</h3>
                               You don't have permission to admin this Rule. "
    ad_script_abort


}

    set rule_name [rules::rule::get_rule_name -rule_id [lindex $rule_id $i]]
    set asm_name [rules::rule::get_asm_name -rule_id  [lindex $rule_id $i]]
    append rules_table "<tr class=list-odd><td class=list-narrow>$rule_name</td><td class=list-narrow>$asm_name</td></tr>"
}
append rules_table "</table>"



