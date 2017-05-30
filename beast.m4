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

### TREE OPERATORS ###

define(`SA_TREE_OPERATORS',
`<operator spec="SAScaleOperator" scaleFactor="0.5" tree="@$1" weight="20.0"/>
<operator spec="SAScaleOperator" rootOnly="true" scaleFactor="0.95" tree="@$1" weight="20.0"/>
<operator spec="SAUniform" tree="@$1" weight="20.0"/>
<operator spec="SAWilsonBalding" tree="@$1" weight="20.0"/>
<operator spec="SAExchange" isNarrow="false" tree="@$1" weight="20.0"/>
<operator spec="SAExchange" tree="@$1" weight="20.0"/>
<operator spec="LeafToSampledAncestorJump" tree="@$1" weight="20.0"/>')

### MISC ###

define(`ELEMENT_MAP',
`<map name="Uniform" >beast.math.distributions.Uniform</map>
<map name="Exponential" >beast.math.distributions.Exponential</map>
<map name="LogNormal" >beast.math.distributions.LogNormalDistributionModel</map>
<map name="Normal" >beast.math.distributions.Normal</map>
<map name="Beta" >beast.math.distributions.Beta</map>
<map name="Gamma" >beast.math.distributions.Gamma</map>
<map name="LaplaceDistribution" >beast.math.distributions.LaplaceDistribution</map>
<map name="prior" >beast.math.distributions.Prior</map>
<map name="InverseGamma" >beast.math.distributions.InverseGamma</map>
<map name="OneOnX" >beast.math.distributions.OneOnX</map>')

divert(0)dnl
