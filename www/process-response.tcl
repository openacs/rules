ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

} {
  survey_id:notnull
  response_id:notnull
}

set user_id [ad_conn user_id]
set perform_actions 0
set rest ""

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
            set today [db_string date "select sysdate from dual"]
	    if { $action_type == 1} {
                    dotlrn_community::add_user $group_id $user_id
                  
		db_transaction {
                    
		    db_dml add_history { insert into rule_history_actions (rha_id,group_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:rule_action_id,:today,:today,'y')}
		}
	    } elseif {$action_type == 2} {
                                set today [db_string date "select sysdate from dual"]
                 		db_transaction {
             db_dml add_history { insert into rule_history_actions (rha_id,group_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:rule_action_id,:today,'','n')}

              
	    }
	}
    }

}
	}
