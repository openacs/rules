<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>
   <fullquery name="all_rules">
	<querytext>
		select r.rule_id,r.rule_name, s.survey_id as asm_id,s.name as asm_name,r.active_p 
		from rules r, surveys s
		where r.asm_id=s.survey_id
	</querytext>
   </fullquery>
   
</queryset>