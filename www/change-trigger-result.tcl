ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  trigger_id:notnull
  res:notnull
  
} 

db_transaction {

    db_dml update_trigger_result { *SQL* }
}
ad_returnredirect "one-rule?rule_id=$rule_id&res=$res"