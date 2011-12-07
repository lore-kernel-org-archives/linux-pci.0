Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39950 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab1LGIWs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 03:22:48 -0500
Received: by ghbz2 with SMTP id z2so248114ghb.19
        for <linux-pci@vger.kernel.org>; Wed, 07 Dec 2011 00:22:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111205103202.29faf6e1@jbarnes-desktop>
References: <20111006210320.GA14959@us.ibm.com>
	<CAErSpo7b_6_AaZXW9XBx5p3-0PZJk-1jeCork__KePdzCS89OA@mail.gmail.com>
	<1317970100.29415.305.camel@pasglop>
	<CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023310.GA2383@ram-ThinkPad-T61>
	<20111205103202.29faf6e1@jbarnes-desktop>
Date: Wed, 7 Dec 2011 00:22:47 -0800
Message-ID: <CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>, linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Content-Type: multipart/mixed; boundary=20cf303f6d4cc8176704b37c4142
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf303f6d4cc8176704b37c4142
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 5, 2011 at 10:32 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wr=
ote:
> On Sun, 6 Nov 2011 10:33:10 +0800
> Ram Pai <linuxram@us.ibm.com> wrote:
>
>>
>> =A0 NOTE: Note, there is subtle change in the pci_enable_device() API.
>> =A0 Any driver that depends on SRIOV BARS to be enabled in pci_enable_de=
vice()
>> =A0 can fail.
>>
>> ---
>
> Applied to my for-linus branch, thanks.
>

please don't push to linus now.

this one causes regression.

please check attached patch.

Thanks

Yinghai

--20cf303f6d4cc8176704b37c4142
Content-Type: text/x-patch; charset=US-ASCII; name="fix_sriov_late.patch"
Content-Disposition: attachment; filename="fix_sriov_late.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gvw2bzx71

W1BBVENIXSBwY2k6IEZpeCBob3RwbHVnIG9mIEV4cHJlc3MgTW9kdWxlIHdpdGggcGNpIGJyaWRn
ZXMKCkZvdW5kIGhvdHBsdWcgb2Ygb25lIHNldHVwIGRvZXMgbm90IHdvcmsgd2l0aCByZWNlbnQg
Y2hhbmdlIGluIHBjaSB0cmVlLgoKQWZ0ZXIgY2hlY2tpbmcgdGhlIGJyaWRnZSBjb25mIHNldHVw
LCBmb3VuZCBicmlkZ2VzIGdldCBhc3NpZ25lZCwgYnV0IG5vdCBnZXQgZW5hYmxlZC4KCkZpbmFs
bHkgZm91bmQgZm9sbG93aW5nIGNvbW1pdCwgc2ltcGxlbHkgaWdub3JlIGJyaWRnZSByZXNvdXJj
ZSB3aGVuIGVuYWJsaW5nIHBjaSBkZXZpY2UuCgp8IGNvbW1pdCBiYmVmOThhYjBmMDE5ZjFiMGMy
NWMxYWNkZjE2ODNjNjg5MzNkNDFiCnwgQXV0aG9yOiBSYW0gUGFpIDxsaW51eHJhbUB1cy5pYm0u
Y29tPgp8IERhdGU6ICAgU3VuIE5vdiA2IDEwOjMzOjEwIDIwMTEgKzA4MDAKfAp8ICAgIFBDSTog
ZGVmZXIgZW5hYmxlbWVudCBvZiBTUklPViBCQVJTCnwuLi4KfCAgICBOT1RFOiBOb3RlLCB0aGVy
ZSBpcyBzdWJ0bGUgY2hhbmdlIGluIHRoZSBwY2lfZW5hYmxlX2RldmljZSgpIEFQSS4gIEFueQp8
ICAgIGRyaXZlciB0aGF0IGRlcGVuZHMgb24gU1JJT1YgQkFSUyB0byBiZSBlbmFibGVkIGluIHBj
aV9lbmFibGVfZGV2aWNlKCkKfCAgICBjYW4gZmFpbC4KClB1dCBiYWNrIGJyaWRnZSByZXNvdXJj
ZSBhbmQgUk9NIHJlc291cmNlIGNoZWNraW5nIHRvIGZpeCB0aGUgcHJvYmxlbS4KClRoYXQgc2hv
dWxkIGZpeCByZWdyZXNzaW9uIGxpa2UgQklPUyBkb2VzIG5vdCBhc3NpZ24gY29ycmVjdCByZXNv
dXJjZSB0byBicmlkZ2UuCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5l
bC5vcmc+CgotLS0KIGRyaXZlcnMvcGNpL3BjaS5jIHwgICAgNiArKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCkluZGV4OiBsaW51eC0yLjYvZHJp
dmVycy9wY2kvcGNpLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kv
cGNpLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9wY2kuYwpAQCAtMTEzOSw3ICsxMTM5LDEx
IEBAIHN0YXRpYyBpbnQgX19wY2lfZW5hYmxlX2RldmljZV9mbGFncyhzdHIKIAlpZiAoYXRvbWlj
X2FkZF9yZXR1cm4oMSwgJmRldi0+ZW5hYmxlX2NudCkgPiAxKQogCQlyZXR1cm4gMDsJCS8qIGFs
cmVhZHkgZW5hYmxlZCAqLwogCi0JZm9yIChpID0gMDsgaSA8IFBDSV9ST01fUkVTT1VSQ0U7IGkr
KykKKwkvKiBvbmx5IHNraXAgc3Jpb3YgcmVsYXRlZCAqLworCWZvciAoaSA9IDA7IGkgPD0gUENJ
X1JPTV9SRVNPVVJDRTsgaSsrKQorCQlpZiAoZGV2LT5yZXNvdXJjZVtpXS5mbGFncyAmIGZsYWdz
KQorCQkJYmFycyB8PSAoMSA8PCBpKTsKKwlmb3IgKGkgPSBQQ0lfQlJJREdFX1JFU09VUkNFUzsg
aSA8IERFVklDRV9DT1VOVF9SRVNPVVJDRTsgaSsrKQogCQlpZiAoZGV2LT5yZXNvdXJjZVtpXS5m
bGFncyAmIGZsYWdzKQogCQkJYmFycyB8PSAoMSA8PCBpKTsKIAo=
--20cf303f6d4cc8176704b37c4142--
