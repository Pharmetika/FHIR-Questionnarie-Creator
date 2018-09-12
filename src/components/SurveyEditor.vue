<template>
	<div>
		<div class="container">
			<div class="row">
				<div class="col-md-11">
					Modify Existing:
							<el-cascader
								filterable
								clearable
								style="margin-right: 10px; width: 400px"
								:options="assessment_options"
								v-model="selected_questionnaire_type"
								placeholder="Select Questionnaire Type"
								@change="set_questionnaire_type_id">
							</el-cascader>
							 -&nbsp;OR&nbsp;-  
							<el-button 
								plain
								type="primary"
								@click="create_new_choose_use_case">
								Create New Assessment
							</el-button>
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
		questionnaire_name: undefined,
	    questionnaires_list: [ ],
		assessment_options:  [ ],
         selected_questionnaire_type: []
/*
		    { title: 'HIV', name: 'abc123'},
		    { title: 'HepC', name: 'def321'},
		    { title: 'green', name: 'ead042'},
		    { title: 'blue', name: '358daa'}
*/
    }
  },
  methods: {
	  set_questionnaire_type_id:
		  function (event) {
			  let self=this;
			  
		  console.log('this.questionnaires:');
		  console.log(this.questionnaires);
		  console.log('this.selected_questionnaire_type:');
		  console.log(this.selected_questionnaire_type);
		  self.usageContext=this.selected_questionnaire_type[0];
		  self.questionnaire_name=this.selected_questionnaire_type[1];
		  this.editor.text=JSON.stringify(this.questionnaires[this.selected_questionnaire_type[0]][this.selected_questionnaire_type[1]].items);
		    },
	create_new_choose_use_case() {
		let self=this;
        this.$prompt('Choose a category or use case for the new questionnaire', 'Create New Questionnaire: Category', {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'info'
        }).then( result => {
	        self.usageContext=result.value;
			self.selected_questionnaire_type.splice(0, self.selected_questionnaire_type.length);
			self.selected_questionnaire_type.push(result.value);
	        self.editor.text=JSON.stringify( {
																 "title": "NEW",
																 "pages": [{
																   "name": "Begin"
																  }]} );

          this.$message({
            type: 'success',
            message: 'Begin creating the new questionnaire'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Canceled'
          });          
        });
      }

  },
  mounted () {
	let self=this;	  
    let editorOptions = { showEmbededSurveyTab: true };
    this.editor = new SurveyEditor.SurveyEditor('surveyEditorContainer', editorOptions);
	let url_get=`/api/pharmetika/v5/assessments/types`;
	if (0 && 'local') {
		
	    		let local_data={
					   "data" : {
					      "assessments" : {
					         "AID Substance Abuse Assessment" : {
					            "461ef048-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "AID Substance Abuse Assessment",
					               "date" : "2017-04-28 15:46:20",
					               "description" : null,
					               "id" : 178,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461ef048-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "CAGE-AID Substance Abuse Assessment",
					               "type_id" : "461ef048-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "AID Substance Abuse Assessment",
					               "version" : 0
					            }
					         },
					         "Adherence" : {
					            "461eeb5e-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Adherence",
					               "date" : "2018-09-06 22:43:29",
					               "description" : null,
					               "id" : 174,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "174 TOT"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461eeb5e-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Morisky Medication Adherence Scale (MMAS-8-Item)",
					               "type_id" : "461eeb5e-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Adherence",
					               "version" : 0
					            }
					         },
 					         "Anticoagulation" : {
					            "461e3d76-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Anticoagulation",
					               "date" : "2017-02-24 15:03:24",
					               "description" : null,
					               "id" : 34,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461e3d76-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Initial Assessment-Anticoagulation",
					               "type_id" : "461e3d76-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Anticoagulation",
					               "version" : 0
					            },
					            "461e8e36-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Anticoagulation",
					               "date" : "2017-03-02 16:07:53",
					               "description" : null,
					               "id" : 102,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461e8e36-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Reassessment-Anticoagulation",
					               "type_id" : "461e8e36-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Anticoagulation",
					               "version" : 0
					            }
					         },
					         "Antiemetics" : {
					            "461e4223-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Antiemetics",
					               "date" : "2017-02-27 10:21:03",
					               "description" : null,
					               "id" : 38,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461e4223-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Initial Assessment-Antiemetics",
					               "type_id" : "461e4223-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Antiemetics",
					               "version" : 0
					            },
					            "461e929e-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Antiemetics",
					               "date" : "2017-03-02 16:33:39",
					               "description" : null,
					               "id" : 106,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461e929e-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Reassessment-Antiemetics",
					               "type_id" : "461e929e-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Antiemetics",
					               "version" : 0
					            }
					         },
					         "Asthma" : {
					            "461e7f51-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Asthma",
					               "date" : "2017-02-27 16:06:51",
					               "description" : null,
					               "id" : 90,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461e7f51-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Initial Assessment-Asthma",
					               "type_id" : "461e7f51-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Asthma",
					               "version" : 0
					            },
					            "461ebfbb-b20e-11e8-af5b-b083fec9ccab" : {
					               "category" : "Asthma",
					               "date" : "2017-03-03 12:42:43",
					               "description" : null,
					               "id" : 146,
					               "items" : {
					                  "pages" : [
					                     {
					                        "name" : "page1"
					                     }
					                  ],
					                  "title" : "TITLE"
					               },
					               "jsond" : 1,
					               "jsond_err" : "",
					               "name" : "461ebfbb-b20e-11e8-af5b-b083fec9ccab",
					               "realm" : null,
					               "status" : "active",
					               "subjectType" : "patient",
					               "title" : "Comprehensive Reassessment-Asthma",
					               "type_id" : "461ebfbb-b20e-11e8-af5b-b083fec9ccab",
					               "usageContext" : "Asthma",
					               "version" : 0
					            }
					         }
							 }
						}
					};
	    		
	    		self.questionnaires=local_data.data.questionnaires || local_data.data.assessments;
				if (1) {
					self.assessment_options.splice(0, self.assessment_options.length);
					self.assessment_options = Object.keys(self.questionnaires).map(function(key, index) {
						return {
					    value: key,
						  label: key,
						  children:  Object.keys(self.questionnaires[key]).map(function(skey, sindex) {return {value: skey, label: self.questionnaires[key][skey].title}}) 
						  }
					});
				}
		// NEXT: sort by something, maybe alphabetical, end up with an array [{ name: 'which is the id', title: 'human title'}...]
				self.questionnaires_list.splice(0, self.questionnaires_list.length);
				Object.entries(local_data).forEach(([key, value]) => self.questionnaires_list.push(value));
				self.questionnaires_list.sort(function(a,b) {return  (a.title > b.title) ? 1 : ((b.title > a.title) ? -1 : 0);}  );
		
	} else {
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
	    .then( function(local_data) {
	    		self.questionnaires=local_data.data.questionnaires || local_data.data.assessments;
				if (1) {
					self.assessment_options.splice(0, self.assessment_options.length);
					self.assessment_options = Object.keys(self.questionnaires).map(function(key, index) {
						return {
					    value: key,
						  label: key,
						  children:  Object.keys(self.questionnaires[key]).map(function(skey, sindex) {return {value: skey, label: self.questionnaires[key][skey].title}}) 
						  }
					});
				}
		// NEXT: sort by something, maybe alphabetical, end up with an array [{ name: 'which is the id', title: 'human title'}...]
				self.questionnaires_list.splice(0, self.questionnaires_list.length);
				Object.entries(local_data).forEach(([key, value]) => self.questionnaires_list.push(value));
				self.questionnaires_list.sort(function(a,b) {return  (a.title > b.title) ? 1 : ((b.title > a.title) ? -1 : 0);}  );
			});
		}


    this.editor.saveSurveyFunc = function() {
	    let questionnaire=JSON.parse(this.text);
	    if (self.selected_questionnaire == 'New' || ! self.selected_questionnaire) {
		  self.selected_questionnaire = undefined
	    }
	    
	    let body_string=
	    JSON.stringify({
		    							questionnaire: questionnaire,
		    							description: self.description,
		    							name: self.questionnaire_name || self.selected_questionnaire_type[1],
		    							usageContext: self.usageContext
		    							
		    							
		    							});
	  let url=`/api/pharmetika/v5/questionnaire`;
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
    .then(response => response.json())
    .then(function(data) {
		    self.questionnaire_name=data.data.questionnaire_name;
		  return data;
		})
    .then( data =>         
    	
    	self.$message({
          message: data.messages[0].message,
          type: data.messages[0].type
        })
    );
  };
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
</style>
