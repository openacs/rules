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
form create add_rule 
element create add_rule rule_name \
     -datatype text\
     -widget text\
     -label "Rule Name"
    
element create add_rule asm_id\
      -datatype text\
      -widget select\
      -label "Assessment Related"\
      -options $assessments

element create add_rule active_p\
      -datatype text\
      -widget select\
      -label "Active"\
      -options {{Yes y} { No n}}
    
if {[template::form is_valid add_rule]} {
    template::form get_values add_rule rule_name asm_id active_p
    rules::rule::new_rule  -rule_name $rule_name -asm_id $asm_id -active_p $active_p 
    ad_returnredirect "index"
}
