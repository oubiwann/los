# LFE Object System(s)


## Introduction

LOS is inspired by
[CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System). It may or may
not provide macros for more than one object system. We shall see.

When referring to the plural form, we recommend the Spanish "los LOS". In the
singular form, "el LOS", "the LOS" or just "LOS" are all acceptable.

Feel free to also make "loss" puns. These will be quite amusing for all, and apropos.

More seriously, the initial implementation will be taken from Peter Norvig's PAIP,
Chapter 13.


### Dependencies

This project assumes that you have [rebar](http://github.com/rebar/rebar) and 
[lfetool](http://github.com/lfe/lfetool) installed somewhere in your ``$PATH``.


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
    {deps, [
        ...
        {los, ".*", {git, "git@github.com:lfe/los.git", "master"}}
      ]}.
```

And then do the usual:

```bash
    $ rebar compile
```

This will automatically download the project deps and compile them before also
compiling LOS.


## Usage

To be done ...
