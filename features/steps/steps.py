import subprocess
from behave import step

@step('I do something for test one')
def step_impl(context):
    pass


@step('I might or might not fail')
def step_impl(context):
    show_confirm_dialog("please verdict the test!")


@step(u'I do something for test two')
def step_impl(context):
    pass

def show_confirm_dialog(message: str) -> None:
    # noinspection PyPep8
    applescript = """
            set theAlertText to "Manual action required"
            set theAlertMessage to "{}"
            display alert theAlertText message theAlertMessage as critical buttons {{"Fail", "Pass"}} default button "Pass" cancel button "Fail"
            """.format(message)

    process = subprocess.run("osascript -e '{}'".format(applescript), shell=True)
    if process.returncode == 1:
        assert False, "You have failed the test!"