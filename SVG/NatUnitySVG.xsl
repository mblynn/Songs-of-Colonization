<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- declare global variable stylesheet variables -->
    <xsl:variable name="barWidth" as="xs:double" select="50"/>
    <xsl:variable name="interbarSpacing" as="xs:double" select="$barWidth * 3"/>
    <xsl:variable name="maxWidth" as="xs:double" select="2.5 * ($barWidth + $interbarSpacing)"/>
    <xsl:variable name="maxHeight" as="xs:double" select="250"/>
    <xsl:variable name="yScale" as="xs:double" select="1.5"/>
    <xsl:variable name="yBarScale" as="xs:double" select="1000"/>
    <xsl:template match="/">
        <svg>
            <!-- draws the chart out of the window and moves it down to visible space -->
            <g transform="translate(100, {$yScale * $maxHeight +100})">
                <!-- draws chart title, y-axis increment labels, ruling lines -->
                <xsl:for-each select="5, 10, 15, 20, 25">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="black"
                        stroke-dasharray="3 3" stroke-width="1"/>
                    <text x="-10" y="-{$height}" text-anchor="end" alignment-baseline="central"
                        font-size="smaller">
                        <xsl:value-of select="."/>% </text>
                </xsl:for-each>
                <text x="-50" y="-{$maxHeight * $yScale div 2}" writing-mode="tb"
                    text-anchor="middle">Percentage of National Unity</text>
                <!-- declares variable for the position of rectangles on the x-axis based on position out input -->
                <xsl:variable name="xPos" as="xs:double"
                    select="
                        ($interbarSpacing) +
                        (position() - 1) * ($barWidth + $interbarSpacing)"/>
                <!-- declares variables that calculate violence by each songs and the type of violence -->
                <xsl:variable name="americanNatUnity"
                    select="count(//line[@lang = 'american']/NatUnity) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="germanNatUnity"
                    select="count(//line[@lang = 'germ-trans']/NatUnity) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="american-bro"
                    select="count(//line[@lang = 'american']/NatUnity[@cat = 'brotherhood']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-sol"
                    select="count(//line[@lang = 'american']/NatUnity[@cat = 'solidarity']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-loy"
                    select="count(//line[@lang = 'american']/NatUnity[@cat = 'loyalty']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-pride"
                    select="count(//line[@lang = 'american']/NatUnity[@cat = 'pride']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-pat"
                    select="count(//line[@lang = 'american']/NatUnity[@cat = 'patriotism']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="german-bro"
                    select="count(//line[@lang = 'germ-trans']/NatUnity[@cat = 'brotherhood']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-sol"
                    select="count(//line[@lang = 'germ-trans']/NatUnity[@cat = 'solidarity']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-loy"
                    select="count(//line[@lang = 'germ-trans']/NatUnity[@cat = 'loyalty']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-pride"
                    select="count(//line[@lang = 'germ-trans']/NatUnity[@cat = 'pride']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-pat"
                    select="count(//line[@lang = 'germ-trans']/NatUnity[@cat = 'patriotism']) div count(//line[@lang = 'germ-trans'])"/>
                <!-- entire american rectangle -->
                <rect x="{$xPos}" y="-{$yScale * ($americanNatUnity * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($americanNatUnity * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- american brotherhood -->
                <rect x="{$xPos}" y="-{$yScale * ($american-bro + $american-sol * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * ($american-bro + $american-sol * $yBarScale)}" fill="orange"
                    stroke="black" stroke-width=".25"/>
                <!--  american solidarity-->
                <rect x="{$xPos}"
                    y="-{2 * ($yScale * ($american-bro + $american-sol * $yBarScale))}"
                    width="{$barWidth}"
                    height="{$yScale * ($american-bro + $american-sol * $yBarScale)}" fill="red"
                    stroke="black" stroke-width=".25"/>
                <rect x="{$xPos}"
                    y="-{(75.07499999999999 + 16.146428571428572)}"
                    width="{$barWidth}"
                    height="{$yScale * ($american-bro + $american-sol + $american-pat * $yBarScale)}" fill="yellow"
                    stroke="black" stroke-width=".25"/>
                <!-- entire german rectangle -->
                <rect x="{$xPos + $interbarSpacing}" y="-{$yScale * ($germanNatUnity * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($germanNatUnity * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- draws axes -->
                <line x1="0" y1="0" x2="{$maxWidth}" y2="0" stroke="black" stroke-linecap="square"/>
                <line x1="0" y1="0" x2="0" y2="-{$maxHeight * $yScale}" stroke="black"
                    stroke-linecap="square"/>
                <!-- labels bars with % at top and corpus at bottom-->
                <text x="{$xPos + $barWidth div 2}" y="{5 *$yScale + 5}" text-anchor="middle"
                    font-size="smaller"> American Songs </text>
                <text x="{$xPos + $barWidth + $interbarSpacing -25}" y="{5 *$yScale + 5}"
                    text-anchor="middle" font-size="smaller"> German Songs </text>
                <text x="{$xPos + $barWidth div 2}"
                    y="-{$yScale * ($americanNatUnity * $yBarScale)+5}" text-anchor="middle"
                    font-size="smaller">
                    <xsl:value-of select="round-half-to-even(100 * $americanNatUnity, 3) || '%'"/>
                </text>
                <text x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanNatUnity * $yBarScale)+6}" font-size="smaller">
                    <xsl:value-of select="round-half-to-even(100 * $germanNatUnity, 3) || '%'"/>
                </text>
                <!-- creates key for color categories -->
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.46}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="blue"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 1.52}">Loyalty</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.63}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="red"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 1.71}">Brotherhood</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 1.83}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="orange"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 1.94}">Solidarity</text>
                <rect x="{$maxWidth + 4}" y="-{$maxHeight * $yScale div 2.08}" height="10" width="10"
                    stroke="black" stroke-width="1" stroke-linecap="square" fill="yellow"/>
                <text x="{$maxWidth + 16}" y="-{$maxHeight * $yScale div 2.2}">Patriotism</text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
