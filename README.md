<h1 align="center">TUXI</h1>
<p align="center">A CLI tool that scrapes Google search results and SERPs that provides instant and concise answers</p>

##  

<img src="https://i.ibb.co/sCwYpZ8/general.gif" alt="Video Preview Gif" align="right" width="500px"/>

### How does this work?

The script uses `pup` to scrape Google search results and SERPs.
If the query returns several results, Tuxi will choose the most 
relevant result on the basis of priority.

In addition to scraping, `tuxi` also uses `jq`, `awk` and `sed` 
to process and return results, and `recode` to unescape html.


[Watch this video for more info](https://youtu.be/EtwWvMa8muU)
> Also checkout BugsWriter's YouTube channel for more scripts like this.

## Requirements

* [pup](https://github.com/ericchiang/pup) - CLI tool for processing HTML.
* [recode](https://github.com/rrthomas/recode) - Charset converter tool and library.
* [jq](https://github.com/stedolan/jq) - Command-line JSON processor.

Note for Mac users, the above packages are available via Homebrew for ease of download.

## Installation

### cURL
cURL **tuxi** to your **$PATH** and give execute permissions.

```sh
$ sudo curl -sL "https://raw.githubusercontent.com/Bugswriter/tuxi/main/tuxi" -o /usr/local/bin/tuxi
$ sudo chmod +x /usr/local/bin/tuxi
```
> To update, just do `curl` again, no need to `chmod` anymore.  
> To uninstall, simply remove `tuxi` from your **$PATH**, for example `sudo rm -f /usr/local/bin/tuxi`.

### Make
```sh
$ git clone https://github.com/Bugswriter/tuxi.git && cd tuxi/
$ sudo make install
```
> To update, just `git pull` on your local tuxi repository and reinstall with `sudo make install`.  
> To uninstall, simply run `sudo make uninstall`.

### Arch Linux AUR
Tuxi is available as the [`tuxi-git`](https://aur.archlinux.org/packages/tuxi-git/) package in the **AUR**.
```sh
$ yay -S tuxi-git
```

## Usage

```sh
$ tuxi "Is Linux better than Windows?"
---
Linux has a reputation for being fast and smooth while
Windows 10 is known to become slow and slow over
time. Linux runs faster than Windows 8.1 and Windows 10
along with a modern desktop environment and qualities of the
operating system while windows are slow on older hardware.
---
```
* Quotations are optional, but should be used if you want to search with special characters (?=!|&<>%$#/\\).
* You can also write your query as a statement, e.g: `tuxi linus torvalds birthday`.
* The -r option will make the output not have formatting, which can be convenient for use in scripts.
* The -q option silences "Did you mean?" and Tuxi's greeting on calling `tuxi`.

Use `-h` to display the help message.

```sh
Usage: tuxi [options] query
OR: query source | tuxi [options]

Options:
  -h                    Show this help message and exit.
  -v                    Print tuxi version info and exit.

  -r                    Raw search results.
                        (no pretty output, no colors)

  -q                    Only output search results.
                        (silences "Did you mean?", greeting, usage)

  -a                    Prints all valid answers.

  -u                    Prints out the top handful of URLs for your search query
                        (this is automatically printed out if tuxi can't find you an answer)

  -b                    Tries to select the best answer based on keywords at the start and end of your query.
                        (experimental - eg: define WORD, SONG lyrics, PERSON quotes, weather CITY, FILM cast)

  -t                    Pick answers to test.
                        (you can specify multiple answers using tuxi_NAME in your query)

  -l                    use LANG_[lang] in your query to override the language used
                        (eg: tuxi -l LANG_en_US my search query)

tuxi supports the following environment variables:
  TUXI_LANG=[lang]      sets default search language (eg: TUXI_LANG='en_US')

  TUXI_DELAY=[int]      if you find more than one answer is being printed (and you're not using -a)
                        increase this number by a little (you want it to be as low as possible)
                        default value is 250 (eg: TUXI_DELAY=270)

developer flags:
  -d                    prints debug info along with results
  -s                    saves HTML for this query to /home/dave/.cache/tuxi/[date]-[query].html

  -c                    use most recent cached result and query
                        this can be combined with -t flag to more quickly test for different answers

  -p                    disable pipe support (it can break some scripts including our own test script)

Report bugs at https://github.com/Bugswriter/tuxi/issues
```

## Features

**Easily change query language**  
Line [8](./tuxi#L8) in `tuxi` contains the language variable which can be changed according the user's preference. However, tuxi will use the system default langauge if none is set.

**Gives corrections**
```sh
$ tuxi linux torvalds birthday
> Did you mean linus?
---
28 December 1969
---
```

**When you know it's actually linux torvalds** <kbd>-q option</kbd>
```sh
$ tuxi -q linux torvalds birthday
---
28 December 1969
---
```

**Raw formatting for output (no colors)** <kbd>-r option</kbd>
> Useful for e.g scripting `notify-send`.
```sh
$ tuxi -r linux torvalds birthday
> Did you mean linus?
28 December 1969
```

**Math operations**
```sh
$ tuxi "log(30)"
---
1.4771212547196624
---
```

**Translate**
```sh
$ tuxi "I love you in japanese"
---
わたしは、あなたを愛しています
---
$ tuxi "わたしは、あなたを愛しています in english"
---
I love you
---
```

**And much more (lyrics, weather, conversions...)**

## License

This project is licensed under [GPL-3.0](./LICENSE).

## Contributing

If you want to contribute, please see [CONTRIBUTING](./.github/ISSUE_TEMPLATE/CONTRIBUTING.md).
