<?xml version="1.0"?>
<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="questions">
   <querytext>
       select * from survey_questions where section_id in (select section_id
       from survey_sections ss where ss.survey_id=:survey_id)
   </querytext>
   </fullquery>
</queryset>