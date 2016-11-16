<table border="1" cellpadding="5" cellspacing="0" width="500">
<tr>
	<th>ID</th>
	<th>Name</th>
</tr>
<cfoutput>
<cfloop array="#prc.users#" item="user">
	<tr>
		<td>#user.id#</td>
		<td>#user.name#</td>
	</tr>
</cfloop>
</cfoutput>