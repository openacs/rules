ad_library {

    Rules Library
    @author Anny Flores (annyflores@viaro.net)
    @creation-date 2004-11-16
}


namespace eval rules::rule {
    
    ad_proc -public get_assessments {
    } {
	Get all assessments 
    } {
        set assessment [list]       

        db_foreach assessment { *SQL* } {
	    lappend assessment [list $asm_name $asm_id]
	}

	return $assessment
      
    }

    ad_proc -public new_rule {
	-rule_name
	-asm_id
	-active_p
    } {
	Add new rule
    } {
	set rule_id [db_exec_plsql add_rule { *SQL*}]
	return $rule_id
    }
    ad_proc delete_rule {
	-rule_id
    } {
	Delete one rule
    } {
	db_exec_plsql delete_rule { *SQL*}
    }

    ad_proc -public get_asm_name {
	-rule_id 
    } {
      	Gets the name of the assessment related to this rule
	
    } {
	set asm_name [db_string get_asm_name { *SQL* }]
	return $asm_name
    }

    ad_proc -public get_rule_name {
	-rule_id 

    } {
	Gets the name of the this rule 
    } {
	set rule_name [db_string get_rule_name { *SQL* }]
	return $rule_name
    }

    ad_proc -public add_trigger {
	-rule_def_id
	-qs_id
	-active_p
	-rule_id
	-result_id

    } {
	Add new trigger
    } {
	db_transaction {
	    
	    db_dml add_trigger { *SQL* }
	}
    }

    ad_proc -public add_action {
	-rule_action_id
	-action_type
	-rule_id
	-group_id
	-active_p

    } {
	Add new action
    } {
	db_transaction {
	    
	    db_dml add_action { *SQL* }
	}
    }

    ad_proc -public delete_action {
	-rule_action_id

    } {
	Delete an  action
    } {
	db_transaction {
	    
	    db_dml delete_action { *SQL* }
	}
    }
    ad_proc -public delete_trigger {
	-rule_def_id

    } {
	Delete a trigger
    } {
	db_transaction {
	    
	    db_dml delete_trigger { *SQL* }
	}
    }


    
 }
