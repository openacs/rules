--
--  The Rules Package
--  
--

drop table rule_history_actions;
drop table rules_actions;
drop table rules_triggers;
drop table rules;

declare begin
	acs_object_type.drop_type (object_type	=>	'rules');
end;
/
show errors;

