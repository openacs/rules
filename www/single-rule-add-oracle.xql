<?xml version="1.0"?>
<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="get_triggers">
	<querytext>
                  select sysdate  from dual
	</querytext>
   </fullquery>
   <fullquery name="communities"> 
   <querytext>
      select community_id,pretty_name from dotlrn_communities_all
   </querytext>
   </fullquery>

   <fullquery name="get_actions">
	<querytext>
		select
		ra.rule_id,ra.group_id,ra.notify_p,ra.active_p,ra.rule_action_id,ra.action_type, (select pretty_name from dotlrn_communities_all where
		community_id=ra.group_id) as name
		from rules r,rules_actions ra
		where ra.rule_id=r.rule_id and ra.rule_id=:rule_id
	</querytext>
   </fullquery>
   <fullquery name="questions">
   <querytext>
            select sq.question_id as qs_id, sq.question_text as description
            from survey_questions sq where sq.section_id in (select section_id from survey_sections where
   survey_id = (select asm_id as survey_id from rules where rule_id=:rule_id))  and (select
   count(choice_id) from survey_question_choices  where  question_id = sq.question_id) > 0 
 
   </querytext>
   </fullquery>
  <fullquery name="results">
   <querytext>
            select choice_id as result_id, label as value 
            from survey_question_choices 
            where  question_id = :s_qs
   </querytext>
   </fullquery>
  <fullquery name="next_action">
   <querytext>
   select action_seq.nextval from dual
   </querytext>
   </fullquery>
  <fullquery name="next_trigger">
   <querytext>
   select trigger_seq.nextval from dual
   </querytext>
   </fullquery>

   <fullquery name="insert_action">
   <querytext>
     insert into rules_actions
   (rule_action_id,action_type,group_id,notify_p,active_p,rule_id) values (:rule_action_id,:action_type,:group_id,'y',:active_p,:rule_id)
   </querytext>
   </fullquery>
   <fullquery name="insert_trigger">
   <querytext>
     insert into rules_triggers (rule_def_id,qs_id,result_id,active_p,rule_id)
   values (:rule_def_id,:qs_id,:result_id,:active_p,:rule_id)
   </querytext>
   </fullquery>
   <fullquery name="get_rule_values">
   <querytext>
       select * from rules_actions ra,rules_triggers rt where
   ra.rule_id=rt.rule_id and ra.rule_id=:rule_id and rt.rule_def_id=:rule_def_id
   </querytext>
   </fullquery>
   <fullquery name="update_action">
   <querytext>
     update rules_actions set group_id=:group_id, active_p=:active_p,
     action_type=:action_type where rule_id=:rule_id 
   </querytext>
   </fullquery>
   <fullquery name="update_trigger">
   <querytext>
     update rules_triggers set qs_id=:qs_id, active_p=:active_p,
     result_id=:result_id where rule_def_id=:id 
   </querytext>
   </fullquery>

   
</queryset>