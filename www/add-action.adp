<master>
<if @admin@ eq 0>
    <if @rule_admin@ eq 0>
	<property name= "title">Permission Denied</property>
	<br>
	<center>You don't have permission to admin Rule. </center>
	<br>
    </if>
<else>
</if>
<property name="title">Registration Rules</property>
<formtemplate id="add_action"></formtemplate>
</else>


