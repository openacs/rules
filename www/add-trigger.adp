<master>
<property name="context">@context@</property>
<script language="JavaScript">
function go() {
        qs = document.add_trigger.qs_id.value;
        destination = "add-trigger?rule_id=@rule_id@&selected_qs="+qs;
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
</if>
<else>
<property name="title">Registration Rules</property>
<formtemplate id="add_trigger"></formtemplate>
</else>

