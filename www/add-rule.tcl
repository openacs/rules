ad_page_contract {

    @author Anny Flores (annyflores@viaro.net)
    @creation_date 2004-12-03

    Add new rule related to an Assessment
} {
 
} -properties {
  context
}

# Just while I get the assessment package ready

set context [list "Add rule"]

set assessments [rules::rule::get_assessments]
ad_form -name  add_rule  -form {
     
    { rule_name:text(text) 
	{label "Rule Name"}
    }
    {asm_id:text(select)
	{label "Assessment Related"}
        {options $assessments}
    }
    {active_p:text(select)
	{label "Active"}
	{options {{Yes y} { No n}}}
    }
} -on_submit  {
     set table_name "rules"
     set id_column_name "rule_id"
     set return_url "index"
     set generated_id "rule_id"

     rules::rule::new_rule  -rule_name $rule_name -asm_id $asm_id -active_p $active_p
    
} -after_submit {
  ad_returnredirect "index"
}
