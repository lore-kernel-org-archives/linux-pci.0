Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35361 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2CUW3S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Mar 2012 18:29:18 -0400
Received: by vcqp1 with SMTP id p1so1501508vcq.19
        for <linux-pci@vger.kernel.org>; Wed, 21 Mar 2012 15:29:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F6A483D.50702@fold.natur.cuni.cz>
References: <4F6A483D.50702@fold.natur.cuni.cz>
Date: Wed, 21 Mar 2012 15:29:17 -0700
Message-ID: <CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com>
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec timeframe
From: Yinghai Lu <yinghai@kernel.org>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary=20cf3071caf86c76fb04bbc852c3
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--20cf3071caf86c76fb04bbc852c3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 2:29 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> Hi,
> =A0I am not sure whether this is a bug or feature but I have problems
> getting my USB3.0 PCI express card detected in my Dello Vostro 3550 lapto=
p.
> It appears to me after removal of the card there is about 60s window when
> the PCI INT is still kept (not released). After that time it is released,
> no matter that I for example meanwhile re-plugged the card already into
> the slot.
>
> =A0After having found this I can confirm that my express card gets detect=
ed
> if I insert it in after at least 60 seconds since its previous removal.
>
> =A0I have attached the logs from my attempts. Would anybody please confir=
m
> this is the intended behavior? Or is that because USB delay of the PCI IN=
T
> resource after cards removal? Could I be, as a user, informed that I am n=
ot
> supposed to re-insert the card in a whatever time window?
>
> Either way, thank you for comments,

can you please post whole boot log ?

wonder if your slot is supporting surprise removal.. if not, attached
patch could remove some
noise about

Mar 20 21:04:17 vostro kernel: pciehp 0000:00:1c.7:pcie04: Card not
present on Slot(7)
Mar 20 21:04:18 vostro kernel: pciehp 0000:00:1c.7:pcie04: Card
present on Slot(7)
Mar 20 21:04:19 vostro kernel: pciehp 0000:00:1c.7:pcie04: Card not
present on Slot(7)
Mar 20 21:04:20 vostro kernel: pciehp 0000:00:1c.7:pcie04: Card
present on Slot(7).

also we have some patches in pci/linux-next, that will power off pcie
link after removal.

so please check if that tree is going to help or wait for kernel 3.4-rc1.

      Yinghai

--20cf3071caf86c76fb04bbc852c3
Content-Type: text/x-patch; charset=US-ASCII; name="pciehp_suprise_present.patch"
Content-Disposition: attachment; filename="pciehp_suprise_present.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h02xzoq32

U3ViamVjdDogW1BBVENIXSBwY2llaHA6IERvbid0IGVuYWJsZSBwcmVzZW5jZSBub3RpZmljYXRp
b24gd2hpbGUgc3VycHJpc2UgcmVtb3ZhbCBpcyBub3Qgc3VwcG9ydGVkLgoKSWYgc3VycHJpc2Ug
cmVtb3ZhbCBpcyBub3Qgc3VwcG9ydGVkLCB0aGF0IGV2ZW50IGdldCBkcm9wcGVkIGxhdGVyLgpT
byB0aGVyZSBpcyBubyBwb2ludCB0byBlbmFibGUgdGhhdC4KCkFsc28gU29tZSBzaWNrIGNoaXBz
ZXQgaGF2ZSB0aG9zZSBiaXQgZmxpcCBhcm91bmQuCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1
IDx5aW5naGFpQGtlcm5lbC5vcmc+CgotLS0KIGRyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hw
Yy5jIHwgICAgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfaHBj
LmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2ll
aHBfaHBjLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9ocGMuYwpA
QCAtODA4LDcgKzgwOCw3IEBAIGludCBwY2llaHBfZ2V0X2N1cl9sbmtfd2lkdGgoc3RydWN0IHNs
b3QKIAogaW50IHBjaWVfZW5hYmxlX25vdGlmaWNhdGlvbihzdHJ1Y3QgY29udHJvbGxlciAqY3Ry
bCkKIHsKLQl1MTYgY21kLCBtYXNrOworCXUxNiBjbWQgPSAwLCBtYXNrOwogCiAJLyoKIAkgKiBU
QkQ6IFBvd2VyIGZhdWx0IGRldGVjdGVkIHNvZnR3YXJlIG5vdGlmaWNhdGlvbiBzdXBwb3J0LgpA
QCAtODIwLDcgKzgyMCw4IEBAIGludCBwY2llX2VuYWJsZV9ub3RpZmljYXRpb24oc3RydWN0IGNv
bnQKIAkgKiB3aGVuIGl0IGlzIGNsZWFyZWQgaW4gdGhlIGludGVycnVwdCBzZXJ2aWNlIHJvdXRp
bmUsIGFuZAogCSAqIG5leHQgcG93ZXIgZmF1bHQgZGV0ZWN0ZWQgaW50ZXJydXB0IHdhcyBub3Rp
ZmllZCBhZ2Fpbi4KIAkgKi8KLQljbWQgPSBQQ0lfRVhQX1NMVENUTF9QRENFOworCWlmIChIUF9T
VVBSX1JNKGN0cmwpKQorCQljbWQgfD0gUENJX0VYUF9TTFRDVExfUERDRTsKIAlpZiAoQVRUTl9C
VVRUTihjdHJsKSkKIAkJY21kIHw9IFBDSV9FWFBfU0xUQ1RMX0FCUEU7CiAJaWYgKE1STF9TRU5T
KGN0cmwpKQo=
--20cf3071caf86c76fb04bbc852c3--
