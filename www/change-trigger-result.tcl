ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  trigger_id:notnull
  res:notnull
  
} 

db_transaction {

    db_dml update_trigger_result { update rules_triggers set result_id=:res where rule_id=:rule_id and rule_def_id=:trigger_id}
}
ad_returnredirect "one-rule?rule_id=$rule_id&res=$res"