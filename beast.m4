divert(-1)

# Small collection of m4 macro definitions useful for piecing together
# BEAST XML files.

### DATA ###

define(`ALIGNMENT',
`<data id="$1" name="alignment">
include(`$2')
</data>')

define(`DATE_TRAIT',
`<trait id="dateTrait.t" spec="beast.evolution.tree.TraitSet" traitname="date" $3>
    include($2)
    <taxa id="TaxonSet" spec="TaxonSet">
        <alignment idref="$1"/>
    </taxa>
</trait>')

### PRIORS ###

define(`NORMAL_DISTR',
`<distribution spec="beast.math.distributions.Prior" x="@$1">
    <distr spec="beast.math.distributions.Normal">
        <mean spec="beast.core.parameter.RealParameter" estimate="false">$2</mean>
        <sigma spec="beast.core.parameter.RealParameter" estimate="false">$3</sigma>
    </distr>
</distribution>')

define(`LOGN_DISTR',
`<distribution spec="beast.math.distributions.Prior" x="@$1">
    <distr spec="beast.math.distributions.LogNormalDistributionModel" $4>
        <M spec="beast.core.parameter.RealParameter" estimate="false">$2</M>
        <S spec="beast.core.parameter.RealParameter" estimate="false" lower="0.0">$3</S>
    </distr>
</distribution>')

define(`EXP_DISTR',
`<distribution spec="beast.math.distributions.Prior" x="@$1">
    <distr spec="beast.math.distributions.Exponential">
        <mean spec="beast.core.parameter.RealParameter" estimate="false">$2</mean>
    </distr>
</distribution>')

define(`ONEONX_DISTR',
`<distribution spec="beast.math.distributions.Prior" x="@$1">
    <distr spec="beast.math.distributions.OneOnX"/>
</distribution>')

define(`UNIFORM_DISTR',
`<distribution spec="beast.math.distributions.Prior" x="@$1">
    <distr spec="beast.math.distributions.Uniform" lower="$2" upper="$3"/>
</distribution>')

### OPERATORS ###

define(`SA_TREE_OPERATORS',
`<operator spec="SAScaleOperator" scaleFactor="0.5" tree="@$1" weight="20.0"/>
<operator spec="SAScaleOperator" rootOnly="true" scaleFactor="0.95" tree="@$1" weight="20.0"/>
<operator spec="SAUniform" tree="@$1" weight="20.0"/>
<operator spec="SAWilsonBalding" tree="@$1" weight="20.0"/>
<operator spec="SAExchange" isNarrow="false" tree="@$1" weight="20.0"/>
<operator spec="SAExchange" tree="@$1" weight="20.0"/>
<operator spec="LeafToSampledAncestorJump" tree="@$1" weight="20.0"/>')

define(`SCALE_OPERATOR', `<operator spec="ScaleOperator" scaleFactor="0.8" parameter="@$1" weight="$2"/>')

### PARAMETER MACROS ###

define(`forloop', `pushdef(`$1', `$2')_forloop($@)popdef(`$1')')
define(`_forloop', `$4`'ifelse($1, `$3', `', `define(`$1', incr($1))$0($@)')')

define(`NPARAMS', 0)
define(`PARAM',`defn(format(``PARAM[%d]'',`$1'))')
define(`PARAM_WEIGHT',`defn(format(``PARAM_WEIGHT[%d]'',`$1'))')
define(`ADD_PARAM', `define(format(``PARAM[%d]'',NPARAMS),$1)define(format(``PARAM_WEIGHT[%d]'',NPARAMS),$2)define(`NPARAMS',incr(NPARAMS))')

define(`REAL_PARAMETER', dnl (input name, param name, initial value [, lower [, upper [, dim, [, weight]]])
` <$1 spec="beast.core.parameter.RealParameter" id="$2" dnl
ifelse($4,`',`',lower="$4" )ifelse($5,`',`',upper="$5" )ifelse($6,`',`',dimension="$6" )value="$3"/>dnl
ifelse($7,`',`ADD_PARAM($2,1.0)',`ADD_PARAM($2,$7)')')

define(`PARAM_LOGS',
`forloop(`i',`0',decr(NPARAMS),
`<log idref="PARAM(i)"/>
')dnl')

define(`PARAM_STATENODES',
`forloop(`i',`0',decr(NPARAMS),
`<stateNode idref="PARAM(i)"/>
')dnl')

define(`PARAM_SCALE_OPERATORS',
`forloop(`i',`0',decr(NPARAMS),
`<operator spec="ScaleOperator" parameter="@PARAM(i)" scaleFactor="0.8" weight="PARAM_WEIGHT(i)"/>
')dnl')

### INITIAL TREES ###
define(`RANDOM_TREE',
`<init spec="beast.evolution.tree.RandomTree" estimate="false" initial="@$1" taxa="@$2">
         <populationModel spec="ConstantPopulation">
             <popSize spec="beast.core.parameter.RealParameter" value="$3"/>
         </populationModel>
</init>')

divert(0)dnl
