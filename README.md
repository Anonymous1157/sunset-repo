# Sunset's Gentoo overlay

Hi! I use Gentoo. Sometimes I change official packages to fix bugs, install newer versions of software, et cetera. Sometimes I write my own from scratch. They're all available here. Enjoy.

## Adding this overlay to your system

If you use eselect-repository:

```
eselect repository add sunset-repo git https://github.com/Anonymous1157/sunset-repo.git
```

If you use layman:

```
layman -o https://raw.github.com/Anonymous1157/sunset-repo/master/repositories.xml -f -a sunset-repo
```

You're on your own if you want to add it manually or hav another repository management solution.
