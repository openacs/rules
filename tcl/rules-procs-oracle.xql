<?xml version="1.0"?>
<queryset>

    <fullquery name="rules::rule::get_assessments.assessment">
    <querytext>
       select  survey_id as asm_id,name as asm_name from surveys 
   </querytext>
    </fullquery>
    <fullquery name="rules::rule::new_rule.add_rule">
    <querytext>
     declare begin
        :1 := rule.new(
              rule_id   =>      :rule_id,
	      rule_name	=>	:rule_name,
	      asm_id	=>	:asm_id,
	      active_p	=>	:active_p
	     
	     );
	end;
    </querytext>
    </fullquery>

    <fullquery name="rules::rule::get_rule_name.get_rule_name">
    <querytext>
		select rule_name 
		from rules 
		where rule_id=$rule_id

    </querytext>
    </fullquery>
    
    <fullquery name="rules::rule::get_asm_name.get_asm_name">
    <querytext>
		select a.name
		from rules r, surveys a 
		where a.survey_id=r.asm_id and r.rule_id=:rule_id
    </querytext>
    </fullquery>

    <fullquery name="rules::rule::get_assessments.assessments">
    <querytext>
       select  survey_id as asm_id,name as asm_name from surveys 
    </querytext>
    </fullquery>
    <fullquery name="rules::rule::delete_rule.delete_rule">
    <querytext>
        begin
        rule.del(:rule_id);
	end;
    </querytext>
    </fullquery>

    <fullquery name="rules::rule::add_trigger.add_trigger">
    <querytext>
    	insert into rules_triggers (rule_def_id,qs_id,result_id,active_p,rule_id)
        values (trigger_seq.nextval, :qs_id, :result_id, :active_p, :rule_id)       
    </querytext>
    </fullquery>

    <fullquery name="rules::rule::delete_trigger.delete_trigger">
    <querytext>
    	delete from  rules_triggers where rule_def_id=:rule_def_id       
    </querytext>
    </fullquery>


    <fullquery name="rules::rule::add_action.add_action">
    <querytext>
    	insert into rules_actions (rule_action_id,action_type,group_id,rule_id,active_p)
        values (action_seq.nextval, :action_type, :group_id,  :rule_id,:active_p)       
    </querytext>
    </fullquery>

    <fullquery name="rules::rule::delete_action.delete_action">
    <querytext>
	delete from rules_actions where rule_action_id=:rule_action_id        
    </querytext>
    </fullquery>


</queryset>
