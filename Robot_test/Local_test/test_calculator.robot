*** Settings ***
Library    Process
Library    OperatingSystem
Library    BuiltIn

*** Variables ***

# Hodnoty pro spuštění kalkulačky
${CALCULATOR_PROCESS}       calc.exe
${TASKLIST}                 tasklist
${PROCESS_LIST_FILE}        process_list.txt
${ENCODING}                 cp850
${CALCULATOR_NAME}          CalculatorApp.exe

# Hodnoty pro sčítání
@{ADD_TESTS}                100 + 0     10 + 8      2.3 + 0.9
@{ADD_RESULTS}              100         18          3.2

# Nesprávné výsledky
@{WRONG_RESULTS}            5           0           2.9

*** Test Cases ***

Test Add Function with Loop
    [Documentation]     Tento test zkontroluje funkci sčítání za pomocí cyklu.
    ${length}           Evaluate         len(${ADD_TESTS})    # Získání délky seznamu
    FOR    ${index}     IN RANGE    0    ${length}
        ${test}         Set Variable     ${ADD_TESTS}[${index}]
        ${expected}     Set Variable     ${ADD_RESULTS}[${index}]
        Log                              ${\n}>>>Spuštěn test pro: ${test}<<<
        ${result}       Evaluate         round(${test}, 2)    # Vyhodnocení matematického výrazu
        Should Be Equal As Numbers       ${result}    ${expected}
    END

Test Add Wrong Function with Loop
    [Documentation]     Tento test zkontroluje, že výsledek není roven "result" pomocí cyklu.
    ${length}            Evaluate         len(${ADD_TESTS})    # Získání délky seznamu
    FOR    ${index}    IN RANGE    0      ${length}
        ${test}          Set Variable     ${ADD_TESTS}[${index}]
        ${wrong_result}  Set Variable     ${WRONG_RESULTS}[${index}]
        Log To Console                    ${\n}>>>Spuštěn test pro: ${test}<<<
        ${result}        Evaluate         round(${test}, 2)    # Vyhodnocení matematického výrazu
        Should Not Be Equal As Numbers    ${result}    ${wrong_result}
    END

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
    Log To Console                     ${\n}>>>Očekávaný výsledek: ${expected_result}<<<

Verify Wrong Addition Result
    [Arguments]       ${calculation}   ${expected_wrong_result}
    ${result}         Evaluate         ${calculation}
    Should Not Be Equal As Numbers     ${result}    ${expected_wrong_result}
    Log To Console                     ${\n}>>>${calculation}<<<
    Log To Console                     ${\n}>>>Neočekávaný výsledek: ${expected_wrong_result}<<<
