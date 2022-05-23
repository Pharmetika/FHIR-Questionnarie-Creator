#!/bin/bash
zip -r dist.zip dist/;
scp dist.zip base6:/www/dist.zip;
rm dist.zip;
rm -rf dist/;
ssh base6 'cd /www/ && unzip dist.zip && rm -rdf fhir_questionnaire.last && mv fhir_questionnaire fhir_questionnaire.last && mv dist fhir_questionnaire;';
