<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
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
