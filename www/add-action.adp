<master>
<property name="title">Registration Rules</property>
<script languate="JavaScript">
function getAction() {
     action=document.add_action.action_type.value;
     destination = "add-action?rule_id=@rule_id@&selected_a="+action;
     if (destination) location.href = destination;
}
</script>

<property name="context">@context@</property>
<formtemplate id="add_action"></formtemplate>