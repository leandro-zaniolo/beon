*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         Collections

*** Variables ***
${API_BASE_POST}    https://reqres.in/
${page_path}        $.path
${id_path}          $.id


*** Test Cases ***
TestCase_post
    Create Session      API_Testing                 ${API_BASE_POST}    disable_warnings=1
    ${endpoint}         Set Variable                api/users
    ${body}=            Create Dictionary           name=Ordnael        job=QAE
    ${response}=        Post On Session             API_Testing         ${endpoint}     data=${body}
    Log To Console      ${response.status_code}
    Log To Console      ${response.content}

    ${staus_code}=      Convert To String           ${response.status_code}
    Should Be Equal    ${staus_code}    201

    ${jsonResponse}=    Convert String To Json    ${response.content}
    ${contents}=        Get Value From Json    ${jsonResponse}    ${id_path}
    Should Not Be Empty    ${contents}
