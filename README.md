# Tuxi

Tuxi is a simple bash script which scrapes Google's search results and provides instant, concise answers for your questions in the terminal.

[Watch this Video Please](https://www.youtube.com/watch?v=EtwWvMa8muU)
> Also checkout my YouTube channel for more scripts like this.

## Requirements
* [pup](https://github.com/ericchiang/pup) - CLI tool for processing HTML.
* Recode
* jq 

## Installation
To install, clone the repository and copy tuxi to a location in your $PATH:

```bash
git clone https://github.com/bugswriter/tuxi.git
cd tuxi
cp tuxi $HOME/.local/bin/tuxi
```

## Usage

```bash
tuxi "is linux better than windows"
Linux is very well secure as it is easy to
detect bugs and fix whereas Windows has a huge user
base, so it becomes a target of hackers to attack
windows system. Linux runs faster even with older hardware whereas
windows are slower compared to Linux.
```
* Quotations are optional, but should be used if you want to search with special characters. 
* You can also write your query as a statement, e.g. `tuxi linus torvalds birthday`

## How this work?
The script uses pup to scrape Google search results and return a clean, concise answer based on the top search result. If the query returns several results that are concise enough for tuxi to return, tuxi will show the results on the basis of priority.

In addition to using `pup` for scraping, `tuxi` also uses `awk` and `sed` to process and return results.

## License
Do whatever you want. Just don't make money from this, but if you do 70% is mine.
