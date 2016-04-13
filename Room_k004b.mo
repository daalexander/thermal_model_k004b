within thermal_model_k004b;
model Room_k004b "model of a room for mpc purpose with JModelica.org"
    /** parameter p **/
    /* parameter of the room */
    parameter Modelica.SIunits.Length room_length=7.81 "length of the room";
    parameter Modelica.SIunits.Breadth room_breadth=5.78 "breadth of the room";
    parameter Modelica.SIunits.Height room_height=2.99 "height of the room";
    parameter Modelica.SIunits.Length window_length=7 "length of the window";
    parameter Modelica.SIunits.Height window_height=2.08 "height of the window";
    parameter Modelica.SIunits.Density rho_air = 1.2 "density of air";
    parameter Modelica.SIunits.CoefficientOfHeatTransfer u_glass=2.0
    "heat transfer coefficient for glass ";                                        //Aus Thesis Ander, Genauere Bestimmung folgt mit original Werten
    parameter Modelica.SIunits.CoefficientOfHeatTransfer u_wall=0.612986
    "heat transfer coefficient for the walls of the room";                         //Aus Thesis Ander, Genauere Bestimmung folgt mit original Werten
    parameter Modelica.SIunits.SpecificHeatCapacity cp_air=1005
    "specific heat capacity of air";
    parameter Modelica.SIunits.SpecificHeatCapacity cp_water=4182
    "specific heat capacity of water";
    Window window "instance of a window";
    /* calculated parameter */
    Modelica.SIunits.Volume room_volume "volume of the room";
    Modelica.SIunits.Mass room_mass "mass of air within the room";
    Modelica.SIunits.Area environment_surface
    "sum of contacting surfaces (walls) with the environment";
    inner Modelica.SIunits.Area window_surface
    "sum of contacting surfaces (windows) with the environment";
    Modelica.SIunits.Energy room_u "inner energy of the system room";
    Modelica.SIunits.HeatFlowRate environment_qdot
    "rate of heat flow with the environment";
    Modelica.SIunits.HeatFlowRate environment_qdot_wall
    "rate of heat flow with the environment through the wall";
    Modelica.SIunits.HeatFlowRate environment_qdot_window
    "rate of heat flow with the environment through the window";
    Modelica.SIunits.HeatFlowRate qdot_loss
    "summed up rate of heatflow leaving the system";
    Modelica.SIunits.HeatFlowRate radiator_qdot
    "heat flow rate at the radiator surfaces streaming into the room";
    /** states x **/
    inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC room_temperature(start=24, fixed=true)
    "temperature within the room (Initially about 24 degree celsius)";
    /** controls u **/
    Modelica.SIunits.MassFlowRate mdot=radiator_inlet_massflow.mdot
    "commitment of the massflowrate to the radiator";
    Modelica.SIunits.Conversions.NonSIunits.Temperature_degC environment_temperature=inlet_environment.t
    "temperature of the environment";
    Modelica.SIunits.HeatFlowRate qdot_sun
    "rate of heat flow brought in by the sun";
    Modelica.SIunits.HeatFlowRate qdot_otherfactors=inlet_other.qdot
    "rate of heat flow brought in by other factors (e.g. people, computer)";
  Temperature inlet_environment
    annotation (Placement(transformation(extent={{-350,210},{-330,230}})));
  HeatFlow inlet_other annotation (Placement(transformation(extent={{350,208},{370,
            228}}), iconTransformation(extent={{352,272},{372,292}})));
  RadiantEnergyFluenceRate inlet_sun
    annotation (Placement(transformation(extent={{350,172},{370,192}})));
  Radiator radiator "instance of a radiator";
    annotation (Placement(transformation(extent={{-238,-180},{280,200}})));
  Massflow radiator_inlet_massflow
    annotation (Placement(transformation(extent={{-350,-28},{-330,-8}})));
  Temperature radiator_inlet_temperature
    annotation (Placement(transformation(extent={{-350,50},{-330,70}})));
equation
 /* calculate room volume */
 room_volume=room_length*room_height*room_breadth;
 /* calculate room mass */
 room_mass=room_volume*rho_air;
 /* calculate wall surface of the room with the environment */
 environment_surface=(room_length*room_height)+(room_breadth*room_height)-window_surface;
 /* calculate window surface of the room with the environment */
 window_surface=(window_length*window_height);
 /* calculate inner energy*/
 room_u = room_mass * cp_air * room_temperature; //Überprüfen ob überhaupt nötig?!?!?!
 /* calculate derival of the inner energy */
 der(room_u) = radiator_qdot + qdot_loss + qdot_sun + qdot_otherfactors;
 /* sum up the lost heat flow */
 qdot_loss = environment_qdot;
 /* sum up the lost heatflow with the environment */
 environment_qdot = environment_qdot_window + environment_qdot_wall;
 /* calculate lost heatflow with the environment through the window */
 environment_qdot_window = u_glass * window_surface * (environment_temperature - room_temperature);
 /* calculate lost heatflow with the environment through the wall */
 environment_qdot_wall = u_wall * environment_surface * (environment_temperature - room_temperature);
 /* commit the inflowing heat flow of the radiator */
 radiator_qdot=radiator.radiator_qdot_out;
 /* connect radiator with the inlet */
 qdot_sun = window.outlet_room.qdot;
  connect(radiator_inlet_massflow, radiator.inlet_massflow) annotation (Line(
      points={{-340,-18},{-286,-18},{-286,10},{-227.405,10}},
      color={0,0,0},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(radiator_inlet_temperature, radiator.inlet_temperature) annotation (
      Line(
      points={{-340,60},{-285,60},{-285,32.5625},{-226.227,32.5625}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inlet_sun, window.inlet_sun)
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-620,
            -440},{620,440}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-620,-440},{620,440}}), graphics={
        Text(
          extent={{-292,240},{-66,144}},
          lineColor={0,0,255},
          textString="inlet_environment.t"),
        Text(
          extent={{184,198},{346,122}},
          lineColor={0,0,255},
          textString="inlet_sun.qdot"),
        Rectangle(
          extent={{-340,358},{362,-320}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-206,400},{248,244}},
          lineColor={0,0,0},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="room_radiator"),
        Polygon(
          points={{324,188},{402,228},{402,148},{324,188}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{-378,220},{-300,260},{-300,180},{-378,220}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{324,282},{402,322},{402,242},{324,282}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Text(
          extent={{168,292},{348,214}},
          lineColor={0,0,255},
          textString="inlet_other.qdot")}));
end Room_k004b;
