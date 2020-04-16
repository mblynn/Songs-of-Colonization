<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- declare global variable stylesheet variables -->
    <xsl:variable name="barWidth" as="xs:double" select="50"/>
    <xsl:variable name="interbarSpacing" as="xs:double" select="$barWidth * 3"/>
    <xsl:variable name="maxWidth" as="xs:double" select="2.5 * ($barWidth + $interbarSpacing)"/>
    <xsl:variable name="maxHeight" as="xs:double" select="100"/>
    <xsl:variable name="yScale" as="xs:double" select="3"/>
    <xsl:variable name="yBarScale" as="xs:double" select="1000"/>
    <xsl:template match="/">
        <svg>
            <!-- draws the chart out of the window and moves it down to visible space -->
            <g transform="translate(100, {$yScale * $maxHeight +100})">
                <!-- draws chart title, y-axis increment labels, ruling lines -->
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="black"
                        stroke-dasharray="3 3" stroke-width="2"/>
                    <text x="-10" y="-{$height}" text-anchor="end" alignment-baseline="central">
                        <xsl:value-of select="."/>% </text>
                </xsl:for-each>
                <text x="-50" y="-{$maxHeight * $yScale div 2}" writing-mode="tb"
                    text-anchor="middle">Percentage of Possession</text>
                <!-- declares variable for the position of rectangles on the x-axis based on position out input -->
                <xsl:variable name="xPos" as="xs:double"
                    select="
                        ($interbarSpacing) +
                        (position() - 1) * ($barWidth + $interbarSpacing)"/>
                <!-- declares variables that calculate violence by each songs and the type of violence -->
                <xsl:variable name="americanPossess"
                    select="count(//line[@lang = 'american']/possess) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="germanPossess"
                    select="count(//line[@lang = 'germ-trans']/possess) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="american-Land"
                    select="count(//line[@lang = 'american']/possess[@kind = 'land']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-Labor"
                    select="count(//line[@lang = 'american']/possess[@kind = 'labor']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-Res"
                    select="count(//line[@lang = 'american']/possess[@kind = 'resource']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-People"
                    select="count(//line[@lang = 'american']/possess[@kind = 'people']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="german-Land"
                    select="count(//line[@lang = 'germ-trans']/possess[@kind = 'land']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="germand-Labor"
                    select="count(//line[@lang = 'germ-trans']/possess[@kind = 'labor']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-Res"
                    select="count(//line[@lang = 'germ-trans']/possess[@kind = 'resource']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-People"
                    select="count(//line[@lang = 'germ-trans']/possess[@kind = 'people']) div count(//line[@lang = 'germ-trans'])"/>
                <!-- entire american rectable -->
                <rect x="{$xPos}" y="-{$yScale * ($americanPossess * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($americanPossess * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- american resource -->
                <rect x="{$xPos}" y="-{$yScale * ($americanPossess + $american-Res * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($americanPossess + $american-Res * $yBarScale)}"
                    fill="orange" stroke="black" stroke-width=".25"/>
                <!-- german rectangle -->
                <rect x="{$xPos + $interbarSpacing}" y="-{$yScale * ($germanPossess * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($germanPossess * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- german people -->
                <rect x="{$xPos + $interbarSpacing}" y="-{$yScale * ($german-People + $german-Res * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * ($german-People + $german-Res * $yBarScale)}" fill="orange"
                    stroke="black" stroke-width=".25"/>
                <!--  german resource-->
                <rect x="{$xPos + $interbarSpacing}"
                    y="-{2 * ($yScale * ($german-People + $german-Res * $yBarScale))}"
                    width="{$barWidth}"
                    height="{$yScale * ($german-People + $german-Res * $yBarScale)}" fill="red"
                    stroke="black" stroke-width=".25"/>
                <!-- draws axes -->
                <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$maxHeight * $yScale}" stroke="black"
                    stroke-linecap="square"/>
                <!-- labels bars with % at top and corpus at bottom-->
                <text x="{$xPos + $barWidth div 2}" y="{5 *$yScale}" text-anchor="middle"
                    font-size="smaller"> American Songs </text>
                <text x="{$xPos + $barWidth + $interbarSpacing -25}" y="{5 *$yScale}"
                    text-anchor="middle" font-size="smaller"> German Songs </text>
                <text x="{$xPos + $barWidth div 2}"
                    y="-{$yScale * ($americanPossess * $yBarScale)+7}" text-anchor="middle">
                    <xsl:value-of select="round-half-to-even(100 * $americanPossess, 3) || '%'"/>
                </text>
                <text x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanPossess * $yBarScale)+3}">
                    <xsl:value-of select="round-half-to-even(100 * $germanPossess, 3) || '%'"/>
                </text>
                <!-- creates key for color categories -->
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.43}" height="10" width="10"
                    stroke="black" stroke-width="1" stroke-linecap="square" fill="orange"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 1.5}">Resource</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.60}" height="10" width="10"
                    stroke="black" stroke-width="1" stroke-linecap="square" fill="red"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 1.7}">People</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.87}" height="10" width="10"
                    stroke="black" stroke-width="1" stroke-linecap="square" fill="blue"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 2}">Land</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 2.2}" height="10" width="10"
                    stroke="black" stroke-width="1" stroke-linecap="square" fill="yellow"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 2.4}">Labor</text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
