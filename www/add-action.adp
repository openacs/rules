<master>
<script languate="JavaScript">
<property name="context">@context@</property>
function getAction() {
     action=document.add_action.action_type.value;
     destination = "add-action?rule_id=@rule_id@&selected_a="+action;
     if (destination) location.href = destination;
}
</script>
<if @admin@ eq 0>
    <if @rule_admin@ eq 0>
	<property name= "title">Permission Denied</property>
	<br>
	<center>You don't have permission to admin Rule. </center>
	<br>
    </if>
<else>
<property name="title">Registration Rules</property>
<formtemplate id="add_action"></formtemplate>
</else>
</if>
