<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">
    <xsl:output method="html"/>

    <!-- transform the root element (TEI) into an HTML template -->
    <xsl:template match="tei:TEI">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:text>&#xa;</xsl:text>
        <html lang="en" xml:lang="en">
            <head>
                <title>
                    Tummeliten 1895 - Diplomatisk transkribering
                </title>
                <!-- load bootstrap css (requires internet!) so you can use their pre-defined css classes to style your html -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous" />
                
                <!-- load the stylesheets in the assets/css folder, where you can modify the styling of your website -->
                <link rel="stylesheet" href="assets/css/main.css"/>
            </head>
            <body>
                <header>
                    <h1 class="header"><a href="index.html">Tummeliten 1895</a></h1>
                    <h2 class="header">Digitaliserad version av 1895 års utgåva</h2>
                </header>
                <nav>
                    <ul class="nav justify-content-center">
                        <li class="nav-item">
                            <a class="nav-link" href="index.html">Hem</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="diplomatic.html">Diplomatisk transkribering</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="reading.html">Läsvy</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"  href="authors.html">Författare &amp; illustratörer</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="aboutproject.html">Om projektet</a>
                        </li>
                    </ul>
                </nav>
                <main id="manuscript" class="transcription_container">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">
                    <!-- define a row layout with bootstrap's css classes (two columns with content, and an empty column in between) -->
                        <div class="row">
                            <div class="col-sm">
                                <h2>Faksimiler</h2>
                            </div>
                            <div class="col-sm">
                            </div>
                            <div class="col-sm">
                                <h2>Diplomatisk transkribering</h2>
                            </div>
                        </div>
                        <xsl:for-each select="//tei:front">
                            <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                            <xsl:variable name="facs" select="@facs"/>
                            
                            <div class="row">
                                <!-- fill the first column with this page's image -->
                                <div class="col-sm">
                                    <article>
                                        <!-- make an HTML <img> element, with a maximum width of 400 pixels -->
                                        <img class="img-full">
                                           
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:graphic/@url"/>
                                            </xsl:attribute>
                                            <!-- <xsl:attribute name="title">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:label"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute> -->
                                        </img>
                                    </article>
                                </div>
                                <div class='col-sm'>
                                    <article class="transcription">
                                            <xsl:apply-templates/>                                      
                                    </article>
                                </div>
                            </div>
                        </xsl:for-each>
                        
                        <!-- set up an image-text pair for each page in your document, and start a new 'row' for each pair -->
                        <xsl:for-each select="//tei:div[@type='page']">
                            <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                            <xsl:variable name="facs" select="@facs"/>
                            
                            <div class="row">
                                <!-- fill the first column with this page's image -->
                                <div class="col-sm">
                                    <article>
                                        <!-- make an HTML <img> element, with a maximum width of 400 pixels -->
                                        <img class="img-full">
                                            <!-- give this HTML <img> attribute three more attributes:
                                                    @src to locate the image file
                                                    @title for a mouse-over effect
                                                    @alt for alternative text (in case the image fails to load, 
                                                        and so people with a visual impairment can still understant what the image displays 
                                                  
                                                  in the XPath expressions below, we use the variable $facs (declared above) 
                                                        so we can use this page's @facs element with to find the corresponding <surface>
                                                        (because it matches with the <surface's @xml:id) 
                                            
                                                  we use the substring-after() function because when we match our page's @facs with the <surface>'s @xml:id,
                                                        we want to disregard the hashtag in the @facs attribute-->
                                            
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:graphic/@url"/>
                                            </xsl:attribute>
                                            <!-- <xsl:attribute name="title">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:label"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute> -->
                                        </img>
                                    </article>
                                </div>
                                <!-- fill the second column with our transcription -->
                                <div class='col-sm'>
                                    <article class="transcription">
                                            <xsl:apply-templates/>   
                                            
                                            <xsl:if test="position() = last()">
                                                <xsl:apply-templates select="//tei:div[@type='colophon']"/>
                                            </xsl:if>
                                    </article>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </main>
                <footer>
                    <div class="container text-center footer_container">
                        <div class="copyright_logos">
                            <a class="copyright_link_container"
                                href="https://creativecommons.org/licenses/by/4.0/legalcode">
                                <img src="assets/img/logos/cc.svg" class="copyright_logo"
                                    alt="Creative Commons License" />
                                <img src="assets/img/logos/by.svg" class="copyright_logo"
                                    alt="Attribution 4.0 International" />
                            </a>
                        </div>

                        <div>
                            2026. Tina Ericsson Ljungberg, Sara Danckwardt &amp; Amanda Olsson
                        </div>
                    </div>
                </footer>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
                <script src="assets/js/script.js"></script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:teiHeader"/>

    <!-- XSL för pageHeader-elementet -->
    <xsl:template match="tei:div[@type='pageHeader']">
        <div class="pageHeader container">
            <div class="row">
                <xsl:apply-templates/>
            </div>
        </div>    
    </xsl:template>

    <xsl:template match="tei:fw[@type='pageNum']">
        <xsl:choose>
            <xsl:when test="@place='top-left'">
                <div class="col num_left">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="col num_right">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
            
    </xsl:template>

    <xsl:template match="tei:fw[@type='header']">
        <div class="col">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <!-- testar om <lb>-taggen har ett @rend-attribut för indentering och renderar beroende på -->
    <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="@rend='indented'">
            <!-- <br/>  -->
            <span class="indented">
                <xsl:apply-templates/>
            </span>
                       
            </xsl:when>
        <xsl:otherwise>
            <br/>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:said[@rend = 'indented']">
        <!-- <br class="indented_br"/>  -->
            <span class="indented">
                <xsl:apply-templates/>
            </span>
    </xsl:template>

    <!-- <xsl:template match="tei:hi[@rend = 'indented']">
        <span class="indented">
            <xsl:apply-templates/>
        </span>
    </xsl:template> -->

    <!-- Markerar ny kolumn med en linje -->
    <xsl:template match="tei:cb[@n = '2']">
        <div class="column_line">
        </div>
    </xsl:template>

    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <!-- apply matching templates for anything that was nested in tei:p -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:hi[@rend = 'italic']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <xsl:template match="tei:*[@rend = 'italic']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <xsl:template match="tei:lg">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:l">
        <!-- <span class="line"> -->
            <xsl:apply-templates/>
        <!-- </span> -->
        <br/>
    </xsl:template>


</xsl:stylesheet>
