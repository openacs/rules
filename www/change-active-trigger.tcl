ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

   Change to active or not-active
} {
    res:notnull
    rule_def_id:integer,notnull
    rule_id 
}
   set active_p "y"

   if { $res == "y"} {
       set active_p "n"
   }

   db_transaction {
       db_dml change_active_trigger { *SQL* }
   }

   ad_returnredirect "one-rule?rule_id=$rule_id"
