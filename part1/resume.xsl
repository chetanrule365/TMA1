<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//cv/me/@name" />
                </title>
                <link rel="stylesheet" type="text/css" href="resume.css" />
            </head>
            <body>
                <div id="container">
                    <div id="me">
                        <h1>
                            <xsl:value-of select="//cv/me/@name" />
                        </h1>
                        <ul id="contactdetails">
                            <li>
                                Address:
                                <xsl:value-of select="//cv/me/@address" />
                            </li>
                            <li>
                                Telephone:
                                <xsl:value-of select="//cv/me/@telephone" />
                            </li>
                            <li>
                                Email:
                                <xsl:value-of select="//cv/me/@email" />
                            </li>
                        </ul>
                    </div>
                    <div id="content">
                        <div id="statement">
                            <p>
                                <xsl:copy-of select="//cv/me" />
                            </p>
                        </div>
                        <div id="sxscontainer">
                            <div id="education">
                                <h2>Education</h2>
                                <xsl:call-template name="showEducation" />
                            </div>
                            <div id="employment">
                                <h2>Employment</h2>
                                <xsl:call-template name="showEmployment" />
                            </div>
                        </div>
                        <div class="page-break" />
                        <div id="hobbiesandinterests">
                            <h2>Projects</h2>
                            <xsl:call-template name="showProjects" />
                        </div>
                        <div>
                            <h2>certifications</h2>
                            <xsl:call-template name="certifications" />
                        </div>
                    </div>
                </div>
                <script type="text/javascript" src="cvedit.js"></script>
            </body>
        </html>
    </xsl:template>
    <!-- useThisElseThat: if the value passed is null, return the 'That' value -->
    <xsl:template name="useThisElseThat">
        <xsl:param name="this" />
        <xsl:param name="that" />
        <xsl:choose>
            <xsl:when test="$this!=''">
                <xsl:value-of select="$this" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$that" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- showDateRange: standardise the way date ranges are shown across the document -->
    <xsl:template name="showDateRange">
        <xsl:param name="fromDate" />
        <xsl:param name="toDate" />
        <xsl:param name="noToDate" />
        (
        <xsl:value-of select="$fromDate" />
        -
        <xsl:call-template name="useThisElseThat">
            <xsl:with-param name="this" select="$toDate" />
            <xsl:with-param name="that" select="$noToDate" />
        </xsl:call-template>
        )
    </xsl:template>
    <!-- niceQual: what an individual qual looks like -->
    <xsl:template name="showQual">
        <xsl:param name="currentQual" />
        <div class="qual">
            <p class="qualcontent">
                <xsl:copy-of select="." />
            </p>
            <p class="qualestablishment">
                <xsl:value-of select="@establishment" />
                <xsl:call-template name="showDateRange">
                    <xsl:with-param name="fromDate" select="@from" />
                    <xsl:with-param name="toDate" select="@to" />
                    <xsl:with-param name="noToDate" select="'Ongoing'" />
                </xsl:call-template>
            </p>
        </div>
    </xsl:template>
    <!-- showEducation: the education section of the document -->
    <xsl:template name="showEducation">
        <h3 class="qualtype">
            <xsl:value-of select="//cv/education/qualification[1]/@type" />
        </h3>
        <xsl:for-each select="//cv/education/qualification">
            <xsl:if test="@type != preceding-sibling::qualification[1]/@type">
                <h3 class="qualtype">
                    <xsl:value-of select="@type" />
                </h3>
            </xsl:if>
            <xsl:call-template name="showQual">
                <xsl:with-param name="currentQual" select="." />
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    <!-- showEmployment: the employment section of the document -->
    <xsl:template name="showEmployment">
        <xsl:for-each select="//cv//employment/experience">
            <h3 class="jobtitle">
                <strong>
                    <xsl:value-of select="@job_title" />
                </strong>
                ,
                <xsl:value-of select="@establishment" />
                <span>
                    <xsl:call-template name="showDateRange">
                        <xsl:with-param name="fromDate" select="@from" />
                        <xsl:with-param name="toDate" select="@to" />
                        <xsl:with-param name="noToDate" select="'Ongoing'" />
                    </xsl:call-template>
                </span>
            </h3>
            <p class="jobdescription">
                <xsl:value-of select="./description[1]" />
            </p>
            <ul class="jobachievementlist">
                <xsl:for-each select="achievement">
                    <li class="jobachievementitem">
                        <xsl:value-of select="." />
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="showProjects">
        <xsl:for-each select="//cv//projects/project">
            <h4 class="jobtitle">
                <strong>
                    <xsl:value-of select="@name" />
                </strong>
            </h4>
            <ul class="jobachievementlist">
                <xsl:for-each select="point">
                    <li class="jobachievementitem">
                        <xsl:value-of select="." />
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="certifications">
        <xsl:for-each select="//cv//certifications">
            <ul class="jobachievementlist">
                <xsl:for-each select="certificate">
                    <li class="jobachievementitem">
                        <xsl:value-of select="." />
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <!-- text: shows paragraphs where <br/> tag is used, 
		@source http://http://www.velocityreviews.com/forums/t169843-br-tag-in-xml-content.html -->
    <xsl:template name="text" match="text()">
        <xsl:param name="text" select="." />
        <xsl:choose>
            <xsl:when test="contains($text, '&#xA;')">
                <xsl:value-of select="substring-before($text, '&#xA;')" />
                <br />
                <xsl:call-template name="text">
                    <xsl:with-param name="text" select="substring-after($text,'&#xA;')" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$text" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>