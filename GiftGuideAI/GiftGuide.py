import clips
import PySimpleGUI as sg
import re
import random

environment = clips.Environment()
environment.load('construct.clp')

while True:
    environment.reset()
    environment.run()
    layout = [[sg.Text("Man's Guide to choosing the perfect holiday gift")], [sg.Text("Click to start")],
              [sg.Button("Start")]]
    window = sg.Window("Gift Guide", layout, size=(400, 100), element_justification='center')
    event, values = window.read()

    if event == "Start":
        while True:
            window.close()
            question = []
            responses = []
            responses_list = []
            number = 0
            buttons = [sg.Button("Next"), sg.Button("Restart")]
            for fact in environment.facts():
                new_fact = str(fact).lstrip("(").rstrip(")")

                if new_fact.split(" ")[0] == "display": #wyświetlanie treści pytania/odpowiedzi
                    question.append(sg.Text(new_fact.split("\"")[1]))

                elif new_fact.split(" ")[0] == "valid-answers": #wyświetlanie możliwych odpowiedzi
                    matches = re.findall(r'"([^"]*)"', new_fact)
                    for i in range(len(matches)):
                        if i == 0:
                            responses.append([sg.Radio(matches[i], 'num', default=True)])
                        else:
                            responses.append([sg.Radio(matches[i], 'num')])
                        responses_list.append(matches[i])

                elif new_fact.split(" ")[0] == "fact-name": #pobieranie nazwy nowego faktu
                    fact_name = new_fact.split(" ")[1]

                elif new_fact.split(" ")[0] == "difficult-decision": #losowa decyzja
                    number = random.randint(1, len(new_fact.split(" "))-1)
                    decision = new_fact.split(" ")[number]
                    environment.eval("(assert (" + fact_name + " " + decision + "))")

                elif new_fact.split(" ")[0] == "decision": #przejscie do nastepnego pytania w przypadku braku dostepnych odpowiedzi
                    next_question = new_fact.split(" ")[1]
                    environment.eval("(assert (" + fact_name + " " + next_question + "))")

                elif new_fact == "state final": #wyswietlanie koncowej odpowiedzi (brak przycisku next)
                    buttons.pop(0)

            layout = [question, responses, buttons]
            layout_f = [[sg.VPush()], [sg.Push(), layout, sg.Push()], [sg.VPush()]]
            window = sg.Window("Gift Guide", layout_f, size=(1350, 400), element_justification='center')
            event, values = window.read()

            if event == "Next":
                environment.eval("(do-for-all-facts((?f display)) TRUE(retract ?f))")
                environment.eval("(do-for-all-facts((?f valid-answers)) TRUE(retract ?f))")
                environment.eval("(do-for-all-facts((?f fact-name)) TRUE(retract ?f))")
                environment.eval("(do-for-all-facts((?f difficult-decision)) TRUE(retract ?f))")
                environment.eval("(do-for-all-facts((?f decision)) TRUE(retract ?f))")
                for i in range(len(values)):
                    if values[i]:
                        print(responses_list[i])
                        environment.eval("(assert (" + fact_name + " " + responses_list[i] + "))")
                environment.run()

            elif event == "Restart" or event == sg.WIN_CLOSED:
                window.close()
                print("\n")
                break

    elif event == sg.WIN_CLOSED:
        break

window.close()