<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Songs</title>
            </head>
            <body>
                <h1>Songs of Colonization</h1>
                <h2>Contents</h2>
                <!-- Creates table of contents -->
                <ul>
                    <xsl:apply-templates select="//song" mode="toc"/>
                </ul>
                <hr/>
                <xsl:apply-templates select="//song"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="song" mode="toc">
        <!-- Adds links to the toc using AVT-->
        <li>
            <a href="#song{@n}">
                <xsl:apply-templates select="@n"/>
                <xsl:text>. </xsl:text>
                <xsl:apply-templates select="title" mode="toc"/>
            </a>
        </li>
    </xsl:template>
    <xsl:template match="song">
        <!-- Outputs the titles as clickable links -->
        <h2 id="song{@n}">
            <xsl:apply-templates select="title"/>
        </h2>
        <!--Wraps each song in a <section> tag-->
        <section>
            <xsl:apply-templates select="verse"/>
        </section>
    </xsl:template>
    <xsl:template match="verse">
        <!-- Outputs verses as <p> elements-->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="line">
        <!-- Adds line breaks -->
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::line">
            <br/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
