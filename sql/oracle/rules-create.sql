-- create rule object
--
-- @creation-date Nov 11, 2004

---------------------------------------------------------------------
--   rule_object
---------------------------------------------------------------------

begin 

	-- create the rule object
	
	acs_object_type.create_type (
		supertype	=>	'acs_object',
		object_type	=>	'rule',
		pretty_name	=>	'Rule',
		pretty_plural	=>	'Rules',
		table_name	=>	'rules',
		id_column	=>	'rule_id'
	);
end;
/
show errors;

declare 

	attr_id acs_attributes.attribute_id%TYPE;
begin
	attr_id := acs_attribute.create_attribute (
		object_type	=> 	'rule',
		attribute_name 	=>	'rule_name',
		pretty_name	=>	'Name',
		pretty_plural	=>	'Names',
		datatype	=>	'string'
	);
	
	attr_id := acs_attribute.create_attribute (
		object_type	=> 	'rule',
		attribute_name 	=>	'asm_id',
		pretty_name	=>	'Assessment',
		pretty_plural	=>	'Assessments',
		datatype	=>	'integer'
	);

	attr_id := acs_attribute.create_attribute (
		object_type	=> 	'rule',
		attribute_name 	=>	'active_p',
		pretty_name	=>	'Active',
		pretty_plural	=>	'Active',
		datatype	=>	'string'
	);
end;
/
show errors;

---------------------------------------------------------
-- Table rules
---------------------------------------------------------


create table rules (	
	rule_id			integer,
	rule_name		varchar2(50),
	asm_id			integer,
	active_p		varchar2(1),
	constraint rules_rule_id_pk primary key (rule_id) ,
	constraint rules_rule_id_fk foreign key (rule_id) references acs_objects (object_id),
	constraint rules_active_p_ck check (active_p in ('y','n'))				
);


-------------------------------------------
-- Table rules_triggers
-------------------------------------------


create table rules_triggers (
	-- primary key		
	rule_def_id		integer	
				constraint rules_triggers_rule_def_id_pk
				primary key,
	qs_id			integer,
	result_id		integer,
	rule_id			integer
				constraint rules_triggers_rule_id_fk
				references rules 
				on delete cascade,
	active_p		varchar2(1)
				default 'y'
				constraint rules_triggers_active_p_ck
				check (active_p in (	
					'y',
					'n'
					)
				)
);


-------------------------------------------
-- Table rules_actions
-------------------------------------------


create table rules_actions (
	-- primary key
	rule_action_id		integer	
				constraint rules_a_rule_a_id_pk
				primary key,
	action_type		varchar2(10),
	group_id		integer,
	rule_id			integer
				constraint rules_a_rule_id_fk
				references rules 
				on delete cascade,
	notify_p		varchar2(1)
				default 'y'
				constraint notify_p_ck
				check (notify_p in (	
					'y',
					'n'
					)
				),
	active_p		varchar2(1)
				default 'y'
				constraint active_p_ck
				check (active_p in (	
					'y',
					'n'
					)
				)
);




-------------------------------------------
-- Table rule_history_actions
-------------------------------------------


create table rule_history_actions (
	-- primary key
	rha_id			integer	
				constraint rha_rha_id_pk
				primary key,
	group_id		integer,
	rule_action_id		integer
				constraint rha_rule_act_id_fk
				references rules_actions
				on delete cascade,
	request_date		date,
	processing_date		date,	
	approved_p		varchar2(1)
				default 'y'
				constraint rha_approved_p_ck
				check (approved_p in (	
					'y',
					'n'
					)
				)
);
 
--------------------------------------------------------
--  TRIGGER SEQUENCE FOR PRIMARY KEY
--------------------------------------------------------
	create sequence trigger_seq
	minvalue 1
	maxvalue 999999999
	start with 1
	increment by 1
	cache 20; 

--------------------------------------------------------
--  ACTION  SEQUENCE FOR PRIMARY KEY
--------------------------------------------------------

	create sequence action_seq
	minvalue 1
	maxvalue 999999999
	start with 1
	increment by 1
	cache 20; 


--------------------------------------------------------
--  RULE HISTORY ACTIONS  SEQUENCE FOR PRIMARY KEY
--------------------------------------------------------

	create sequence rha_seq
	minvalue 1
	maxvalue 999999999
	start with 1
	increment by 1
	cache 20; 
