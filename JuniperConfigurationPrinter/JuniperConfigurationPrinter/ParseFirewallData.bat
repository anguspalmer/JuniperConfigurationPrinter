@echo off
echo Juniper Firewall Policy Parser
echo Pushes XML data exported from Juniper Firewalls
echo  through an XSLT transformation into a single page HTML


set $xml_input=".\data\2015-08-17-FW-Rules.xml"
set $xslt=".\source\Junos-fw-rules.xslt"
set $html_output=".\output\2015-08-17-FW-Rules.html"

%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ".\source\Transform-XML.ps1 -xml %$xml_input% -xsl %$xslt% -output %$html_output%"
echo Done!
pause