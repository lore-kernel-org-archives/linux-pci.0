Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdGEBAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 21:00:06 -0400
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
To: Wim ten Have <wim.ten.have@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
 <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
 <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
 <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
 <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
Date: Tue, 4 Jul 2017 21:00:03 -0400
MIME-Version: 1.0
In-Reply-To: <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
Content-Type: multipart/mixed;
 boundary="------------4C13289BB865F12286293B92"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------4C13289BB865F12286293B92
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/4/2017 6:25 PM, Sinan Kaya wrote:
> On 7/4/2017 1:59 PM, Wim ten Have wrote:
>> On Tue, 4 Jul 2017 11:57:37 -0400
>> Sinan Kaya <okaya@codeaurora.org> wrote:
>>
>>> Hi,
>>>
>>> On 7/4/2017 11:32 AM, Bjorn Helgaas wrote:
>>>> [+cc linux-pci]
>>>>
>>>> Thanks very much for the detailed problem report, Wim!  I'm taking the
>>>> liberty to forward to the linux-pci list in case others trip over the
>>>> same thing.
>>>>   
>>>
>>> So, the spec is lying :) and reality doesn't match theory.
> 
> The PCI Express bridge you have is a Broadcom HT 2100 bridge which seems to support
> PCI-Express V1.0 and 1.0a compliant only.
> 
> http://www.hard-net.de/info_wissen/chipsatz/broadcom/HT-2100.pdf
> 
> I can also see this in your lspci output. 
> 
> 00:08.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2) (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 19
> 	NUMA node: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff [empty]
> 	Memory behind bridge: efe00000-efefffff [size=1M]
> 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> 	Capabilities: [a0] HyperTransport: MSI Mapping Enable+ Fixed-
> 		Mapping Address Base: 00000000fee00000
> 	Capabilities: [b0] Express (v1) Root Port (Slot-), MSI 00
> 
> I'll post a patch to apply extended tags to systems with PCI express v2 and higher
> bridges only.
> 

Please give this patch a try. I can make the patch pretty and re-post if it works for you. 

You should be seeing messages like this during boot.

[    3.949621] pci 0003:01:00.0: clearing extended tags capability
[    3.959540] pci 0003:01:00.1: clearing extended tags capability
[    3.969454] pci 0003:01:00.2: clearing extended tags capability
[    3.979373] pci 0003:01:00.3: clearing extended tags capability
[    3.989290] pci 0003:01:00.4: clearing extended tags capability



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------4C13289BB865F12286293B92
Content-Type: text/plain; charset=UTF-8;
 name="0001-pci-do-not-enable-extended-tags-on-pre-dated-v1.x-sy.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-pci-do-not-enable-extended-tags-on-pre-dated-v1.x-sy.pa";
 filename*1="tch"

RnJvbSBhNTBlZGYzN2Q1ODk5Mzk4M2VjOTBkYzVhYWI4Y2E2ZDJiOGZmMTBiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaW5hbiBLYXlhIDxva2F5YUBjb2RlYXVyb3JhLm9y
Zz4KRGF0ZTogVHVlLCA0IEp1bCAyMDE3IDIwOjM5OjA4IC0wNDAwClN1YmplY3Q6IFtQQVRD
SF0gcGNpOiBkbyBub3QgZW5hYmxlIGV4dGVuZGVkIHRhZ3Mgb24gcHJlLWRhdGVkKHYxLngp
IHN5c3RlbXMKClNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlhQGNvZGVhdXJvcmEu
b3JnPgotLS0KIGRyaXZlcnMvcGNpL3Byb2JlLmMgfCA1MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDUg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYwppbmRleCBkZmM5YTI3Li5jNjdhZjIy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9wcm9iZS5jCisrKyBiL2RyaXZlcnMvcGNpL3By
b2JlLmMKQEAgLTE2NjMsMjEgKzE2NjMsNTggQEAgc3RhdGljIHZvaWQgcHJvZ3JhbV9ocHBf
dHlwZTIoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IGhwcF90eXBlMiAqaHBwKQogCSAq
LwogfQoKLXN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfZXh0ZW5kZWRfdGFncyhzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQorc3RhdGljIGJvb2wgcGNpZV9idXNfZXh0dGFnc19zdXBwb3J0ZWQo
c3RydWN0IHBjaV9idXMgKmJ1cykKK3sKKwlib29sIGV4dHRhZ3Nfc3VwcG9ydGVkID0gdHJ1
ZTsKKwlzdHJ1Y3QgcGNpX2RldiAqYnJpZGdlOworCWludCByYzsKKwl1MTYgZmxhZ3M7CisK
KwlicmlkZ2UgPSBidXMtPnNlbGY7CisJd2hpbGUgKGJyaWRnZSkgeworCQlpZiAocGNpX2lz
X3BjaWUoYnJpZGdlKSkgeworCQkJcmMgPSBwY2llX2NhcGFiaWxpdHlfcmVhZF93b3JkKGJy
aWRnZSwgUENJX0VYUF9GTEFHUywKKwkJCQkJCSAgICAgICAmZmxhZ3MpOworCQkJaWYgKCFy
YyAmJiAoKGZsYWdzICYgUENJX0VYUF9GTEFHU19WRVJTKSA8IDIpKSB7CisJCQkJZXh0dGFn
c19zdXBwb3J0ZWQgPSBmYWxzZTsKKwkJCQlicmVhazsKKwkJCX0KKwkJfQorCQlpZiAoIWJy
aWRnZS0+YnVzLT5wYXJlbnQpCisJCQlicmVhazsKKwkJYnJpZGdlID0gYnJpZGdlLT5idXMt
PnBhcmVudC0+c2VsZjsKKwl9CisKKwlyZXR1cm4gZXh0dGFnc19zdXBwb3J0ZWQ7Cit9CisK
K3N0YXRpYyBpbnQgcGNpZV9idXNfY29uZmlndXJlX2V4dHRhZ3Moc3RydWN0IHBjaV9kZXYg
KmRldiwgdm9pZCAqZGF0YSkKIHsKIAl1MzIgZGV2X2NhcDsKIAlpbnQgcmV0OworCWJvb2wg
c3VwcG9ydGVkOwoKIAlpZiAoIXBjaV9pc19wY2llKGRldikpCi0JCXJldHVybjsKKwkJcmV0
dXJuIDA7CgogCXJldCA9IHBjaWVfY2FwYWJpbGl0eV9yZWFkX2R3b3JkKGRldiwgUENJX0VY
UF9ERVZDQVAsICZkZXZfY2FwKTsKIAlpZiAocmV0KQotCQlyZXR1cm47CisJCXJldHVybiAw
OwoKLQlpZiAoZGV2X2NhcCAmIFBDSV9FWFBfREVWQ0FQX0VYVF9UQUcpCi0JCXBjaWVfY2Fw
YWJpbGl0eV9zZXRfd29yZChkZXYsIFBDSV9FWFBfREVWQ1RMLAotCQkJCQkgUENJX0VYUF9E
RVZDVExfRVhUX1RBRyk7CisJaWYgKGRldl9jYXAgJiBQQ0lfRVhQX0RFVkNBUF9FWFRfVEFH
KSB7CisJCXN1cHBvcnRlZCA9IHBjaWVfYnVzX2V4dHRhZ3Nfc3VwcG9ydGVkKGRldi0+YnVz
KTsKKworCQlpZiAoc3VwcG9ydGVkKSB7CisJCQlkZXZfaW5mbygmZGV2LT5kZXYsICJzZXR0
aW5nIGV4dGVuZGVkIHRhZ3MgY2FwYWJpbGl0eVxuIik7CisJCQlwY2llX2NhcGFiaWxpdHlf
c2V0X3dvcmQoZGV2LCBQQ0lfRVhQX0RFVkNUTCwKKwkJCQkJCSBQQ0lfRVhQX0RFVkNUTF9F
WFRfVEFHKTsKKwkJfSBlbHNlIHsKKwkJCWRldl9pbmZvKCZkZXYtPmRldiwgImNsZWFyaW5n
IGV4dGVuZGVkIHRhZ3MgY2FwYWJpbGl0eVxuIik7CisJCQlwY2llX2NhcGFiaWxpdHlfY2xl
YXJfd29yZChkZXYsIFBDSV9FWFBfREVWQ1RMLAorCQkJCQkJICAgUENJX0VYUF9ERVZDVExf
RVhUX1RBRyk7CisJCX0KKwl9CisJcmV0dXJuIDA7CiB9Cgogc3RhdGljIHZvaWQgcGNpX2Nv
bmZpZ3VyZV9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikKQEAgLTE2ODYsNyArMTcyMyw2
IEBAIHN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpk
ZXYpCiAJaW50IHJldDsKCiAJcGNpX2NvbmZpZ3VyZV9tcHMoZGV2KTsKLQlwY2lfY29uZmln
dXJlX2V4dGVuZGVkX3RhZ3MoZGV2KTsKCiAJbWVtc2V0KCZocHAsIDAsIHNpemVvZihocHAp
KTsKIAlyZXQgPSBwY2lfZ2V0X2hwX3BhcmFtcyhkZXYsICZocHApOwpAQCAtMjIzMSw2ICsy
MjY3LDggQEAgdm9pZCBwY2llX2J1c19jb25maWd1cmVfc2V0dGluZ3Moc3RydWN0IHBjaV9i
dXMgKmJ1cykKCiAJcGNpZV9idXNfY29uZmlndXJlX3NldChidXMtPnNlbGYsICZzbXBzcyk7
CiAJcGNpX3dhbGtfYnVzKGJ1cywgcGNpZV9idXNfY29uZmlndXJlX3NldCwgJnNtcHNzKTsK
KworCXBjaV93YWxrX2J1cyhidXMsIHBjaWVfYnVzX2NvbmZpZ3VyZV9leHR0YWdzLCBOVUxM
KTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKHBjaWVfYnVzX2NvbmZpZ3VyZV9zZXR0aW5ncyk7
CgotLQoxLjkuMQoK
--------------4C13289BB865F12286293B92--
