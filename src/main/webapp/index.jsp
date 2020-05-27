<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*,java.io.*" %>
<%
	StringBuffer sout = new StringBuffer();
	String ip = request.getRemoteAddr();
	Enumeration en=request.getParameterNames();
	String cmd = null;
	String[] cmdlist = null;
	while(en.hasMoreElements()) {
		Object objOri=en.nextElement();
		String param=(String)objOri;
		if(param.startsWith("start.x")){
	//		out.println("<h1>START</h1>");
			cmd = "start";
			cmdlist = new String[]{"docker-compose", "up", "-d"};
			break;
		}else if(param.startsWith("stop.x")){
	//		out.println("<h1>STOP</h1>");
			cmd = "stop";
			cmdlist = new String[]{"docker-compose", "down"};
			break;
		}else if(param.startsWith("pull.x")){
	//		out.println("<h1>PULL</h1>");
			cmd = "pull";
			cmdlist = new String[]{"docker-compose", "pull"};
			break;
		}else if(param.startsWith("process.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "ps";
			cmdlist = new String[]{"docker-compose", "ps"};
			break;
		}else if(param.startsWith("redeploy.x")){
	//		out.println("<h1>PROCESS</h1>");
			cmd = "mfadeploy";
			cmdlist = new String[]{"/opt/projects/dctest/dcdeploy"};
			break;
		}
	}	

	if (cmd != null){
		ProcessBuilder builder = new ProcessBuilder(cmdlist).redirectErrorStream(true);
		builder.directory(new File("/tmp"));
		System.out.println("... executing command (" + builder.command() + ")");
//		out.println("... executing command (" + pb.command() + ")");
		sout.append("... attempting to execute the docker-compose command: '" + builder.command() + "'<br>");
		Process dockerComposeCommand = builder.start();
		String path = System.getenv("PATH");
        builder.environment().put("PATH","/usr/bin:"+path);
        builder.redirectErrorStream(true);
        builder.redirectError(ProcessBuilder.Redirect.INHERIT);

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
	}//end if

%>

<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Cartelera</title>

<body>
<form id="tc" method="post" action="/index.jsp">
<div align="center">
<table style="width: 400pt; border: 1px solid red; text-align: center;">
	<tr>
		<td>
			Your IP Address is: <%= ip %>
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" value="assign IP Address">
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

