Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <5551312.D3H9D4JOFc@vostro.rjw.lan>
 <201609280023.31987.linux@rainbow-software.org>
 <4220489.2ZUOL1U5cK@vostro.rjw.lan>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d3fd8f7a-520d-d204-87d8-e9f59fb8f180@codeaurora.org>
Date: Tue, 27 Sep 2016 19:06:12 -0400
MIME-Version: 1.0
In-Reply-To: <4220489.2ZUOL1U5cK@vostro.rjw.lan>
Content-Type: multipart/mixed;
 boundary="------------0171856AC59ED07213AF7069"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------0171856AC59ED07213AF7069
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 9/27/2016 6:58 PM, Rafael J. Wysocki wrote:
>> :040000 040000 9bf16c388d23bb66e087809f069eafed18e46a8c bcac95fb33ee834aec7d23eab9eb0dc5e330c68c M      drivers
> OK
> 
> Sinan, can you help, please?
> 
> 

Sure, let's see what's going on. I was writing an email. 

Can we apply this and collect the kernel log? It also helps to see the kernel log from a working
combination.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------0171856AC59ED07213AF7069
Content-Type: text/plain; charset=UTF-8;
 name="0001-acpi-pci_link-debug-aids.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-acpi-pci_link-debug-aids.patch"

RnJvbSA5MTgxZjRiOWFiNDA1YmM2Yzk0MTIxMzNhZWZlZjc2NzY4OTk3MzNjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW5hbiBLYXlhIDxva2F5YUBjb2RlYXVyb3JhLm9y
Zz4KRGF0ZTogVHVlLCAyNyBTZXAgMjAxNiAxODozNToxNSAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIGFjcGk6IHBjaV9saW5rOiBkZWJ1ZyBhaWRzCgpDaGFuZ2UtSWQ6IEk2YzQ1OWNiNTg4
OGQ5NWY1ZjFlZjdjMGUyZjEzOGZiOWM2NWY0MGU1Ci0tLQogZHJpdmVycy9hY3BpL3BjaV9s
aW5rLmMgfCAxMyArKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYWNwaS9wY2lfbGlu
ay5jIGIvZHJpdmVycy9hY3BpL3BjaV9saW5rLmMKaW5kZXggYzk4M2JmNy4uNDQ5MzdmOTMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9wY2lfbGluay5jCisrKyBiL2RyaXZlcnMvYWNw
aS9wY2lfbGluay5jCkBAIC01MDgsNiArNTA4LDggQEAgc3RhdGljIGludCBhY3BpX2lycV9n
ZXRfcGVuYWx0eShpbnQgaXJxKQogCQkJcGVuYWx0eSArPSBQSVJRX1BFTkFMVFlfSVNBX0FM
V0FZUzsKIAkJZWxzZQogCQkJcGVuYWx0eSArPSBQSVJRX1BFTkFMVFlfUENJX1VTSU5HOwor
CisJCXByX2luZm8oIiVzOiVkIGFkZGluZyBTQ0kgcGVuYWx0eTogJWRcbiIsIF9fZnVuY19f
LCBfX0xJTkVfXywgcGVuYWx0eSk7CiAJfQogCiAJaWYgKGlycSA8IEFDUElfTUFYX0lTQV9J
UlFTKQpAQCAtNjA0LDYgKzYwNiwxMiBAQCBzdGF0aWMgaW50IGFjcGlfcGNpX2xpbmtfYWxs
b2NhdGUoc3RydWN0IGFjcGlfcGNpX2xpbmsgKmxpbmspCiAJCX0KIAl9CiAJaWYgKGFjcGlf
aXJxX2dldF9wZW5hbHR5KGlycSkgPj0gUElSUV9QRU5BTFRZX0lTQV9BTFdBWVMpIHsKKwkJ
Zm9yIChpID0gKGxpbmstPmlycS5wb3NzaWJsZV9jb3VudCAtIDEpOyBpID49IDA7IGktLSkg
eworCQkJcHJfaW5mbygicGVuYWx0eVslZF0gPSAweCV4XG4iLAorCQkJCQlsaW5rLT5pcnEu
cG9zc2libGVbaV0sCisJCQkgICAgYWNwaV9pcnFfZ2V0X3BlbmFsdHkobGluay0+aXJxLnBv
c3NpYmxlW2ldKSk7CisJCX0KKwogCQlwcmludGsoS0VSTl9FUlIgUFJFRklYICJObyBJUlEg
YXZhaWxhYmxlIGZvciAlcyBbJXNdLiAiCiAJCQkgICAgIlRyeSBwY2k9bm9hY3BpIG9yIGFj
cGk9b2ZmXG4iLAogCQkJICAgIGFjcGlfZGV2aWNlX25hbWUobGluay0+ZGV2aWNlKSwKQEAg
LTg3MCw5ICs4NzgsMTIgQEAgc3RhdGljIGludCBfX2luaXQgYWNwaV9pcnFfcGVuYWx0eV91
cGRhdGUoY2hhciAqc3RyLCBpbnQgdXNlZCkKICAqLwogdm9pZCBhY3BpX3BlbmFsaXplX2lz
YV9pcnEoaW50IGlycSwgaW50IGFjdGl2ZSkKIHsKLQlpZiAoKGlycSA+PSAwKSAmJiAoaXJx
IDwgQVJSQVlfU0laRShhY3BpX2lzYV9pcnFfcGVuYWx0eSkpKQorCWlmICgoaXJxID49IDAp
ICYmIChpcnEgPCBBUlJBWV9TSVpFKGFjcGlfaXNhX2lycV9wZW5hbHR5KSkpIHsKIAkJYWNw
aV9pc2FfaXJxX3BlbmFsdHlbaXJxXSA9IGFjcGlfaXJxX2dldF9wZW5hbHR5KGlycSkgKwog
CQkgIChhY3RpdmUgPyBQSVJRX1BFTkFMVFlfSVNBX1VTRUQgOiBQSVJRX1BFTkFMVFlfUENJ
X1VTSU5HKTsKKwkJcHJfaW5mbygiJXM6JWQgYWNwaV9pc2FfaXJxX3BlbmFsdHlbJWRdPTB4
JXggYWN0aXZlID0gJWRcbiIsIF9fZnVuY19fLAorCQkJCV9fTElORV9fLCBpcnEsICBhY3Bp
X2lycV9nZXRfcGVuYWx0eShpcnEpLCBhY3RpdmUpOworCX0KIH0KIAogYm9vbCBhY3BpX2lz
YV9pcnFfYXZhaWxhYmxlKGludCBpcnEpCi0tIAoxLjkuMQoK
--------------0171856AC59ED07213AF7069--
