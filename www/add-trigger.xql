<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="questions">
   <querytext>
            select sq.question_id as qs_id, sq.question_text as description
            from survey_questions sq where sq.section_id in (select section_id from survey_sections where
   survey_id = (select asm_id as survey_id from rules where rule_id=:rule_id)) and sq.question_id not
   in (select qs_id from rules_triggers where rule_id=:rule_id)  and (select
   count(choice_id) from survey_question_choices  where  question_id = sq.question_id) > 0 
 
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
