tilt_prop = "PER3_12x38SF.dat";
[tilt_rpm,tilt_data] = readData(tilt_prop);
prop.rpm = tilt_rpm;
prop.data = tilt_data;
prop.prop = tilt_prop;