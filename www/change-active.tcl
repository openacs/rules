ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

   Change to active or not-active
} {
    res:notnull
    rule_id:integer,notnull
}
permission::require_permission -object_id $rule_id -privilege "admin"
   set active_p "y"

   if { $res == "y"} {
       set active_p "n"
   }

   db_transaction {
       db_dml change_active_rule { *SQL* }
   }

   ad_returnredirect "index"
