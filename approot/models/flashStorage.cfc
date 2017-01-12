component extends="coldbox.system.web.flash.AbstractFlashScope" hint="A dummy implementation of the ColdBox flash scope." {


	public any function init(controller) {
		super.init(argumentCollection=arguments);
		return this;
	}


	public any function getFlashKey(){
		return "";
	}


	public any function saveFlash(){
		return ;
	}


	public any function flashExists(){
		return false;
	}


	public any function getFlash(){
		return {};
	}


	public any function removeFlash(){
		return ;
	}


}