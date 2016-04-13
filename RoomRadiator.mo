within thermal_model_k004b;
model RoomRadiator
  Modelica.Blocks.Sources.RealExpression power_other_sources(y=0)
    annotation (Placement(transformation(extent={{88,68},{68,88}})));
  Modelica.Blocks.Sources.RealExpression outside_temperature(y=-10)
    annotation (Placement(transformation(extent={{-152,54},{-132,74}})));
  Modelica.Blocks.Sources.RealExpression heating_massflow(y=0.01)
    annotation (Placement(transformation(extent={{-24,-42},{-4,-22}})));
  Modelica.Blocks.Sources.RealExpression heating_temperature(y=60)
    annotation (Placement(transformation(extent={{-24,-16},{-4,4}})));
  SourceHeat other_sources
    annotation (Placement(transformation(extent={{46,68},{26,88}})));
  Modelica.Blocks.Sources.RealExpression power_sun(y=800)
    annotation (Placement(transformation(extent={{88,42},{68,62}})));
  SourceTempMass heater
    annotation (Placement(transformation(extent={{18,-30},{40,-8}})));
  SourceTemp UmgebungA
    annotation (Placement(transformation(extent={{-110,54},{-90,74}})));
  SourceSun sourceSun
    annotation (Placement(transformation(extent={{46,42},{26,62}})));
  Room_k004b room_k004b
    annotation (Placement(transformation(extent={{-94,-2},{30,86}})));
equation
  connect(heating_temperature.y, heater.inlet_t) annotation (Line(
      points={{-3,-6},{0,-6},{0,-14.6},{20.42,-14.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heating_massflow.y, heater.inlet_mdot) annotation (Line(
      points={{-3,-32},{0,-32},{0,-23},{18,-23},{18,-23.4},{20.42,-23.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(outside_temperature.y, UmgebungA.inlet) annotation (Line(
      points={{-131,64},{-109,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(power_other_sources.y, other_sources.inlet) annotation (Line(
      points={{67,78},{45,78}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(room_k004b.inlet_other, other_sources.outlet) annotation (Line(
      points={{4.2,70.2},{15.1,70.2},{15.1,78},{27.2,78}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(room_k004b.inlet_sun, sourceSun.outlet) annotation (Line(
      points={{4,60.2},{14,60.2},{14,51},{28,51}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(UmgebungA.outlet, room_k004b.inlet_environment) annotation (Line(
      points={{-91,64},{-66,64}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(power_sun.y, sourceSun.inlet) annotation (Line(
      points={{67,52},{45,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heater.massflow, room_k004b.radiator_inlet_massflow) annotation (Line(
      points={{38.9,-24.5},{54,-24.5},{54,-40},{-86,-40},{-86,40.2},{-66,40.2}},

      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(heater.temperature, room_k004b.radiator_inlet_temperature)
    annotation (Line(
      points={{38.9,-15.7},{60,-15.7},{60,-48},{-92,-48},{-92,48},{-66,48}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={Rectangle(
          extent={{-54,48},{-6,30}},
          lineColor={0,0,0},
          lineThickness=0.5), Text(
          extent={{-48,48},{-14,44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="radiator")}));
end RoomRadiator;
