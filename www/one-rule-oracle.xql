<?xml version="1.0"?>
<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="get_triggers">
	<querytext>
		select r.rule_id, r.rule_name, rt.result_id, rt.qs_id,
		rt.rule_def_id, rt.active_p,r.asm_id,q.question_text as
		description, (select label value from survey_question_choices
		where question_id=rt.qs_id and choice_id=rt.result_id) as value
		from rules r,rules_triggers rt,survey_questions	q,survey_sections ss
		where rt.rule_id=r.rule_id and rt.rule_id=:rule_id 
		and q.question_id = rt.qs_id and ss.survey_id = r.asm_id and ss.section_id = q.section_id
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
            select question_id as qs_id, question_text as description
            from survey_questions
            where section_id = (select section_id from survey_sections where
            survey_id=(select asm_id from rules where rule_id=:rule_id)) 
 
   </querytext>
   
   </fullquery>
  <fullquery name="results">
   <querytext>
             select choice_id as result_id, label as value 
            from survey_question_choices 
            where  question_id = :selected_qs
 
   </querytext>
   
   </fullquery>

   
</queryset>