{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, google-api-core
, libcst
, mock
, proto-plus
, pytest-asyncio
, pythonOlder
}:

buildPythonPackage rec {
  pname = "google-cloud-texttospeech";
  version = "2.12.3";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-gnSl/W0mTv6It//+xV5ti0Rd6io1Gh4yxd0arrbEPtQ=";
  };

  propagatedBuildInputs = [
    libcst
    google-api-core
    proto-plus
  ];

  checkInputs = [
    mock
    pytest-asyncio
    pytestCheckHook
  ];

  disabledTests = [
    # Disable tests that require credentials
    "test_list_voices"
    "test_synthesize_speech"
  ];

  pythonImportsCheck = [
    "google.cloud.texttospeech"
    "google.cloud.texttospeech_v1"
    "google.cloud.texttospeech_v1beta1"
  ];

  meta = with lib; {
    description = "Google Cloud Text-to-Speech API client library";
    homepage = "https://github.com/googleapis/python-texttospeech";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
