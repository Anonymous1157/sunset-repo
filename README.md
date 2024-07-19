# Sunset's Gentoo overlay

Hi! I use Gentoo. Sometimes I change official packages to fix bugs, install newer versions of software, et cetera. Sometimes I write my own from scratch. They're all available here. Enjoy.

## Adding this overlay to your system

You can add it automagically with [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository):

```
eselect repository enable sunset-repo
```

You can still add it manually if you want to:

```
eselect repository add sunset-repo git https://github.com/Anonymous1157/sunset-repo.git
```

*Note that this repo is now being mirrored* at https://github.com/gentoo-mirror/sunset-repo so these two methods do slightly different things. It's not a big deal in practice.

