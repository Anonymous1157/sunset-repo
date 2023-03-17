# Sunset's Gentoo overlay

Hi! I use Gentoo. Sometimes I change official packages to fix bugs, install newer versions of software, et cetera. Sometimes I write my own from scratch. They're all available here. Enjoy.

## Adding this overlay to your system

**UPDATE**: This repo has been added to the global list of Gentoo repositories! You can add it automagically with eselect-repository:

```
eselect repository enable sunset-repo
```

You can still add it manually if you want to:

```
eselect repository add sunset-repo git https://github.com/Anonymous1157/sunset-repo.git
```

Note that [eselect-repository supersedes Layman](https://wiki.gentoo.org/wiki/Layman), so if you're still using Layman, you should consider switching.
