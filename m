Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51577 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726Ab2DODVp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Apr 2012 23:21:45 -0400
Received: by pbcun15 with SMTP id un15so5029243pbc.19
        for <linux-pci@vger.kernel.org>; Sat, 14 Apr 2012 20:21:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F89B5E8.3040906@snewbury.org.uk>
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
	<CAE9FiQWnvB2VbBQQaEnDE0nf+Zwy6nyoGrEuVrUesQEzgYfbvA@mail.gmail.com>
	<4F84A3EC.6030903@snewbury.org.uk>
	<CAE9FiQU+EEtBWrc66Sw4GFQjSy9Vh9fyFvhgQUheev_aVpAzrw@mail.gmail.com>
	<1334229754.30606.7.camel@Nokia-N900>
	<CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>
	<1334248841.2910.6.camel@Nokia-N900>
	<4F89B5E8.3040906@snewbury.org.uk>
Date: Sat, 14 Apr 2012 20:21:44 -0700
Message-ID: <CAE9FiQW_GWWg6GOjG5q4ufAX0-WX=kTpWjWNY3pUt_3v4ZVLYQ@mail.gmail.com>
Subject: Re: PCI resources above 4GB
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: "Barnes, Jesse" <jesse.barnes@intel.com>,
	Dave Airlie <airlied@linux.ie>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary=e89a8ff2434383307904bdaf3459
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--e89a8ff2434383307904bdaf3459
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 14, 2012 at 10:37 AM, Steven Newbury <steve@snewbury.org.uk> wr=
ote:
> I've created a new quirk utilising an extra PCI resource flag to force
> reallocation of the resource. =A0It's the first approach I've had any
> success at. =A0It does work. =A0Only "Intel Page Flush" now gets allocate=
d
> @0xe0000000!

Maybe we can be more aggressive with pci=3Dpref_bar to reassign all pref me=
m.

Please check attached patch.

Yinghai

--e89a8ff2434383307904bdaf3459
Content-Type: application/octet-stream; name="pci_assign_pref.patch"
Content-Disposition: attachment; filename="pci_assign_pref.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h11j345e1

U3ViamVjdDogW1BBVENIXSBQQ0ksIHg4NjogQWRkIHBjaT1wcmVmX2JhciB0byByZWFsbG9jIHBy
ZWYgYmFycwoKU28gY291bGQgcmVhbGxvY2F0ZSA2NGJpdCBwcmVmIG1lbSBhYm92ZSA0Zy4KClNp
Z25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogYXJjaC94
ODYvaW5jbHVkZS9hc20vcGNpX3g4Ni5oIHwgICAgMSArCiBhcmNoL3g4Ni9wY2kvY29tbW9uLmMg
ICAgICAgICAgfCAgICAzICsrKwogYXJjaC94ODYvcGNpL2kzODYuYyAgICAgICAgICAgIHwgICAg
OCArKysrKystLQogMyBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKSW5kZXg6IGxpbnV4LTIuNi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wY2lfeDg2LmgKPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNpX3g4Ni5o
CisrKyBsaW51eC0yLjYvYXJjaC94ODYvaW5jbHVkZS9hc20vcGNpX3g4Ni5oCkBAIC0zMSw2ICsz
MSw3IEBACiAjZGVmaW5lIFBDSV9OT0FTU0lHTl9ST01TCTB4ODAwMDAKICNkZWZpbmUgUENJX1JP
T1RfTk9fQ1JTCQkweDEwMDAwMAogI2RlZmluZSBQQ0lfTk9BU1NJR05fQkFSUwkweDIwMDAwMAor
I2RlZmluZSBQQ0lfQVNTSUdOX1BSRUZfQkFSUwkweDQwMDAwMAogCiBleHRlcm4gdW5zaWduZWQg
aW50IHBjaV9wcm9iZTsKIGV4dGVybiB1bnNpZ25lZCBsb25nIHBpcnFfdGFibGVfYWRkcjsKSW5k
ZXg6IGxpbnV4LTIuNi9hcmNoL3g4Ni9wY2kvY29tbW9uLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
Mi42Lm9yaWcvYXJjaC94ODYvcGNpL2NvbW1vbi5jCisrKyBsaW51eC0yLjYvYXJjaC94ODYvcGNp
L2NvbW1vbi5jCkBAIC01NTYsNiArNTU2LDkgQEAgY2hhciAqIF9fZGV2aW5pdCAgcGNpYmlvc19z
ZXR1cChjaGFyICpzdAogCX0gZWxzZSBpZiAoIXN0cmNtcChzdHIsICJhc3NpZ24tYnVzc2VzIikp
IHsKIAkJcGNpX3Byb2JlIHw9IFBDSV9BU1NJR05fQUxMX0JVU1NFUzsKIAkJcmV0dXJuIE5VTEw7
CisJfSBlbHNlIGlmICghc3RyY21wKHN0ciwgInByZWZfYmFyIikpIHsKKwkJcGNpX3Byb2JlIHw9
IFBDSV9BU1NJR05fUFJFRl9CQVJTOworCQlyZXR1cm4gTlVMTDsKIAl9IGVsc2UgaWYgKCFzdHJj
bXAoc3RyLCAidXNlX2NycyIpKSB7CiAJCXBjaV9wcm9iZSB8PSBQQ0lfVVNFX19DUlM7CiAJCXJl
dHVybiBOVUxMOwpJbmRleDogbGludXgtMi42L2FyY2gveDg2L3BjaS9pMzg2LmMKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gbGludXgtMi42Lm9yaWcvYXJjaC94ODYvcGNpL2kzODYuYworKysgbGludXgtMi42L2Fy
Y2gveDg2L3BjaS9pMzg2LmMKQEAgLTIxMiw3ICsyMTIsOSBAQCBzdGF0aWMgdm9pZCBwY2liaW9z
X2FsbG9jYXRlX2JyaWRnZV9yZXNvCiAJCQljb250aW51ZTsKIAkJaWYgKCFyLT5mbGFncykKIAkJ
CWNvbnRpbnVlOwotCQlpZiAoIXItPnN0YXJ0IHx8IHBjaV9jbGFpbV9yZXNvdXJjZShkZXYsIGlk
eCkgPCAwKSB7CisJCWlmICgoKHItPmZsYWdzICYgSU9SRVNPVVJDRV9QUkVGRVRDSCkgJiYKKwkJ
ICAgICAocGNpX3Byb2JlICYgUENJX0FTU0lHTl9QUkVGX0JBUlMpKSB8fAorCQkgICAgIXItPnN0
YXJ0IHx8IHBjaV9jbGFpbV9yZXNvdXJjZShkZXYsIGlkeCkgPCAwKSB7CiAJCQkvKgogCQkJICog
U29tZXRoaW5nIGlzIHdyb25nIHdpdGggdGhlIHJlZ2lvbi4KIAkJCSAqIEludmFsaWRhdGUgdGhl
IHJlc291cmNlIHRvIHByZXZlbnQKQEAgLTI1Niw3ICsyNTgsOSBAQCBzdGF0aWMgdm9pZCBwY2li
aW9zX2FsbG9jYXRlX2Rldl9yZXNvdXJjCiAJCQlkZXZfZGJnKCZkZXYtPmRldiwKIAkJCQkiQkFS
ICVkOiByZXNlcnZpbmcgJXByIChkPSVkLCBwPSVkKVxuIiwKIAkJCQlpZHgsIHIsIGRpc2FibGVk
LCBwYXNzKTsKLQkJCWlmIChwY2lfY2xhaW1fcmVzb3VyY2UoZGV2LCBpZHgpIDwgMCkgeworCQkJ
aWYgKCgoci0+ZmxhZ3MgJiBJT1JFU09VUkNFX1BSRUZFVENIKSAmJgorCQkJICAgICAocGNpX3By
b2JlICYgUENJX0FTU0lHTl9QUkVGX0JBUlMpKSB8fAorCQkJICAgIHBjaV9jbGFpbV9yZXNvdXJj
ZShkZXYsIGlkeCkgPCAwKSB7CiAJCQkJLyogV2UnbGwgYXNzaWduIGEgbmV3IGFkZHJlc3MgbGF0
ZXIgKi8KIAkJCQlwY2liaW9zX3NhdmVfZndfYWRkcihkZXYsIGlkeCwgci0+c3RhcnQpOwogCQkJ
CXItPmVuZCAtPSByLT5zdGFydDsK
--e89a8ff2434383307904bdaf3459--
