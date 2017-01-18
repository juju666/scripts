Set objArgs = Wscript.Arguments
ldapFilter = "(samAccountName=" & objArgs(0) & ")"
Set rootDSE = GetObject("LDAP://rootDSE") 
domainDN = rootDSE.Get("defaultNamingContext") 
Set ado = CreateObject("ADODB.Connection") 
ado.Provider = "ADSDSOObject" 
ado.Open "ADSearch" 
Set objectList = ado.Execute("<LDAP://" & domainDN & ">;" & ldapFilter & ";distinguishedName,samAccountName,displayname,userPrincipalName,mail;subtree") 

While Not objectList.EOF userDN = objectList.Fields("distinguishedName") 
logonName = objectList.Fields("samAccountName") 
On Error Resume Next 
displayName = "" : displayName = objectList.Fields("displayname") 
logonNameUPN = "" : logonNameUPN = objectList.Fields("userPrincipalName") 
email = "" : email = objectList.Fields("mail")

On Error Goto 0 
WScript.Echo logonName 
Wscript.echo "   " & displayName 
Wscript.echo "   " &email 
Wscript.echo "   " &userDN 
Wscript.echo "-------------------------------------------------------------------------------------------------------------"
objectList.MoveNext 
Wend