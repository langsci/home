<?php

/**
 * @file plugins/generic/home/HomePlugin.inc.php
 *
 * Copyright (c) 2016 Language Science Press
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class HomePlugin
 */

import('lib.pkp.classes.plugins.GenericPlugin');

class HomePlugin extends GenericPlugin {
	/**
	 * Register the plugin.
	 * @param $category string
	 * @param $path string
	 */
	function register($category, $path) {

		if (parent::register($category, $path)) {
			if ($this->getEnabled()) {
				HookRegistry::register ('TemplateManager::display', array(&$this, 'handleDisplayTemplate'));
			}
			return true;
		}
		return false;
	}

	function handleDisplayTemplate($hookName, $args) {

		$request = $this->getRequest();
		$templateMgr =& $args[0];
		$template =& $args[1];

		switch ($template) {

			case 'frontend/pages/index.tpl':	

				if (PluginRegistry::getPlugin('generic', 'slidercontentplugin')) {
					import('plugins.generic.sliderContent.classes.SliderContentDAO');
					$sliderContentDao = new SliderContentDao();
					$contentArray = $sliderContentDao->getAllContent($request->getPress()->getId());

					$content='';
					foreach ($contentArray as $value) {
						$content.= "<div class='slider-container'>";
						$content.= $value;
						$content.= "</div>";
					}
					$templateMgr->assign('content',$content);
				}

				$templateMgr->assign('title',__('plugins.generic.home.title'));
				$templateMgr->assign('baseUrl',$request->getBaseUrl());

				$templateMgr->display($this->getTemplatePath() . 
					'home.tpl', 'text/html', 'TemplateManager::display');

			return true;
		}
		return false;
	}

	/**
	 * @copydoc PKPPlugin::getDisplayName()
	 */
	function getDisplayName() {
		return __('plugins.generic.home.displayName');
	}

	/**
	 * @copydoc PKPPlugin::getDescription()
	 */
	function getDescription() {
		return __('plugins.generic.home.description');
	}

	/**
	 * @copydoc PKPPlugin::getTemplatePath
	 */
	function getTemplatePath() {
		return parent::getTemplatePath() . 'templates/';
	}
}

?>
