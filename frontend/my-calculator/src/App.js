import Footer from "./Components/Footer";
import "./App.css"
import { useEffect, useState } from "react";
import buttonsData from "./Data/buttons.json"
function App() {

  const [currentValue, setCurrentValue] = useState("");
  const [topDisplay, setTopDisplay] = useState("");
  const [bottomDisplay, setBottomDisplay] = useState("")
  const [result, setResult] = useState();
  const [currentOperator, setCurrentOperator] = useState("")
  const [lastClicked, setLastClicked] = useState("")
  const operations = ["equals", "plus", "minus", "divide", "multi"]

  useEffect(() => {
    console.log("lastValue changed to: " + result);
  }, [result])

  function handleNumber(number) {
    if (operations.includes(lastClicked)) {
      setCurrentValue(number)
      setBottomDisplay(number)
    } else {
      const newValue = currentValue + number
      setCurrentValue(newValue)
      setBottomDisplay(newValue)
    }
    if (lastClicked === "equals") {
      setResult()
      setTopDisplay("")
    }
  }

  function handleOperator() {
    if (!result) {
      //calc with 0
      setResult(currentValue)
      setTopDisplay(currentValue)
      setCurrentValue()
      setBottomDisplay("")
    } else {
      if (currentValue) {
        //perform calc
        let newValue
        switch (currentOperator) {
          case "+":
            newValue = Number(result) + Number(currentValue)
            break
          case "-":
            newValue = Number(result) - Number(currentValue)
            break
          case "*":
            newValue = Number(result) * Number(currentValue)
            break
          case "/":
            newValue = Number(result) / Number(currentValue)
            break
          default:
          //TODO: check case
        }
        setResult(newValue)
        setCurrentValue()
        setTopDisplay(newValue)
        setBottomDisplay()
      }
    }
  }

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
      case 'dot':
        //TODO
        setCurrentValue(prevText => prevText + ".")
        break;
      case 'equals':
        handleOperator()
        setCurrentOperator("=")
        break;
      case 'plus':
        handleOperator()
        setCurrentOperator("+")
        break;
      case 'minus':
        handleOperator()
        setCurrentOperator("-")
        break;
      case 'divide':
        handleOperator()
        setCurrentOperator("/")
        break;
      case 'multi':
        handleOperator()
        setCurrentOperator("*")
        break;
      case 'inverse':
        //TODO
        break;
      case 'sqr':
        //TODO
        break;
      case 'sqrt':
        //TODO
        break;
      case 'negate':
        //TODO
        break;
      case 'back':
        //TODO: check if correct
        if (currentValue.length > 0) { setCurrentValue(prevText => prevText.slice(0, -1)) }
        break;
      case 'clear':
        //TODO: check if correct
        setCurrentValue("")
        setTopDisplay("")
        setResult(0)
        setCurrentOperator("")
        setBottomDisplay("")
        break;
      default:
        console.log("default");
    }
    setLastClicked(e.target.id)
  }

  return (
    <div className="App">
      <main>
        <div className="calc">
          <div className="display">
            <p className="totalValueText">{topDisplay ? topDisplay : "topDisplay"}{currentOperator ? " " + currentOperator : ""}</p>
            <p className="currentValueText">{currentValue ? currentValue : currentOperator ? currentOperator : "currentValue"}</p>
            <p className="currentValueText">{bottomDisplay ? bottomDisplay : "bottomDisplay"}</p>
          </div>
          {buttonsData.map(item => <button key={item.name} id={item.name} className={item.placeholder} onClick={handleClick}>{item.displayName}</button>)}
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default App;