<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0"
xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<NamedLayer>
    <Name>cbe_flood_style</Name>
    <UserStyle>
        <Title>CBE Flood Risk Styling</Title>
        <Abstract>Dynamic styling for building vulnerability mapping.</Abstract>
        <FeatureTypeStyle>
            <Rule>
                <Name>High Risk Zone</Name>
                <ogc:Filter>
                    <ogc:PropertyIsEqualTo>
                        <ogc:PropertyName>risk_level</ogc:PropertyName>
                        <ogc:Literal>High Risk</ogc:Literal>
                    </ogc:PropertyIsEqualTo>
                </ogc:Filter>
                <PolygonSymbolizer>
                    <Fill><CssParameter name="fill">#FF0000</CssParameter></Fill>
                    <Stroke>
                        <CssParameter name="stroke">#000000</CssParameter>
                        <CssParameter name="stroke-width">0.5</CssParameter>
                    </Stroke>
                </PolygonSymbolizer>
            </Rule>
            <Rule>
                <Name>Safe Zone</Name>
                <ogc:Filter>
                    <ogc:PropertyIsNotEqualTo>
                        <ogc:PropertyName>risk_level</ogc:PropertyName>
                        <ogc:Literal>High Risk</ogc:Literal>
                    </ogc:PropertyIsNotEqualTo>
                </ogc:Filter>
                <PolygonSymbolizer>
                    <Fill><CssParameter name="fill">#00FF00</CssParameter></Fill>
                    <Stroke>
                        <CssParameter name="stroke">#000000</CssParameter>
                        <CssParameter name="stroke-width">0.5</CssParameter>
                    </Stroke>
                </PolygonSymbolizer>
            </Rule>
        </FeatureTypeStyle>
    </UserStyle>
</NamedLayer>
</StyledLayerDescriptor>
