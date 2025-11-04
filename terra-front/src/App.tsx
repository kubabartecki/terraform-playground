import React from 'react';

import './App.css';
import TerraList from './components/TerraList';
import TerraAdd from './components/TerraAdd';

function App() {
  const [list, setList] = React.useState<string[]>([]);
  const allItemsApiUrl = process.env.REACT_APP_API_URL + '/all';

  const fetchTerraList = async () => {
    const response = await fetch(allItemsApiUrl)
      .catch((error) => {
        console.error('Error:', error);
      }
    );
    if (!response) {
      return;
    }
    const data = await response.json();
    setList(data);
  };

  React.useEffect(() => {
    fetchTerraList();
  }, []);

  return (
    <div className="App-header">
      <div className="left">
        <TerraList list={list}/>
      </div>
      <div className="right">
        <TerraAdd afterAdd={fetchTerraList}/>
      </div>
    </div>
  );
}

export default App;
