Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34105 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab2HUXWx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2012 19:22:53 -0400
Received: by vcbfk26 with SMTP id fk26so442614vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2012 16:22:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120821151245.GA2356@ram-ThinkPad-T61>
References: <20120618050333.GA13469@ram-ThinkPad-T61>
	<CAE9FiQWwPOgBa5guG1y-xF95nBMwE+TC75E_xcg-N8ZxuPW_XQ@mail.gmail.com>
	<CAErSpo40Ok9NuMm0zxGnZ0DmFmGT19Y23JC4BCQV1RSxsmakCw@mail.gmail.com>
	<20120816032602.GN2449@ram-ThinkPad-T61>
	<CAE9FiQW08aoQBiy+37x-VMYrG-OunqzfuRpB1JhDAgNL3AxEuw@mail.gmail.com>
	<20120816044104.GQ2449@ram-ThinkPad-T61>
	<20120821151245.GA2356@ram-ThinkPad-T61>
Date: Tue, 21 Aug 2012 16:22:52 -0700
Message-ID: <CAE9FiQUW2rB8X18=X6hVb-ZV8AnoL4RA+8P7897vHxwjj63bsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 ]pci: pci resource iterator
From: Yinghai Lu <yinghai@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: multipart/mixed; boundary=bcaec5040dfccdb1c904c7cee746
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--bcaec5040dfccdb1c904c7cee746
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Aug 21, 2012 at 8:13 AM, Ram Pai <linuxram@us.ibm.com> wrote:
> PCI: pci resource iterator
>
> Currently pci_dev structure holds an array of 17 PCI resources; six base
> BARs, one ROM BAR, four BRIDGE BARs, six sriov BARs.  This is wasteful.
> A bridge device just needs the 4 bridge resources. A non-bridge device
> just needs the six base resources and one ROM resource. The sriov
> resources are needed only if the device has SRIOV capability.
>
> The pci_dev structure needs to be re-organized to avoid unnecessary
> bloating.  However too much code outside the pci-bus driver, assumes the
> internal details of the pci_dev structure, thus making it hard to
> re-organize the datastructure.
>
> As a first step this patch provides generic methods to access the
> resource structure of the pci_dev.
>
> Once this patch is accepted, I have another 40+ patches that modify all
> the files that directly access the resource structure, to use the new
> methods provided in the first step.
>
> Finally we can re-organize the resource structure in the pci_dev
> structure and correspondingly update the methods.
>
> This patch is compile tested only.
>
> Changelog:
>         Consolidated iterator interface as per Bjorn's suggestion.
>
> +#define for_each_pci_resource(dev, res, flag) \
> +       for (res = pci_next_resource(dev, NULL, flag); res; \
> +                       res = pci_next_resource(dev, res, flag))
> +

We may need to keep the idx, so we could make the converting more granularity.

because some loop body is still using the idx.

also there is some abusing pci bridge resource as addon resources.
and we need to remove the abusing at first ---
that is addressed by:
http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=5eb48c3c998257386f67a7570778872ec600138f

 PCI: Add addon_resource support for pci_dev

and later we may remove the idx in the for_each_pci_resource()

Please check updated version of your patch that keep the idx.

Thanks

Yinghai

--bcaec5040dfccdb1c904c7cee746
Content-Type: application/octet-stream; name="ram_pci_it_v3.patch"
Content-Disposition: attachment; filename="ram_pci_it_v3.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h65mcm7w0

RnJvbTogUmFtIFBhaSA8bGludXhyYW1AdXMuaWJtLmNvbT4KVG86IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmcKQ2M6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4sIEJqb3JuIEhlbGdh
YXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+ClN1YmplY3Q6IFtSRkMgUEFUQ0ggdjNdcGNpOiBwY2kg
cmVzb3VyY2UgaXRlcmF0b3IKCkN1cnJlbnRseSBwY2lfZGV2IHN0cnVjdHVyZSBob2xkcyBhbiBh
cnJheSBvZiAxNyBQQ0kgcmVzb3VyY2VzOyBzaXggYmFzZQpCQVJzLCBvbmUgUk9NIEJBUiwgZm91
ciBCUklER0UgQkFScywgc2l4IHNyaW92IEJBUnMuICBUaGlzIGlzIHdhc3RlZnVsLgpBIGJyaWRn
ZSBkZXZpY2UganVzdCBuZWVkcyB0aGUgNCBicmlkZ2UgcmVzb3VyY2VzLiBBIG5vbi1icmlkZ2Ug
ZGV2aWNlCmp1c3QgbmVlZHMgdGhlIHNpeCBiYXNlIHJlc291cmNlcyBhbmQgb25lIFJPTSByZXNv
dXJjZS4gVGhlIHNyaW92CnJlc291cmNlcyBhcmUgbmVlZGVkIG9ubHkgaWYgdGhlIGRldmljZSBo
YXMgU1JJT1YgY2FwYWJpbGl0eS4KClRoZSBwY2lfZGV2IHN0cnVjdHVyZSBuZWVkcyB0byBiZSBy
ZS1vcmdhbml6ZWQgdG8gYXZvaWQgdW5uZWNlc3NhcnkKYmxvYXRpbmcuICBIb3dldmVyIHRvbyBt
dWNoIGNvZGUgb3V0c2lkZSB0aGUgcGNpLWJ1cyBkcml2ZXIsIGFzc3VtZXMgdGhlCmludGVybmFs
IGRldGFpbHMgb2YgdGhlIHBjaV9kZXYgc3RydWN0dXJlLCB0aHVzIG1ha2luZyBpdCBoYXJkIHRv
CnJlLW9yZ2FuaXplIHRoZSBkYXRhc3RydWN0dXJlLgoKQXMgYSBmaXJzdCBzdGVwIHRoaXMgcGF0
Y2ggcHJvdmlkZXMgZ2VuZXJpYyBtZXRob2RzIHRvIGFjY2VzcyB0aGUKcmVzb3VyY2Ugc3RydWN0
dXJlIG9mIHRoZSBwY2lfZGV2LgoKT25jZSB0aGlzIHBhdGNoIGlzIGFjY2VwdGVkLCBJIGhhdmUg
YW5vdGhlciA0MCsgcGF0Y2hlcyB0aGF0IG1vZGlmeSBhbGwKdGhlIGZpbGVzIHRoYXQgZGlyZWN0
bHkgYWNjZXNzIHRoZSByZXNvdXJjZSBzdHJ1Y3R1cmUsIHRvIHVzZSB0aGUgbmV3Cm1ldGhvZHMg
cHJvdmlkZWQgaW4gdGhlIGZpcnN0IHN0ZXAuCgpGaW5hbGx5IHdlIGNhbiByZS1vcmdhbml6ZSB0
aGUgcmVzb3VyY2Ugc3RydWN0dXJlIGluIHRoZSBwY2lfZGV2CnN0cnVjdHVyZSBhbmQgY29ycmVz
cG9uZGluZ2x5IHVwZGF0ZSB0aGUgbWV0aG9kcy4KClRoaXMgcGF0Y2ggaXMgY29tcGlsZSB0ZXN0
ZWQgb25seS4KCkNoYW5nZWxvZzoKCUNvbnNvbGlkYXRlZCBpdGVyYXRvciBpbnRlcmZhY2UgYXMg
cGVyIEJqb3JuJ3Mgc3VnZ2VzdGlvbi4KCi12MzogYWRkIHRoZSBpZHggYmFjawoKU2lnbmVkLW9m
Zi1ieTogUmFtIFBhaSA8bGludXhyYW1AdXMuaWJtLmNvbT4KCi0tLQogaW5jbHVkZS9saW51eC9w
Y2kuaCB8ICAgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtMi42L2luY2x1ZGUv
bGludXgvcGNpLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvaW5jbHVkZS9saW51eC9w
Y2kuaAorKysgbGludXgtMi42L2luY2x1ZGUvbGludXgvcGNpLmgKQEAgLTE0MTAsNiArMTQxMCw0
NyBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2X2dlCiAJIChwY2lfcmVz
b3VyY2VfZW5kKChkZXYpLCAoYmFyKSkgLQkJXAogCSAgcGNpX3Jlc291cmNlX3N0YXJ0KChkZXYp
LCAoYmFyKSkgKyAxKSkKIAorI2RlZmluZSBQQ0lfU1REX1JFUwkJMHgwMQorI2RlZmluZSBQQ0lf
Uk9NX1JFUwkJMHgwMgorI2RlZmluZSBQQ0lfQlJJREdFX1JFUwkJMHgwNAorI2RlZmluZSBQQ0lf
SU9WX1JFUwkJMHgwOAorI2RlZmluZSBQQ0lfQUxMX1JFUwkJKFBDSV9TVERfUkVTIHwgUENJX1JP
TV9SRVMgfCBQQ0lfQlJJREdFX1JFUyB8IFBDSV9JT1ZfUkVTKQorI2RlZmluZSBQQ0lfTk9TVERf
UkVTCQkoUENJX0FMTF9SRVMgJiBeUENJX1NURF9SRVMpCisjZGVmaW5lIFBDSV9OT0lPVl9SRVMJ
CShQQ0lfQUxMX1JFUyAmIF5QQ0lfSU9WX1JFUykKKyNkZWZpbmUgUENJX05PUk9NX1JFUwkJKFBD
SV9BTExfUkVTICYgXlBDSV9ST01fUkVTKQorI2RlZmluZSBQQ0lfTk9CUklER0VfUkVTCShQQ0lf
QUxMX1JFUyAmIF5QQ0lfQlJJREdFX1JFUykKKyNkZWZpbmUgUENJX1NURF9ST01fUkVTCQkoUENJ
X1NURF9SRVMgfCBQQ0lfUk9NX1JFUykKKyNkZWZpbmUgUENJX1NURF9JT1ZfUkVTCQkoUENJX1NU
RF9SRVMgfCBQQ0lfSU9WX1JFUykKKyNkZWZpbmUgUENJX1NURF9ST01fSU9WX1JFUwkoUENJX1NU
RF9SRVMgfCBQQ0lfUk9NX1JFUyB8IFBDSV9JT1ZfUkVTKQorCitzdGF0aWMgaW5saW5lIHN0cnVj
dCByZXNvdXJjZSAqcGNpX25leHRfcmVzb3VyY2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYsCisJCQlz
dHJ1Y3QgcmVzb3VyY2UgKnJlcywgaW50IGZsYWcsIGludCAqbmV4dF9pKQoreworCWludCBpID0g
Km5leHRfaTsKKworCXdoaWxlICgrK2kgPCBQQ0lfTlVNX1JFU09VUkNFUykgeworCQlpZiAoKGkg
Pj0gMCAmJiBpIDwgUENJX1JPTV9SRVNPVVJDRSkgJiYgKGZsYWcgJiBQQ0lfU1REX1JFUykpCisJ
CQlnb3RvIGZvdW5kOworCQllbHNlIGlmICgoaSA9PSBQQ0lfUk9NX1JFU09VUkNFKSAmJiAoZmxh
ZyAmIFBDSV9ST01fUkVTKSkKKwkJCWdvdG8gZm91bmQ7CisJCWVsc2UgaWYgKChpIDw9IFBDSV9J
T1ZfUkVTT1VSQ0VfRU5EKSAmJiAoZmxhZyAmIFBDSV9JT1ZfUkVTKSkKKwkJCWdvdG8gZm91bmQ7
CisJCWVsc2UgaWYgKChpIDw9IFBDSV9CUklER0VfUkVTT1VSQ0VfRU5EKSAmJiAoZmxhZyAmIFBD
SV9CUklER0VfUkVTKSkKKwkJCWdvdG8gZm91bmQ7CisJfQorCisJKm5leHRfaWQgPSAtMTsKKwly
ZXR1cm4gTlVMTDsKKworZm91bmQ6CisJKm5leHRfaWQgPSBpOworCXJldHVybiBwY2lfZGV2X3Jl
c291cmNlX24oaSk7Cit9CisKKyNkZWZpbmUgZm9yX2VhY2hfcGNpX3Jlc291cmNlKGRldiwgcmVz
LCBpLCBmbGFnKSBcCisJZm9yIChpID0gLTEsIHJlcyA9IHBjaV9uZXh0X3Jlc291cmNlKGRldiwg
TlVMTCwgZmxhZywgJmkpOyByZXM7IFwKKwkJCXJlcyA9IHBjaV9uZXh0X3Jlc291cmNlKGRldiwg
cmVzLCBmbGFnLCAmaSkpCisKIC8qIFNpbWlsYXIgdG8gdGhlIGhlbHBlcnMgYWJvdmUsIHRoZXNl
IG1hbmlwdWxhdGUgcGVyLXBjaV9kZXYKICAqIGRyaXZlci1zcGVjaWZpYyBkYXRhLiAgVGhleSBh
cmUgcmVhbGx5IGp1c3QgYSB3cmFwcGVyIGFyb3VuZAogICogdGhlIGdlbmVyaWMgZGV2aWNlIHN0
cnVjdHVyZSBmdW5jdGlvbnMgb2YgdGhlc2UgY2FsbHMuCg==
--bcaec5040dfccdb1c904c7cee746--
