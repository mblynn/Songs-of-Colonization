<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%">
    <!--Global variables, from assignment 2 -->
    <xsl:variable name="barWidth" select="20"/>
    <xsl:variable name="barInterval" select="$barWidth + 10"/>
    <xsl:variable name="barHeight" select="300"/>
    <xsl:variable name="barShift" select="22"/>
    <xsl:template match="/">
        <g transform="translate(30, 330)">
            <!--
                    The height of the y axis is hard-coded
                    The length of the x axis is calculated according to the number of states
                    There's a dashed line at 50% on the y axis
                -->
            <line x1="20" x2="20" y1="0" y2="-320" stroke="black" stroke-width="1"/>
            <line x1="20" x2="{count(//homeland*$barInterval + 20}" y1="0" y2="0" stroke="black"
                stroke-width="1"/>
            <line x1="{20}" x2="{count(//homeland)*$barInterval + 20}" y1="-{$barHeight div 2}"
                y2="-{$barHeight div 2}" stroke="black" opacity="0.5" stroke-dasharray="8 4"
                stroke-width="1"/>
            <text x="10" y="5" text-anchor="end">0%</text>
            <text x="10" y="{5 - $barHeight div 2}" text-anchor="end">50%</text>
            <text x="10" y="{5 - $barHeight}" text-anchor="end">100%</text>
            <xsl:apply-templates select="//homeland"/>
        </g>
    
        <!-- x and y axes, from stooges -->
        <g transform="translate(30, 250)">
        <line x1="0" y1="0" x2="150" y2="0" stroke="black" stroke-width="2" stroke-linecap="square"/>
        <line x1="0" y1="0" x2="0" y2="-210" stroke="black" stroke-width="2" stroke-linecap="square"/>
        <!-- horizontal ticks on Y axis, from stooges -->
        <line x1="-3" x2="3" y1="-20" y2="-20" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-40" y2="-40" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-60" y2="-60" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-80" y2="-80" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-100" y2="-100" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-120" y2="-120" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-140" y2="-140" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-160" y2="-160" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-180" y2="-180" stroke="black" stroke-width="1"/>
        <line x1="-3" x2="3" y1="-200" y2="-200" stroke="black" stroke-width="1"/>
        <!-- labels for Y axis -->
        <text x="-8" y="-15" text-anchor="end">1</text>
        <text x="-8" y="-35" text-anchor="end">2</text>
        <text x="-8" y="-55" text-anchor="end">3</text>
        <text x="-8" y="-75" text-anchor="end">4</text>
        <text x="-8" y="-95" text-anchor="end">5</text>
        <text x="-8" y="-115" text-anchor="end">6</text>
        <text x="-8" y="-135" text-anchor="end">7</text>
        <text x="-8" y="-155" text-anchor="end">8</text>
        <text x="-8" y="-175" text-anchor="end">9</text>
        <text x="-8" y="-195" text-anchor="end">10</text>
        <!-- rectangular data bars, with name labels -->
        <rect x="0" y="-200" width="40" height="200" fill="green" stroke="black" stroke-width="1"/>
        <text x="20" y="15" text-anchor="middle">American</text>
        <rect x="60" y="-140" width="40" height="140" fill="blue" stroke="black" stroke-width="1"/>
        <text x="80" y="15" text-anchor="middle">German</text>
    </g>
</svg>