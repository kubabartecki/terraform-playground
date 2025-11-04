import React from "react";

interface Props {
  list: string[];
}

const TerraList: React.FC<Props> = (props) => {
  return (<div>
    <h1>Terra List</h1>
    <ul>
      {props.list.map((item, index) => (
        <li key={index}>{item}</li>
      ))}
    </ul>
  </div>);
};

export default TerraList;
