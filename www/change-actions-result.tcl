ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  action_id:notnull
  res:notnull
  
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
                               You don't have permission to admin Rule. "
    ad_script_abort


}

db_transaction {

    db_dml update_action_result { update rules_actions set group_id=:res where rule_action_id=:action_id}
}
ad_returnredirect "one-rule?rule_id=$rule_id&res=$res"