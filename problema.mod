set ANALISTAS;
set OPERACIONES;

param tiempo {ANALISTAS, OPERACIONES};

param permitido {ANALISTAS, OPERACIONES} binary;

var x {ANALISTAS, OPERACIONES} binary;

minimize Tiempo_Total:
    sum {a in ANALISTAS, o in OPERACIONES}
        tiempo[a,o] * x[a,o];

# Cada operación debe asignarse a un único analista
subject to Operacion_Unica {o in OPERACIONES}:
    sum {a in ANALISTAS} x[a,o] = 1;

# Cada analista realiza exactamente una operación
subject to Analista_Unico {a in ANALISTAS}:
    sum {o in OPERACIONES} x[a,o] = 1;

# Restricciones de compliance
subject to Compliance {a in ANALISTAS, o in OPERACIONES}:
    x[a,o] <= permitido[a,o];