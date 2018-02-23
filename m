Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0041.outbound.protection.outlook.com ([104.47.0.41]:44384
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750861AbeBWKxZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Feb 2018 05:53:25 -0500
From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: free_irq(IRQ#0) on PCIe device with MSI enabled issue...
Date: Fri, 23 Feb 2018 10:53:22 +0000
Message-ID: <AM5PR03MB2963AE1C1288495E4A45997ED6CC0@AM5PR03MB2963.eurprd03.prod.outlook.com>
References: <AM5PR03MB296338FECDD421CF2F438EB7D6CD0@AM5PR03MB2963.eurprd03.prod.outlook.com>
 <20180222151938.GC52685@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180222151938.GC52685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed;
        boundary="_002_AM5PR03MB2963AE1C1288495E4A45997ED6CC0AM5PR03MB2963eurp_"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--_002_AM5PR03MB2963AE1C1288495E4A45997ED6CC0AM5PR03MB2963eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

Many thanks for your quick answer. Here are what you asked for:

1/ running 4.16.0-rc1 doesn't change anything. Issue still here...

2/ you'll find a "git diff" patch that contains the changes to switch the d=
river into full MSI mode attached to that e-mail.

Here are also some other logs:

$ uname -r
4.16.0-rc1
$ dmesg | grep peak_pciefd
[ 4022.170354] peak_pciefd 0000:0b:00.0: 4x CAN-FD PCAN-PCIe FPGA v3.2.1:
[ 4022.170456] peak_pciefd 0000:0b:00.0: MSI[1..4] enabling status: 4
[ 4022.170653] peak_pciefd 0000:0b:00.0: can0 at reg_base=3D0x00000000aab55=
a4d irq=3D70
[ 4022.170791] peak_pciefd 0000:0b:00.0: can1 at reg_base=3D0x0000000015bb0=
963 irq=3D71
[ 4022.170957] peak_pciefd 0000:0b:00.0: can2 at reg_base=3D0x000000004f07a=
1fc irq=3D72
[ 4022.171085] peak_pciefd 0000:0b:00.0: can3 at reg_base=3D0x00000000da023=
608 irq=3D73

When a canX interface is set to UP (see also $ ip link help can) then the I=
RQ is requested. It is freed when the interface goes back to DOWN.

Setting UP both can0 and can1:

$ sudo ip link set can0 up type can bitrate 500000
$ sudo ip link set can1 up type can bitrate 500000

$ cat /proc/interrupts | grep peak
 70:          0          0          0          0       3141          0     =
     0          0          0          1          0          0  IR-PCI-MSI 5=
767168-edge      peak_pciefd
 71:          1          0          0          0          0          0     =
     0          0          0       2602          0          0  IR-PCI-MSI 5=
767169-edge      peak_pciefd

(You can notice that host is 12 cores CPU. CAN interrupts are each handled =
by different cores.)

Setting DOWN can0 (=3D> issue):

$ sudo ip link set can0 down
$ cat /proc/interrupts | grep peak
 71:          1          0          0          0          0          0     =
     0          0          0       2602          0          0  IR-PCI-MSI 5=
767169-edge      peak_pciefd

Note that IR-PCI-MSI controller is being used, because of CONFIG_IRQ_REMAP.=
 According to arch/x86/kernel/apic/msi.c, this controller belongs to a doma=
in with MSI_FLAG_MULTI_PCI_MSI set.

Regards,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: jeudi 22 f=E9vrier 2018 16:20
> To: St=E9phane Grosjean <s.grosjean@peak-system.com>
> Cc: linux-pci@vger.kernel.org; Marc Zyngier <marc.zyngier@arm.com>;
> Thomas Gleixner <tglx@linutronix.de>
> Subject: Re: free_irq(IRQ#0) on PCIe device with MSI enabled issue...
>
> [+cc Marc, Thomas]
>
> Hi St=E9phane,
>
> Thanks for your email!
>
> On Thu, Feb 22, 2018 at 08:23:52AM +0000, St=E9phane Grosjean wrote:
> > I've been writing some drivers for Linux-can in the past years and
> > want to add support of MSI in one of them (see
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rive
> rs/net/can/peak_canfd).
> >
> > This device driver works with legacy shared INTx over a CAN PCIe
> > device. I'd like to switch to a full MSI usage of this device, which
> > proposes up to 4 vectors (this device is proposed with 1, 2 or 4 CAN
> > FD ports).
> >
> > I'm running x86_64 Kernel 4.13.0-32 from Ubuntu 17.10. Everything
> > looks ok as I successfully get the 4 consecutive IRQ levels. My
> > problem is this one: as soon as the driver free_irq() the FISRT IRQ
> > level, then it does not receive any interrupt from the device anymore,
> > for all other 3 IRQs... On the contrary, when the driver
> > free_irq() one of the 3 other IRQ (instead of the 1st one), then there
> > is no problem and all other interrupts (including the first IRQ
> > vector) are working as they should.
>
> Can you share the actual driver code you're running?  The peak_canfd.c in
> v4.16-rc1 doesn't have the MSI code in it, so I can't see exactly what yo=
u're
> doing.
>
> The fact that it does work on ARM suggests there's some difference in the
> arch code.  I don't know enough about this area to figure it out from scr=
atch,
> but maybe working through the actual code would help.
>
> It would be ideal if you could reproduce the problem on v4.16-rc1, in cas=
e it's
> something fixed since v4.13.
>
> > I contact you because this "issue" seems to be arch dependent:
> > running the same driver and the same board on another arch (ARM), then
> > everything works like a charm: the driver can free_irq() any IRQ in
> > any order without disturbing the other ones. But running on x86,
> > free_irq() on the FIRST MSI seems to (also) free all the other ones...
> >
> > Note that the driver set up MSI as described in the last version of
> > Documentation/PCI/MSI-HOWTO.txt.

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
--

--_002_AM5PR03MB2963AE1C1288495E4A45997ED6CC0AM5PR03MB2963eurp_
Content-Type: application/octet-stream;
	name="0001-can-peak-canfd-add-MSI-support.patch"
Content-Description: 0001-can-peak-canfd-add-MSI-support.patch
Content-Disposition: attachment;
	filename="0001-can-peak-canfd-add-MSI-support.patch"; size=3266;
	creation-date="Fri, 23 Feb 2018 10:39:22 GMT";
	modification-date="Fri, 23 Feb 2018 10:34:34 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21haW4u
YyBiL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2NhbmZkL3BlYWtfcGNpZWZkX21haW4uYwppbmRleCA3
ODhjMzQ2NGEzYjAuLjk5OTg4MWE2MWUyYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvY2FuL3Bl
YWtfY2FuZmQvcGVha19wY2llZmRfbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L2Nhbi9wZWFrX2Nh
bmZkL3BlYWtfcGNpZWZkX21haW4uYwpAQCAtMjAxLDYgKzIwMSw4IEBAIHN0cnVjdCBwY2llZmRf
Ym9hcmQgewogCXZvaWQgX19pb21lbSAqcmVnX2Jhc2U7CiAJc3RydWN0IHBjaV9kZXYgKnBjaV9k
ZXY7CiAJaW50IGNhbl9jb3VudDsKKwlpbnQgaXJxX2ZsYWdzOwkJCS8qIElSUUZfU0hBUkVEIG9y
IDAgKi8KKwlpbnQgbXNpX2NvdW50OwkJCS8qIGNvdW50IG9mIE1TSSBsZXZlbHMgaG9zdCBnaXZl
cyAqLwogCXNwaW5sb2NrX3QgY21kX2xvY2s7CQkvKiA2NC1iaXRzIGNtZHMgbXVzdCBiZSBhdG9t
aWMgKi8KIAlzdHJ1Y3QgcGNpZWZkX2NhbiAqY2FuWzBdOwkvKiBhcnJheSBvZiBuZXR3b3JrIGRl
dmljZXMgKi8KIH07CkBAIC00MTAsOSArNDEyLDkgQEAgc3RhdGljIGludCBwY2llZmRfcHJlX2Nt
ZChzdHJ1Y3QgcGVha19jYW5mZF9wcml2ICp1Y2FuKQogCQkJYnJlYWs7CiAKIAkJLyogZ29pbmcg
aW50byBvcGVyYXRpb25hbCBtb2RlOiBzZXR1cCBJUlEgaGFuZGxlciAqLwotCQllcnIgPSByZXF1
ZXN0X2lycShwcml2LT5ib2FyZC0+cGNpX2Rldi0+aXJxLAorCQllcnIgPSByZXF1ZXN0X2lycShw
cml2LT51Y2FuLm5kZXYtPmlycSwKIAkJCQkgIHBjaWVmZF9pcnFfaGFuZGxlciwKLQkJCQkgIElS
UUZfU0hBUkVELAorCQkJCSAgcHJpdi0+Ym9hcmQtPmlycV9mbGFncywKIAkJCQkgIFBDSUVGRF9E
UlZfTkFNRSwKIAkJCQkgIHByaXYpOwogCQlpZiAoZXJyKQpAQCAtNDkxLDcgKzQ5Myw3IEBAIHN0
YXRpYyBpbnQgcGNpZWZkX3Bvc3RfY21kKHN0cnVjdCBwZWFrX2NhbmZkX3ByaXYgKnVjYW4pCiAJ
CXBjaWVmZF9jYW5fd3JpdGVyZWcocHJpdiwgQ0FORkRfQ1RMX0lFTl9CSVQsCiAJCQkJICAgIFBD
SUVGRF9SRUdfQ0FOX1JYX0NUTF9DTFIpOwogCi0JCWZyZWVfaXJxKHByaXYtPmJvYXJkLT5wY2lf
ZGV2LT5pcnEsIHByaXYpOworCQlmcmVlX2lycShwcml2LT51Y2FuLm5kZXYtPmlycSwgcHJpdik7
CiAKIAkJdWNhbi0+Y2FuLnN0YXRlID0gQ0FOX1NUQVRFX1NUT1BQRUQ7CiAKQEAgLTY2Niw3ICs2
NjgsMTkgQEAgc3RhdGljIGludCBwY2llZmRfY2FuX3Byb2JlKHN0cnVjdCBwY2llZmRfYm9hcmQg
KnBjaWVmZCkKIAkJYnJlYWs7CiAJfQogCi0JbmRldi0+aXJxID0gcGNpZWZkLT5wY2lfZGV2LT5p
cnE7CisJc3dpdGNoIChwY2llZmQtPm1zaV9jb3VudCkgeworCWNhc2UgMDoKKwkJbmRldi0+aXJx
ID0gcGNpZWZkLT5wY2lfZGV2LT5pcnE7CisJCWJyZWFrOworCWNhc2UgMToKKwkJLyogKHNoYXJl
ZCkgc2luZ2xlLU1TSSAqLworCQluZGV2LT5pcnEgPSBwY2lfaXJxX3ZlY3RvcihwY2llZmQtPnBj
aV9kZXYsIDApOworCQlicmVhazsKKwlkZWZhdWx0OgorCQkvKiBtdWx0aS1NU0kgKi8KKwkJbmRl
di0+aXJxID0gcGNpX2lycV92ZWN0b3IocGNpZWZkLT5wY2lfZGV2LCBwcml2LT51Y2FuLmluZGV4
KTsKKwkJYnJlYWs7CisJfQogCiAJU0VUX05FVERFVl9ERVYobmRldiwgJnBjaWVmZC0+cGNpX2Rl
di0+ZGV2KTsKIApAQCAtNjgzLDcgKzY5Nyw3IEBAIHN0YXRpYyBpbnQgcGNpZWZkX2Nhbl9wcm9i
ZShzdHJ1Y3QgcGNpZWZkX2JvYXJkICpwY2llZmQpCiAJcGNpZWZkLT5jYW5bcGNpZWZkLT5jYW5f
Y291bnRdID0gcHJpdjsKIAogCWRldl9pbmZvKCZwY2llZmQtPnBjaV9kZXYtPmRldiwgIiVzIGF0
IHJlZ19iYXNlPTB4JXAgaXJxPSVkXG4iLAotCQkgbmRldi0+bmFtZSwgcHJpdi0+cmVnX2Jhc2Us
IHBjaWVmZC0+cGNpX2Rldi0+aXJxKTsKKwkJIG5kZXYtPm5hbWUsIHByaXYtPnJlZ19iYXNlLCBu
ZGV2LT5pcnEpOwogCiAJcmV0dXJuIDA7CiAKQEAgLTc4NSw2ICs3OTksMjUgQEAgc3RhdGljIGlu
dCBwZWFrX3BjaWVmZF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwKIAogCXBjaV9zZXRfbWFz
dGVyKHBkZXYpOwogCisJLyogZGVmYXVsdCBpczogc2hhcmVkIElOVHggbW9kZSAqLworCXBjaWVm
ZC0+aXJxX2ZsYWdzID0gSVJRRl9TSEFSRUQ7CisJcGNpZWZkLT5tc2lfY291bnQgPSAwOworCisJ
ZXJyID0gcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KHBkZXYsIDEsIGNhbl9jb3VudCwK
KwkJCQkJICAgICBQQ0lfSVJRX01TSSwgTlVMTCk7CisKKwlkZXZfaW5mbygmcGRldi0+ZGV2LCAi
TVNJWyV1Li4ldV0gZW5hYmxpbmcgc3RhdHVzOiAlZFxuIiwKKwkJIDEsIGNhbl9jb3VudCwgZXJy
KTsKKworCS8qIGlmIGRpZG4ndCBnZXQgdGhlIHJlcXVlc3RlZCBjb3VudCBvZiBNU0ksIGZhbGwg
YmFjayB0byBJTlR4ICovCisJaWYgKGVyciA+PSAwKSB7CisJCXBjaWVmZC0+bXNpX2NvdW50ID0g
ZXJyOworCisJCS8qIElSUSBub3Qgc2hhcmVkIG9ubHkgaWYgZWFjaCBjaGFubmVsIHdpbGwgZ2V0
IGl0cyBvd24gTVNJICovCisJCWlmIChwY2llZmQtPm1zaV9jb3VudCA9PSBjYW5fY291bnQpCisJ
CQlwY2llZmQtPmlycV9mbGFncyAmPSB+SVJRRl9TSEFSRUQ7CisJfQorCiAJLyogY3JlYXRlIG5v
dyB0aGUgY29ycmVzcG9uZGluZyBjaGFubmVscyBvYmplY3RzICovCiAJd2hpbGUgKHBjaWVmZC0+
Y2FuX2NvdW50IDwgY2FuX2NvdW50KSB7CiAJCWVyciA9IHBjaWVmZF9jYW5fcHJvYmUocGNpZWZk
KTsKQEAgLTgxNiw3ICs4NDksNyBAQCBzdGF0aWMgaW50IHBlYWtfcGNpZWZkX3Byb2JlKHN0cnVj
dCBwY2lfZGV2ICpwZGV2LAogCiBlcnJfZnJlZV9jYW5mZDoKIAlwY2llZmRfY2FuX3JlbW92ZV9h
bGwocGNpZWZkKTsKLQorCXBjaV9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOwogCXBjaV9pb3VubWFw
KHBkZXYsIHBjaWVmZC0+cmVnX2Jhc2UpOwogCiBlcnJfcmVsZWFzZV9yZWdpb25zOgpAQCAtODM4
LDcgKzg3MSw3IEBAIHN0YXRpYyB2b2lkIHBlYWtfcGNpZWZkX3JlbW92ZShzdHJ1Y3QgcGNpX2Rl
diAqcGRldikKIAogCS8qIHJlbGVhc2UgQ0FOLUZEIGNoYW5uZWxzIHJlc291cmNlcyAqLwogCXBj
aWVmZF9jYW5fcmVtb3ZlX2FsbChwY2llZmQpOwotCisJcGNpX2ZyZWVfaXJxX3ZlY3RvcnMocGRl
dik7CiAJcGNpX2lvdW5tYXAocGRldiwgcGNpZWZkLT5yZWdfYmFzZSk7CiAKIAlwY2lfcmVsZWFz
ZV9yZWdpb25zKHBkZXYpOwo=

--_002_AM5PR03MB2963AE1C1288495E4A45997ED6CC0AM5PR03MB2963eurp_--
