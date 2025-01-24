
# ======================
# Private Model Template
# ======================
# Read more details at
# https://herbie.readthedocs.io/en/stable/user_guide/extend.html

# Uncomment and edit the class below, add additional classes, and edit
# the SOURCES dictionary to help Herbie locate your locally stored GRIB2
# files.

'''
class model1_name:
    def template(self):
        self.DESCRIPTION = "Local GRIB Files for model1"
        self.DETAILS = {
            "local_main": "These GRIB2 files are from a locally-stored modeling experiments."
            "local_alt": "These GRIB2 files are an alternative location for these model files."
        }

        # These PRODUCTS are optional but can provide an additional parameter to search for files.
        self.PRODUCTS = {
            "prs": "3D pressure level fields",
            "sfc": "Surface level fields",
        }

        # These are the paths to your local GRIB2 files.
        self.SOURCES = {
            "local_main": f"/path/to/your/model1/templated/with/{self.model}/gribfiles/{self.date:%Y%m%d%H}/nest{self.nest}/the_file.t{self.date:%H}z.{self.product}.f{self.fxx:02d}.grib2",
            "local_alt": f"/alternative/path/to/your/model1/templated/with/{self.model}/gribfiles/{self.date:%Y%m%d%H}/nest{self.nest}/the_file.t{self.date:%H}z.{self.product}.f{self.fxx:02d}.grib2",
        }
        self.LOCALFILE = f"{self.get_remoteFileName}"
'''
