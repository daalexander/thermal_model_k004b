within thermal_model_k004b;
model Window
  Modelica.SIunits.DensityOfHeatFlowRate radiation_arriving=inlet_sun.radiation_sun;
  Modelica.SIunits.HeatFlowRate qdot_effective;
  parameter Real window_transmission = 0.00687213;
  outer Modelica.SIunits.Area window_surface
    "sum of contacting surfaces (windows) with the environment";
  HeatFlow outlet_room annotation (Placement(transformation(extent={{70,-10},{90,
            10}}), iconTransformation(extent={{70,-10},{90,10}})));
  RadiantEnergyFluenceRate inlet_sun annotation (Placement(transformation(
          extent={{-90,-10},{-70,10}}), iconTransformation(extent={{-90,-10},{-70,
            10}})));
equation
  qdot_effective = radiation_arriving * window_transmission * window_surface;
  qdot_effective = outlet_room.qdot;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Window;
