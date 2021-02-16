# Tuxi

Tuxi is a simple bash script which scrape google search for getting instant answers of your question on your terminal.

[Watch this Video Please](https://www.youtube.com/watch?v=EtwWvMa8muU)
> Also checkout my youtube channel for more scripts like this

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
* Quotations are optional if you want to search with some special character.
* You can write question directly like `tuxi linus torvalds birthday`
* `--raw` arguments are used to simplify output by removing colors and decorations.  
  This is useful, for example to bring up `tuxi` into `notify-send`.
  ```bash
  $ tuxi --raw "Linus Torvalds birthday"
  tuxi --raw "Linus Torvalds birthday"
  ```

## How this work?
It simply use google search results.
By using pup I scrape google search results and get cream information like answer of one word question or paragraph which google show on top.
Sometimes Google give multiple cream information like one word results and other information on right In that case It show result of the basis of priority.
I do scraping with `pup` and use some Unix tools like `awk` `sed` to do the magic.

## License
Do whatever you want. Just don't make money from this and If you do 70% is mine.
