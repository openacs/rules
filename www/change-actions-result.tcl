ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  action_id:notnull
  res:notnull
  
} 

db_transaction {

    db_dml update_action_result { update rules_actions set group_id=:res where rule_action_id=:action_id}
}
ad_returnredirect "one-rule?rule_id=$rule_id&res=$res"