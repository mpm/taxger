# Taxger Source Generation

The Lohnsteuer calculator is created from [https://www.bmf-steuerrechner.de/interface/pseudocode.jsp](pseudo code) offered by the
Ministery of Finance.

To rebuild these files (or create files for years not yet included in
this gem), execute the following steps:

### Download the pseudo code

Download the files by running

```
$ rake taxger:source:download
```

The files will be stored in `src/xml/`. The rake task assumes you have
`curl` installed. If not, check `src/converter.rb` to see where to
download the files manually.

### Parse and generate Ruby code

To create Ruby code from the pseudo code, run:

```
$ rake taxger:source:generate
```

For every year, a Ruby class will be generated in `src/generated/`.

### Copy generated sources to gem sources

Inspect the automatically generated files in `src/generated/` and apply
changes if necessary.

To make them usable for the actual gem, copy them to `lib/lohnsteuer/`
and adjust `lib/taxger.rb` to make sure these files are loaded.

## About the parser

The pseudo code consists of two different structural layers. Declaration
of variables, method bodies and control flow (IF/THEN/ELSE) is specified
in XML.

### Parsing XML

The XML tags contain Java-like pseudo code (for example to specify a
boolean expression for a conditional statement or an assignment).

The parser uses Nokogiri to parse the XML and generates its own nodes
(classes in `src/node` to translate the structure).

These nodes build up a tree structure (for example a `MethodNode`
containing a `ConditionalNode` which in turn contains a `MethodCallNode`
etc.).

### Parsing Java-like pseudo code

Every `Node` exposes a `render` method that returns the actual Ruby code
(and is mostly fed by content of attributes of the underlying XML tag).

This pseudo code has a Java like syntax. `PseudoCodeParser` uses Ruby's
internal `StringScanner` class to tokenize the input.

The parser is nowhere near complete but enough to parse the existing
pseudo code XML files from the last 10 years.

It distinguishes between instance variables and constants. While in
pseudo code, all these are uppercase, the parser translates instance
variables to proper lowercase names prefixed with `@`.

Constants are left in uppercase.

Instantiations of `BigDecimal` are translated into a Ruby syntax (`new
BigDecimal(0)` becomes `BigDecimal.new(0)`.

*Please note that BigDecimal has been monkey-patched to make it
compatible with the Java-like syntax of doing calculations with
designated methods (i.e. `a.substract(b)` instead of `a - b`!)*

The parser accepts an optional `;` at EOL, but other unknown symbols
will trigger an error (to make sure it roughly understands whats going
on).

### Parser warnings

You will encounter the following messages for older files:

```
WARNING: Orphaned ELSE block found, but assigning it to previous IF statement` in some older files.
```

These can be safely ignored. The reason is that older files use an
ambigous XML nesting like this:

```xml
<IF>
  <THEN> ... </THEN>
</IF>
<ELSE> ... </ELSE>
```

The parser checks if the `ELSE` tag is follwing an `IF` tag immediatly.
If so, it is attached there and the warning is shown.

Newer files from the Ministery of Finance use the following syntax:

```xml
<IF>
  <THEN> ... </THEN>
  <ELSE> ... </ELSE>
</IF>
```

### Final words

I would not consider this code to be a text book example on how to do
something like this (the whole thing could use some refactoring). It is
more of a quick hack, but this does not affect the quality of the
resulting Ruby files.

They are 100% compatible with the pseudo code provided.
