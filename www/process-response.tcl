ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {
  survey_id:notnull
  response_id:notnull
}

set user_id [ad_conn user_id]
set user_info ""
set perform_actions 0
set rest ""
set message ""
set notif_text ""


db_foreach rules_related { *SQL*  } {
    if { $active_p == "y"} {
	db_foreach rule_triggers { *SQL* } {
            if { $active_p == "y" } {
		set answer [db_string answer { *SQL* }] 
		
		if { $answer == $result_id } {
		    set perform_actions 1
		} else {
		    set perform_actions 0

		}
		if { $perform_actions == 1 } {
		    db_foreach action { *SQL* } {
			set rha_id [db_nextval rha_seq]
			set community_name [db_string name { *SQL* } -default System]
			set today [db_string date { *SQL* }]
			set  username [db_string username { *SQL* }]
			if { $action_type == 1} {
			    append message "<li> You have joined the $community_name community."
			    append notif_text "The user user has joined the $community_name community." 
			    if {![dotlrn::user_is_community_member_p  -user_id $user_id   -community_id $group_id]} {
			    dotlrn_community::add_user $group_id $user_id
			    }
			    db_transaction {
				db_dml add_history { *SQL* }
			    }
			} elseif { $action_type == 2 } {
			    append message "<li> Your request to join  $community_name  has been sent to the administrator of the group."
			    append notif_text "The user $username requested to join  $community_name."
			    
			    set today [db_string date { *SQL* }]
			    db_transaction {
				db_dml add_history_wait { *SQL* }
			    }
			} elseif { $action_type == 3 } {
			    set s_id ""
			    db_foreach questions { *SQL* } {
				if { $question_text == "student_id"} {
				    set s_id $question_id

				}
			    } 
			    set user_info [db_string student_id { *SQL* }]
			    array set user_new_info [auth::create_user -username $user_info -email $user_info@viaro.net  -first_names $user_info -last_name $user_info -password $user_info]
			    append message "<li> You have joined the System
	                    <br>
                            <br>
                            <b>User Name:</b>   $user_info@viaro.net
                            <br>
                            <b>Password:</b>  $user_info"
			    append notif_text "A user has joined to the system                                             
                                          User Name:  $user_info@viaro.net" 
                            if { ![exists_and_not_null user_new_info(user_id)]} {
                                   ad_return_complaint 1 "The user $user_info@viaro.net alredy exists in the system"
                                   ad_script_abort
			    } 
			    set user_id $user_new_info(user_id)
                            dotlrn_privacy::set_user_guest_p -user_id $user_id -value "t"
			    dotlrn::user_add -can_browse  -user_id $user_id 
			    db_transaction {          
				db_dml add_history_system { *SQL* }
			    }
			}
		    }

		}
		append notif_text "You can visit this rule history at http://216.230.130.230:3500/rules/admin/admin-request"
		notification::new -type_id [notification::type::get_type_id -short_name rule_notif] -object_id $rule_id -notif_subject "$rule_name has been executed" -notif_text $notif_text
	    }
	}
    }
}





