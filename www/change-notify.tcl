ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

   Change to active or not-active
} {
    res:notnull
    action_id:integer,notnull
    rule_id 
}
   set notify_p "y"

   if { $res == "y"} {
       set notify_p "n"
   }

   db_transaction {
       db_dml change_notify { *SQL* }
   }
if { $res == "n" } {
    ad_returnredirect "request-notification?object_id=$rule_id&type_id=[notification::type::get_type_id -short_name rule_notif]&return_url=index"
}
   

   ad_returnredirect "one-rule?rule_id=$rule_id"
