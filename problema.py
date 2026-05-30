import streamlit as st
import pandas as pd
from amplpy import AMPL

st.title("Asignación de Analistas - Programación Entera Binaria")

ampl = AMPL()

ampl.read("asignacion.mod")
ampl.readData("asignacion.dat")

ampl.option["solver"] = "highs"

ampl.solve()

st.subheader("Valor Óptimo")

obj = ampl.getObjective("Tiempo_Total").value()

st.write(f"Tiempo mínimo total: {obj}")

x = ampl.getVariable("x")

resultados = []

for idx, val in x.getValues().toDict().items():
    if val > 0.5:
        analista, operacion = idx
        resultados.append([analista, operacion])

df = pd.DataFrame(
    resultados,
    columns=["Analista", "Operación"]
)

st.subheader("Asignaciones Óptimas")
st.dataframe(df)