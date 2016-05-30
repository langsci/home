{**
 * plugins/generic/home/templates/home.tpl
 *
 * Copyright (c) 2016 Language Science Press
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 *}

{include file="frontend/components/header.tpl" pageTitleTranslated="$title"}

<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/owl-carousel/owl.carousel.css">  
<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/owl-carousel/owl.theme.css">
<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/css/home.css">

<div id="langsciHome">

	<div class="title">

		<h2>{$title}</h2>
		<p>{translate key="plugins.generic.home.intro"}</p>

	</div>

    	<div id="owl-slider" class="owl-carousel">

		{$content}
      
	</div>

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="additional_content">
			{$additionalHomeContent}
		</div>
	{/if}

</div>

<script src="{$baseUrl}/plugins/generic/home/owl-carousel/owl.carousel.js"></script>

<script>
	$(function() {ldelim}
		$("#owl-slider").owlCarousel({ldelim}
			navigation: true,
			pagination: true,
			navigationText: ['&#9664;','&#9654;'],
			singleItem:true,
			slideSpeed : 2000,
			rewindSpeed : 4000,
			autoHeight: true
		{rdelim});
	{rdelim});
</script>

{include file="frontend/components/footer.tpl"}


