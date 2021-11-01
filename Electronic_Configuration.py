print("ELECTRON CONFIGURATION")

def ask_AtomicNumber():
    element_id = None

    while type(element_id) != int:
        element_id = input("Type in the atomic number of the element: ")
        try:
            element_id = int(element_id)

            if element_id < 0 or element_id > 118:
                print("There is no element for with that atomic number.")
                element_id = None
        except:
            print("Error in the entrance. Try again.")
    return element_id

def maxPerLevel(term):    #To set the maximum amount of electrons in each level
    if term[1] == 's':
        max = 2
    elif term[1] == 'p':
        max = 6
    elif term[1] == 'd':
        max = 10
    elif term[1] == 'f':
        max = 14
    return max

def full_configuration(element_id, terms):
    electron_configuration = ''

    for term in terms:
        if element_id > maxPerLevel(term):
            electron_configuration += term + str(maxPerLevel(term)) + " "
            element_id -= maxPerLevel(term)
        else:
            electron_configuration += term + str(element_id)
            break

    return electron_configuration

def shorthand_configuration(element_id, terms, elements):
    nobleGas_period = element_id // 8
    gas_electrons = nobleGas_period*8+2

    if nobleGas_period == 0 and element_id < 3:
        shorthand = ""
    elif element_id > gas_electrons:
        shorthand = f"[{elements[gas_electrons][1]}]"
    else:
        shorthand = f"[{elements[(nobleGas_period-1)*8+2][1]}]"
    
    electron_congifuration = full_configuration(element_id, terms)
    electron_congifuration = electron_congifuration.replace(f'{full_configuration(gas_electrons, terms)}', shorthand).lstrip()

    return electron_congifuration

def electron_configuration():
    #Variables
    terms = ['1s','2s', '2p', '3s', '3p', '4s', '3d', '4p', '5s','4d','5p','6s','4f','5d','6p','7s']
    elements = {1: ['Hydrogen', 'H'], 2: ["Helium", 'He'], 3: ["Lithium", 'Li'], 4: ["Berylium", 'Be'], 
    5: ['Boron', 'B'], 6: ['Carbon', 'C'], 7: ['Nitrogen', 'N'], 8: ['Oxigen', 'O'], 9: ['Fluorine','F'], 
    10: ['Neon','Ne'], 11: ['Sodium','Na'], 12: ['Manesium','Mg'], 13: ['Aluminium', 'Al'], 14: ['Silicon','Si'],
    15: ['Phosphorus','P'], 16: ['Sulfur','S'], 17: ['Chlorine','Cl'], 18: ['Argon','Ar'], 19: ['Potassium', 'K'],
    20: ['Calcium', 'Ca'] 
    }

    #Ask for the atomic number and manage exceptions
    element_id = ask_AtomicNumber()

    #Create the string with electronic configuration
    if element_id == 2 or element_id == 10 or element_id == 18 or element_id == 36 or element_id == 54 or element_id == 86 or element_id == 188:
        electron_congifuration = full_configuration(element_id,terms)
    else:
        opcion = input("Choose an opcion:\n(1) Full electron configuration\n(2) Shorthand electron configuration\n\nSelection: ")
        while opcion != '1' and opcion != '2':
            print("Please enter a valid opcion.")
            opcion = input("Selection: ")

        if opcion == '1':
            electron_congifuration = full_configuration(element_id,terms)
        elif opcion == '2':
            electron_congifuration = shorthand_configuration(element_id,terms,elements)

    #Print electronic configuration
    print(f"\nElectronic configuration of {elements[element_id][0]}({elements[element_id][1]}):\n{electron_congifuration}")

electron_configuration()