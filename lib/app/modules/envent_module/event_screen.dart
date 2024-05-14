import 'package:cached_network_image/cached_network_image.dart';
import 'package:chuva_dart/app/data/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:html/parser.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/storage/event_id_storage.dart';
import '../../models/person_model.dart';
import '../home_module/home_store.dart';

class EventScreen extends StatefulWidget {
  final EventModelTeste event;

  EventScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // String decodificarTexto(String textoCodificado) {
  //   var unescape = HtmlUnescape();
  //   return unescape.convert(textoCodificado);
  // }
  String decodificarTexto(String textoCodificado) {
    var document = parse(textoCodificado);
    return (document.outerHtml);
  }
  late bool _isFavorited;
  @override
  void initState() {
    super.initState();
    _isFavorited = context.read<EventIdStorage>().contains(widget.event.id);
  }
  @override
  Widget build(BuildContext context) {


    String startTime = DateFormat('HH:mm').format(widget.event.start);
    String endTime = DateFormat('HH:mm').format(widget.event.end);
    String obterDiaDaSemana(DateTime data) {
      // Converter a string de data para um objeto DateTime
      //  DateTime data = DateTime.parse(dataString);

      // Obter o dia da semana como um número (1 = segunda-feira, 7 = domingo)
      int diaSemana = data.weekday;

      // Mapear o número do dia da semana para o nome do dia
      switch (diaSemana) {
        case 1:
          return 'Segunda-feira';
        case 2:
          return 'Terça-feira';
        case 3:
          return 'Quarta-feira';
        case 4:
          return 'Quinta-feira';
        case 5:
          return 'Sexta-feira';
        case 6:
          return 'Sábado';
        case 7:
          return 'Domingo';
        default:
          return '';
      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Color(0xff456189),
        title: Column(children: [
          const Text(
            'Chuva 💜 Flutter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
      ),
      body: SingleChildScrollView(
        child: Column(

       //   crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: double.infinity,
              color: widget.event.category['color'] != null
                  ? getColorFromCss(widget.event.category['color'])
                  : Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.event.category["title"]["pt-br"],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              widget.event.title["pt-br"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: Color(0xff306DC3),
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      '${obterDiaDaSemana(widget.event.start)} ${startTime}h - ${endTime}h'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Color(0xff306DC3),
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.event.locations[0]["title"]["pt-br"]),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async{
                  final eventIdStorage = context.read<EventIdStorage>();
                  if (_isFavorited) {
                    await eventIdStorage.removeIdEvent(widget.event.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Não vamos mais te lembrar dessa atividade.'),
                      ),
                    );
                  } else {
                   await eventIdStorage.addIdEvent(widget.event.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Vamos te lembrar dessa atividade.'),
                      ),
                    );
                  }
                  setState(() {
                    _isFavorited = !_isFavorited;
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xff306DC3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isFavorited ? Icons.star_border : Icons.star,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _isFavorited
                            ? 'Remover da sua agenda'
                            : 'Adicionar a sua agenda',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),

            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.event.description["pt-br"] ??  'Descrição não disponível'),
            ),
            //Text(Html(data:widget.event.description["pt-br"]) as String),
            SizedBox(
              height: 40,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text( widget.event.people.isNotEmpty ?
                   widget.event.people[0]["role"]["label"]["pt-br"] : ''  ,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              visible: widget.event.people.isNotEmpty,
              child: Column(
                children: widget.event.people.map((person) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: InkWell(
                      onTap: (){
                        context.pushNamed('/people',extra: Person(bio: person["bio"],name: person["name"],institution: person["institution"],picture: person["picture"]));
                      },
                      child: Row(
                        children: [

                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            backgroundImage: person['picture'] != null
                                ? CachedNetworkImageProvider(person['picture'])
                                : null,
                            child: person['picture'] == null
                                ? Icon(Icons.person, size: 30)
                                : null,
                          ),

                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person['name'] ?? '',
                                style: TextStyle(

                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                person['institution'] ?? '',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
