import 'dart:io';
import 'dart:math';

void main() {
  // Definicion Variables
  int opcion = 0;
  int exposicion;
  int indice;
  int estudiantes;
  int cantidadEstudiantes;
  int indiceEstudiante;
  int indiceBorrar;
  int index;
  int opcionDificultad;
  int expoIndex;
  int estIndex;
  String dificultad;
  String nombreExposicion;
  String respuesta;
  String? nomExp;
  String? nuevoNombre;
  String? nombreCompleto;
  String? nuevoNombreEstudiante;
  String? estudianteBorrado;
  String? estudianteAsignado;
  List<Map<String, dynamic>> expoNew = [];
  List<String?> estNew = [];
  Map<String, List<String?>> asignaciones = {};

  List<String?> adso = [
    "ANDRES FELIPE SANCHEZ HURTADO",
    "ANGIE DAHIANA RIOS QUINTERO",
    "CRISTIAN ALVAREZ ARANZAZU",
    "DANIEL ESTIVEN ARBOLEDA DUQUE",
    "DAVID ANDRES MORALES GUAPACHA",
    "DAVID STIVEN OCAMPO LONDOÑO",
    "ESTEBAN REYES AGUDELO",
    "JACOBO GALVIS JIMENEZ",
    "JAIME ANDRES CALLE SALAZAR",
    "JEFERSON MAURICIO HERNANDEZ LADINO",
    "JHON ALEXANDER PINEDA OSORIO",
    "JOSE MIGUEL SIERRA ARISTIZABAL",
    "JOSÉ SEBASTIÁN OCAMPO LÓPEZ",
    "JUAN ANDRES OSORIO GOMEZ",
    "JUAN DIEGO CALVO OSORIO",
    "JUAN ESTEBAN LOPEZ CALLE",
    "JUAN PABLO RIOS ARISTIZABAL",
    "MARIA PAULA MELO SOLANO",
    "MIGUEL ANGEL PEÑA JIMENEZ",
    "SAMUEL CASTAÑO CARDONA",
    "JUAN JOSÉ POSADA PÉREZ",
    "ALEJANDRO SERNA LONDOÑO",
    "JUAN MANUEL ZULUAGA RINCON",
    "JUAN DANIEL GOMEZ LASERNA",
    "YERSON STIVEN HERRERA OBANDO",
    "MATEO HERRERA VARGAS",
    "ALEJANDRO VALLEJO ESCOBAR",
  ];

  List<Map<String, dynamic>> temasAdso = [
    {
      "nombre": "¿Que es POO y cuales son sus caracteristicas principales?",
      "limite": 3
    },
    {
      "nombre": "¿Diferencia entre POO y programacion estructurada?",
      "limite": 3
    },
    {
      "nombre": "¿Que es un objeto, clase y diferencia entre ambos?",
      "limite": 3
    },
    {"nombre": "¿Que es abstraccion?", "limite": 3},
    {"nombre": "Que es encapsulamiento?", "limite": 3},
    {"nombre": "¿Que es herencia?", "limite": 4},
    {"nombre": "¿Que es polimorfismo y un ejemplo?", "limite": 4},
    {"nombre": "Principales diagramas de UML", "limite": 4},
  ];

  // Inicializar menu principal
  do {
    print("---------Menu Principal---------");
    print("1. Gestion de exposiciones ");
    print("2. Gestion de estudiantes ");
    print("3. Asignar estudiantes a temas");
    print("4. Precargar datos");
    print("5. Salir");
    opcion = int.parse(stdin.readLineSync()!);

    switch (opcion) {
      case 1:
        // Gestion de exposiciones
        do {
          print("*" * 30);
          print("1. Crear Exposicion");
          print("2. Editar Exposicion");
          print("3. Borrar Exposicion");
          print("4. Regresar");
          exposicion = int.parse(stdin.readLineSync()!);

          if (exposicion == 1) {
            print("Ingresa el nombre de la exposicion");
            nomExp = stdin.readLineSync()!;

            do {
              print("Seleccione la dificultad de la exposición:");
              print("1. Fácil");
              print("2. Intermedio");
              print("3. Difícil");
              opcionDificultad = int.parse(stdin.readLineSync()!);

              switch (opcionDificultad) {
                case 1:
                  dificultad = "Fácil";
                  break;
                case 2:
                  dificultad = "Intermedio";
                  break;
                case 3:
                  dificultad = "Difícil";
                  break;
                default:
                  dificultad = "";
                  print("Opción no válida. Por favor, seleccione 1, 2 o 3.");
              }
            } while (dificultad.isEmpty);

            print("Ingrese la cantidad de estudiantes para esta exposición:");
            cantidadEstudiantes = int.parse(stdin.readLineSync()!);

            Map<String, dynamic> nuevaExposicion = {
              'nombre': nomExp,
              'dificultad': dificultad,
              'cantidadEstudiantes': cantidadEstudiantes
            };

            expoNew.add(nuevaExposicion);
            asignaciones[nomExp] = [];
            print("Exposición creada exitosamente");
            print("Nombre: ${nuevaExposicion['nombre']}");
            print("Dificultad: ${nuevaExposicion['dificultad']}");
            print(
                "Cantidad de estudiantes: ${nuevaExposicion['cantidadEstudiantes']}");
          }

          if (exposicion == 2) {
            if (expoNew.isEmpty) {
              print("No hay exposiciones para editar.");
            } else {
              print("Exposiciones disponibles:");
              for (int i = 0; i < expoNew.length; i++) {
                print(
                    "${i + 1}. ${expoNew[i]['nombre']} (${expoNew[i]['dificultad']}, ${expoNew[i]['cantidadEstudiantes']} estudiantes)");
              }
              print("¿Cuál desea editar? (Ingrese el número)");
              indice = int.parse(stdin.readLineSync()!) - 1;

              if (indice >= 0 && indice < expoNew.length) {
                print("La exposición actual es: ${expoNew[indice]['nombre']}");
                print("Ingrese el nuevo nombre para la exposición:");
                nuevoNombre = stdin.readLineSync();

                if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
                  asignaciones[nuevoNombre] =
                      asignaciones[expoNew[indice]['nombre']]!;
                  asignaciones.remove(expoNew[indice]['nombre']);

                  expoNew[indice]['nombre'] = nuevoNombre;
                  print("Exposición editada exitosamente.");
                } else {
                  print(
                      "El nombre no puede estar vacío. No se realizaron cambios.");
                }
              } else {
                print("Número inválido. No se pudo editar la exposición.");
              }
            }
          }

          if (exposicion == 3) {
            if (expoNew.isEmpty) {
              print("No hay exposiciones para borrar.");
            } else {
              print("Exposiciones disponibles:");
              for (int i = 0; i < expoNew.length; i++) {
                print(
                    "${i + 1}. ${expoNew[i]['nombre']} (${expoNew[i]['dificultad']}, ${expoNew[i]['cantidadEstudiantes']} estudiantes)");
              }
              print("¿Qué exposición desea borrar? (Ingrese el número)");
              indiceBorrar = int.parse(stdin.readLineSync()!) - 1;

              if (indiceBorrar >= 0 && indiceBorrar < expoNew.length) {
                Map<String, dynamic> exposicionBorrada =
                    expoNew.removeAt(indiceBorrar);
                asignaciones.remove(exposicionBorrada['nombre']);
                print(
                    "La exposición '${exposicionBorrada['nombre']}' ha sido borrada exitosamente.");
                print("Lista actualizada de exposiciones:");
                if (expoNew.isEmpty) {
                  print("No hay exposiciones.");
                } else {
                  for (int i = 0; i < expoNew.length; i++) {
                    print(
                        "${i + 1}. ${expoNew[i]['nombre']} (${expoNew[i]['dificultad']}, ${expoNew[i]['cantidadEstudiantes']} estudiantes)");
                  }
                }
              } else {
                print("Número inválido. No se pudo borrar la exposición.");
              }
            }
          }
        } while (exposicion != 4);
        break;

      case 2:
        // Gestion de estudiantes
        do {
          print("*" * 30);
          print("1. Editar estudiantes");
          print("2. Ingresar estudiantes");
          print("3. Borrar estudiantes");
          print("4. Regresar");
          estudiantes = int.parse(stdin.readLineSync()!);

          if (estudiantes == 1) {
            if (estNew.isEmpty) {
              print("No hay estudiantes para editar.");
            } else {
              print("Estudiantes disponibles:");
              for (int i = 0; i < estNew.length; i++) {
                print("${i + 1}. ${estNew[i]}");
              }
              print("¿Cuál estudiante desea editar? (Ingrese el número)");
              indiceEstudiante = int.parse(stdin.readLineSync()!) - 1;

              if (indiceEstudiante >= 0 && indiceEstudiante < estNew.length) {
                print(
                    "El nombre actual del estudiante es: ${estNew[indiceEstudiante]}");
                print("Ingrese el nuevo nombre para el estudiante:");
                nuevoNombreEstudiante = stdin.readLineSync();

                if (nuevoNombreEstudiante != null &&
                    nuevoNombreEstudiante.isNotEmpty) {
                  for (var tema in asignaciones.keys) {
                    index =
                        asignaciones[tema]!.indexOf(estNew[indiceEstudiante]);
                    if (index != -1) {
                      asignaciones[tema]![index] = nuevoNombreEstudiante;
                    }
                  }

                  estNew[indiceEstudiante] = nuevoNombreEstudiante;
                  print("Nombre del estudiante editado exitosamente.");
                  print(estNew);
                } else {
                  print(
                      "El nombre no puede estar vacío. No se realizaron cambios.");
                }
              } else {
                print("Número inválido. No se pudo editar el estudiante.");
              }
            }
          }

          if (estudiantes == 2) {
            print('Ingrese la cantidad de estudiantes a registrar:');
            cantidadEstudiantes = int.parse(stdin.readLineSync()!);

            for (int i = 0; i < cantidadEstudiantes; i++) {
              print('Ingrese el nombre completo del estudiante ${i + 1}:');
              nombreCompleto = stdin.readLineSync()!;
              estNew.add(nombreCompleto);
            }
            print("Estudiantes actuales: ");
            print(estNew);
          }

          if (estudiantes == 3) {
            if (estNew.isEmpty) {
              print("No hay estudiantes para borrar.");
            } else {
              print("Estudiantes disponibles:");
              for (int i = 0; i < estNew.length; i++) {
                print("${i + 1}. ${estNew[i]}");
              }
              print("¿Qué estudiante desea borrar? (Ingrese el número)");
              indiceBorrar = int.parse(stdin.readLineSync()!) - 1;

              if (indiceBorrar >= 0 && indiceBorrar < estNew.length) {
                estudianteBorrado = estNew.removeAt(indiceBorrar);

                for (var tema in asignaciones.keys) {
                  asignaciones[tema]!.remove(estudianteBorrado);
                }

                print(
                    "El estudiante '${estudianteBorrado}' ha sido borrado exitosamente.");
                print("Lista actualizada de estudiantes:");
                for (int i = 0; i < estNew.length; i++) {
                  print("${i + 1}. ${estNew[i]}");
                }
              } else {
                print("Número inválido. No se pudo borrar el estudiante.");
              }
            }
          }
        } while (estudiantes != 4);
        break;

      case 3:
        if (expoNew.isEmpty) {
          print(
              "No hay exposiciones para asignar estudiantes. Por favor, cree exposiciones primero.");
        } else {
          print("1. Asignar estudiantes manualmente");
          print("2. Asignar estudiantes aleatoriamente");
          print("3. Reasignar todos los estudiantes aleatoriamente");
          print("Seleccione una opción:");
          int opcionAsignacion = int.parse(stdin.readLineSync()!);

          switch (opcionAsignacion) {
            case 1:
              // Asignación manual (código existente)
              List<String?> estudiantesSinAsignar = estNew
                  .where((estudiante) => !asignaciones.values
                      .any((lista) => lista.contains(estudiante)))
                  .toList();
              print("Asignaciones actuales:");
              asignaciones.forEach((tema, estudiantes) {
                print(
                    "$tema (${estudiantes.length}/${expoNew.firstWhere((expo) => expo['nombre'] == tema)['cantidadEstudiantes']}): ${estudiantes.join(', ')}");
              });

              if (estudiantesSinAsignar.isEmpty) {
                print(
                    "No hay estudiantes disponibles para asignar. Por favor, ingrese estudiantes primero.");
              } else {
                print("Estudiantes sin asignar:");
                for (int i = 0; i < estudiantesSinAsignar.length; i++) {
                  print("${i + 1}. ${estudiantesSinAsignar[i]}");
                }

                print("Exposiciones disponibles:");
                for (int i = 0; i < expoNew.length; i++) {
                  print(
                      "${i + 1}. ${expoNew[i]['nombre']} (${asignaciones[expoNew[i]['nombre']]!.length}/${expoNew[i]['cantidadEstudiantes']})");
                }
                print(
                    "Seleccione el número de la exposición para asignar un estudiante:");
                expoIndex = int.parse(stdin.readLineSync()!) - 1;

                if (expoIndex >= 0 && expoIndex < expoNew.length) {
                  nombreExposicion = expoNew[expoIndex]['nombre'];

                  print("Estudiantes disponibles:");
                  for (int i = 0; i < estudiantesSinAsignar.length; i++) {
                    print("${i + 1}. ${estudiantesSinAsignar[i]}");
                  }
                  print("Seleccione el número del estudiante a asignar:");
                  estIndex = int.parse(stdin.readLineSync()!) - 1;

                  if (estIndex >= 0 &&
                      estIndex < estudiantesSinAsignar.length) {
                    estudianteAsignado = estudiantesSinAsignar[estIndex];

                    if (asignaciones[nombreExposicion]!.length >=
                        expoNew[expoIndex]['cantidadEstudiantes']) {
                      print(
                          "La exposición está al tope. ¿Desea aumentar el límite y agregar al estudiante? (s/n)");
                      respuesta = stdin.readLineSync()!.toLowerCase();
                      if (respuesta == 's') {
                        expoNew[expoIndex]['cantidadEstudiantes']++;
                        print(
                            "Límite aumentado. Nuevo límite: ${expoNew[expoIndex]['cantidadEstudiantes']}");
                      } else {
                        print("Operación cancelada.");
                        return;
                      }
                    }

                    asignaciones[nombreExposicion]!.add(estudianteAsignado);
                    estudiantesSinAsignar.removeAt(estIndex);
                    print("Estudiante asignado exitosamente.");
                    print(
                        "Estudiantes en ${nombreExposicion}: ${asignaciones[nombreExposicion]!.length}/${expoNew[expoIndex]['cantidadEstudiantes']}");
                  } else {
                    print("Número de estudiante inválido.");
                  }
                } else {
                  print("Número de exposición inválido.");
                }
              }
              break;
            case 2:
            case 3:
              // Asignación aleatoria o reasignación de todos los estudiantes
              List<String?> estudiantesDisponibles = [];

              if (opcionAsignacion == 3) {
                // Desasigna todos los estudiantes si se elige reasignar
                asignaciones.forEach((tema, estudiantes) {
                  estudiantesDisponibles.addAll(estudiantes);
                  estudiantes.clear();
                });
              } else {
                // Para la opción 2, usa los estudiantes no asignados
                estudiantesDisponibles = estNew
                    .where((estudiante) => !asignaciones.values
                        .any((lista) => lista.contains(estudiante)))
                    .toList();
              }

              Random random = Random();

              // Mezcla la lista de estudiantes aleatoriamente
              estudiantesDisponibles.shuffle(random);

              // Asigna estudiantes a las exposiciones
              for (var expo in expoNew) {
                while (asignaciones[expo['nombre']]!.length <
                        expo['cantidadEstudiantes'] &&
                    estudiantesDisponibles.isNotEmpty) {
                  String? estudianteAsignado =
                      estudiantesDisponibles.removeAt(0);
                  asignaciones[expo['nombre']]!.add(estudianteAsignado);
                }
              }

              // Actualiza estNew si se realizó una reasignación completa
              if (opcionAsignacion == 3) {
                estNew = List.from(estudiantesDisponibles);
                estudiantesDisponibles.forEach((estudiante) {
                  if (!estNew.contains(estudiante)) {
                    estNew.add(estudiante);
                  }
                });
              }

              // Muestra las asignaciones realizadas
              print("Estudiantes asignados aleatoriamente:");
              asignaciones.forEach((tema, estudiantes) {
                print(
                    "$tema (${estudiantes.length}/${expoNew.firstWhere((expo) => expo['nombre'] == tema)['cantidadEstudiantes']}): ${estudiantes.join(', ')}");
              });

              // Muestra los estudiantes que quedaron sin asignar, si los hay
              if (estudiantesDisponibles.isNotEmpty) {
                print("Estudiantes que quedaron sin asignar:");
                print(estudiantesDisponibles.join(', '));
              }
              break;
          }
        }
        break;

      case 4:
        // Precargar datos
        // Limpiar datos existentes
        expoNew.clear();
        asignaciones.clear();

        // Precargar exposiciones
        for (var tema in temasAdso) {
          Map<String, dynamic> nuevaExposicion = {
            'nombre': tema['nombre'],
            'dificultad': 'No especificada',
            'cantidadEstudiantes': tema['limite']
          };
          expoNew.add(nuevaExposicion);
          asignaciones[tema['nombre']] = [];
        }

        // Asignar estudiantes al azar
        List<String?> estudiantesSinAsignar = List.from(adso);
        Random random = Random();

        for (var expo in expoNew) {
          while (asignaciones[expo['nombre']]!.length < expo['cantidadEstudiantes'] && estudiantesSinAsignar.isNotEmpty) {
            indiceEstudiante = random.nextInt(estudiantesSinAsignar.length);
            estudianteAsignado = estudiantesSinAsignar.removeAt(indiceEstudiante);
            asignaciones[expo['nombre']]!.add(estudianteAsignado);
          }
        }

        print("Datos precargados y estudiantes asignados aleatoriamente:");
        asignaciones.forEach((tema, estudiantes) {
          print("$tema (${estudiantes.length}/${expoNew.firstWhere((expo) => expo['nombre'] == tema)['cantidadEstudiantes']}): ${estudiantes.join(', ')}");
        });

        if (estudiantesSinAsignar.isNotEmpty) {
          print("Estudiantes que quedaron sin asignar:");
          print(estudiantesSinAsignar.join(', '));
        }
        break;

      case 5:
        print("Gracias por usar nuestro proyecto");
        break;

      default:
        print("Opción no válida. Por favor, seleccione una opción del menú.");
        break;
    }
  } while (opcion != 5);
}
