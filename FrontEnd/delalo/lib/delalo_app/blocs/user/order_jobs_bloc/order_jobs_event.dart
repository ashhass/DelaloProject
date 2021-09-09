import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class AcceptJob extends OrderEvent {
  final String order_id;
  const AcceptJob(this.order_id);

  @override
  List<Object> get props => [];
}

class DeclineJob extends OrderEvent {
  final String order_id;
  const DeclineJob(this.order_id);

  @override
  List<Object> get props => [];
}

class OrdersLoad extends OrderEvent {
  const OrdersLoad();

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {
  final String seeker_id;
  const OrderLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class ProviderJobStatus extends OrderEvent {
  final String provider_id;
  const ProviderJobStatus(this.provider_id);

  @override
  List<Object> get props => [];
}

class OrderCreate extends OrderEvent {
  final Order order;

  const OrderCreate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Created {order: $order}';
}

class OrderUpdate extends OrderEvent {
  final Order order;

  const OrderUpdate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Updated {order: $order}';
}

class OrderDelete extends OrderEvent {
  final Order order;

  const OrderDelete(this.order);

  @override
  List<Object> get props => [order];

  @override
  toString() => 'Order Deleted {order: $order}';
}
