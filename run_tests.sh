make virtualtest
brew install allure
rm -rf json_folder

# start first run
behave -f allure_behave.formatter:AllureFormatter -o json_folder

# collect the failures from the json folder and output the name of failed tests to a 'failed.txt' file
python3 get_failed_tests.py json_folder 

# rerun all failed tests and output to the same json folder
while read fail_test_name; do
  echo "retrying $fail_test_name"
  behave -f allure_behave.formatter:AllureFormatter -o json_folder -n "$fail_test_name"
done <failed.txt

allure serve json_folder