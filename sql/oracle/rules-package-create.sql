------------------------------------------------
--	create package rule
------------------------------------------------


create or replace package rule
as

	function new (
		 rule_id	in acs_objects.object_id%TYPE	default null,
		 rule_name	in rules.rule_name%TYPE	default null,
		 object_type	in acs_objects.object_type%TYPE	default 'rule',
		 asm_id		in rules.asm_id%TYPE,
		 active_p	in rules.active_p%TYPE default 'y',
		 context_id	in acs_objects.context_id%TYPE          default null,
                 creation_date           in acs_objects.creation_date%TYPE       default sysdate,
                 creation_user           in acs_objects.creation_user%TYPE       default null,
                 creation_ip             in acs_objects.creation_ip%TYPE         default null
		     ) return rules.rule_id%TYPE;

	procedure del (
		  rule_id	in rules.rule_id%TYPE
		  );
end rule;
/
show errors;

create or replace package body rule
as
	function new (
	           rule_id        in acs_objects.object_id%TYPE   default null,
		   rule_name      in rules.rule_name%TYPE default null,
		   object_type    in acs_objects.object_type%TYPE default 'rule',
		   asm_id         in rules.asm_id%TYPE,
		   active_p       in rules.active_p%TYPE default 'y',
		   context_id     in acs_objects.context_id%TYPE          default null,
		   creation_date           in acs_objects.creation_date%TYPE       default sysdate,
		   creation_user           in acs_objects.creation_user%TYPE       default null,
		   creation_ip             in acs_objects.creation_ip%TYPE         default null
                     ) return rules.rule_id%TYPE
	is
	v_rule_id	rules.rule_id%TYPE;

	begin
	      v_rule_id := acs_object.new (
			object_id	  =>	rule_id,
			object_type	  =>	object_type,
			creation_date	  =>	creation_date,
			creation_user	  =>	creation_user,
			creation_ip	  =>	creation_ip,
			context_id	  =>	context_id
			);

			insert into rules
				    (rule_id,rule_name,asm_id,active_p)
				    values
				    (v_rule_id,rule_name,asm_id,active_p);

				    return v_rule_id;
		 end new;
		


		 -- body for procedure delete

		 procedure del (
			   rule_id	in rules.rule_id%TYPE
			   )
			   is
			   begin
			   delete from rule_history_actions
			   where rule_id = rule.del.rule_id;
			   delete from rules_actions
			   where rule_id = rule.del.rule_id;
			   delete from rules_triggers 
			   where rule_id = rule.del.rule_id;
			   delete from rules
			   where rule_id = rule.del.rule_id;
			   acs_object.del(rule_id);
		   end del;

end rule;
/
show errors



		    

		 
		 
		 	
