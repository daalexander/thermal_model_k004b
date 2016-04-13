within thermal_model_k004b;
model SourceHeat
  Modelica.SIunits.HeatFlowRate qdot=inlet;
  Modelica.Blocks.Interfaces.RealInput inlet annotation (Placement(
        transformation(extent={{-120,-30},{-80,10}}), iconTransformation(
          extent={{-100,-10},{-80,10}})));
  HeatFlow outlet
    annotation (Placement(transformation(extent={{78,-10},{98,10}})));
equation
  outlet.qdot=qdot;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-78,10},{-38,-2}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="inlet.qdot"),
        Text(
          extent={{48,12},{72,-2}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="outlet"),
        Text(
          extent={{-42,84},{44,46}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="heat_source")}));
end SourceHeat;
