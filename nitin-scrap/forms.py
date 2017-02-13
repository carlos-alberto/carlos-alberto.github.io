from flask_wtf import Form

from wtforms import StringField
from wtforms.validators import DataRequired


class ScrapForm(Form):
    project = StringField(validators=[DataRequired()])
    part = StringField(validators=[DataRequired()])
    tool = StringField(validators=[DataRequired()])
    reason = StringField(validators=[DataRequired()])
