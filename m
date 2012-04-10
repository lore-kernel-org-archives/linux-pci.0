Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33372 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab2DJUpy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 16:45:54 -0400
Received: by dake40 with SMTP id e40so228941dak.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 13:45:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1334089568.4083.2.camel@Nokia-N900>
References: <1333968563.5678.19.camel@infinity>
	<CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com>
	<4F84110E.3000400@snewbury.org.uk>
	<CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com>
	<4F8467AA.90305@snewbury.org.uk>
	<CAE9FiQWaop0NE7ZJu6jVW3SnxLkOJ9hRKh4xMNk64XjCAMRMMw@mail.gmail.com>
	<4F848357.3060007@snewbury.org.uk>
	<CAE9FiQXTgh3X4x+xD1T0ipsEbhbPtctYucfGeuWK=cq7kHeZ1Q@mail.gmail.com>
	<4F848E10.1090703@snewbury.org.uk>
	<CAE9FiQXvwYrJhLi91VDVtD4+OOfbGQ1U20-Cap+8tBZUt7QCkA@mail.gmail.com>
	<1334089568.4083.2.camel@Nokia-N900>
Date: Tue, 10 Apr 2012 13:45:54 -0700
Message-ID: <CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary=047d7b33d87882102604bd5935ff
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7b33d87882102604bd5935ff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 1:26 PM, Steven Newbury <steve@snewbury.org.uk> wro=
te:
>>
> So far I'm concluding the BIOS isn't sane. =A0Is it possible to define a =
custom memory map from the linux boot cmdline to set TOP_OF_LOW_MEM?

The BIOS have MMIO and memory overlapping...

>
> Obviously, I'd prefer getting everything allocated into the address space=
 available, and working, but if it comes down to it I'd accept a hack like =
the above if there's no other way.

Could try to reduce carbus preallocated size.... boot with pci=3Dcbmemsize=
=3D16M

Please apply attached patch in addtition to allocate_high_at_first

Thanks

Yinghai

--047d7b33d87882102604bd5935ff
Content-Type: application/octet-stream; name="request_optional_failed.patch"
Content-Disposition: attachment; filename="request_optional_failed.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h0vf2y1n0

U3ViamVjdDogW1BBVENIXSBQQ0k6IFNob3VsZCBhZGQgY2hpbGRyZW4gZGV2aWNlIHJlcyB0byBm
YWlsIGxpc3QKCldlIGNhbiBzdG9wIGFjY29yZGluZyB0byB0cnkgbnVtYmVyIG5vdy4gU28gZG8g
bmVlZCB0aGF0IGFzIHN0b3Agc2lnbi4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdo
YWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMgfCAgICAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51
eC0yLjYvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9y
aWcvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9zZXR1
cC1idXMuYwpAQCAtMjgxLDcgKzI4MSw3IEBAIHN0YXRpYyB2b2lkIGFzc2lnbl9yZXF1ZXN0ZWRf
cmVzb3VyY2VzX3MKIAkJaWR4ID0gcGNpX2Rldl9yZXNvdXJjZV9pZHgoZGV2X3Jlcy0+ZGV2LCBy
ZXMpOwogCQlpZiAocmVzb3VyY2Vfc2l6ZShyZXMpICYmCiAJCSAgICBwY2lfYXNzaWduX3Jlc291
cmNlKGRldl9yZXMtPmRldiwgaWR4KSkgewotCQkJaWYgKGZhaWxfaGVhZCAmJiAhcGNpX2lzX3Jv
b3RfYnVzKGRldl9yZXMtPmRldi0+YnVzKSkgeworCQkJaWYgKGZhaWxfaGVhZCkgewogCQkJCS8q
CiAJCQkJICogaWYgdGhlIGZhaWxlZCByZXMgaXMgZm9yIFJPTSBCQVIsIGFuZCBpdCB3aWxsCiAJ
CQkJICogYmUgZW5hYmxlZCBsYXRlciwgZG9uJ3QgYWRkIGl0IHRvIHRoZSBsaXN0Cg==
--047d7b33d87882102604bd5935ff--
