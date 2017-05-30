divert(-1)

# Small collection of m4 macro definitions useful for piecing together
# BEAST XML files.

### DATA ###

define(`ALIGNMENT',
`<data id="$1" name="alignment">
include(`$2')
</data>')

define(`DATE_TRAIT',
`<trait id="dateTrait.t" spec="beast.evolution.tree.TraitSet" traitname="date">
    include($2)
    <taxa id="TaxonSet" spec="TaxonSet">
        <alignment idref="$1"/>
    </taxa>
</trait>')

### PRIORS ###

define(`NORMAL_DISTR',
`<prior name="distribution" x="@$1">
    <Normal id="Normal.0" name="distr">
        <parameter estimate="false" name="mean">$2</parameter>
        <parameter estimate="false" name="sigma">$3</parameter>
    </Normal>
</prior>')

define(`LOGN_DISTR',
`<prior name="distribution" x="@$1">
    <LogNormal name="distr" $4>
        <parameter estimate="false" name="M">$2</parameter>
        <parameter estimate="false" lower="0.0" name="S" upper="5.0">$3</parameter>
    </LogNormal>
</prior>')

define(`EXP_DISTR',
`<prior name="distribution" x="@$1">
    <Exponential name="distr">
        <parameter estimate="false" name="mean">$2</parameter>
    </Exponential>
</prior>')

define(`ONEONX_DISTR',
`<prior name="distribution" x="@$1">
    <OneOnX name="distr"/>
</prior>')

define(`UNIFORM_DISTR',
`<prior name="distribution" x="@$1">
    <Uniform name="distr"/>
</prior>')

divert(0)dnl
