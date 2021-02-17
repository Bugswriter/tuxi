# Tuxi

Tuxi is a simple bash script which scrapes Google's search results and provides instant, concise answers for your questions in the terminal.

[Watch this Video Please](https://www.youtube.com/watch?v=EtwWvMa8muU)
> Also checkout my YouTube channel for more scripts like this.

## Requirements
* [pup](https://github.com/ericchiang/pup) - CLI tool for processing HTML.
* [recode](https://github.com/rrthomas/recode) - Charset converter tool and library
* [jq](https://github.com/stedolan/jq) - Command-line JSON processor

## Installation
cURL **tuxi** to your **$PATH** and give execute permissions.
```bash
$ curl -sL "https://raw.githubusercontent.com/Bugswriter/tuxi/main/tuxi" -o $HOME/.local/bin/tuxi
$ chmod +x $HOME/.local/bin/tuxi
```

## Usage
```bash
$ tuxi "Is Linux better than Windows?"
---
Linux has a reputation for being fast and smooth while
Windows 10 is known to become slow and slow over
time. Linux runs faster than Windows 8.1 and Windows 10
along with a modern desktop environment and qualities of the
operating system while windows are slow on older hardware.
---
```
* Quotations are optional, but should be used if you want to search with special characters. 
* You can also write your query as a statement, e.g. `tuxi linus torvalds birthday`

Use `-h`, `--help` arguments to display help message. 
```bash
$ tuxi --help
Usage: tuxi <your question>
       tuxi <OPTIONS> <your question>

OPTIONS:
-r, --raw             Simplify Tuxi output. Useful for e.g notify-send.
-h, --help            Displays this help message.

Report bugs to https://github.com/Bugswriter/tuxi
```
```bash
$ tuxi -r linus torvalds birthday
28 December 1969
```

## How this work?
The script uses pup to scrape Google search results and return a clean, concise answer based on the top search result. If the query returns several results that are concise enough for tuxi to return, tuxi will show the results on the basis of priority.

In addition to using `pup` for scraping, `tuxi` also uses `awk` and `sed` to process and return results.

## License
Do whatever you want. Just don't make money from this, but if you do 70% is mine.
