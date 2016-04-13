within thermal_model_k004b;
model SourceTemp
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC t=inlet;
  Modelica.Blocks.Interfaces.RealInput inlet annotation (Placement(
        transformation(extent={{-120,-30},{-80,10}}),
                                                    iconTransformation(extent={{-100,
            -10},{-80,10}})));
  Temperature outlet
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
equation
  outlet.t=t;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-66,90},{66,20}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="environment_source"),
        Text(
          extent={{-88,12},{-48,0}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="inlet.t"),
        Text(
          extent={{52,12},{76,-2}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="outlet")}));
end SourceTemp;
