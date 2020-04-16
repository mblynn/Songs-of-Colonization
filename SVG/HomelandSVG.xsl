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
                <!--       <text x="{$maxWidth div 2}" y="-{$maxHeight + 250}" text-anchor="middle"
                    font-weight="bold" font-size="larger">Violence by Category in the Songs of
                    Colonization</text>-->
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="black"
                        stroke-dasharray="3 3" stroke-width="2"/>
                    <text x="-10" y="-{$height}" text-anchor="end" alignment-baseline="central">
                        <xsl:value-of select="."/>% </text>
                </xsl:for-each>
                <text x="-50" y="-{$maxHeight * $yScale div 2}" writing-mode="tb"
                    text-anchor="middle">Percentage of Homeland</text>
                <!-- declares variable for the position of rectangles on the x-axis based on position out input -->
                <xsl:variable name="xPos" as="xs:double"
                    select="
                        ($interbarSpacing) +
                        (position() - 1) * ($barWidth + $interbarSpacing)"/>
                <!-- declares variables that calculate homeland by each songs and homeland by mood -->
                <xsl:variable name="americanHomeland"
                    select="count(//line[@lang = 'american']/homeland) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="germanHomeland"
                    select="count(//line[@lang = 'germ-trans']/homeland) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="american-pos"
                    select="count(//line[@lang = 'american']/homeland[@mood = 'positive']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-neg"
                    select="count(//line[@lang = 'american']/homeland[@mood = 'negative']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-ambig"
                    select="count(//line[@lang = 'american']/homeland[@mood = 'ambiguous']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="german-pos"
                    select="count(//line[@lang = 'germ-trans']/homeland[@mood = 'positive']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="german-neg"
                    select="count(//line[@lang = 'germ-trans']/homeland[@mood = 'negative']) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="germans-ambig"
                    select="count(//line[@lang = 'germ-trans']/homeland[@mood = 'ambiguous']) div count(//line[@lang = 'germ-trans'])"/>
                <!-- entire american rectangle (positive) -->
                <rect x="{$xPos}" y="-{$yScale * ($americanHomeland * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($americanHomeland * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- american negative -->
                <rect x="{$xPos}" y="-{$yScale * ($american-pos + $american-neg * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * ($american-pos + $american-neg * $yBarScale)}" fill="orange"
                    stroke="black" stroke-width=".25"/>
                <!--  american ambig-->
                <rect x="{$xPos}"
                    y="-{2 * ($yScale * ($american-pos + $american-neg * $yBarScale))}"
                    width="{$barWidth}"
                    height="{$yScale * ($american-pos + $american-neg * $yBarScale)}" fill="red"
                    stroke="black" stroke-width=".25"/>
                <!-- entire german rectangle -->
                <rect x="{$xPos + $interbarSpacing}" y="-{$yScale * ($germanHomeland * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($germanHomeland * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- german negative and positive (note: both are 0) -->
                <rect x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanHomeland + $german-neg * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * ($germanHomeland + $german-neg * $yBarScale)}" fill="red"
                    stroke="black" stroke-width=".25"/>
                <rect x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanHomeland + $german-pos * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * ($germanHomeland + $german-pos * $yBarScale)}" fill="blue"
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
                    y="-{$yScale * ($americanHomeland * $yBarScale)+3}" text-anchor="middle">
                    <xsl:value-of select="round-half-to-even(100 * $americanHomeland, 3) || '%'"/>
                </text>
                <text x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanHomeland * $yBarScale)+3}">
                    <xsl:value-of select="round-half-to-even(100 * $germanHomeland, 3) || '%'"/>
                </text>
                <!-- creates key for color categories -->
                <rect x="{$maxWidth + 4}" y="-{210}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="blue"/>
                <text x="{$maxWidth + 16}" y="-{200}">Positive</text>
                <rect x="{$maxWidth + 4}" y="-{184}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="red"/>
                <text x="{$maxWidth + 16}" y="-{174}">Negative</text>
                <rect x="{$maxWidth + 4}" y="-{158}" height="10"
                    width="10" stroke="black" stroke-width="1" stroke-linecap="square" fill="orange"/>
                <text x="{$maxWidth + 16}" y="-{148}">Ambiguous</text>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
