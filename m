Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64235 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbaA3S4O (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 13:56:14 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so3945618obc.36
        for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 10:56:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52E9E3AB.1040805@gmail.com>
References: <52CBC4D1.5080706@gmail.com>
	<CAErSpo7bUchKT5WN+BBq6oKn+O62gWbH+gfaruePBAYrvP7Lmw@mail.gmail.com>
	<52CD2387.2030403@gmail.com>
	<CAE9FiQV5r-c4ufd2SqLJk-KcoJhucmr6RszUb0LyUFtgq_a5sg@mail.gmail.com>
	<52CE301E.60108@gmail.com>
	<CAE9FiQWxpRMX-0vyd5hML-Hnto8H+C83dcne9FBZcN9qsmGCEw@mail.gmail.com>
	<52CF7A17.60703@gmail.com>
	<CAE9FiQVPtNk2LN4TVMzXX72TN8bjDTyD74y_BH05rfw=NArD3Q@mail.gmail.com>
	<52D102EF.5070303@gmail.com>
	<CAE9FiQU=4qABcZLJzF13aYSmzryB1=WkO+NYvs0LTj9Kt_1ajA@mail.gmail.com>
	<CAA__XvTqOtfqzFAdSuUBdr-YAe5SxhUg_FPXr3xvibio_CqbXg@mail.gmail.com>
	<52D6CEC6.2000901@gmail.com>
	<52E9E3AB.1040805@gmail.com>
Date: Thu, 30 Jan 2014 10:56:13 -0800
Message-ID: <CAE9FiQVD-qx-12G3j89SRqt3hUyLaUw8XKngjkFUsLwOrKSNrA@mail.gmail.com>
Subject: Re: pci->pcie bridge issue: kernel unable to find a free I/O port range.
From: Yinghai Lu <yinghai@kernel.org>
To: "`VL" <vl.homutov@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a11c309468ab60104f1349cc8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--001a11c309468ab60104f1349cc8
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jan 29, 2014 at 9:31 PM, `VL <vl.homutov@gmail.com> wrote:
> On 15.01.2014 22:09, `VL wrote:
>>
>> On 15.01.2014 13:10, `VL wrote:
>>>>
>>>> looks like the your adapter need more time to settle down?
>>>> Can you check if you can enable slow boot mode in BIOS setup?
>>>
>>> yes, probably. I'll try to repeat steps with disabled fast boot.
>>
>> no, this is not the case. I've disabled all fast boot in BIOS and nothing
>> changed in logs.
>>
>> so this is the best of what we have:
>> http://inspert.ru/pci/dmesg-earlydump.txt
>>
>> I was also able to reproduce the issue without pci=realloc. I have
>> disabled
>> all builtin devices on motherboard (unused controllers, NICs and audio).
>> Looks like in this conditions kernel was able to allocate some resource
>> and hang during snd_ice1712 driver load.
>>
>> Attached is the photo of boot with this situation.
>> Unfortunately, since NICs are disabled and there is no serial onboard,
>> I cannot provide full log.
>>
> up: any concluision/suggestions?

I don't know why the io bar of 07:00.0 can not be updated.
also it's weird that 07:0.0 is not showing up in earlydump.

anyway please try attached patch to see if it could make any difference.

Thanks

Yinghai

--001a11c309468ab60104f1349cc8
Content-Type: text/x-patch; charset=US-ASCII; name="raw_pci_ext_ops_all.patch"
Content-Disposition: attachment; filename="raw_pci_ext_ops_all.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hr2dv0000

U3VqZWN0OiBbUEFUQ0hdIHg4NiwgcGNpOiB1c2UgcmF3X3BjaV9leHRfb3BzIGZvciBjb25mMQoK
U2lnbmVkLW9mZi1ieTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKLS0tCiBhcmNo
L3g4Ni9wY2kvY29tbW9uLmMgfCAgICA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9hcmNoL3g4Ni9wY2kv
Y29tbW9uLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvYXJjaC94ODYvcGNpL2NvbW1v
bi5jCisrKyBsaW51eC0yLjYvYXJjaC94ODYvcGNpL2NvbW1vbi5jCkBAIC00MSwyMCArNDEsMjAg
QEAgY29uc3Qgc3RydWN0IHBjaV9yYXdfb3BzICpfX3JlYWRfbW9zdGx5CiBpbnQgcmF3X3BjaV9y
ZWFkKHVuc2lnbmVkIGludCBkb21haW4sIHVuc2lnbmVkIGludCBidXMsIHVuc2lnbmVkIGludCBk
ZXZmbiwKIAkJCQkJCWludCByZWcsIGludCBsZW4sIHUzMiAqdmFsKQogewotCWlmIChkb21haW4g
PT0gMCAmJiByZWcgPCAyNTYgJiYgcmF3X3BjaV9vcHMpCi0JCXJldHVybiByYXdfcGNpX29wcy0+
cmVhZChkb21haW4sIGJ1cywgZGV2Zm4sIHJlZywgbGVuLCB2YWwpOwogCWlmIChyYXdfcGNpX2V4
dF9vcHMpCiAJCXJldHVybiByYXdfcGNpX2V4dF9vcHMtPnJlYWQoZG9tYWluLCBidXMsIGRldmZu
LCByZWcsIGxlbiwgdmFsKTsKKwlpZiAoZG9tYWluID09IDAgJiYgcmVnIDwgMjU2ICYmIHJhd19w
Y2lfb3BzKQorCQlyZXR1cm4gcmF3X3BjaV9vcHMtPnJlYWQoZG9tYWluLCBidXMsIGRldmZuLCBy
ZWcsIGxlbiwgdmFsKTsKIAlyZXR1cm4gLUVJTlZBTDsKIH0KIAogaW50IHJhd19wY2lfd3JpdGUo
dW5zaWduZWQgaW50IGRvbWFpbiwgdW5zaWduZWQgaW50IGJ1cywgdW5zaWduZWQgaW50IGRldmZu
LAogCQkJCQkJaW50IHJlZywgaW50IGxlbiwgdTMyIHZhbCkKIHsKLQlpZiAoZG9tYWluID09IDAg
JiYgcmVnIDwgMjU2ICYmIHJhd19wY2lfb3BzKQotCQlyZXR1cm4gcmF3X3BjaV9vcHMtPndyaXRl
KGRvbWFpbiwgYnVzLCBkZXZmbiwgcmVnLCBsZW4sIHZhbCk7CiAJaWYgKHJhd19wY2lfZXh0X29w
cykKIAkJcmV0dXJuIHJhd19wY2lfZXh0X29wcy0+d3JpdGUoZG9tYWluLCBidXMsIGRldmZuLCBy
ZWcsIGxlbiwgdmFsKTsKKwlpZiAoZG9tYWluID09IDAgJiYgcmVnIDwgMjU2ICYmIHJhd19wY2lf
b3BzKQorCQlyZXR1cm4gcmF3X3BjaV9vcHMtPndyaXRlKGRvbWFpbiwgYnVzLCBkZXZmbiwgcmVn
LCBsZW4sIHZhbCk7CiAJcmV0dXJuIC1FSU5WQUw7CiB9CiAK
--001a11c309468ab60104f1349cc8--
