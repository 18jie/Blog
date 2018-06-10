package com.fengjie.init;

import com.fengjie.kit.StringUtils;
import com.vladsch.flexmark.ast.Node;
import com.vladsch.flexmark.ext.tables.TablesExtension;
import com.vladsch.flexmark.html.HtmlRenderer;
import com.vladsch.flexmark.parser.Parser;
import com.vladsch.flexmark.parser.ParserEmulationProfile;
import com.vladsch.flexmark.util.options.MutableDataSet;

import java.util.Arrays;

public class Theme {

    public static String mdToHtml(String markdown){
        if(StringUtils.hasLength(markdown)){
            MutableDataSet options = new MutableDataSet();
            options.setFrom(ParserEmulationProfile.MARKDOWN);

            // enable table parse!
            options.set(Parser.EXTENSIONS, Arrays.asList(TablesExtension.create()));


            Parser parser = Parser.builder(options).build();
            HtmlRenderer renderer = HtmlRenderer.builder(options).build();

            Node document = parser.parse(markdown);
            return renderer.render(document);
        }
        return "";
    }

}
