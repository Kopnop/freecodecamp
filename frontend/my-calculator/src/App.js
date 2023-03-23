import Footer from "./Components/Footer";
import "./App.css"
import { useEffect, useState } from "react";
import buttonsData from "./Data/buttons.json"

function App() {

  const [currentValue, setCurrentValue] = useState("");
  const [topDisplay, setTopDisplay] = useState("");
  const [result, setResult] = useState();
  const [currentOperator, setCurrentOperator] = useState("")
  const [lastClicked, setLastClicked] = useState("")
  const operations = ["equals", "add", "subtract", "divide", "multiply"]

  useEffect(() => {
    setTopDisplay(result ? result : "0")
  }, [result])

  function handleClick(e) {
    switch (e.target.id) {
      case 'zero':
        handleNumber("0")
        break;
      case 'one':
        handleNumber("1")
        break;
      case 'two':
        handleNumber("2")
        break;
      case 'three':
        handleNumber("3")
        break;
      case 'four':
        handleNumber("4")
        break;
      case 'five':
        handleNumber("5")
        break;
      case 'six':
        handleNumber("6")
        break;
      case 'seven':
        handleNumber("7")
        break;
      case 'eight':
        handleNumber("8")
        break;
      case 'nine':
        handleNumber("9")
        break;
      case 'decimal':
        if (!currentValue) {
          setCurrentValue("0.")
        } else {
          if (!currentValue.includes(".")) {
            setCurrentValue(prevText => prevText + ".")
          }
        }
        break;
      case 'equals':
        handleOperator()
        setCurrentOperator("=")
        break;
      case 'add':
        handleOperator()
        setCurrentOperator("+")
        break;
      case 'subtract':
        handleOperator()
        setCurrentOperator("-")
        break;
      case 'divide':
        handleOperator()
        setCurrentOperator("/")
        break;
      case 'multiply':
        handleOperator()
        setCurrentOperator("*")
        break;
      // case 'inverse':
      //   //TODO
      //   break;
      // case 'sqr':
      //   //TODO
      //   break;
      // case 'sqrt':
      //   //TODO
      //   break;
      case 'negate':
        if (currentValue) { setCurrentValue(prevValue => prevValue * -1) }
        break;
      case 'back':
        if (currentValue && currentValue.length > 0) {
          if (currentValue.length === 2 && currentValue[0] === "0" && currentValue[1] === ".") {
            setCurrentValue()
          } else {
            setCurrentValue(prevText => prevText.slice(0, -1))
          }
        }
        break;
      case 'clear':
        setCurrentValue("")
        setResult()
        setCurrentOperator("")
        break;
      default:
        console.log("default");
    }
    setLastClicked(e.target.id)
  }

  function handleNumber(number) {
    if (operations.includes(lastClicked) || currentValue === undefined) {
      setCurrentValue(number)
    } else {
      if (currentValue.length > 30) {
        return
      }
      if (number === "0") {
        if ((!currentValue || currentValue[0] === "0") && !currentValue.includes(".")) {
          return;
        }
      }
      const newValue = currentValue + number
      setCurrentValue(newValue)
    }
    if (lastClicked === "equals") {
      setResult()
    }
  }
  function handleOperator() {
    if (result === undefined) {
      //calc with 0
      setResult(currentValue)
      setCurrentValue()
    } else {
      if (currentValue) {
        //perform calc
        let newValue
        switch (currentOperator) {
          case "+":
            newValue = Math.round((Number(result) + Number(currentValue)) * 1e6) / 1e6

            break
          case "-":
            newValue = Math.round((Number(result) - Number(currentValue)) * 1e6) / 1e6

            break
          case "*":
            newValue = Math.round((Number(result) * Number(currentValue)) * 1e6) / 1e6
            break
          case "/":
            if (currentValue === "0") {
              setResult("can't divide by 0")
              return
            }
            newValue = Math.round((Number(result) / Number(currentValue)) * 1e6) / 1e6
            break
          default:
          //TODO: check case
        }
        setResult(newValue)
        setCurrentValue()
      }
    }
  }

  return (
    <div className="App">
      <main>
        <div className="calc">
          <div className="display" id="display">
            <p className="topDisplay">{topDisplay}{currentOperator ? " " + currentOperator : ""}</p>
            <p className="bottomDisplay">{currentValue ? currentValue : currentOperator ? currentOperator : "0"}</p>
          </div>
          {buttonsData.map(item => <button key={item.name} id={item.name} className={item.className} onClick={handleClick}>{item.displayName}</button>)}
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default App;