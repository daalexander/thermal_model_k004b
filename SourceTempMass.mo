within thermal_model_k004b;
model SourceTempMass
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC t=inlet_t;
  Modelica.SIunits.MassFlowRate mdot=inlet_mdot;
  Modelica.Blocks.Interfaces.RealInput inlet_t annotation (Placement(
        transformation(extent={{-108,10},{-68,50}}),iconTransformation(extent={{-88,30},
            {-68,50}})));
  Modelica.Blocks.Interfaces.RealInput inlet_mdot
    annotation (Placement(transformation(extent={{-108,-70},{-68,-30}}),
        iconTransformation(extent={{-88,-50},{-68,-30}})));
  Massflow massflow
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  Temperature temperature
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
equation
  temperature.t=t;
  massflow.mdot=mdot/3600;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
          extent={{-90,90},{90,-90}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-70,40},{-30,28}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="inlet_t.t"),
        Text(
          extent={{-66,-18},{2,-54}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="inlet_mdot.mdot"),
        Text(
          extent={{54,12},{78,-2}},
          lineColor={0,0,255},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="outlet"),
        Text(
          extent={{-52,92},{46,40}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="radiator_source")}));
end SourceTempMass;
