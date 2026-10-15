import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/calculator_result_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/converter_result_screen.dart';
import 'screens/not_found_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/calculator',
      builder: (context, state) => const CalculatorScreen(),
    ),
    GoRoute(
      path: '/calculator/result',
      builder: (context, state) {
        final q = state.uri.queryParameters;
        return CalculatorResultScreen(
          rawA: q['a'],
          rawOp: q['op'],
          rawB: q['b'],
        );
      },
    ),
    GoRoute(
      path: '/converter',
      builder: (context, state) => const ConverterScreen(),
    ),
    GoRoute(
      path: '/converter/result',
      builder: (context, state) {
        final q = state.uri.queryParameters;
        return ConverterResultScreen(
          amount: q['amount'],
          from: q['from'],
          to: q['to'],
        );
      },
    ),
  ],
  errorBuilder: (context, state) => 
      NotFoundScreen(location: state.uri.toString()),
);