ad_page_contract {

   @author Anny Flores (annyflores@viaro.net)
   @creation-date 2004-11-25

} {
  user_id:integer,notnull
  object_id:integer,notnull
  type_id:integer,notnull
  return_url
  users_list:optional
}
if { $users_list == "" } {
    set users_list $user_id
} else {
    append users_list "-$user_id"
}
  ad_returnredirect "request-notification?object_id=$object_id&type_id=$type_id&return_url=$return_url&users_list=$users_list"