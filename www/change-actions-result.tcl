ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  action_id:notnull
  res:notnull
  
} 

permission::require_permission -object_id $rule_id -privilege "admin"

db_transaction {

    db_dml update_action_result { *SQL* }
}
ad_returnredirect "one-rule?rule_id=$rule_id&res=$res"