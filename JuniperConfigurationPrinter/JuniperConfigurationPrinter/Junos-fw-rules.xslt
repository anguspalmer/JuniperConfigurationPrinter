<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:junos="http://xml.juniper.net.junos/*/junos" >
  <xsl:output
      doctype-system='http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'
      doctype-public='-//W3C//DTD XHTML 1.0 Transitional//EN'
      indent='yes'
      method='html'
/>

  <xsl:template match="/rpc-reply/configuration">
    <html>
      <head>
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.8/css/jquery.dataTables.min.css" />

        <!-- Security Policies [Local File] CSS -->
        <link rel="stylesheet" type="text/css" href="../css/security-policies.css" />

        <!-- jQuery -->
        <script type="text/javascript" charset="utf8" src="http://code.jquery.com/jquery-1.10.2.min.js" />

        <!-- DataTables -->
        <script type="text/javascript" charset="utf8" src="http://cdn.datatables.net/1.10.8/js/jquery.dataTables.min.js"/>
      </head>
      <body>
        <div id="header">
          <div class="wrap">
            <div class="logo">
              <a href="#"></a>
            </div>
            <h1>Juniper Firewall Configuration</h1>
            </div>
            
          </div>
        <div id="content">
          Date of Export: <xsl:value-of select="@junos:commit-localtime" />
          <xsl:apply-templates select="security/policies" />
          <script type="text/javascript">
            //<![CDATA[
          $(document).ready( function () {
            $('#policies').DataTable( {
              "pageLength":50
            });
          } );
          //]]>
          </script>
        </div>
        <div id="footer">
          <div class="wrap">
            <p>Copyright © ac3 Limited 2015</p>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- Security Policies Template -->
  <xsl:template match="security/policies">
    <h2>Security Policies</h2>
    <table id="policies" class="cell-border compact" cellspacing="0">
      <thead>
        <tr>
          <th>From Zone</th>
          <th>To Zone</th>
          <th>Name</th>
          <th>Description</th>
          <th>Source</th>
          <th>Destination</th>
          <th>Application</th>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="policy/policy"/>
      </tbody>
    </table>
  </xsl:template>

  <!-- Security Policy Template -->
  <xsl:template match="policy/policy">
    <xsl:choose>
      <xsl:when test="then/deny">
        <tr class="deny">
          <td>
            <xsl:value-of select="../from-zone-name"/>
          </td>
          <td>
            <xsl:value-of select="../to-zone-name"/>
          </td>
          <td>
            <xsl:value-of select="name"/>
          </td>
          <td>
            <xsl:value-of select="description"/>
          </td>
          <xsl:apply-templates select="match" />
        </tr>
      </xsl:when>
      <xsl:otherwise>
        <tr class="permit">
          <td>
            <xsl:value-of select="../from-zone-name"/>
          </td>
          <td>
            <xsl:value-of select="../to-zone-name"/>
          </td>
          <td>
            <xsl:value-of select="name"/>
          </td>
          <td>
            <xsl:value-of select="description"/>
          </td>
          <xsl:apply-templates select="match" />
        </tr>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Match Criteria Template -->
  <xsl:template match="match">
    <td>
      <xsl:for-each select="source-address">
        <xsl:value-of select="." />
        <br/>
      </xsl:for-each>
    </td>
    <td>
      <xsl:for-each select="destination-address">
        <xsl:value-of select="." />
        <br/>
      </xsl:for-each>
    </td>
    <td>
      <xsl:for-each select="application">
        <xsl:value-of select="." />
        <br/>
      </xsl:for-each>
    </td>
  </xsl:template>

</xsl:stylesheet>

