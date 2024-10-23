`odfvalidator` available in this directory (= `contrib/odt/odfvalidator/odfvalidator-0.12.0-jar-with-dependencies.jar`) is part of [ODF Toolkit](https://odftoolkit.org/downloads.html).

# About `ODF Validator: 0.12.0`

This version supports ODF 1.2.

The release 0.12.0 uses JDK 11 implementing [ODF 1.2](http://docs.oasis-open.org/office/v1.2/os/).\

For more details see the [release notes](https://odftoolkit.org/ReleaseNotes.html). People interested should also follow the [mail list](https://odftoolkit.org/mailing-lists.html) to track progress.

# About ODF Toolkit

The ODF Toolkit is a set of Java modules that allow programmatic creation, scanning and manipulation of [Open Document Format](http://opendocument.xml.org/), which [is being developed under OASIS](https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=office) (ISO/IEC 26300 == ODF) documents. Unlike other approaches which rely on runtime manipulation of heavy-weight editors via an automation interface, the ODF Toolkit is lightweight and ideal for server use.

## Components of the ODF Toolkit (Java)

1.  **Software access to ODF** is achievable by [ODFDOM](https://odftoolkit.org/odfdom/index.html). With 0.10.0 the basics of collaboration functionality - [the change/operation concept](https://odftoolkit.org/odfdom/operations/operations.html) were added.

2.  **ODF Conformance** can be tested via the [ODF Validator](https://odftoolkit.org/conformance/ODFValidator.html). Offered as command-line tool (executable JAR) or server component - via Web application archive (WAR) like [here](https://odfvalidator.org/).

3.  **XSL Transformation** loading the ODF XML from the zipped ODF can take the zipped ODF as source using the [ODF XSLT Runner](https://odftoolkit.org/xsltrunner/ODFXSLTRunner.html).\
    This functionality is also available from [ANT](https://ant.apache.org/) using our [ANT task](https://odftoolkit.org/xsltrunner/ODFXSLTRunnerTask.html)

4.  **Creating Software Artefacts from the ODF grammar** is possible via the [generator project](https://odftoolkit.org/generator/index.html)

Find our sources on [GitHub](https://github.com/tdf/odftoolkit). People interested should follow the [mail list](https://odftoolkit.org/mailing-lists.html) to track progress.

## More Information about ODF Toolkit

Visit our latest documentation on [GitHub](https://tdf.github.io/odftoolkit/). People interested should follow the [mail list](https://odftoolkit.org/mailing-lists.html) to track progress.

