class Books {
  String id;
  String data;
  String? descricao;

  Books({required this.id, required this.data});

  Books.fromMap(Map<String, dynamic> map):
    id = map['id'],
    data = map['data'],
    descricao = map['descricao'];
  
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'data': data,
      'descricao': descricao,
    };
  }

}