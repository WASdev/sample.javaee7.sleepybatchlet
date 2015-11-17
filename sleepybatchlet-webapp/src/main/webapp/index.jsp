<!DOCTYPE html>
<html>
<!-- 
 - COPYRIGHT LICENSE: This information contains sample code provided in source
 - code form. You may copy, modify, and distribute these sample programs in any 
 - form without payment to IBM for the purposes of developing, using, marketing 
 - or distributing application programs conforming to the application programming 
 - interface for the operating platform for which the sample code is written. 
 - 
 - Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE 
 - ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, 
 - BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, 
 - SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR 
 - CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT, INDIRECT,
 - INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR
 - OPERATION OF THE SAMPLE SOURCE CODE. IBM HAS NO OBLIGATION TO PROVIDE
 - MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE
 - SOURCE CODE.
 - 
 - (C) Copyright IBM Corp. 2015.
 - 
 - All Rights Reserved. Licensed Materials - Property of IBM.  
 -->
<head>
<meta charset="utf-8"></meta>
<title>Batch WAS Classic tests</title>
<style>
.frm1{
	padding: 15px;
	background-color: #9666af; 
	margin-bottom: 10px;
}

.frm2{
	padding-left: 25px; 
	color: #440055;
}

.frm3 {
	padding-left: 25px;
	font-family: Verdana;
	font-size: 12px;
	color: #443355;
	white-space: nowrap;
}

.big {
	font-size: 26px;
	color: white;
}

button {
	padding: 5px;
	padding-left: 20px;
	padding-right: 20px;
	margin: 10px;
	width: 270px
}

.small{
	font-size: 12px;
}

</style>
</head>

<body>
<div class="frm1">
<div class="big"> WAS Java EE 7 Sample - Batch</div>

</div>
<div class="frm2">
<div class="small">This application has been tested with Firefox and Chrome </div>
<div class="small"> The source code for this application can be found on: <a href="https://github.com/WASdev/">https://github.com/WASdev/</a> </div>
</div>

<div class="frm3">
		<h3>How does this work?</h3>
		<p>You can start a SleepyBatchlet job by specifying the Sleep Time and clicking the 'Start a Batch Job' button, which will then display batch runtime 
		output on a new screen.  This output will contain information <br> regarding the status of the job, Execution Id, Instance Id, etc. It is a good idea 
		to record the Execution Id because it is used to do various batch management tasks such as get the status of an execution, stop <br>an execution, or 
		restart a stopped execution.  If you forget to record it, don't panic!  Clicking 'List Running Executions' will display all executions which are still running
		and clicking 'List Job Instances' will <br> display all job instances that have been run with links to their executions.</p>
		<br />
		<a href="http://localhost:9080/SleepyBatchletSample/joboperator?action=start&jobXMLName=sleepy-batchlet" id="startURL">
			<button type="button" onclick="javascript:startJob()" id="startButton">Start a Batch Job</button></a> Sleep Time: <input id="sleepTimeStartJob" type="number" value="60" min="0"> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=start&jobXMLName=sleepy-batchlet&jobParameters=sleep.time.seconds={value}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=status&executionId=" id="statusURL"><button
				type="button" onclick="javascript:statusJob()" id="statusButton">Get Job Status</button></a> Job Execution ID: <input id="executionIdStatus" type="number" min="0" value="0"> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=status&executionId={executionId}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=stop&executionId=" id="stopURL"><button
				type="button" onclick="javascript:stopJob()" id="stopButton">Stop a Running Job</button></a> Job Execution ID: <input id="executionIdStop" type="number" min="0" value="0"> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=stop&executionId={executionId}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=restart&executionId=&restartParameters=sleep.time.seconds=10" id="restartURL"><button
				type="button" onclick="javascript:restartJob()" id="restartButton">Restart a Stopped Job</button></a> Job Execution ID: <input id="executionIdRestart" type="number" min="0" value="0"> Sleep Time: <input id="sleepTimeRestartJob" type="number" value="60" min="0"> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=restart&executionId={executionId}&restartParameters=sleep.time.seconds={value}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=getRunningExecutions&jobName=" id="runningExecutionsURL"><button
				type="button" onclick="javascript:listExecutions()" id="runningExecsButton">List Running Executions</button></a> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=getRunningExecutions&jobName={jobName}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=getJobInstances&jobName=sleepy-batchlet&start=0&count=1" id="jobInstancesURL"><button
				type="button" onclick="javascript:listJobInstances()" id="jobInstancesButton">List Job Instances</button></a> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=getJobInstances&jobName={jobName}&start={value}&count={value}
		<br />
		<a
			href="http://localhost:9080/SleepyBatchletSample/joboperator?action=help" id="helpURL"><button 
				type="button" id="helpButton" onclick="javascript:getHelp()">View a List of All Possible Actions</button></a> url: &lt;host:port&gt;/sample.javaee7.sleepybatchlet/joboperator?action=help
		<br />
	</div>

<script>

function startJob(){
	var sleepTime = parseInt(document.getElementById("sleepTimeStartJob").value, 10);
	var elem = document.getElementById("startButton");
	var lnkElem = document.getElementById("startURL");
	if(sleepTime>0){
		elem.innterHTML = window.location.href + "joboperator?action=start&jobXMLName=sleepy-batchlet&jobParameters=sleep.time.seconds=" + sleepTime;
		lnkElem.href = window.location.href + "joboperator?action=start&jobXMLName=sleepy-batchlet&jobParameters=sleep.time.seconds=" + sleepTime;	
	}
	else{
		elem.innterHTML = window.location.href + "joboperator?action=start&jobXMLName=sleepy-batchlet";
		lnkElem.href = window.location.href + "joboperator?action=start&jobXMLName=sleepy-batchlet";	
	}
}

function statusJob (){
	var num = parseInt(document.getElementById("executionIdStatus").value, 10);
	var elem = document.getElementById("statusButton");
	var lnkElem = document.getElementById("statusURL");
	if(num>=0){
		elem.innterHTML = window.location.href + "joboperator?action=status&executionId=" + num;
		lnkElem.href = window.location.href + "joboperator?action=status&executionId=" + num;
	}else{
		elem.innterHTML = window.location.href;
		lnkElem.href = window.location.href;
	}
}

function stopJob(){
	var num = parseInt(document.getElementById("executionIdStop").value, 10);
	var elem = document.getElementById("stopButton");
	var lnkElem = document.getElementById("stopURL");
	elem.innterHTML = window.location.href + "joboperator?action=stop&executionId=" + num;
	lnkElem.href = window.location.href + "joboperator?action=stop&executionId=" + num;
}

function restartJob(){
	var num = parseInt(document.getElementById("executionIdRestart").value, 10);
	var sleepTime = parseInt(document.getElementById("sleepTimeRestartJob").value, 10);
	var elem = document.getElementById("restartButton");
	var lnkElem = document.getElementById("restartURL");
	if(sleepTime>0){
		elem.innterHTML = window.location.href + "joboperator?action=restart&executionId=" + num + "&restartParameters=sleep.time.seconds=" + sleepTime;
		lnkElem.href = window.location.href + "joboperator?action=restart&executionId=" + num + "&restartParameters=sleep.time.seconds=" + sleepTime;	
	}
	else{
		elem.innterHTML = window.location.href + "joboperator?action=restart&executionId=" + num;
		lnkElem.href = window.location.href + "joboperator?action=restart&executionId=" + num;	
	}
}

function getHelp(){
	var elem = document.getElementById("helpButton");
	var lnkElem = document.getElementById("helpURL");
	elem.innterHTML = window.location.href + "joboperator?action=help";
	lnkElem.href = window.location.href + "joboperator?action=help";
}

function listExecutions(){
	var elem = document.getElementById("runningExecsButton");
	var lnkElem = document.getElementById("runningExecutionsURL");
	elem.innterHTML = window.location.href + "joboperator?action=getRunningExecutions&jobName=sleepy-batchlet";
	lnkElem.href = window.location.href + "joboperator?action=getRunningExecutions&jobName=sleepy-batchlet";
}

function listJobInstances(){
	var elem = document.getElementById("jobInstancesButton");
	var lnkElem = document.getElementById("jobInstancesURL");
	elem.innterHTML = window.location.href + "joboperator?action=getJobInstances&jobName=sleepy-batchlet&start=0&count=100";
	lnkElem.href = window.location.href + "joboperator?action=getJobInstances&jobName=sleepy-batchlet&start=0&count=100";
}
</script>
</html>
