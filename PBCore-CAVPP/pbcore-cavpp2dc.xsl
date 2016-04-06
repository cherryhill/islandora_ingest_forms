<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cavpp_dc="https://repository.californialightandsound.org/metadata/cavpp_dc/" xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:pbcore="http://www.pbcore.org/PBCore/PBCoreNamespace.html" exclude-result-prefixes="pbcore">
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="text()" />

  <xsl:template match="/pbcore:pbcoreCollection/pbcore:pbcoreDescriptionDocument[1]">
    <cavpp_dc:cavpp_dc xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <xsl:attribute name="xsi:schemaLocation">https://repository.californialightandsound.org/metadata/cavpp_dc/ https://repository.californialightandsound.org/metadata/20160331/cavpp_dc.xsd</xsl:attribute>
      <xsl:apply-templates />

      <!-- dcterms:provenance from /pbcoreCollection[@collectionSource] -->
      <dcterms:provenance>
        <xsl:value-of select="parent::pbcore:pbcoreCollection/@collectionSource"/>
      </dcterms:provenance>
      
      <!-- dcterms:isPartOf from /pbcoreCollection[@collectionTitle] -->
      <xsl:variable name="collGuideTitle" select="parent::pbcore:pbcoreCollection/@collectionTitle" />
      <xsl:choose>
        <xsl:when test="$collGuideTitle">
          <dcterms:isPartOf>
            <xsl:value-of select="$collGuideTitle" />
          </dcterms:isPartOf>
        </xsl:when>
      </xsl:choose>
    </cavpp_dc:cavpp_dc>
  </xsl:template>
  
  <!-- dc:identifier from pbcoreIdentifier[@annotation='Call Number'] -->
  <xsl:template match="pbcore:pbcoreIdentifier[@annotation = 'Call Number']">
    <dc:identifier>
      <xsl:value-of select="." />
    </dc:identifier>
  </xsl:template>
  
  <!-- dc:identifier from pbcoreIdentifier[@annotation="Internet Archive URL"] -->
  <xsl:template match="pbcore:pbcoreIdentifier[@annotation = 'Internet Archive URL']">
    <dc:identifier>
      <xsl:value-of select="." />
    </dc:identifier>
  </xsl:template>
  
  <!-- dc:title -->
  <xsl:template match="pbcore:pbcoreTitle[@titleType = 'Main or Supplied']">
    <dc:title>
      <xsl:variable name="title" select="normalize-space(text())" />
      <xsl:choose>
        <xsl:when test="$title">
          <xsl:value-of select="$title" />
        </xsl:when>
        <xsl:otherwise>Unknown</xsl:otherwise>
      </xsl:choose>
    </dc:title>
  </xsl:template>

  <!-- dcterms:alternative -->
  <xsl:template match="pbcore:pbcoreTitle[@titleType != 'Main or Supplied']">
    <dcterms:alternative>
      <xsl:value-of select="." />
    </dcterms:alternative>
  </xsl:template>

  <!-- dc:creator from pbcoreCreator -->
  <xsl:template match="pbcore:pbcoreCreator">
    <dc:creator>
      <xsl:variable name="person" select="pbcore:creator" />
      <xsl:variable name="role" select="pbcore:creatorRole" />
      <xsl:if test="$role">
        <xsl:choose>
          <xsl:when test="$role"><xsl:value-of select="$person" /> (<xsl:value-of select="$role" />)</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$person" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </dc:creator>
  </xsl:template>

  <!-- dc:subject from pbcoreSubject -->
  <xsl:template match="pbcore:pbcoreSubject">
    <dc:subject>
      <xsl:value-of select="." />
    </dc:subject>
  </xsl:template>

  <!-- dc:description from pbcoreDescription -->
  <xsl:template match="pbcore:pbcoreDescription">
    <dc:description>
      <xsl:value-of select="." />
    </dc:description>
  </xsl:template>

  <!-- dc:description from extension(ProjectNote) -->
  <xsl:template match="pbcore:pbcoreExtension/pbcore:extensionWrap[pbcore:extensionElement = 'ProjectNote']">
    <dc:description>
      <xsl:value-of select="pbcore:extensionValue" />
    </dc:description>
  </xsl:template>
  
  <!-- dc:type from pbcoreGenre -->
  <xsl:template match="pbcore:pbcoreGenre">
    <dc:type>
      <xsl:value-of select="." />
    </dc:type>
  </xsl:template>

  <!-- dc:type from pbcoreMediaType -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationMediaType">
    <dc:type>
      <xsl:value-of select="." />
    </dc:type>
  </xsl:template>
  
  <!-- dc:coverage from pbcoreCoverage -->
  <xsl:template match="pbcore:pbcoreCoverage/pbcore:coverage">
    <dc:coverage>
      <xsl:value-of select="." />
    </dc:coverage>
  </xsl:template>

  <!-- dc:publisher from pbcorePublisher -->
  <xsl:template match="pbcore:pbcorePublisher/pbcore:publisher">
    <dc:publisher>
      <xsl:value-of select="." />
    </dc:publisher>
  </xsl:template>
  
  <!-- dc:contributor from pbcoreContributor -->
  <xsl:template match="pbcore:pbcoreContributor">
    <dc:contributor>
      <xsl:variable name="person" select="pbcore:contributor" />
      <xsl:variable name="role" select="pbcore:contributorRole" />
      <xsl:if test="$role">
        <xsl:choose>
          <xsl:when test="$role"><xsl:value-of select="$person" /> (<xsl:value-of select="$role" />)</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$person" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </dc:contributor>
  </xsl:template>

  <!-- dc:rights from pbcoreRightsSummary -->
  <xsl:template match="pbcore:pbcoreRightsSummary/pbcore:rightsSummary">
    <dc:rights>
      <xsl:value-of select="." />
    </dc:rights>
  </xsl:template>

  <!-- dc:rights from extension(CountryOfCreation) -->
  <xsl:template match="pbcore:pbcoreExtension/pbcore:extensionWrap[pbcore:extensionElement = 'CountryOfCreation']">
    <dc:rights>
      <xsl:value-of select="pbcore:extensionValue" />
    </dc:rights>
  </xsl:template>

  <!-- dc:date from pbcoreAssetDate -->
  <xsl:template match="pbcore:pbcoreAssetDate">
    <dc:date>
      <xsl:value-of select="." />
    </dc:date>
  </xsl:template>
 
  <!-- dc:format from pbcore:instantiationGenerations -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationGenerations">
    <dc:format>
      <xsl:value-of select="." />
    </dc:format>
  </xsl:template>
  
  <!-- dc:format from pbcore:instantiationTracks -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationTracks">
    <dc:format>
      <xsl:value-of select="." />
    </dc:format>
  </xsl:template>
  
  <!-- dc:format from pbcore:instantiationColors -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationColors">
    <dc:format>
      <xsl:value-of select="." />
    </dc:format>
  </xsl:template>
  
  <!-- dc:format from pbcore:instantiationChannelConfiguration -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationChannelConfiguration">
    <dc:format>
      <xsl:value-of select="." />
    </dc:format>
  </xsl:template>
  
  <!-- dcterms:extent from instantiationAnnotation[@annotation='Extent'] -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationAnnotation[@annotation='Extent']">
    <dcterms:extent>
      <xsl:value-of select="." />
    </dcterms:extent>
  </xsl:template>
  
  <!-- dcterms:extent from instantiationDuration -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationDuration">
    <dcterms:extent>
      <xsl:value-of select="." />
    </dcterms:extent>
  </xsl:template>

  <!-- dc:language from pbcore:instantiationLanguage -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationLanguage">
    <dc:language>
      <xsl:value-of select="." />
    </dc:language>
  </xsl:template>

  <!-- dc:medium from pbcore:instantiationPhysical -->
  <xsl:template match="pbcore:pbcoreInstantiation[1]/pbcore:instantiationPhysical">
    <dcterms:medium>
      <xsl:value-of select="." />
    </dcterms:medium>
  </xsl:template>
  
</xsl:stylesheet>
