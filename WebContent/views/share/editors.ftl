
<#macro text metadata value>
	<i-input v-model="model.${metadata.name}" placeholder="${metadata.display}"></i-input>
</#macro>
<#macro string metadata value>
	<i-input v-model="model.${metadata.name}" placeholder="${metadata.display}"></i-input>
</#macro>
<#macro datetime metadata value>
	<date-picker type="date" placeholder="${metadata.display}" v-model="model.${metadata.name}" format="yyyy年M月d日"></date-picker>
</#macro>
<#macro images metadata value>
	<i-input v-model="model.${metadata.name}" placeholder="${metadata.display}"></i-input>
</#macro>
<#macro avater metadata value>
	<i-input v-model="model.${metadata.name}" placeholder="${metadata.display}"></i-input>
</#macro>



<#macro edit metadata value>
	<#if metadata.type=="int">
		<@string metadata=metadata value=value />
	<#elseif metadata.type=="datetime">
		<@datetime metadata=metadata value=value />
	<#else>
		<@text metadata=metadata value=value />
	</#if>
</#macro>