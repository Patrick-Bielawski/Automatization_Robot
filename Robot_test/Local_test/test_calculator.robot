*** Settings ***
Library    Process
Library    OperatingSystem
*** Test Cases ***
# Testování kalkulačky v PC

Test_start_calc

    [Documentation]    Tento test zkontroluje, zda je proces kalkulačky spuštěn
    Run Process    calc.exe
    Run Process    tasklist    stdout=process_list.txt
    ${output} =    Get File    process_list.txt    encoding=cp850
    Should Contain    ${output}    CalculatorApp.exe

Test_add_function

    [Documentation]     Tento test zkontroluje funkci sčítání.
    ${result} =     Evaluate    5 + 0
    Should Be Equal As Integers    ${result}    5
    ${result} =     Evaluate    5 + 1
    Should Be Equal As Integers    ${result}    6
    ${result} =     Evaluate    5 + 6
    Should Be Equal As Integers    ${result}    11

Test_add_wrong_function

    [Documentation]     Tento test zkontroluje, že výsledek není roven "result".
    ${result} =     Evaluate    3 + 4
    Should Not Be Equal As Integers   ${result}    2
    ${result} =     Evaluate    3 + 4
    Should Not Be Equal As Integers    ${result}    8
    ${result} =     Evaluate    3 + 4
    Should Not Be Equal As Integers    ${result}    1



