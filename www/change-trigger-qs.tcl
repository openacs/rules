ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03


} {
  rule_id:notnull
  trigger_id:notnull
  qs:notnull
  
} 

db_transaction {

    db_dml update_trigger { *SQL* }
}
ad_returnredirect "one-rule?rule_id=$rule_id&trigger=$trigger_id&qs=$qs"