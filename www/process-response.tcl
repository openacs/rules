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
db_foreach rules_related {select * from rules where asm_id=:survey_id} {
    db_foreach rule_triggers { select * from rules_triggers  where rule_id=:rule_id } {
	set answer [db_string answer { select choice_id from survey_question_responses where question_id=:qs_id and response_id=:response_id}] 
        if { $answer == $result_id } {
            set perform_actions 1
	} else {
            set perform_actions 0
	}
    }
    if { $perform_actions == 1 } {
        db_foreach action { select * from rules_actions where rule_id=:rule_id} {
            set rha_id [db_nextval rha_seq]
            set community_name [db_string name {select pretty_name from dotlrn_communities_all where community_id=:group_id} -default System]
            set today [db_string date "select to_date(sysdate,'YYYY-MM-DD') from dual"]
	    if { $action_type == 1} {

                append message "<li> You have joined the $community_name community."
                    dotlrn_community::add_user $group_id $user_id
                  
		db_transaction {
                    
		    db_dml add_history { insert into rule_history_actions (rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),to_date(:today,'YYYY-MM-DD'),'y')}
		}
	    } elseif {$action_type == 2} {
                                append message "<li> Your request to join  $community_name  has been sent to the administrator of the group."
                                set today [db_string date "select sysdate from dual"]
                 		db_transaction {
				    db_dml add_history { insert into rule_history_actions (rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),'','n')}

              
				}
	    } elseif {$action_type == 3 } {
                set user_info [db_string student_id {select number_answer from survey_question_responses where question_id = (:qs_id+1) and response_id = :response_id}]

		array set user_new_info [auth::create_user -username $user_info -email $user_info@viaro.com  -first_names $user_info -last_name $user_info -password $user_info]
                
                append message "<li> You have joined the System
                <br>
                <br>
                <b>User Name:</b>   $user_info@viaro.net
                <br>
                <b>Password:</b>  $user_info

"
                set user_id $user_new_info(user_id)
		db_transaction {          
		    db_dml add_history { insert into rule_history_actions (rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),to_date(:today,'YYYY-MM-DD'),'y')}
		}

		  }
    }

}
	}
