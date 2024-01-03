*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections

*** Variables ***
${API_BASE}    http://thetestingworldapi.com/


*** Test Cases ***
TestCase_get_FetchValidate
    Create Session      API_Testing                 ${APIBASE}          disable_warnings=1
    ${Get_Response}=    GET On Session              API_Testing         api/studentsDetails/10011
    Log To Console      ${Get_Response.status_code}

    ${json_response}=   Set Variable                ${Get_Response.json()}
    Log To Console      ${json_response}

    ${jsonValue}=       Get Value From Json         ${json_response}    status
    ${f_name}=          Get From List               ${jsonValue}        0
    Should Be Equal     ${f_name}    false
    Log To Console      ${jsonValue}

TestCase_get_StatusCode_200
    Create Session      API_Testing                 ${APIBASE}
    ${Get_Response}=    GET On Session              API_Testing         api/studentsDetails/10011

    ${statusCode}=      Convert To String           ${Get_Response.status_code}
