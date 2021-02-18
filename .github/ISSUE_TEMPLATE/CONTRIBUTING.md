## How to contribute to Tuxi 🎉

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching [Issues](https://github.com/Bugswriter/tuxi/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/Bugswriter/tuxi/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible.

* If possible, use the bug report template to create the issue.
  * [**Bug report**](https://github.com/Bugswriter/tuxi/blob/main/.github/ISSUE_TEMPLATE/BUG_REPORT.md)
  
#### **Do you want to add a new SERP scraper?**

* **Fork** the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch and add your code above `Knowledge Graph - right`.

* Create a pull request to merge with the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.

```
# <Name of the SERP> <optional position> ( eg: <relevant search example> )
#
# <your scraper code goes here>
#

# Knowledge Graph - right ( eg: the office )
kno_right="$(echo "$google_html" | pup 'div.kno-rdesc span' | sed -n '2p' | awk '{$1=$1;print}' | recode html..ISO-8859-1 | tr ' ' '\0' | xargs -0 -n10)"
[ -n "$kno_right" ] && output "$kno_right" && exit 0

```

* Your code must be **posix compatible**. **Pup**, **Recode**, and **Jq** are dependencies.

* Use **concise and readable variables** (snake_case is preferred).


#### **Do you want to add a new feature?**

* **Fork** the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.

* Create a pull request to merge with the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.
