ad_page_contract {


    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Request a new notification 

  
} {
    type_id:integer,notnull
    object_id:integer,notnull
    {pretty_name ""}
    users_list:optional
    
   
}
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set context [list "Add rule"]
set rule_admin ""
set admin [permission::permission_p -object_id $package_id -party_id $user_id -privilege "admin"]
if { [exists_and_not_null object_id] } {
set rule_admin [permission::permission_p -object_id $object_id -party_id $user_id -privilege "admin"]
}

if  { $rule_admin == 0 && $admin == 0 } {
    doc_return 200 text/html  "<h3>Permission Denied</h3>
                               You don't have permission to admin Rule. "
    ad_script_abort


}

# Check that the object can be subcribed to
notification::security::require_notify_object -object_id $object_id

if {[empty_string_p $pretty_name]} { 
    set page_title "[_ notifications.Request_Notification]"
} else { 
    set page_title "[_ notifications.lt_Request_Notification_]"
}

set context [list [list "one-rule?rule_id=$object_id" "Rule Properties"] "[_ notifications.Request_Notification]"]

set intervals [notification::get_intervals -type_id $type_id]
set delivery_methods [notification::get_delivery_methods -type_id $type_id]


form create request

element create request party_id\
    -datatype party_search \
    -widget party_search\
    -label "User to Notify"\
    -value " "
element create request object_id\
    -datatype integer\
    -widget hidden\
    -value $object_id

element create request type_id\
    -datatype integer\
    -widget hidden\
    -value $type_id
    
element create request return_url\
    -datatype text\
    -widget hidden\
    -value "index"
element create request interval_id\
    -datatype integer \
    -widget select\
    -label  "[_ notifications.lt_Notification_Interval]"\
    -options $intervals\
    -value 0

element create request delivery_method_id\
    -datatype integer \
    -widget select\
    -label  "[_ notifications.Delivery_Method]"\
    -options $delivery_methods\
    -value [lindex [lindex $delivery_methods 0] 1]

if {[template::form is_valid request]} {
    template::form get_values request party_id interval_id delivery_method_id type_id object_id
    # Add the subscribe
    notification::request::new \
            -type_id $type_id \
            -user_id $party_id \
            -object_id $object_id \
            -interval_id $interval_id \
            -delivery_method_id $delivery_method_id


    ad_returnredirect "request-notification?type_id=$type_id&object_id=$object_id"
}

template::list::create -name notify_users\
-multirow notify_users\
-key request_id\
-bulk_actions\
    {
      "Unsubscribe" "unsubscribe" "Unsubscribe user to this rule"
    }\
    -bulk_action_method post -bulk_action_export_vars {
   object_id
   type_id
    }\
-no_data "There are no users to notify"\
-row_pretty_plural "notify_users"\
-elements {
    name {
          label "UserName"
 }
    interval_name {
          label "Interval"
	
    }
    delivery_name {
          label "Delivery Method"
    }
}
    db_multirow notify_users notify_users { *SQL* }