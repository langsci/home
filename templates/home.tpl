{**
 * plugins/generic/home/templates/home.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Copyright (c) 2016 Language Science Press
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the front page of the site
 *
 * @uses $homepageImage array Details about the uploaded homepage image
 * @uses $spotlights array Selected spotlights to promote on the homepage
 * @uses $featuredMonographs array List of featured releases in this press
 * @uses $newReleases array List of new releases in this press
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $additionalHomeContent string HTML blob of arbitrary content added by
 *  an editor/admin.
 *}
 
{include file="frontend/components/header.tpl"}


<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/owl-carousel/owl.carousel.css">  
<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/owl-carousel/owl.theme.css">
<link rel="stylesheet" href="{$baseUrl}/plugins/generic/home/css/home.css">

<div class="page page_homepage" id="langsciHome">

	{* Homepage Image *}
	{if $homepageImage}
		<div class="homepage_image">
			<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" alt="{$homepageImage.altText|escape}">
		</div>
	{/if}
	
	{* Slider added by Language Science Press *}
	{if $sliderContent}
		<div id="owl-slider" class="owl-carousel">
			{$sliderContent}
		</div>
	{/if}

	{* Spotlights *}
	{if !empty($spotlights)}
		<h2 class="pkp_screen_reader">
			{translate key="spotlight.spotlights"}
		</h2>
		{include file="frontend/components/spotlights.tpl"}
	{/if}
	
	{* Featured *}
	{if !empty($featuredMonographs)}
		{include file="frontend/components/monographList.tpl" monographs=$featuredMonographs titleKey="catalog.featured"}
	{/if}

	{* New releases *}
	{if !empty($newReleases)}
		{include file="frontend/components/monographList.tpl" monographs=$newReleases titleKey="catalog.newReleases"}
	{/if}

	{* Announcements *}
	{if $numAnnouncementsHomepage}
		<div class="cmp_announcements highlight_first">
			<h2>
				{translate key="announcement.announcements"}
			</h2>
			{foreach name=announcements from=$announcements item=announcement}
				{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
					{php}break;{/php}
				{/if}
				{if $smarty.foreach.announcements.iteration == 1}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
					<div class="more">
				{else}
					<article class="obj_announcement_summary">
						<h4>
							<a href="{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
								{$announcement->getLocalizedTitle()|escape}
							</a>
						</h4>
						<div class="date">
							{$announcement->getDatePosted()}
						</div>
					</article>
				{/if}
			{/foreach}
			</div><!-- .more -->
		</div>
	{/if}

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

{include file="common/frontend/footer.tpl"}
