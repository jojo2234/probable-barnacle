/**
 * Mostra informazioni sulla codifica
 */
function mostraEnco(){
	document.getElementById("encoInfo").style.display = "block";
}
/**
 * Nasconde informazioni sulla codifica
 */
function hideEnco(){
	document.getElementById("encoInfo").style.display="none";
}

window.onload=function(){createPage();removeDupl();setFacsimile();};


/**
 * 
 * @param {*} idElem 
 * Mostra il glossario di quel term
 */
function showGloss(idElem){
	alert(document.getElementById(idElem).innerText);
	/*var glossario = document.getElementById("my_gloss").children.;
	for(var i=0; i<glossario.length; i++){
		if(glossario[i].id == idElem){
			alert(document.getElementById(idElem).innerText + ": \n"+ glossario[i].innerText);
			break;
		}
	}*/
}

/**
 * Imposta i fine pagina
 */
function createPage(){
	var pbElemes = document.getElementsByClassName("pb"); //Ottieni i pb nel documento
	var divTrovato = false;
	var elem, j;
	var pString="";
	var pAper = new Array();
	var pApsr = "";
	for(var i=0;i<pbElemes.length;i++){ //Per ogni pb nel documento
		elem = pbElemes[i].parentElement;
		pAper = new Array();
		j=0;
		while(!divTrovato){ //Cerca il suo div padre
			if(elem.tagName == "DIV"){
				if(pAper[0] != undefined){
					if(pAper[1] != undefined){
						pAper.reverse();
					}
					for(var x=0;x<pAper.length;x++){
						pApsr += pAper[x];
					}
				}
				aggiornaPB(elem,pString,pApsr,pbElemes[i]); //body,divOriginale,divModified
				divTrovato = true; //div padre trovato, esci dal ciclo
			}else{
				switch(elem.tagName){
					case "P":
						pString += "</p>" //Tutti i p da chiudere prima di pb
						pAper[j] = "<p>"//Tutti i p da aprire dopo pb
					break;
					case "LI":
						pString += "</li>"
						pAper[j] = "<li>"
					break;
					case "UL":
						pString += "</ul>"
						pAper[j] = "<ul>"
					break;
					case "OL":
						pString += "</ol>"
						pAper[j] = "<ol>"
					break;
					case "SPAN":
						pString += "</span>"
						pAper[j] = "<span>"
					break;
					case "SECTION":
						pString += "</section>"
						pAper[j] = "<section>"
					break;
				}
				elem = elem.parentElement;
				j++;
			}
		}
		divTrovato = false; //Azzera il trovato per il prossimo pb
		pString = "";
		pApsr = "";
	}
}
/**
 * 
 * @param {*} elemento 
 * @param {*} p_close 
 * @param {*} p_open 
 * @param {*} pbEl 
 * 
 * Quindi all'interno di un div con testo e paragrafi, prendo in analisi l'elemento che inizia con <p class="pb">
 * E sostituisco ad esempio a <p class="pb">December Byte 32</p> la stringa
 * </p></p></div><p class="pb">December Byte 32</p><div><p><p>
 * Questo perchè il mio pb era dentro due p e un div
 */
function aggiornaPB(elemento,p_close,p_open,pbEl){
	var toMod = elemento.outerHTML;
	if(p_close != "" && p_open != ""){ //Altrimenti pb si trova direttamente in un div
		elemento.outerHTML = toMod.replace(pbEl.outerHTML,p_close + '</div><p class="pb">' + pbEl.innerText + '</p><div>'+p_open);
	}
	if(elemento.className == "conclusion"){
		elemento.outerHTML = toMod.replace(pbEl.outerHTML,'</div><p class="pb">' + pbEl.innerText + '</p><div>');
	}
}

function removeDupl(){
	document.getElementById("appe").remove();
	document.getElementById("AdvIng").remove();
	document.getElementsByClassName("figures")[0].remove();
	document.getElementById("my_gloss").style.display = "none"; //Nascondo il glossario
	document.getElementsByClassName("appendix")[0].id = "appe";//Metto un id per far funzionare i link
	var finTxt = document.getElementsByTagName("div")[19].innerText;
	var txtSc = document.getElementById("sez11").outerHTML + document.getElementById("sez12").outerHTML;
	document.getElementsByTagName("div")[19].innerHTML =  txtSc + document.getElementById("addrCom").outerHTML + finTxt;
	document.getElementsByClassName("addressList")[0].remove();
	document.getElementById("sez11").remove();
	document.getElementById("sez12").remove();
	document.getElementsByTagName("div")[9].innerHTML = document.getElementsByClassName("appendix")[0].outerHTML;
	document.getElementsByTagName("div")[20].innerHTML = document.getElementsByTagName("li")[50].innerHTML;
	document.getElementsByClassName("chap")[0].remove();
	document.getElementById("fac_img9").style.display = "none";
}

function setFacsimile(){
	var faxImg = document.getElementById("fax_id").innerHTML;
	var area0 = "<p onclick='showDBX(\"imtArea_0\")' class='faxOver' style='position: relative;left: -6%;width: 110%;height: 64px;bottom: 244px;'></p>";
	var area1 = "<p onclick='showDBX(\"imtArea_1\")' class='faxOver' style='position: relative;left: -6%;width: 110%;height: 20px;bottom: 244px;'></p>";
	var area2 = "<p onclick='showDBX(\"imtArea_2\")' class='faxOver' style='position: relative;left: 18%;width: 60%;height: 14px;bottom: 249px;'></p>";
	var area3 = "<p onclick='showDBX(\"imtArea_3\")' class='faxOver' style='position: relative;left: -6%;width: 110%;height: 25px;bottom: 251px;'></p>";
	var area4 = "<p onclick='showDBX(\"imtArea_4\")' class='faxOver' style='position: relative;left: -6%;width: 110%;height: 14px;bottom: 255px;'></p>";
	var area5 = "<p onclick='showDBX(\"imtArea_5\")' class='faxOver' style='position: relative;left: -6%;width: 110%;height: 58px;bottom: 258px;'></p>";
	document.getElementById("fax_id").innerHTML = faxImg + area0 + area1 + area2 + area3 + area4 + area5;
}

var myWindow;

function showDBX(txtImg) {
  myWindow = window.open("", "Facsimile", "top=260,left=400, width=500, height=230");
  myWindow.document.write("<h3>"+document.getElementById("#"+txtImg).innerHTML+"</h3>");
}

/*
function showDBX(txtImg){
	var faxID = document.getElementById("fax_id").innerHTML;
	document.getElementById("fax_id").innerHTML = faxID + "<div id='"+txtImg+"' class='finestra'><p class='titleBar' onmousedown='trascina(\""+txtImg+"\",event)'><span class='titFin'>Finestra</span><span class='closeFin' onclick='closeDBX(\""+txtImg+"\")'>X</span></p>"+document.getElementById("#"+txtImg).innerText+"</div>";
}*/

/*
function closeDBX(id){
	document.getElementById(id).remove();
}*/