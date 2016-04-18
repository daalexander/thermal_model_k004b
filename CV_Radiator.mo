within thermal_model_k004b;
model CV_Radiator "control volume for a discretized radiator"
  /** parameter **/
  /* central parameter */
  parameter Modelica.SIunits.Conversions.NonSIunits.Temperature_degC cv_temperature_init=45.0
    "initialization of the temperature of the fluid leaving the control volume";
  outer parameter Modelica.SIunits.CoefficientOfHeatTransfer u_radiator
    "heat transfer coefficient of the radiator";
  outer parameter Modelica.SIunits.SpecificHeatCapacity cp_water
    "specific heat capacity of water";
  outer Modelica.SIunits.Mass cv_m "mass within one control volume";
  outer Modelica.SIunits.Area exchange_surface
    "surface of one control volume at which heat transfer takes place";
  /* calculated parameter*/
  //Modelica.SIunits.Energy cv_u "inner energy of the control volume";
  Modelica.SIunits.HeatFlowRate cv_qdot
    "heatflowrate over the borders of the control volume";
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC cv_temperature_out(start=cv_temperature_init, fixed=true)
    "temperature of the fluid leaving the control volume";
  /** states **/
  outer Modelica.SIunits.Conversions.NonSIunits.Temperature_degC room_temperature_cv
    "temperature within the room";
  /** controls **/
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC cv_temperature_in=inlet.t
    "temperature of the fluid streaming in the control volume";
  outer Modelica.SIunits.MassFlowRate mdot "massflowrate within the radiator";
  Temperature inlet
    annotation (Placement(transformation(extent={{-434,-12},{-414,8}}),
        iconTransformation(extent={{-434,-12},{-414,8}})));
  Temperature outlet
    annotation (Placement(transformation(extent={{408,-8},{428,12}}),
        iconTransformation(extent={{408,-8},{428,12}})));
equation
  /* calculate inner energy */
  //cv_u = cv_m * cp_water * cv_temperature_out;
  /* calculate derival of the inner energy */
   cv_m * cp_water * der(cv_temperature_out) = mdot * cp_water * (cv_temperature_in - cv_temperature_out) - cv_qdot;
  /* calculate heatflowrate */
  cv_qdot = u_radiator * exchange_surface * (cv_temperature_out - room_temperature_cv);
  /* commit calculated temperature */
  outlet.t = cv_temperature_out;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-460,
            -440},{460,440}}),
                         graphics={Rectangle(
          extent={{-418,340},{416,-330}},
          lineColor={0,0,0},
          lineThickness=1),
        Text(
          extent={{-192,422},{232,200}},
          lineColor={0,0,0},
          lineThickness=1,
          textStyle={TextStyle.Bold},
          textString="control volume - cv"),
        Text(
          extent={{-406,42},{-296,-4}},
          lineColor={0,0,255},
          lineThickness=1,
          textString="inlet.t"),
        Text(
          extent={{280,40},{390,-6}},
          lineColor={0,0,255},
          lineThickness=1,
          textString="outlet.t"),
        Polygon(
          points={{-102,-274},{98,-274},{2,-418},{-102,-274}},
          lineColor={255,0,0},
          lineThickness=1,
          smooth=Smooth.None)}),       Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-460,-440},{460,440}}), graphics));
end CV_Radiator;
