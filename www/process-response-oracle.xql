<?xml version="1.0"?>
<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="questions">
   <querytext>
       select * from survey_questions where section_id in (select section_id
       from survey_sections ss where ss.survey_id=:survey_id)
   </querytext>
   </fullquery>
   <fullquery name="responses">
   <querytext>
       select * from survey_responses where survey_id=:survey_id
   </querytext>
   </fullquery>
   <fullquery name="question_responses">
   <querytext>
       select * from survey_questions_responses where response_id=:response_id
   and question_id=:question_id
   </querytext>
   </fullquery>
   <fullquery name="rules_related">
      select * from rules where asm_id=:survey_id
   </fullquery>
   <fullquery name="rule_triggers">
      select * from rules_triggers  where rule_id=:rule_id
   </fullquery>
   <fullquery name="answer">
   <querytext>
      select choice_id from survey_questions_responses where
   question_id=:qs_id and response_id= (select response_id from survey_responses where survey_id=:survey_id)
   </querytext>
   </fullquery>
   
</queryset>