import React from "react";

import './TerraAdd.scss';

interface Props {
  afterAdd: () => void;
}

const TerraAdd: React.FC<Props> = (props) => {
  const apiUrl = process.env.REACT_APP_API_URL;
  
  const addTerra = async (event: React.FormEvent<HTMLFormElement>): Promise<void> => {
    event.preventDefault();
    await fetch(apiUrl + '/add/' + name,
      {
        method: 'POST',
      }
    )
      .catch((error) => {
        console.error('Error:', error);
      });
    props.afterAdd();
  };

  const [name, setName] = React.useState<string>('');

  return (<div>
    <h1>Add to list</h1>
    <form onSubmit={addTerra}>
      <label>
        Name:
        <input type="text" name="name" value={name} onChange={(e) => setName(e.target.value)}/>
      </label>
      <input type="submit" value="Submit" />
    </form>
  </div>);
};

export default TerraAdd;
