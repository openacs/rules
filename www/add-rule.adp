<master>
<property name="context">@context@</property>
<if @admin@ eq 0>
    <if @rule_admin@ eq 0>
	<property name= "title">Permission Denied</property>
	<br>
	<center>You don't have permission to admin Rule. </center>
	<br>
    </if>

    <else>
	<property name= "title">Edit Rule</property>
	<formtemplate id="add_rule"></formtemplate>
    </else>
</if>