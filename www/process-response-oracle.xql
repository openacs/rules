<?xml version="1.0"?>
<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="questions">
	      <querytext>
			select * from survey_questions where section_id in (select section_id
			from survey_sections ss where ss.survey_id=:survey_id)
	      </querytext>

   </fullquery>

   <fullquery name="rules_related">
	       <querytext>
			select * from rules where asm_id=:survey_id
	       </querytext>
   </fullquery>
   <fullquery name="rule_triggers">
	       <querytext>
			select result_id,rule_def_id, qs_id, active_p, rule_id from rules_triggers  where rule_id=:rule_id
	      </querytext>
   </fullquery>
   <fullquery name="answer">
	      <querytext>
			select choice_id from survey_question_responses where question_id=:qs_id and response_id=:response_id
	     </querytext>
   </fullquery>
   <fullquery name="action">
	      <querytext>
			select * from rules_actions where rule_id=:rule_id
	      </querytext>
   </fullquery>

   <fullquery name="name">
	      <querytext>
		select pretty_name from dotlrn_communities_all where community_id=:group_id	
	      </querytext>
   </fullquery>
   <fullquery name="date">
	      <querytext>
	        select to_date(sysdate,'YYYY-MM-DD') from dual
	      </querytext>
   </fullquery>
   <fullquery name="username">
	      <querytext>
			select p.first_names || ' ' || p.last_name as name  from persons p where p.person_id = :user_id
	      </querytext>
   </fullquery>
   <fullquery name="student_id">
	      <querytext>
			select number_answer from survey_question_responses where question_id = :s_id and response_id = :response_id
	      </querytext>
   </fullquery>
   <fullquery name="add_history">
	      <querytext>
			insert into rule_history_actions (rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,:group_id,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),to_date(:today,'YYYY-MM-DD'),'y')
	      </querytext>
   </fullquery>
   <fullquery name="add_history_wait">
	      <querytext>

			insert into rule_history_actions
			(rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p)
			values
			(:rha_id,:group_id,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),'','n')
	      </querytext>
   </fullquery>
   <fullquery name="add_history_system">
	      <querytext>					
	      insert into rule_history_actions (rha_id,group_id,user_id,rule_action_id,request_date,processing_date,approved_p) values (:rha_id,-1,:user_id,:rule_action_id,to_date(:today,'YYYY-MM-DD'),to_date(:today,'YYYY-MM-DD'),'y')
	      </querytext>
   </fullquery>

</queryset>