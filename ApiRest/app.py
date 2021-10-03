from flask import Flask,jsonify
app = Flask(__name__)
from consultas import consulta1,consulta2,consulta3,consulta4,consulta5,consulta6,consulta7,consulta8,consulta9,consulta10,eliminarTemporal,cargarTemporal,elimnarModelo

import psycopg2

#Datos para conexion a la base de datos
PSQL_HOST = "localhost"
PSQL_PORT = "5432"
PSQL_USER = "postgres"
PSQL_PASS = "X9413299x"
PSQL_DB = "db_BlockBuster"
#String conector
connection_adress = """
host=%s port=%s user=%s password=%s dbname=%s
""" % (PSQL_HOST,PSQL_PORT,PSQL_USER,PSQL_PASS,PSQL_DB)

connection = psycopg2.connect(connection_adress)
cursor =connection.cursor()

def ejecutarConsulta(consulta):
    connection = psycopg2.connect(connection_adress)
    cursor =connection.cursor()
    cursor.execute(consulta)
    respuesta = cursor.fetchall()
    cursor.close()
    connection.close()
    return respuesta

@app.route('/consulta1')
def consutla1():
    return jsonify(ejecutarConsulta(consulta1))

@app.route('/consulta2')
def consutla2():
    return jsonify(ejecutarConsulta(consulta2))

@app.route('/consulta3')
def consutla3():
    return jsonify(ejecutarConsulta(consulta3))

@app.route('/consulta4')
def consutla4():
    return jsonify(ejecutarConsulta(consulta4))

@app.route('/consulta5')
def consutla5():
    return jsonify(ejecutarConsulta(consulta5))

@app.route('/consulta6')
def consutla6():
    return jsonify(ejecutarConsulta(consulta6))

@app.route('/consulta7')
def consutla7():
    return jsonify(ejecutarConsulta(consulta7))

@app.route('/consulta8')
def consutla8():
    return jsonify(ejecutarConsulta(consulta8))

@app.route('/consulta9')
def consutla9():
    return jsonify(ejecutarConsulta(consulta9))

@app.route('/consulta10')
def consutla10():
    return jsonify(ejecutarConsulta(consulta10))


@app.route('/eliminarTemporal')
def eliminarTemporal_():
    connection = psycopg2.connect(connection_adress)
    cursor =connection.cursor()
    cursor.execute(eliminarTemporal)
    cursor.close()
    connection.close()
    return ("Datos eliminados en temporal")

@app.route('/cargarTemporal')
def cargarTemporal_():
    connection = psycopg2.connect(connection_adress)
    cursor =connection.cursor()
    cursor.execute(cargarTemporal)
    cursor.close()
    connection.close()
    return ("Datos cargados en temporal")

@app.route('/elimnarModelo')
def elimnarModelo_():
    connection = psycopg2.connect(connection_adress)
    cursor =connection.cursor()
    cursor.execute(elimnarModelo)
    cursor.close()
    connection.close()
    return ("Datos eliminados en el modelo")



@app.route('/cargarModelo')
def cargarModelo_():
    connection = psycopg2.connect(connection_adress)
    cursor =connection.cursor()
    cursor.execute(elimnarModelo)
    cursor.close()
    connection.close()
    return ("Datos cargados en el modelo")
    

if __name__ == '__main__':
 app.run(debug=True,port=4000)