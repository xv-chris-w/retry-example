make virtualtest
brew install allure
rm -rf json_folder
rm failed.txt

# start first run
behave -f allure_behave.formatter:AllureFormatter -o json_folder

# collect the a list of failed test names from the json folder 
# and write to a 'failed.txt' file
python3 get_failed_tests.py json_folder 

# rerun all failed tests and output to the same json folder
while read fail_test_name; do
  echo "retrying $fail_test_name"
  # explicitly give the test name that needs to be retried
  behave -f allure_behave.formatter:AllureFormatter -o json_folder -n "$fail_test_name"
done <failed.txt

# after all the tests are done,  generate report
allure serve json_folder
