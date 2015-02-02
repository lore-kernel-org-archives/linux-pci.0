Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44689 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbbBBWaS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 17:30:18 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar1so20983884iec.6
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2015 14:30:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54CFBC0E.4080102@nwtrail.com>
References: <54C81B4E.7060900@nwtrail.com>
	<CAErSpo6P-gm1xFjLrbKBU+P3zUHY-RGMkhaVpWsK7vDz_wK=YQ@mail.gmail.com>
	<54CBB062.4040801@nwtrail.com>
	<CAE9FiQUxD8g4KG9CYe1znb5Lw5skkq=9QSOgkmGUDbhsaDq2Qw@mail.gmail.com>
	<54CFBC0E.4080102@nwtrail.com>
Date: Mon, 2 Feb 2015 14:30:17 -0800
Message-ID: <CAE9FiQUT5j1PDw5c0X-k_E+0TbwCdrX1nbqk8rKzxAKxRLqvEg@mail.gmail.com>
Subject: Re: [problem] mpt2sas load fails with LSISAS2008
From: Yinghai Lu <yinghai@kernel.org>
To: pjay@nwtrail.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1140c8feacf57c050e227f8c
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a1140c8feacf57c050e227f8c
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 2, 2015 at 10:03 AM, Paul Johnson <pjay@nwtrail.com> wrote:
> I applied the patch but, unfortunately, the problem is still there. dmesg is
> attached.

ok. please check attached patch that will disable auto realloc.

Thanks

Yinghai

--001a1140c8feacf57c050e227f8c
Content-Type: text/x-patch; charset=US-ASCII; name="disable_reallaoc_auto_for_lsi.patch"
Content-Disposition: attachment;
	filename="disable_reallaoc_auto_for_lsi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5ofkoxd1

U3ViamVjdDogW1BBVENIXSBQQ0k6IGRpc2FibGUgYXV0byByZWFsbG9jIGRldGVjdGlvbiBmb3Ig
bHNpIGRldmljZXMKCkxTSSBjYXJkcyBkbyBub3Qgd29yayBpZiBwY2kgY29yZSBjaGFuZ2UgcGNp
IGJhciB2YXVsZXMuCndpbGwgbmVlZCB0byBkaXNhYmxlL2VuYWJsZSBwY2llIGxpbmsgb2YgYnJp
ZGdlIG1hbnVhbGx5LgoKU28gZGlzYWJsZSBhdXRvIHJlYWxsb2MgaWYgdGhlcmUgaXMgYW55IGxz
aSBkZXZpY2Ugb24gdGhhdCBwY2kgcm9vdApidXMuCgpJZiBCSU9TIGlzIGJyb2tlbiwgc29sdXRp
b24gd291bGQgYmUgYm9vdGluZyBwY2k9cmVhbGxvYyBhbmQKMS4gY2hlY2sgd2l0aCBsc2kgdG8g
Z2V0IG5ldyBoYmEgZmlybXdhcmUgdG8gaGFuZGxlIEJBUiBjaGFuZ2luZy4KMi4gb3IgZGlzYWJs
ZS9lbmFibGUgcGNpZSBsaW5rIG1hbnVhbGx5IHRvIGdldCBmaXJtYXJlIHJlc2V0LgoKUmVwb3J0
ZWQtYnk6IFBhdWwgSm9obnNvbiA8cGpheUBud3RyYWlsLmNvbT4KQnVnemlsbGE6IGh0dHBzOi8v
YnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9OTIzNTEKU2lnbmVkLW9mZi1ieTog
WWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCiBkcml2ZXJzL3BjaS9zZXR1cC1i
dXMuYyB8ICAgMTcgKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspCgpJbmRleDogbGludXgtMi42L2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jCisrKyBsaW51eC0y
LjYvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKQEAgLTE1NDgsMTQgKzE1NDgsMzEgQEAgc3RhdGlj
IGludCBpb3ZfcmVzb3VyY2VzX3VuYXNzaWduZWQoc3RydQogCXJldHVybiAwOwogfQogCitzdGF0
aWMgaW50IHN0cmFuZ2VfZGV2X2NoZWNrKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHZvaWQgKmRhdGEp
Cit7CisJYm9vbCAqZm91bmQgPSBkYXRhOworCisJLyogTFNJIGRldmljZSBmaXJtd2FyZSBpcyBu
b3QgaGFwcHkgd2l0aCBjaGFuZ2luZyBCQVIgdmFsdWUgKi8KKwlpZiAoZGV2LT52ZW5kb3IgPT0g
UENJX1ZFTkRPUl9JRF9MU0lfTE9HSUMpIHsKKwkJKmZvdW5kID0gdHJ1ZTsKKwkJcmV0dXJuIDE7
IC8qIHJldHVybiBlYXJseSBmcm9tIHBjaV93YWxrX2J1cygpICovCisJfQorCisJcmV0dXJuIDA7
Cit9CiBzdGF0aWMgZW51bSBlbmFibGVfdHlwZSBwY2lfcmVhbGxvY19kZXRlY3Qoc3RydWN0IHBj
aV9idXMgKmJ1cywKIAkJCSBlbnVtIGVuYWJsZV90eXBlIGVuYWJsZV9sb2NhbCkKIHsKIAlib29s
IHVuYXNzaWduZWQgPSBmYWxzZTsKKwlib29sIGZvdW5kID0gZmFsc2U7CiAKIAlpZiAoZW5hYmxl
X2xvY2FsICE9IHVuZGVmaW5lZCkKIAkJcmV0dXJuIGVuYWJsZV9sb2NhbDsKIAorCXBjaV93YWxr
X2J1cyhidXMsIHN0cmFuZ2VfZGV2X2NoZWNrLCAmZm91bmQpOworCWlmIChmb3VuZCkKKwkJcmV0
dXJuIGVuYWJsZV9sb2NhbDsKKwogCXBjaV93YWxrX2J1cyhidXMsIGlvdl9yZXNvdXJjZXNfdW5h
c3NpZ25lZCwgJnVuYXNzaWduZWQpOwogCWlmICh1bmFzc2lnbmVkKQogCQlyZXR1cm4gYXV0b19l
bmFibGVkOwo=
--001a1140c8feacf57c050e227f8c--
