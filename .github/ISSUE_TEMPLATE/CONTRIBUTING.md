## How to contribute to Tuxi 🎉

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching [Issues](https://github.com/Bugswriter/tuxi/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/Bugswriter/tuxi/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible.

* If possible, use the bug report template to create the issue.
  * [**Bug report**](https://github.com/Bugswriter/tuxi/blob/main/.github/ISSUE_TEMPLATE/BUG_REPORT.md)
  
#### **Do you want to add a new SERP scraper?**

* **Fork** the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch and add your code above `Knowledge Graph - right`.

* Create a pull request to merge with the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.

Remember that it must be added in a few places, the first is on priority variable (Search `priority=`).

```sh
name            # Comment explaining (example)
```

And a function in `Answer functions` section. Remember of the `a_` prefix for the function's name, it's important!


* Your code must be **posix compatible**. And dependant of **pup**, **recode**, and **jq**.

* Use **concise and readable variables** (snake_case is preferred).


#### **Do you want to add a new feature?**

* **Fork** the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.

* Create a pull request to merge with the [develop](https://github.com/Bugswriter/tuxi/tree/develop) branch.

