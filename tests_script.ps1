flutter test --coverage
flutter pub run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r 'ui'
perl C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml -o coverage\html coverage\lcov.info