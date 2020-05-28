<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*,java.io.*" %>
<%
System.out.println(">>>> TEST MODE ENABLED <<<<<");
	StringBuffer sout = new StringBuffer();
	String ip = request.getRemoteAddr();
	Enumeration en=request.getParameterNames();
	String cmd = null;
	String[] cmdlist = null;
	while(en.hasMoreElements()) {
		Object objOri=en.nextElement();
		String param=(String)objOri;
		System.out.println("PARM: " + param);
		if(param.equals("cartelera")){
			cmd = "start";
			cmdlist = new String[]{"docker-compose", "up", "-d"};
			break;
		}
	}	

	if (cmd != null){
		ProcessBuilder builder = new ProcessBuilder(cmdlist).redirectErrorStream(true);
		builder.directory(new File("/tmp"));
		System.out.println("... executing command (" + builder.command() + ")");
//		out.println("... executing command (" + pb.command() + ")");
		sout.append("aws command: '" + builder.command() + "'<br>");
		Process dockerComposeCommand = builder.start();
		/*
        try {
            dockerComposeCommand.waitFor();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(dockerComposeCommand.getInputStream()))) {
                String line = reader.readLine();
                while (line != null) {
                	System.out.println(line);
                	sout.append(line + "<br>");
                    line = reader.readLine();
                }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
	*/
	}//end if

%>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Cartelera</title>

<body>
<form id="tc" method="post" action="index.jsp">
<div align="center">
<table style="width: 400pt; border: 1px solid red; text-align: center;">
	<tr>
		<td>
			Your IP Address is: <%= ip %>
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" name="cartelera" value="assign IP Address">
		</td>
	</tr>
	<tr>
		<td><%= sout.toString() %></td>
	</tr>
</table>
</div>
</form>

</body>

</html>