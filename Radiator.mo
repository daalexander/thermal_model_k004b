within thermal_model_k004b;
model Radiator "model for a discretized radiator within a room"
  /** parameter **/
  /* parameter of the radiator */
  parameter Real radiator_element_number=106
    "number of normed elements of which the radiator consists";
  parameter Real radiator_tubes_element=2
    "number of parallel tubes in one element";
  parameter Integer cv_number = 10
    "number of control volumes in which the radiator is discretized";

  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC cv_temperature_init_inlet=55.0
    "initialization of the income temperature of the fluid in the radiator";

  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC cv_temperature_init_outlet=35.0
    "initialization of the outcome temperature of the fluid in the radiator";

  parameter Modelica.SIunits.Length radiator_element_length=0.045
    "length of one element depending on type (Recknagel 2013/2014: Heizung und Klimatechnik S.815ff.)";
  parameter Modelica.SIunits.Height tube_length_vertical=0.4
    "height of one element depending on type (Recknagel 2013/2014: Heizung und Klimatechnik S.815ff.)";
  parameter Modelica.SIunits.Diameter tube_diameter_horizontal=0.05
    "diameter of the horizontal tubes depending on type (Recknagel 2013/2014: Heizung und Klimatechnik S.815ff.)";
  parameter Modelica.SIunits.Diameter tube_diameter_vertical=0.0255
    "diameter of the vertical tubes depending on type (Recknagel 2013/2014: Heizung und Klimatechnik S.815ff.)";
  parameter Modelica.SIunits.Density rho_water = 1000 "density of water";
  parameter Modelica.SIunits.Mass radiator_element_mass=0.35
    "mass within one element of the radiator depending on type (Recknagel 2013/2014: Heizung und Klimatechnik S.815ff.)";
  inner parameter Modelica.SIunits.CoefficientOfHeatTransfer u_radiator = 12.9872
    "heat transfer coefficient of the radiator";
  inner parameter Modelica.SIunits.SpecificHeatCapacity cp_water = 4182
    "specific heat capacity of water";
                                                                                // Etvl Modelica aus Grundgleichung berechnet in Abhänigkeit von Temperatur
  CV_Radiator cv_radiator[cv_number](cv_temperature_init=linspace(cv_temperature_init_inlet, cv_temperature_init_outlet, cv_number))
    "array of control volumes to discretize the radiator";
  /* calculated parameter */
  Modelica.SIunits.HeatFlowRate radiator_qdot_out
    "heatflow which is leaving the radiator";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC radiator_temperature_out
    "calculated(predicted) temperature of the water leaving the radiator";
  //Modelica.SIunits.Volume cv_v "volume within one control volume";
  /* parameter of the control volumes */
  inner Modelica.SIunits.Mass cv_m "mass within one control volume";
  inner Modelica.SIunits.Area exchange_surface
    "surface of one control volume at which h";
  /** states **/
  /* states of the radiator variable */
  inner Modelica.SIunits.Conversions.NonSIunits.Temperature_degC room_temperature_cv
    "temperature within the room for the control volume";
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC room_temperature
    "temperature within the room from the room";
  /** controls **/
  inner Modelica.SIunits.MassFlowRate mdot=inlet_massflow.mdot
    "massflowrate within the radiator";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC radiator_inlet = inlet_temperature.t
    "temperature of the inflowing fluid";
  Massflow inlet_massflow
    annotation (Placement(transformation(extent={{-432,-10},{-412,10}}),
        iconTransformation(extent={{-432,-10},{-412,10}})));
  Temperature inlet_temperature
    annotation (Placement(transformation(extent={{-430,28},{-410,48}}),
        iconTransformation(extent={{-430,28},{-410,48}})));
  Temperature outlet_temperature
    annotation (Placement(transformation(extent={{410,30},{430,50}}),
        iconTransformation(extent={{410,30},{430,50}})));
  Massflow outlet_massflow
    annotation (Placement(transformation(extent={{410,-10},{430,10}}),
        iconTransformation(extent={{410,-10},{430,10}})));
equation
  /* calculate surface of one control volume */
  exchange_surface = (radiator_element_number * radiator_element_length * 2 * Modelica.Constants.pi * tube_diameter_horizontal + radiator_element_number * radiator_tubes_element * tube_length_vertical * Modelica.Constants.pi * tube_diameter_vertical)/cv_number;
  /* calculate mass within one control volume */
  cv_m = (radiator_element_mass * radiator_element_number)/cv_number;
  /* calculate volume within one control volume */
  //cv_v = (radiator_element_number * radiator_element_volume) / cv_number;
  /* commit temperature of radiator fluid inlet to the first control volume */
  cv_radiator[1].inlet.t = radiator_inlet;
  /* commit fluid temperatures within the radiator control volumes */
  for i in 1 : (cv_number-1) loop
   connect( cv_radiator[i].outlet, cv_radiator[i+1].inlet);
  end for;
  /* save fluid temperature of the last radiator control volumes */
  radiator_temperature_out=cv_radiator[cv_number].outlet.t;
  /* calculate and save the heatflowrate which is leaving the radiator*/
  radiator_qdot_out = sum(cv_radiator.cv_qdot);
  /* commit roomtemperature*/
  room_temperature=room_temperature_cv;
  outlet_massflow.mdot = mdot;
  outlet_temperature.t = radiator_temperature_out;
     annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-440,
            -320},{440,320}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-440,-320},{440,320}}),
                                               graphics={
        Rectangle(
          extent={{-300,92},{358,-88}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={175,175,175}),
        Rectangle(
          extent={{-420,300},{422,-300}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-122,312},{128,214}},
          lineColor={0,0,0},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="radiator"),
        Rectangle(
          extent={{-282,38},{-202,-40}},
          lineColor={0,0,0},
          lineThickness=1),
        Rectangle(
          extent={{-180,38},{-100,-40}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-404,22},{-294,-24}},
          lineColor={0,0,255},
          lineThickness=1,
          textString="inlet.t
inlet.mdot",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(
          extent={{262,40},{342,-38}},
          lineColor={0,0,0},
          lineThickness=1),
        Rectangle(
          extent={{160,40},{240,-38}},
          lineColor={0,0,0},
          lineThickness=1),
        Line(
          points={{-350,164}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{-412,0},{-280,0}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-202,0},{-178,0}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-100,0},{160,0}},
          color={0,128,255},
          smooth=Smooth.None,
          thickness=0.5,
          pattern=LinePattern.Dot),
        Line(
          points={{240,0},{262,0}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{342,0},{380,0},{380,240}},
          color={0,128,255},
          thickness=0.5,
          smooth=Smooth.None,
          pattern=LinePattern.Dash),
        Text(
          extent={{228,228},{406,286}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="radiator_temperature_out"),
        Rectangle(
          extent={{224,278},{422,240}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Ellipse(
          extent={{408,244},{436,272}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-264,44},{-224,12}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.CrossDiag,
          textString="cv_1",
          textStyle={TextStyle.Bold}),
        Text(
          extent={{-162,44},{-122,12}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.CrossDiag,
          textStyle={TextStyle.Bold},
          textString="cv_2"),
        Text(
          extent={{284,44},{324,12}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.CrossDiag,
          textStyle={TextStyle.Bold},
          textString="cv_n"),
        Text(
          extent={{172,52},{226,8}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.CrossDiag,
          textStyle={TextStyle.Bold},
          textString="cv_n-1"),
        Ellipse(
          extent={{-288,-6},{-276,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-208,-6},{-196,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-186,-6},{-174,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-106,-6},{-94,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{154,-6},{166,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{234,-6},{246,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{256,-6},{268,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{336,-6},{348,6}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-150,-32},{-130,-32},{-140,-52},{-150,-32}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{-250,-32},{-230,-32},{-240,-52},{-250,-32}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{188,-30},{208,-30},{198,-50},{188,-30}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{290,-30},{310,-30},{300,-50},{290,-30}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Polygon(
          points={{-40,-272},{40,-272},{0,-336},{-40,-272}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None),
        Line(
          points={{-240,-50},{-2,-240}},
          smooth=Smooth.None,
          color={255,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Text(
          extent={{-66,-240},{62,-268}},
          lineColor={255,0,0},
          pattern=LinePattern.Dot,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="radiator_qdot_out"),
        Line(
          points={{-140,-50},{-2,-240},{200,-52}},
          color={255,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{300,-50},{0,-242}},
          color={255,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Rectangle(
          extent={{-78,-240},{80,-270}},
          lineColor={255,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(
          extent={{-420,278},{-238,240}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Ellipse(
          extent={{-434,246},{-406,274}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillPattern=FillPattern.CrossDiag),
        Text(
          extent={{-390,238},{-252,282}},
          lineColor={0,128,255},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="room_temperature"),
        Line(
          points={{-240,240},{-240,40}},
          smooth=Smooth.None,
          color={0,128,255},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(
          points={{-240,240},{-140,40}},
          smooth=Smooth.None,
          color={0,128,255},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(
          points={{-238,240},{200,42}},
          smooth=Smooth.None,
          color={0,128,255},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(
          points={{-238,240},{302,42}},
          smooth=Smooth.None,
          color={0,128,255},
          pattern=LinePattern.Dot,
          thickness=0.5),
        Line(
          points={{-410,0},{-340,0},{-340,140}},
          color={0,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Rectangle(
          extent={{-378,178},{-306,140}},
          lineColor={0,255,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-394,144},{-290,174}},
          lineColor={0,255,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="mdot"),
        Line(
          points={{-306,140},{-242,40}},
          color={0,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-140,38},{-306,140},{200,42}},
          color={0,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-308,140},{306,42}},
          color={0,255,0},
          pattern=LinePattern.Dot,
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-88,114},{100,34}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5,
          fillColor={0,0,255},
          fillPattern=FillPattern.CrossDiag,
          textStyle={TextStyle.Bold},
          textString="cv_radiator")}),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics(
        Text(
          extent={{-86,62},{-46,46}},
          lineColor={0,0,0},
          textString="rad"),
        Text(
          extent={{-22,56},{60,22}},
          lineColor={0,0,0},
          textString="radiator"))=
                 {
        Text(
          extent={{-80,58},{-40,42}},
          lineColor={0,0,0},
          textString="radiator"),
        Text(
          extent={{-72,60},{-32,44}},
          lineColor={0,0,0},
          textString="inlet")}),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics));
end Radiator;
