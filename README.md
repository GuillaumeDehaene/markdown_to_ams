# `markdown_to_ams` Extension For Quarto and Pandoc

This Pandoc filter converts `$$..$$` environments to `equation` or `align` automatically.

```markdown
$$
1+1 = 2
$$
$$
3+2 &= 5 \\
    &= 3+2
$$
```

is transformed to:

```latex
\begin{equation}
    1+1 = 2
\end{equation}
\begin{align}
3+2 &= 5 \\
    &= 3+2
\end{align}
```

## Installing

```bash
quarto add GuillaumeDehaene/markdown_to_ams
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

The goal of this extension is to automate the usage of `equation` and `align` in Quarto and Pandoc markdow. Without this extension, such environments need to be inputted as raw latex blocks. This extension instead transforms `$$`-delimited math into the appropriate environment, or a manually specified environment if needed.

It has three features:

1. This extension converts all *displayMath* `$$`-delimited environments to `equation`.

1. This extension extends markdown math syntax to represent multiline math.
    The syntax is identical to Latex multiline syntax:
        - `&` defines an aligment point.
        - `\\` defines a new line.
    When parsing a `$$`-delimited environment with either of those symbols, this extension transforms it into:
        - a `gather` (centered) if only `\\` present.
        - an `align` (alternating right/left aligned) if `&` is present.

1. The environment can be manually specified by entering the environment name on the first line of the `$$` block, wrapped in brackets `{}`:

    ```markdown
    $$ {multline}
    0 = 0 + 0 \\
        + 0 + 0
    $$
    ```
    
    This could lead to parsing errors and might change in new versions of this extension.

When writing math with this extension, you should never have to use raw latex environments. You should write any sequence of related equations in the new multiline math syntax. The extension will then convert it to align. If you need another ams environment, use the manual syntax.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

