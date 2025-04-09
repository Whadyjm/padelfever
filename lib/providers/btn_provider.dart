// Importación del paquete Flutter necesario
import 'package:flutter/cupertino.dart';

/// Provider para gestionar la visibilidad de campos de texto en la interfaz.
///
/// Este provider utiliza el patrón ChangeNotifier para manejar el estado
/// de visibilidad de dos campos de texto de forma reactiva.
class BtnProvider with ChangeNotifier {
  // Estado privado que controla la visibilidad del primer campo de texto
  bool _showTextField1 = false;

  // Estado privado que controla la visibilidad del segundo campo de texto
  bool _showTextField2 = false;

  bool _blur = true;

  /// Getter público para acceder al estado de visibilidad del primer campo
  bool get showTextField1 => _showTextField1;

  /// Getter público para acceder al estado de visibilidad del segundo campo
  bool get showTextField2 => _showTextField2;

  bool get blur => _blur;
  /// Alterna (toggle) la visibilidad del primer campo de texto
  ///
  /// Cambia el estado actual y notifica a los listeners (oyentes)
  /// para que reconstruyan la interfaz si es necesario
  void toggleTextField1() {
    _showTextField1 = !_showTextField1; // Invierte el valor actual
    notifyListeners(); // Notifica a los widgets suscritos
  }

  /// Alterna (toggle) la visibilidad del segundo campo de texto
  ///
  /// Cambia el estado actual y notifica a los listeners (oyentes)
  /// para que reconstruyan la interfaz si es necesario
  void toggleTextField2() {
    _showTextField2 = !_showTextField2; // Invierte el valor actual
    notifyListeners(); // Notifica a los widgets suscritos
  }

  void hideBlur(){
    _blur = false;
    notifyListeners();
  }
}