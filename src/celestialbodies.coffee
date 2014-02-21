G = 6.674e-11
TWO_PI = 2 * Math.PI
HALF_PI = 0.5 * Math.PI

(exports ? this).CelestialBody = class CelestialBody
  constructor: (@mass, @radius, @siderealRotation, @orbit, @atmPressure) ->
    @gravitationalParameter = G * @mass
    @sphereOfInfluence = @orbit.semiMajorAxis * Math.pow(@mass / @orbit.referenceBody.mass, 0.4) if @orbit?
    @atmPressure ?= 0
  
  circularOrbitVelocity: (altitude) ->
    Math.sqrt(@gravitationalParameter / (altitude + @radius))
  
  siderealTimeAt: (longitude, time) ->
    result = ((time / @siderealRotation) * TWO_PI + HALF_PI + longitude) % TWO_PI
    if result < 0 then result + TWO_PI else result
  
  name: -> return k for k, v of CelestialBody when v == this
  
  children: ->
    result = {}
    result[k] = v for k, v of CelestialBody when v?.orbit?.referenceBody == this
    result

CelestialBody.fromJSON = (json) ->
  orbit = Orbit.fromJSON(json.orbit) if json.orbit?
  new CelestialBody(json.mass, json.radius, json.siderealRotation, orbit, json.atmPressure)
  
  CelestialBody.Kerbol = Kerbol = new CelestialBody(1.9891e30, 696342000, 432000, null)
  CelestialBody.Mercury_Moho = Mercury_Moho = new CelestialBody(3.3022e23, 2439700, 5067031.68, new Orbit(Kerbol, 57909100000, 0.20563, 7.005, 48.331, 29.124, 3.051))
  CelestialBody.Venus_Eve = Venus_Eve = new CelestialBody(4.8676e24, 6051800, 20996798.4, new Orbit(Kerbol, 108208000000, 0.0067, 3.39458, 76.678, 55.186, 0.875), 5)
  CelestialBody.Earth_Kerbin = Earth_Kerbin = new CelestialBody(5.97219e24, 6371000, 86164.0916, new Orbit(Kerbol, 149598261000, 0.01671123, 0, 348.73936, 114.20783, 6.24), 1)
  CelestialBody.Moon_Mun = Moon_Mun = new CelestialBody(7.34767309e22, 1737100, 2360584.6848, new Orbit(Earth_Kerbin, 384399000, 0.0549, 23.435, 0, 0, 1.7))
  CelestialBody.Mars_Duna = Mars_Duna = new CelestialBody(6.4185e23, 3396200, 88642.6848, new Orbit(Kerbol, 227939100000, 0.093315, 1.85, 49.562, 286.537, 0.338), 0.2)
  CelestialBody.Phobos_Bop = Phobos_Bop = new CelestialBody(10720000000000000, 6100, 544507.4, new Orbit(Mars_Duna, 9377200, 0.0151, 26.04, 0, 25.0, 0.9))
  CelestialBody.Deimos_Gilly = Deimos_Gilly = new CelestialBody(1480000000000000, 4200, 28255, new Orbit(Mars_Duna, 23460000, 0.0002, 27.58, 0, 10.0, 0.9))
  CelestialBody.Jupiter_Jool = Jupiter_Jool = new CelestialBody(1.8986e27, 69911000, 35730, new Orbit(Kerbol, 778547200000, 0.048775, 1.305, 100.492, 275.066, 0.328), 15)
  CelestialBody.Io_Pol = Io_Pol = new CelestialBody(8.9319e22, 1821300, 901902.62, new Orbit(Jupiter_Jool, 421800000, 0.0041, 2.21, 0, 15.0, 0.9))
  CelestialBody.Europa_Eeloo = Europa_Eeloo = new CelestialBody(4.7998e22, 1560800, 19460, new Orbit(Jupiter_Jool, 671100000, 0.009, 2.68, 0, 260.0, 3.14))
  CelestialBody.Ganymede_Tylo = Ganymede_Tylo = new CelestialBody(1.4819e23, 2634100, 211926.36, new Orbit(Jupiter_Jool, 1070400000, 0.0013, 2.41, 0, 0, 3.14))
  CelestialBody.Callisto_Ike = Callisto_Ike = new CelestialBody(1.075938e23, 2410300, 65517.862, new Orbit(Jupiter_Jool, 1882700000, 0.0074, 2.402, 0, 0, 1.7))
  CelestialBody.Saturn_Dres = Saturn_Dres = new CelestialBody(5.6846e26, 60268000, 38052, new Orbit(Kerbol, 1433449370000, 0.055723219, 2.48524, 113.642811, 336.013862, 5.591))
  CelestialBody.Titan_Laythe = Titan_Laythe = new CelestialBody(1.3452e23, 2576000, 52980.879, new Orbit(Saturn_Dres, 1221870000, 0.0288, 27.07854, 0, 0, 3.14), 2)
  CelestialBody.Uranus_Minmus = Uranus_Minmus = new CelestialBody(8.681e25, 25559000, 62063.712, new Orbit(Kerbol, 2876679082000, 0.04440558, 0.772556, 73.989821, 96.541318, 2.495))
  CelestialBody.Pluto_Vall = Pluto_Vall = new CelestialBody(1.305e22, 1153000, 551856.672, new Orbit(Kerbol, 5874000000000, 0.244671664, 17.151394, 110.28683, 113.76349, 0.259))
