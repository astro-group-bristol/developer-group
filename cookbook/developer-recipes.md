# Adding a recipe to the Astro Dev Cookbook

This recipe shows how to
- fork the developer group, and
- open a PR with a new recipe.

## Recipe

![](.github/assets/fork-me.png)

![](.github/assets/create-fork.png)

Clone with

```bash
git clone git@github.com/YOUR_USERNAME/developer-group
```

Then copy the [template recipe](cookbook/_template.md) and fill in all the details
```bash
cp cookbook/_template.md cookbook/SHORT-KEBAB-CASE-TITLE.md
```

If you have any additional assets that you want to include in your document, put them in the `.github/assets/` directory.

Once done, commit your recipe and its assets, and push to your fork
```bash
git add cookbook/SHORT-KEBAB-CASE-TITLE.md
git commit -m "cookbook: added new recipe"
git push origin main
```

Next, in your web browser, navigate to your fork and hit the "Contribute button" to open a pull request:


