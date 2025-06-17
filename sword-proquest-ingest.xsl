<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dim="http://www.dspace.org/xmlns/dspace/dim"
    xmlns:diss="http://www.etdadmin.com/ns/etdsword"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="mets diss xlink"
    version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="text()"/>

    <xsl:template match="/mets:mets">
        <dim:dim>
            <xsl:apply-templates select="mets:dmdSec/mets:mdWrap/mets:xmlData/*"/>
        </dim:dim>
    </xsl:template>

    <xsl:template match="diss:DISS_submission">
        <xsl:apply-templates select="diss:DISS_authorship/diss:DISS_author"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_title"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_dates/diss:DISS_comp_date"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_dates/diss:DISS_accept_date"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_degree"/>
        <xsl:apply-templates select="diss:DISS_description/@type"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_institution/diss:DISS_inst_name"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_institution/diss:DISS_inst_contact"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_advisor"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_cmte_member"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_categorization/diss:DISS_category/diss:DISS_cat_desc"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_categorization/diss:DISS_keyword"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_categorization/diss:DISS_language"/>
        <xsl:apply-templates select="diss:DISS_content/diss:DISS_abstract"/>
        <xsl:apply-templates select="diss:DISS_description/diss:DISS_identifiers/diss:isbn"/>
        <xsl:apply-templates select="diss:DISS_repository/diss:DISS_delayed_release"/>
    </xsl:template>

    <xsl:template match="diss:DISS_author">
        <dim:field mdschema="dc" element="contributor" qualifier="author">
            <xsl:call-template name="format-name">
                <xsl:with-param name="surname" select="normalize-space(diss:DISS_name/diss:DISS_surname)"/>
                <xsl:with-param name="fname" select="normalize-space(diss:DISS_name/diss:DISS_fname)"/>
                <xsl:with-param name="middle" select="normalize-space(diss:DISS_name/diss:DISS_middle)"/>
                <xsl:with-param name="suffix" select="normalize-space(diss:DISS_name/diss:DISS_suffix)"/>
            </xsl:call-template>
        </dim:field>
        <xsl:if test="normalize-space(diss:DISS_orcid)">
             <dim:field mdschema="dc" element="identifier" qualifier="orcid">
                 <xsl:value-of select="normalize-space(diss:DISS_orcid)"/>
             </dim:field>
        </xsl:if>
    </xsl:template>

    <xsl:template match="diss:DISS_advisor">
        <dim:field mdschema="dc" element="contributor" qualifier="advisor">
            <xsl:call-template name="format-name">
                <xsl:with-param name="surname" select="normalize-space(diss:DISS_name/diss:DISS_surname)"/>
                <xsl:with-param name="fname" select="normalize-space(diss:DISS_name/diss:DISS_fname)"/>
                <xsl:with-param name="middle" select="normalize-space(diss:DISS_name/diss:DISS_middle)"/>
                <xsl:with-param name="suffix" select="normalize-space(diss:DISS_name/diss:DISS_suffix)"/>
            </xsl:call-template>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_cmte_member">
        <dim:field mdschema="dc" element="contributor" qualifier="committeeMember">
            <xsl:call-template name="format-name">
                <xsl:with-param name="surname" select="normalize-space(diss:DISS_name/diss:DISS_surname)"/>
                <xsl:with-param name="fname" select="normalize-space(diss:DISS_name/diss:DISS_fname)"/>
                <xsl:with-param name="middle" select="normalize-space(diss:DISS_name/diss:DISS_middle)"/>
                <xsl:with-param name="suffix" select="normalize-space(diss:DISS_name/diss:DISS_suffix)"/>
            </xsl:call-template>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_title">
        <dim:field mdschema="dc" element="title">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_comp_date">
        <dim:field mdschema="dc" element="date" qualifier="issued">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

     <xsl:template match="diss:DISS_accept_date">
         <dim:field mdschema="dc" element="date" qualifier="proquestAvailable">
            <xsl:value-of select="normalize-space(.)"/>
         </dim:field>
     </xsl:template>

    <xsl:template match="diss:DISS_degree">
        <dim:field mdschema="dc" element="thesis" qualifier="degree">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_inst_name">
        <dim:field mdschema="dc" element="publisher">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

     <xsl:template match="diss:DISS_inst_contact">
         <dim:field mdschema="ou" element="group">
             <xsl:value-of select="normalize-space(.)"/>
         </dim:field>
     </xsl:template>

    <xsl:template match="diss:DISS_keyword">
        <xsl:call-template name="process-keywords">
            <xsl:with-param name="keyword-string" select="normalize-space(.)"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="diss:DISS_cat_desc">
        <dim:field mdschema="dc" element="subject">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_language">
        <dim:field mdschema="dc" element="language" qualifier="iso">
            <xsl:value-of select="normalize-space(.)"/>
            </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_abstract">
        <dim:field mdschema="dc" element="description" qualifier="abstract">
            <xsl:for-each select="diss:DISS_para">
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:if test="position() != last()">
                    <xsl:text> </xsl:text> </xsl:if>
            </xsl:for-each>
        </dim:field>
    </xsl:template>

    <xsl:template match="diss:DISS_delayed_release">
        <dim:field mdschema="dc" element="date" qualifier="embargoExpiration">
            <xsl:value-of select="normalize-space(.)"/>
        </dim:field>
    </xsl:template>

    <xsl:template name="format-name">
        <xsl:param name="surname"/>
        <xsl:param name="fname"/>
        <xsl:param name="middle"/>
        <xsl:param name="suffix"/>
        <xsl:value-of select="$surname"/>
        <xsl:if test="$fname">
            <xsl:value-of select="concat(', ', $fname)"/>
        </xsl:if>
        <xsl:if test="$middle">
            <xsl:value-of select="concat(' ', $middle)"/>
            </xsl:if>
         <xsl:if test="$suffix">
             <xsl:value-of select="concat(', ', $suffix)"/>
         </xsl:if>
    </xsl:template>

    <xsl:template match="diss:isbn">
        <xsl:if test="normalize-space(.)">
            <dim:field mdschema="dc" element="identifier" qualifier="isbn">
                <xsl:value-of select="normalize-space(.)"/>
            </dim:field>
        </xsl:if>
    </xsl:template>

    <xsl:template match="diss:DISS_creative_commons_license">
        <xsl:if test="./diss:DISS_abbreviation">
            <dim:field mdschema="dc" element="rights">
                <xsl:value-of select="./diss:DISS_creative_commons_license/diss:DISS_abbreviation"/>
            </dim:field>
        </xsl:if>
    </xsl:template>

    <xsl:template name="process-keywords">
        <xsl:param name="keyword-string"/>
        <xsl:param name="delimiter" select="','"/>
        <xsl:choose>
            <xsl:when test="contains($keyword-string, $delimiter)">
                <xsl:variable name="current-keyword" select="normalize-space(substring-before($keyword-string, $delimiter))"/>

                <dim:field mdschema="dc" element="subject">
                    <xsl:value-of select="$current-keyword"/>
                </dim:field>

                <xsl:call-template name="process-keywords">
                    <xsl:with-param name="keyword-string" select="substring-after($keyword-string, $delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space($keyword-string)">
                    <dim:field mdschema="dc" element="subject">
                        <xsl:value-of select="normalize-space($keyword-string)"/>
                    </dim:field>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>