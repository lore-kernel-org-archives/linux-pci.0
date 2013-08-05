Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:38904 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3HETFF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 15:05:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so7218435oag.12
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2013 12:05:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
	<CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
Date: Mon, 5 Aug 2013 12:05:03 -0700
Message-ID: <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in pbus_size_io()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: multipart/mixed; boundary=089e0122a988660e5b04e337fc1b
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--089e0122a988660e5b04e337fc1b
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 5, 2013 at 10:58 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Yinghai]
>
> After the loop we have this (added by Yinghai in fd5913411):
>
>     if (min_align > io_align)
>         min_align = io_align;
>
> I don't understand this.  There are three cases:
>
> 1) No downstream bridges: min_align <= 256 because I/O BARs are
> limited to 256 bytes.
> 2) All downstream bridges have 1K extension: min_align = 1024.
> 3) At least one downstream bridge requires 4K alignment: min_align = 4096.
>
> "io_align" is the minimum alignment enforced by the bridge.  This is
> independent of any devices below the bridge, so "io_align >= 1024" in
> all cases.
>
> Therefore, the "min_align = io_align" assignment only happens in case
> 3, when a downstream bridge requires 4K alignment and *this* bridge
> supports the 1K extension.  But that seems wrong.  The downstream
> bridge's 4K requirement also applies to all bridges all the way
> upstream.
>
> It looks to me like this test should instead be:
>
>     if (min_align < io_align)
>         min_align = io_align;

before my change, min_align always set to 4096.
in the loop to get min_align, dev resource could have size bigger than
4k, those resource will have SIZEALIGN, so final min_align could be
more than 4096.
so at last we cap it to 4096 again.

But according to your findings: "I/O BARs are limited to 256 bytes"
we should not worry about that.

So we should just drop io_align and checking like attached patch.
(min_align is already set to 1k or 4k before the looping.)

and that should solve Wei Yang's problem.

Thanks

Yinghai

--089e0122a988660e5b04e337fc1b
Content-Type: application/octet-stream; name="fix_io_align_checking.patch"
Content-Disposition: attachment; filename="fix_io_align_checking.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hk01tjcr0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3NldHVwLWJ1cy5jIGIvZHJpdmVycy9wY2kvc2V0dXAt
YnVzLmMKaW5kZXggNjRhN2RlMi4uZWRhYTllOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvc2V0
dXAtYnVzLmMKKysrIGIvZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMKQEAgLTgxNiwxMiArODE2LDEy
IEBAIHN0YXRpYyB2b2lkIHBidXNfc2l6ZV9pbyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLCByZXNvdXJj
ZV9zaXplX3QgbWluX3NpemUsCiAJc3RydWN0IHJlc291cmNlICpiX3JlcyA9IGZpbmRfZnJlZV9i
dXNfcmVzb3VyY2UoYnVzLCBJT1JFU09VUkNFX0lPKTsKIAl1bnNpZ25lZCBsb25nIHNpemUgPSAw
LCBzaXplMCA9IDAsIHNpemUxID0gMDsKIAlyZXNvdXJjZV9zaXplX3QgY2hpbGRyZW5fYWRkX3Np
emUgPSAwOwotCXJlc291cmNlX3NpemVfdCBtaW5fYWxpZ24sIGlvX2FsaWduLCBhbGlnbjsKKwly
ZXNvdXJjZV9zaXplX3QgbWluX2FsaWduLCBhbGlnbjsKIAogCWlmICghYl9yZXMpCiAgCQlyZXR1
cm47CiAKLQlpb19hbGlnbiA9IG1pbl9hbGlnbiA9IHdpbmRvd19hbGlnbm1lbnQoYnVzLCBJT1JF
U09VUkNFX0lPKTsKKwltaW5fYWxpZ24gPSB3aW5kb3dfYWxpZ25tZW50KGJ1cywgSU9SRVNPVVJD
RV9JTyk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShkZXYsICZidXMtPmRldmljZXMsIGJ1c19saXN0
KSB7CiAJCWludCBpOwogCkBAIC04NDgsOCArODQ4LDggQEAgc3RhdGljIHZvaWQgcGJ1c19zaXpl
X2lvKHN0cnVjdCBwY2lfYnVzICpidXMsIHJlc291cmNlX3NpemVfdCBtaW5fc2l6ZSwKIAkJfQog
CX0KIAotCWlmIChtaW5fYWxpZ24gPiBpb19hbGlnbikKLQkJbWluX2FsaWduID0gaW9fYWxpZ247
CisJaWYgKG1pbl9hbGlnbiA+IFBDSV9QMlBfREVGQVVMVF9JT19BTElHTikKKwkJbWluX2FsaWdu
ID0gUENJX1AyUF9ERUZBVUxUX0lPX0FMSUdOOwogCiAJc2l6ZTAgPSBjYWxjdWxhdGVfaW9zaXpl
KHNpemUsIG1pbl9zaXplLCBzaXplMSwKIAkJCXJlc291cmNlX3NpemUoYl9yZXMpLCBtaW5fYWxp
Z24pOwo=
--089e0122a988660e5b04e337fc1b--
