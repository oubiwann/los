# LFE Object System(s) [![Build Status](https://travis-ci.org/lfex/los.png?branch=master)](https://travis-ci.org/lfex/los)


## Introduction

LOS is inspired by
[CLOS](https://en.wikipedia.org/wiki/Common_Lisp_Object_System). It may or may
not provide macros for more than one object system. We shall see.

When referring to the plural form, we recommend the Spanish "los LOS". In the
singular form, "el LOS", "the LOS" or just "LOS" are all acceptable.

Feel free to also make "loss" puns. These will be quite amusing for all, and apropos.

More seriously, the initial implementation will be taken from Peter Norvig's PAIP,
Chapter 13.


### Why OOP?

Blame it on [cadar](https://github.com/cadar); he made me do it. But before that,
there was [this](https://github.com/rvirding/lfe/blob/77b6c6ddc4db5f734dc529ac0653ead1c3b47ce5/examples/object-via-closure.lfe),
so I guess it can't all be laid at his feet.

Peter Norvig said it best (especially when we take it out of context):

    "Object-oriented programming turns the world of computing
    on its side..."

And now that we've got a doubly-functional programming language (Lisp + Erlang),
we're going to turn it over on its other side.

The reason this project is blamed on cadar is that he made a very good argument
that 1) there are definitely valid use cases for OOP (or AOP), and 2) we should
offer people that flexibility.

### Features

#### Development Plan

First, we're going to start with a simple knock-off of CLOS as developed by Peter
Norvig in PAIP, Chapter 13. This will be done using classic ``lambda`` closures.
Next, we'll look at using processes instead of ``lambda``s for closures. This
is defnitely the more Erlang-y way to do it, but it may be more inefficient for
many uses. Then, we may look at Clojure's protocols and add support for that.
After this, the sky's the limit. Or maybe not. Who knows?

#### ``lambda`` Closures

* ``defclass`` - 
* 

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

And then do the usual for your ``lfetool``-created project:

```bash
    $ rebar compile
```

This will automatically download the project deps and compile them before also
compiling LOS.


## Usage

To be done ...
