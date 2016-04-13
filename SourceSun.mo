within thermal_model_k004b;
model SourceSun
  Modelica.SIunits.DensityOfHeatFlowRate radiation_sun = inlet;
  Modelica.Blocks.Interfaces.RealInput inlet annotation (Placement(
        transformation(extent={{-120,-30},{-80,10}}), iconTransformation(
          extent={{-100,-10},{-80,10}})));
  RadiantEnergyFluenceRate outlet
    annotation (Placement(transformation(extent={{70,-20},{90,0}})));
equation
  outlet.radiation_sun = radiation_sun;
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
          textString="inlet"),
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
end SourceSun;
