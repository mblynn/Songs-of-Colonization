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
                <text x="{$maxWidth div 2}" y="-{$maxHeight + 250}" text-anchor="middle"
                    font-weight="bold" font-size="larger">Violence by Category in the Songs of
                    Colonization</text>
                <xsl:for-each select="1 to 10">
                    <xsl:variable name="height" as="xs:double" select=". * 10 * $yScale"/>
                    <line x1="0" y1="-{$height}" x2="{$maxWidth}" y2="-{$height}" stroke="black"
                        stroke-dasharray="3 3" stroke-width="2"/>
                    <text x="-10" y="-{$height}" text-anchor="end" alignment-baseline="central">
                        <xsl:value-of select="."/>% </text>
                </xsl:for-each>
                <text x="-50" y="-{$maxHeight * $yScale div 2}" writing-mode="tb"
                    text-anchor="middle">Percentage of Violence</text>
                <!-- declares variable for the position of rectangles on the x-axis based on position out input -->
                <xsl:variable name="xPos" as="xs:double"
                    select="
                        ($interbarSpacing) +
                        (position() - 1) * ($barWidth + $interbarSpacing)"/>
                <!-- declares variables that calculate violence by each songs and the type of violence -->
                <xsl:variable name="americanViolence"
                    select="count(//line[@lang = 'american']/violence) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="germanViolence"
                    select="count(//line[@lang = 'germ-trans']/violence) div count(//line[@lang = 'germ-trans'])"/>
                <xsl:variable name="american-NtoS"
                    select="count(//line[@lang = 'american']/violence[@perp = 'native' and @victim = 'settler']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-StoN"
                    select="count(//line[@lang = 'american']/violence[@perp = 'settler' and @victim = 'native']) div count(//line[@lang = 'american'])"/>
                <xsl:variable name="american-ambig"
                    select="count(//line[@lang = 'american']/violence[@perp = 'ambiguous' or @victim = 'ambiguous']) div count(//line[@lang = 'american'])"/>
                <!-- entire american rectable -->
                <rect x="{$xPos}" y="-{$yScale * ($americanViolence * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($americanViolence * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
                <!-- rectangle for ambiguous -->
                <rect x="{$xPos}" y="-{$yScale * (($american-StoN + $american-NtoS) * $yBarScale)}"
                    width="{$barWidth}"
                    height="{$yScale * (($american-StoN + $american-NtoS) * $yBarScale)}" fill="red"
                    stroke="black" stroke-width=".25"/>
                <!-- rectangle for settler to native -->
                <rect x="{$xPos}" y="-{$yScale * ($american-NtoS * $yBarScale)}" width="{$barWidth}"
                    height="{$yScale * ($american-NtoS * $yBarScale)}" fill="orange" stroke="black"
                    stroke-width=".25"/>
                <!-- violence for german songs. note: all violence in these songs had either ambiguous perpetrator or native -->
                <rect x="{$xPos + $interbarSpacing}" y="-{$yScale * ($germanViolence * $yBarScale)}"
                    width="{$barWidth}" height="{$yScale * ($germanViolence * $yBarScale)}"
                    fill="blue" stroke="black" stroke-width=".25"/>
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
                    y="-{$yScale * ($americanViolence * $yBarScale)+10}" text-anchor="middle">
                    <xsl:value-of select="round-half-to-even(100 * $americanViolence, 3) || '%'"/>
                </text>
                <text x="{$xPos + $interbarSpacing}"
                    y="-{$yScale * ($germanViolence * $yBarScale)+7}">
                    <xsl:value-of select="round-half-to-even(100 * $germanViolence, 3) || '%'"/>
                </text>
                <!-- writes note about how values are calulated -->
                <!--<text x="{$maxWidth div 2 +10}" y="{5 * $yScale + 20}" text-anchor="middle"
                    font-weight="bold" font-size="smaller">*Note: percentages calculated by counting
                    violence elements and dividing </text>
                <text x="{$maxWidth div 2 +10}" y="{5 * $yScale + 35}" text-anchor="middle"
                    font-weight="bold" font-size="smaller"> by the number of lines in each
                    language's corpus</text>-->
                <!--<!-\- creates key for color categories -\->
                <text x="{$maxWidth + 100}" y="-{$maxHeight * $yScale div 1.3}"
                    text-decoration="underline" font-weight="bold">Key</text>
                <text x="{$maxWidth + 10}" y="-{$maxHeight * $yScale div 1.5}" fill="orange"
                    >Perpetrator: Settler | Victim: Native</text>
                <text x="{$maxWidth + 10}" y="-{$maxHeight * $yScale div 1.7}" fill="red"
                    >Perpetrator: Native | Victim: Settler</text>
                <text x="{$maxWidth + 10}" y="-{$maxHeight * $yScale div 2}" fill="blue">Perpetrator
                    or Victim: Ambiguous</text>-->
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
