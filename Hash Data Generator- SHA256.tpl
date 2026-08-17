___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Hash Data Generator- SHA256",
  "description": "Generate SHA256 from your plain text.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "text",
    "displayName": "Text Input",
    "simpleValueType": true,
    "alwaysInSummary": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const makeString = require('makeString');
const Math = require('Math');
if (!data.text) return;

function sha256(input) {
  input = makeString(input);

  var K = [
    1116352408,1899447441,-1245643825,-373957723,
    961987163,1508970993,-1841331548,-1424204075,
    -670586216,310598401,607225278,1426881987,
    1925078388,-2132889090,-1680079193,-1046744716,
    -459576895,-272742522,264347078,604807628,
    770255983,1249150122,1555081692,1996064986,
    -1740746414,-1473132947,-1341970488,-1084653625,
    -958395405,-710438585,113926993,338241895,
    666307205,773529912,1294757372,1396182291,
    1695183700,1986661051,-2117940946,-1838011259,
    -1564481375,-1474664885,-1035236496,-949202525,
    -778901479,-694614492,-200395387,275423344,
    430227734,506948616,659060556,883997877,
    958139571,1322822218,1537002063,1747873779,
    1955562222,2024104815,-2067236844,-1933114872,
    -1866530822,-1538233109,-1090935817,-965641998
  ];

  var H = [
    1779033703,-1150833019,1013904242,-1521486534,
    1359893119,-1694144372,528734635,1541459225
  ];

  var chars =
    ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

  var bytes = [];
  var i, j, code;

  /* Convert ASCII characters to bytes */
  for (i = 0; i < input.length; i++) {
    code = chars.indexOf(input.charAt(i));
    bytes.push(code < 0 ? 0 : code + 32);
  }

  /* SHA-256 padding */
  bytes.push(128);

  while (bytes.length % 64 !== 56) {
    bytes.push(0);
  }

  var bits = input.length * 8;

  for (i = 7; i >= 0; i--) {
    bytes.push(
      (bits / Math.pow(2, i * 8)) & 255
    );
  }

  /* Process 512-bit blocks */
  for (i = 0; i < bytes.length; i += 64) {

    var w = [];

    for (j = 0; j < 16; j++) {
      w[j] =
        (bytes[i + j * 4] << 24) |
        (bytes[i + j * 4 + 1] << 16) |
        (bytes[i + j * 4 + 2] << 8) |
        bytes[i + j * 4 + 3];
    }

    for (j = 16; j < 64; j++) {
      var x = w[j - 15];
      var y = w[j - 2];

      w[j] = (
        (
          ((x >>> 7) | (x << 25)) ^
          ((x >>> 18) | (x << 14)) ^
          (x >>> 3)
        ) +
        w[j - 16] +
        (
          ((y >>> 17) | (y << 15)) ^
          ((y >>> 19) | (y << 13)) ^
          (y >>> 10)
        ) +
        w[j - 7]
      ) | 0;
    }

    var a = H[0];
    var b = H[1];
    var c = H[2];
    var d = H[3];
    var e = H[4];
    var f = H[5];
    var g = H[6];
    var h = H[7];

    var t1, t2;

    for (j = 0; j < 64; j++) {

      t1 = (
        h +
        (
          ((e >>> 6) | (e << 26)) ^
          ((e >>> 11) | (e << 21)) ^
          ((e >>> 25) | (e << 7))
        ) +
        ((e & f) ^ (~e & g)) +
        K[j] +
        w[j]
      ) | 0;

      t2 = (
        (
          ((a >>> 2) | (a << 30)) ^
          ((a >>> 13) | (a << 19)) ^
          ((a >>> 22) | (a << 10))
        ) +
        ((a & b) ^ (a & c) ^ (b & c))
      ) | 0;

      h = g;
      g = f;
      f = e;
      e = (d + t1) | 0;
      d = c;
      c = b;
      b = a;
      a = (t1 + t2) | 0;
    }

    H[0] = (H[0] + a) | 0;
    H[1] = (H[1] + b) | 0;
    H[2] = (H[2] + c) | 0;
    H[3] = (H[3] + d) | 0;
    H[4] = (H[4] + e) | 0;
    H[5] = (H[5] + f) | 0;
    H[6] = (H[6] + g) | 0;
    H[7] = (H[7] + h) | 0;
  }

  var result = '';

  for (i = 0; i < 8; i++) {
    result += (
      '00000000' +
      (H[i] >>> 0).toString(16)
    ).slice(-8);
  }

  return result;
}

return sha256(data.text);


___TESTS___

scenarios: []


___NOTES___

Created on 8/17/2026, 3:57:27 PM


