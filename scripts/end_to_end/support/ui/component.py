import json

class Component:
    def __init__(self, raw):
        data = json.loads(raw)
        attrs = data['value']['Attrs']
        self.attrs = {}
        for attr in attrs:
            name = attr['Name']['Local']
            value = attr['Value']
            self.attrs[name] = value

    def name(self):
        return self.attrs['name']

    def attributes(self):
        return self.attrs.keys

    def attribute_exists(self, attr):
        return attr in self.attrs

    def attribute_value(self, attr):
        return self.attrs[attr]

    def is_visible(self):
        return 'visible' not in self.attrs