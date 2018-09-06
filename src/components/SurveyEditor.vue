<template>
	<div>
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div>Choose Questionnaire: 
						<select v-model="selected_questionnaire" @change="selectQuestionnaire">
						  <option v-for="option in questionnaires_list" v-bind:value="option.name">
						    {{ option.title }}
						  </option>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div id="surveyEditorContainer"></div>
	</div>
</template>

<script>
import * as SurveyEditor from 'surveyjs-editor'
import 'surveyjs-editor/surveyeditor.css';

import * as SurveyKo from "survey-knockout";
import * as widgets from "surveyjs-widgets";

import "inputmask/dist/inputmask/phone-codes/phone.js";

widgets.icheck(SurveyKo);
widgets.select2(SurveyKo);
widgets.inputmask(SurveyKo);
widgets.jquerybarrating(SurveyKo);
widgets.jqueryuidatepicker(SurveyKo);
widgets.nouislider(SurveyKo);
widgets.select2tagbox(SurveyKo);
widgets.signaturepad(SurveyKo);
widgets.sortablejs(SurveyKo);
widgets.ckeditor(SurveyKo);
widgets.autocomplete(SurveyKo);
widgets.bootstrapslider(SurveyKo);


export default {
  name: 'survey-editor',
  data () {
    return {
	    description: '',
	    editor: undefined,
        selected_questionnaire: 'New',
        questionnaires: {},

	    questionnaires_list: [ ]
/*
		    { title: 'HIV', name: 'abc123'},
		    { title: 'HepC', name: 'def321'},
		    { title: 'green', name: 'ead042'},
		    { title: 'blue', name: '358daa'}
*/
    }
  },
  methods: {
    selectQuestionnaire: function (event) {
//	    console.log(this.selected_questionnaire);
//	    console.log(this.questionnaires[this.selected_questionnaire].items);
		this.editor.text=JSON.stringify(this.questionnaires[this.selected_questionnaire].items);
//	    let survey=new SurveyVue.Model(this.questionnaires[this.selected_questionnaire].items)
/*
	    console.log(survey);
	    this.survey=survey;
	    console.log(this);
*/
//	    console.log(this.SurveyEditor);
	    }
  },
  mounted () {
	let self=this;	  
    let editorOptions = { showEmbededSurveyTab: true };
    this.editor = new SurveyEditor.SurveyEditor('surveyEditorContainer', editorOptions);
	let url_get=`/api/pharmetika/v5/assessments/types`;
	 fetch(url_get, {
	        method: "GET", // *GET, POST, PUT, DELETE, etc.
	        mode: "cors", // no-cors, cors, *same-origin
	        cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
	        credentials: "same-origin", // include, same-origin, *omit
	        headers: {
	            "Content-Type": "application/json; charset=utf-8",
	        },
	        redirect: "follow", // manual, *follow, error
	        referrer: "no-referrer", // no-referrer, *client
	    })
	    .then(response => response.json())
	    .then( function(data) {
	    		self.questionnaires=data.data.questionnaires || data.data.assessments;
		// NEXT: sort by something, maybe alphabetical, end up with an array [{ name: 'which is the id', title: 'human title'}...]
				self.questionnaires_list.splice(0, self.questionnaires_list.length);
				Object.entries(data).forEach(([key, value]) => self.questionnaires_list.push(value));
				self.questionnaires_list.sort(function(a,b) {return  (a.title > b.title) ? 1 : ((b.title > a.title) ? -1 : 0);}  );

				console.log('self.questionnaires:');				
				console.log(self.questionnaires);
				console.log('self.questionnaires_list:');
				console.log(self.questionnaires_list);
		});


    this.editor.saveSurveyFunc = function() {
	    let questionnaire=JSON.parse(this.text);
	    if (self.selected_questionnaire == 'New' || ! self.selected_questionnaire) {
		  self.selected_questionnaire = undefined
	    }
	    
	    let body_string=
	    JSON.stringify({
		    							questionnaire: questionnaire,
		    							description: self.description,
		    							name: self.selected_questionnaire
		    							
		    							});
      console.log(JSON.stringify(this.text));
	  let url=`/_util/post_data`;
	  //let url=`/assessments/type/${type}`;

 return fetch(url, {
        method: "POST", // *GET, POST, PUT, DELETE, etc.
        mode: "cors", // no-cors, cors, *same-origin
        cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
        credentials: "same-origin", // include, same-origin, *omit
        headers: {
            "Content-Type": "application/json; charset=utf-8",
            // "Content-Type": "application/x-www-form-urlencoded",
        },
        redirect: "follow", // manual, *follow, error
        referrer: "no-referrer", // no-referrer, *client
        body: body_string, // body data type must match "Content-Type" header
    })
    .then(response => response.json()).then( data => console.log(data) );
    };
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
