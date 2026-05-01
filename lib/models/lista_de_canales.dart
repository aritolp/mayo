import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class listaDeCanales {
  @NowaGenerated({'loader': 'auto-constructor'})
  const listaDeCanales({
    this.id,
    this.nombre,
    this.url_stream,
    this.logo,
    this.categoria,
  });

  @NowaGenerated({'loader': 'auto-from-json'})
  factory listaDeCanales.fromJson(Map<String, dynamic> json) {
    return listaDeCanales(
      id: json['id'],
      nombre: json['nombre'],
      url_stream: json['url_stream'],
      logo: json['logo'],
      categoria: json['categoria'],
    );
  }

  final int? id;

  final String? nombre;

  final String? url_stream;

  final String? logo;

  final String? categoria;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'url_stream': url_stream,
      'logo': logo,
      'categoria': categoria,
    };
  }
}
