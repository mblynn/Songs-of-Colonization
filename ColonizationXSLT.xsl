<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes" doctype-system="about:legacy-compat"/>
    <!--    Begin Structural XSLT-->
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
        <section>
            <!-- Outputs the titles as clickable links -->
            <h2 id="song{@n}">
                <xsl:apply-templates select="title"/>
            </h2>
            <!--Wraps each song in a <section> tag-->

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
    <!--    End Strucutural XSLT-->
    <!--  BeginDescriptive XSLT  -->
    <!--    How should we deal with the @type attribute. There are so many values!-->
    <xsl:template match="violence">
        <span class="violence">
            <xsl:choose>
                <xsl:when test="@perp = 'native' and @victim = 'settler'">
                    <span class="nat-to-set">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@perp = 'settler' and @victim = 'native'">
                    <span class="set-to-nat">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="action">
        <span class="action">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="sig">
        <span class="sig">
            <xsl:choose>
                <xsl:when test="@mood = 'positive'">
                    <span class="positive">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@mood = 'negative'">
                    <span class="negative">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@mood = 'ambiguous'">
                    <span class="ambiguous">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="homeland">
        <span class="homeland">
            <xsl:choose>
                <xsl:when test="@mood = 'positive'">
                    <span class="positive">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@mood = 'negative'">
                    <span class="negative">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@mood = 'ambiguous'">
                    <span class="ambiguous">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="NatUnity">
        <span class="NatUnity">
            <xsl:choose>
                <xsl:when test="@cat = 'brotherhood'">
                    <span class="brotherhood">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@cat = 'solidarity'">
                    <span class="solidarity">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@cat = 'loyalty'">
                    <span class="loyalty">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@cat = 'pride'">
                    <span class="pride">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@cat = 'patriotism'">
                    <span class="patriotism">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="possess">
        <span class="possess">
            <xsl:choose>
                <xsl:when test="@kind = 'land'">
                    <span class="land">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@kind = 'people'">
                    <span class="people">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@kind = 'labor'">
                    <span class="labor">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:when test="@kind = 'resource'">
                    <span class="resource">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
</xsl:stylesheet>
