function zebraStripe(){

	// add css  -  requires include_once(), a custom include function

	var tables = document.getElementsByTagName("table");
	// for all the tables, look for trs
	for(i=0;i<tables.length;i++){
		// if it's a zebra table
			if(tables[i].attributes['zebra']){
				//tables[i].attributes['zebra'].value='striped';
			// style the rows with their default colours
			var trs = tables[i].getElementsByTagName("tr");
			for(j = 0; j < trs.length; j++){
				if(trs[j].getElementsByTagName("td").length > 0){
					if ((j % 2) == 1){
						trs[j].setAttribute('zebra','odd');
					}else{
						trs[j].setAttribute('zebra','even');
					}
				}
				// add mouseover and mouseout functions
				trs[j].onmouseover = function(j){
					if(this.getElementsByTagName("td").length > 0){ //if the row isn't empty / a header
						this.setAttribute('highlight',true);
						this.onmouseout = function(){
							this.removeAttribute('highlight');
						};
					}
				};
				// done mouseover and mouseout functions
				if (tables[i].attributes['zebra'].value.match(/\bnavigation\b/)){ // are we following links?
					trs[j].onclick = function(){
						if(this.getElementsByTagName('a').length > 0){
							document.location.href = this.getElementsByTagName('a')[0].href;
						}
					};
				}else if(tables[i].attributes['zebra'].value.match(/\bselection\b/)){ // are we marking rows?

					// auto mark all checked boxes
					inputs = trs[j].getElementsByTagName('input');
					for(k=0;k<inputs.length;k++){
						if(inputs[k].type.match(/\bcheckbox\b/)){
							if(inputs[k].checked){
								trs[j].setAttribute('marked',true);
							}else{
								trs[j].removeAttribute('marked');
							}
						}
					}

					trs[j].onclick = function(){
						if(this.attributes['marked']){
							if(this.getElementsByTagName("td").length == 0) return false;
							// if it is highlighted already
							this.removeAttribute('marked');
							inputs = this.getElementsByTagName('input');
							for(i=0;i<inputs.length;i++){if(inputs[i].type.match(/\bcheckbox\b/))inputs[i].checked='';}
						}else{
							if(this.getElementsByTagName("td").length == 0) return false;
							this.setAttribute('marked',true);
							inputs = this.getElementsByTagName('input');
							for(i=0;i<inputs.length;i++){if(inputs[i].type.match(/\bcheckbox\b/))inputs[i].checked='checked';}
						}
					};
				}
			}
		} 
	}
}
var start = "zebraStripe"; /* STOP EDITING */ if(window.addEventListener){ /* mozilla */ window.addEventListener("load",eval(start),false);}else{ /* ie */ window.attachEvent("onload",eval(start));}
