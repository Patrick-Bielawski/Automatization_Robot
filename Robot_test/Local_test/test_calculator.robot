*** Settings ***
Library    Process
Library    OperatingSystem

*** Variables ***

# Hodnoty pro spuštění kalkulačky
${CALCULATOR_PROCESS}       calc.exe
${TASKLIST}                 tasklist
${PROCESS_LIST_FILE}        process_list.txt
${ENCODING}                 cp850
${CALCULATOR_NAME}          CalculatorApp.exe

# Hodnoty pro sčítání
${ADD_TEST_1}               100 + 0
${ADD_RESULT_1}             100
${ADD_TEST_2}               10 + 8
${ADD_RESULT_2}             18
${ADD_TEST_3}               2.3 + 0.9
${ADD_RESULT_3}             3.2

# Nesprávné výsledky
${WRONG_RESULT_1}           5
${WRONG_RESULT_2}           0
${WRONG_RESULT_3}           2.9

*** Test Cases ***

Test Start Calculator
    [Documentation]     Tento test zkontroluje, zde je kalkulačka spuštěná.
    Start Calculator
    Verify Calculator Run

Test Add Function
    [Documentation]     Tento test zkontroluje funkci sčítání
    Verify Addition Result          ${ADD_TEST_1}   ${ADD_RESULT_1}
    Verify Addition Result          ${ADD_TEST_2}   ${ADD_RESULT_2}
    Verify Addition Result          ${ADD_TEST_3}   ${ADD_RESULT_3}

Test Add Wrong Function
    [Documentation]     Tento test zkontroluje, že výsledek není roven "result"
    Test Add Wrong Function          ${ADD_TEST_1}   ${WRONG_RESULT_1}
    Test Add Wrong Function          ${ADD_TEST_2}   ${WRONG_RESULT_2}
    Test Add Wrong Function          ${ADD_TEST_3}   ${WRONG_RESULT_3}

*** Keywords ***

Start Calculator
    Run Process       ${CALCULATOR_PROCESS}

Verify Calculator Run
    Run Process       ${TASKLIST}      stdout=${PROCESS_LIST_FILE}
    ${output}         Get File         ${PROCESS_LIST_FILE}    encoding=${ENCODING}
    Should Contain    ${output}        ${CALCULATOR_NAME}

Verify Addition Result
    [Arguments]       ${calculation}   ${expected_result}
    ${result}         Evaluate         ${calculation}
    Should Be Equal As Numbers         ${result}    ${expected_result}
    Log To Console                     ${\n}>>>${calculation}<<<
    Log To Console                     ${\n}>>>${expected_result}<<<

Test Add Wrong Function
    [Arguments]       ${calculation}   ${expected_wrong_result}
    ${result}         Evaluate         ${calculation}
    Should Not Be Equal As Numbers     ${result}    ${expected_wrong_result}
    Log To Console                     ${\n}>>>${calculation}<<<
    Log To Console                     ${\n}>>>${${expected_wrong_result}}<<<




