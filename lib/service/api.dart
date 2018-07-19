import 'dart:async';

import 'package:todo/entity/entity.dart';

abstract class API<E extends Entity> {

  Future<void> addOne({E entity});

  Future<List<E>> getAll();

  Future<E> getOne({String id});
  
  Future<void> updateOne({String id, E entity});

  Future<void> deleteOne({String id});

}