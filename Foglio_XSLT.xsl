<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="./css/css.css" />
            </head>
            <body>
                <xsl:apply-templates/>
                <script src="./js/js.js">//script in js.js</script>
            </body>
        </html>
    </xsl:template>
    <!--Only match not apply other templates.-->
    <xsl:template match="tei:teiHeader">
        <div id="encoInfo">
            <div class="modalContent">
		        <span class="close" onclick="hideEnco()">x</span>
                <h1>
                    <center><xsl:value-of select="//tei:title"/></center>
                </h1>
                <center><p><xsl:value-of select="//tei:editionStmt"/></p></center>
                <center><p><xsl:value-of select="//tei:respStmt"/></p></center><br/>
                <p><b>Project Description</b><xsl:value-of select="//tei:projectDesc"/></p><br/>
                <br/>
                <p><b>Based on:</b><br/>
                    <xsl:value-of select="//tei:biblStruct//tei:title"/> by <xsl:value-of select="//tei:biblStruct//tei:author/tei:persName"/><br/>
                    <xsl:for-each select="//tei:biblStruct/tei:monogr/*">
                        <xsl:if test="@unit">
                            <xsl:value-of select="@unit"/>: 
                        </xsl:if>
                        <xsl:value-of select="."/> <br/>
                    </xsl:for-each>
                </p>
                <p>Document typology: 
                <xsl:for-each select="//tei:profileDesc/tei:textClass/tei:keywords/*">
                    <xsl:value-of select="."/>, 
                </xsl:for-each>
                </p>
                <p>Language: 
                <xsl:for-each select="//tei:profileDesc/tei:langUsage/tei:language">
                    <xsl:value-of select="."/>, 
                </xsl:for-each>
                </p>
                <p>Licence: <xsl:value-of select="//tei:licence"/></p>
                <h3>Editorial Declarations: </h3>
                <ul>
                    <xsl:for-each select="//tei:editorialDecl/*">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
                <h3>Revisions Description</h3>
                <ul>
                    <xsl:for-each select="//tei:revisionDesc/*">
                        <li>When: <xsl:value-of select="@when"/>, What: <xsl:value-of select="."/>, Who: <xsl:value-of select="@who"/></li>
                    </xsl:for-each>
                </ul>
            </div>
        </div>
    </xsl:template>
    <!--Only match not apply other templates.-->
    <xsl:template match="tei:body/tei:div[@type = 'introduction']/tei:head">
        <h2>
            <xsl:value-of select="."/>
        </h2>
        <hr/>
        <div id="showInfo"><a href="#" onclick="mostraEnco()">Show information about encoding</a></div>
        <hr/>
    </xsl:template>
        <xsl:template match="*[@rend = 'italic']">
        <xsl:choose>
            <xsl:when test="../tei:p">
                <center>
                    <p>
                        <i>
                            <xsl:value-of select="."/>
                        </i>
                    </p>
                </center>
            </xsl:when>
            <xsl:otherwise>
                <i>
                    <xsl:value-of select="."/>
                </i>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="*[@rend = 'bold']">
        <b>
            <xsl:value-of select="."/>
        </b>
    </xsl:template>
    <!--Now with apply templates inside-->
    <xsl:template match="tei:body">
        <div id="bodyText">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@n">
                <xsl:attribute name="id">sez<xsl:value-of select="@n"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="@type">
                <xsl:attribute name="class">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:p">
      <p>
        <xsl:if test="@xml:id">
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="@facs">
          <xsl:attribute name="id">
            <xsl:value-of select="@facs"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
      </p>
    </xsl:template>
    <xsl:template match="tei:seg">
      <p>
        <xsl:if test="@xml:id">
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
      </p>
    </xsl:template>
    <xsl:template match="tei:expan">
        <span class="expan">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:ptr">
        <xsl:variable name="targ" select="@target" />   
        <xsl:if test="@type='image'">
            <div class="figure"><!--Build a div with an ID taked from target of ptr compared with all IDs of tei figure in back-->
                <xsl:attribute name="id">
                    <xsl:for-each select="//tei:div[@type='figures']//tei:figure">
                        <xsl:variable name="idF" select="concat('#',@xml:id)"/><!--Concat with a # to allow compare with target that had got a #-->
                        <xsl:if test="$idF = $targ">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
                <img class="solImg"><!--Look up, same thing but used to find the image-->
                    <xsl:attribute name="src">
                        <xsl:for-each select="//tei:div[@type='figures']//tei:graphic">
                            <xsl:variable name="id" select="concat('#',../@xml:id)"/>
                            <xsl:if test="$id = $targ">
                                <xsl:value-of select="@url"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:attribute>
                </img>
                <xsl:for-each select="//tei:div[@type='figures']/tei:figure/tei:figDesc"><!--Same thing used to find figDesc-->
                    <xsl:variable name="idV" select="concat('#',../@xml:id)"/>
                    <xsl:if test="$idV = $targ">
                        <p class="figDesc"><i><xsl:apply-templates/></i></p>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </xsl:if>
        <xsl:if test="@type='facsimile'">
        <img id="facs_img">
            <xsl:attribute name="src">
                <xsl:for-each select="//tei:facsimile/tei:surface/tei:graphic">
                    <xsl:variable name="id" select="concat('#',@xml:id)"/>
                    <xsl:if test="$id = $targ">
                        <xsl:value-of select="@url"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:attribute>
        </img>
        </xsl:if>
        <xsl:if test="not(@type)">
            <xsl:for-each select="//tei:div">
                <xsl:if test="@xml:id">
                    <xsl:if test="concat('#',@xml:id) = $targ">
                        <div>
                            <xsl:if test="@type">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@type"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:apply-templates/>
                        </div>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="not(@xml:id)">
                    <xsl:if test="tei:epigraph">
                        <p>
                            <xsl:choose>
                                <xsl:when test="$targ='#epgh'">
                                    <xsl:attribute name="id">epgh</xsl:attribute>
                                    <xsl:value-of select="tei:epigraph"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="id">cpy</xsl:attribute>
                                    <xsl:value-of select="tei:ab"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </p>
                    </xsl:if>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:term">
        <span class='glossOver'><xsl:if test="@ref"><xsl:attribute name="onclick">showGloss('<xsl:value-of select="@ref"/>')</xsl:attribute></xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:gloss"><xsl:if test="@xml:id"><xsl:attribute name="id">#<xsl:value-of select="@xml:id"/></xsl:attribute></xsl:if>
      <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:abbr">
        <abbr>
            <xsl:attribute name="title">
                <xsl:value-of select="following-sibling::tei:expan"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:figure">
        <div class="figure">
            <xsl:attribute name="id">
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:figDesc">
        <p class="figDesc">
            <i>
                <xsl:apply-templates/>
            </i>
        </p>
    </xsl:template>
    <xsl:template match="tei:head">
        <h3>
            <xsl:if test="@facs">
                <xsl:attribute name="id">
                    <xsl:value-of select="@facs"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="."/>
        </h3>
    </xsl:template>
    <xsl:template match="tei:figure//tei:graphic">
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
        </img>
    </xsl:template>
    <xsl:template match="tei:ref">
        <a>
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="tei:graphic">
                        <xsl:value-of select="tei:graphic/@url"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@target"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </a>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:list//tei:label">
        <li><xsl:attribute name="style">font-weight: bold;</xsl:attribute><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:list//tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:fw">
        <xsl:choose>
            <xsl:when test="@type='pageNum'">
                 <p class="pb"><xsl:apply-templates/></p>
            </xsl:when>
            <xsl:otherwise>
                <p class="topLeft"><xsl:value-of select="."/></p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/><xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
