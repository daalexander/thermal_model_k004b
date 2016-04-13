within thermal_model_k004b;
connector MassTemperature
  Modelica.SIunits.Conversions.NonSIunits.Temperature_degC t;
  Modelica.SIunits.MassFlowRate mdot;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Ellipse(
          extent={{98,-98},{-98,98}},
          lineColor={0,255,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.CrossDiag,
          lineThickness=1)}));
end MassTemperature;
