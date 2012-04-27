Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28960 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab2D0B0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Apr 2012 21:26:22 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Subject: RE: [PATCH v6] Quirk for IVB graphics FLR errata
Date: Fri, 27 Apr 2012 01:26:18 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD906DD@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD24698@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4Dm45uRsvdzSAfrvGNPPA_7QqvC_Se-JxpJErsasoTKw@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
 <CAErSpo4Qm1DP-i2YWc1ZibiUAnPC-tLG9X0xceAvGFxs8e+mPQ@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD8BEA9@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4tUnA6oFr1uXyfVPHQh7F-LMN913pu=MfaEsRi5isLLQ@mail.gmail.com>
In-Reply-To: <CAErSpo4tUnA6oFr1uXyfVPHQh7F-LMN913pu=MfaEsRi5isLLQ@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="_002_403610A45A2B5242BD291EDAE8B37D300FD906DDSHSMSX102ccrcor_"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--_002_403610A45A2B5242BD291EDAE8B37D300FD906DDSHSMSX102ccrcor_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Bjorn,=20

Maybe something configuration wrong on my mail client, I attach the patch a=
s an attachment, can you open it in your side?

Thanks,
-Xudong

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Friday, April 27, 2012 7:15 AM
> To: Hao, Xudong
> Cc: linux-pci@vger.kernel.org; Don Dutile; Matthew Wilcox; Zhang, Xiantao
> Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
>=20
> On Wed, Apr 25, 2012 at 9:19 PM, Hao, Xudong <xudong.hao@intel.com>
> wrote:
> > For IvyBridge Mobile platform, a system hang may occur if a FLR(Functio=
n
> Level Reset) is asserted to internal graphics.
> >
> > This quirk patch is workaround for the IVB FLR errata issue.
> > We are disabling the FLR reset handshake between the PCH and CPU displa=
y,
> then
> > manually powering down the panel power sequencing and resetting the PCH
> display.
> >
> > Signed-off-by: Xudong Hao <xudong.hao@intel.com>
> > Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
> > Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> > ---
> > =A0drivers/pci/quirks.c | =A0 48
> ++++++++++++++++++++++++++++++++++++++++++++++++
> > =A01 files changed, 48 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4bf7102..213cad9 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -29,6 +29,7 @@
> > =A0#include <linux/sched.h>
> > =A0#include <linux/ktime.h>
> > =A0#include <asm/dma.h> =A0 /* isa_dma_bridge_buggy */
> > +#include <asm/io.h>
> > =A0#include "pci.h"
> >
> > =A0/*
> > @@ -3085,11 +3086,58 @@ static int reset_intel_82599_sfp_virtfn(struct
> pci_dev *dev, int probe)
> > =A0 =A0 =A0 =A0return 0;
> > =A0}
> >
> > +#include "../gpu/drm/i915/i915_reg.h"
> > +#define MSG_CTL =A0 =A0 =A0 =A00x45010
> > +#define IGD_OPERATION_TIMEOUT 10000 =A0 =A0 /* set timeout 10 seconds
> */
> > +
> > +static int reset_ivb_igd(struct pci_dev *dev, int probe)
> > +{
> > + =A0 =A0 =A0 void __iomem *mmio_base;
> > + =A0 =A0 =A0 unsigned long timeout;
> > + =A0 =A0 =A0 u32 val;
> > +
> > + =A0 =A0 =A0 if (probe)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > +
> > + =A0 =A0 =A0 mmio_base =3D ioremap_nocache(pci_resource_start(dev, 0),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_resou=
rce_len(dev, 0));
> > + =A0 =A0 =A0 if (!mmio_base)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 /* Work Around */
> > + =A0 =A0 =A0 writel(0x00000002, mmio_base + MSG_CTL);
> > + =A0 =A0 =A0 /* Clobbering SOUTH_CHICKEN2 register is fine only if the=
 next
> > + =A0 =A0 =A0 =A0* driver loaded sets the right bits. However, this's a=
 reset and
> > + =A0 =A0 =A0 =A0* the bits have been set by i915 previously, so we clo=
bber
> > + =A0 =A0 =A0 =A0* SOUTH_CHICKEN2 register directly here.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 writel(0x00000005, mmio_base + SOUTH_CHICKEN2);
> > + =A0 =A0 =A0 val =3D readl(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
> > + =A0 =A0 =A0 writel(val, mmio_base + PCH_PP_CONTROL);
> > + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(IGD_OPERATION_TIME=
OUT);
> > + =A0 =A0 =A0 while (time_before(jiffies, timeout)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readl(mmio_base + PCH_PP_STATUS);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((val & 0xB0000000) =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 writel(0x00000002, mmio_base + 0xd0100);
> > +
> > + =A0 =A0 =A0 iounmap(pci_resource_start(dev, 0));
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > =A0#define PCI_DEVICE_ID_INTEL_82599_SFP_VF =A0 0x10ed
> > +#define PCI_DEVICE_ID_INTEL_IVB_M_VGA =A0 =A0 =A00x0156
> > +#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA =A0 =A0 0x0166
> >
> > =A0static const struct pci_dev_reset_methods pci_dev_reset_methods[] =
=3D {
> > =A0 =A0 =A0 =A0{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset_intel_82599_sfp_virtfn },
> > + =A0 =A0 =A0 { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset_ivb_igd },
> > + =A0 =A0 =A0 { PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset_ivb_igd },
> > =A0 =A0 =A0 =A0{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reset_intel_generic_dev },
> > =A0 =A0 =A0 =A0{ 0 }
> > --
> > 1.6.0.rc1
> >
> >
> >> If we're doing FLR in a pass-through situation, where the host does
> >> the FLR but has no driver for the device, doing this in a quirk makes
> >> sense to me.
> >>
> >> I tried to apply this patch, but it's whitespace-damaged. =A0Can you r=
epost
> it?
> >>
> >
> >
> > Thanks Bjorn, I repost it and can you try again?
>=20
> Did you change anything, or did you just repost it the same way you
> did before?  The patch I see is still corrupted.  Here's what I see:
>=20
>=20
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/ktime.h>
>  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
> +#include <asm/io.h>
>  #include "pci.h"
> =3D20
> ...
>=20
> The "=3D20" is bogus.

--_002_403610A45A2B5242BD291EDAE8B37D300FD906DDSHSMSX102ccrcor_
Content-Type: application/octet-stream; name="ivb_gfx_quirk_v6.patch"
Content-Description: ivb_gfx_quirk_v6.patch
Content-Disposition: attachment; filename="ivb_gfx_quirk_v6.patch"; size=2802;
	creation-date="Fri, 27 Apr 2012 01:25:42 GMT";
	modification-date="Thu, 26 Apr 2012 18:28:53 GMT"
Content-Transfer-Encoding: base64

Rm9yIEl2eUJyaWRnZSBNb2JpbGUgcGxhdGZvcm0sIGEgc3lzdGVtIGhhbmcgbWF5IG9jY3VyIGlm
IGEgRkxSKEZ1bmN0aW9uIExldmVsIFJlc2V0KSBpcyBhc3NlcnRlZCB0byBpbnRlcm5hbCBncmFw
aGljcy4KClRoaXMgcXVpcmsgcGF0Y2ggaXMgd29ya2Fyb3VuZCBmb3IgdGhlIElWQiBGTFIgZXJy
YXRhIGlzc3VlLgpXZSBhcmUgZGlzYWJsaW5nIHRoZSBGTFIgcmVzZXQgaGFuZHNoYWtlIGJldHdl
ZW4gdGhlIFBDSCBhbmQgQ1BVIGRpc3BsYXksIHRoZW4KbWFudWFsbHkgcG93ZXJpbmcgZG93biB0
aGUgcGFuZWwgcG93ZXIgc2VxdWVuY2luZyBhbmQgcmVzZXR0aW5nIHRoZSBQQ0ggZGlzcGxheS4K
ClNpZ25lZC1vZmYtYnk6IFh1ZG9uZyBIYW8gPHh1ZG9uZy5oYW9AaW50ZWwuY29tPgpTaWduZWQt
b2ZmLWJ5OiBLYXksIEFsbGVuIE0gPGFsbGVuLm0ua2F5QGludGVsLmNvbT4KU2lnbmVkLW9mZi1i
eTogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGxpbnV4LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL3Bj
aS9xdWlya3MuYyB8ICAgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWly
a3MuYwppbmRleCA0YmY3MTAyLi4yMTNjYWQ5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9xdWly
a3MuYworKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwpAQCAtMjksNiArMjksNyBAQAogI2luY2x1
ZGUgPGxpbnV4L3NjaGVkLmg+CiAjaW5jbHVkZSA8bGludXgva3RpbWUuaD4KICNpbmNsdWRlIDxh
c20vZG1hLmg+CS8qIGlzYV9kbWFfYnJpZGdlX2J1Z2d5ICovCisjaW5jbHVkZSA8YXNtL2lvLmg+
CiAjaW5jbHVkZSAicGNpLmgiCiAKIC8qCkBAIC0zMDg1LDExICszMDg2LDU4IEBAIHN0YXRpYyBp
bnQgcmVzZXRfaW50ZWxfODI1OTlfc2ZwX3ZpcnRmbihzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQg
cHJvYmUpCiAJcmV0dXJuIDA7CiB9CiAKKyNpbmNsdWRlICIuLi9ncHUvZHJtL2k5MTUvaTkxNV9y
ZWcuaCIKKyNkZWZpbmUgTVNHX0NUTAkweDQ1MDEwCisjZGVmaW5lIElHRF9PUEVSQVRJT05fVElN
RU9VVCAxMDAwMCAgICAgLyogc2V0IHRpbWVvdXQgMTAgc2Vjb25kcyAqLworCitzdGF0aWMgaW50
IHJlc2V0X2l2Yl9pZ2Qoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHByb2JlKQoreworCXZvaWQg
X19pb21lbSAqbW1pb19iYXNlOworCXVuc2lnbmVkIGxvbmcgdGltZW91dDsKKwl1MzIgdmFsOwor
CisJaWYgKHByb2JlKQorCQlyZXR1cm4gMDsKKworCW1taW9fYmFzZSA9IGlvcmVtYXBfbm9jYWNo
ZShwY2lfcmVzb3VyY2Vfc3RhcnQoZGV2LCAwKSwKKwkJCQlwY2lfcmVzb3VyY2VfbGVuKGRldiwg
MCkpOworCWlmICghbW1pb19iYXNlKQorCQlyZXR1cm4gLUVOT01FTTsKKworCS8qIFdvcmsgQXJv
dW5kICovCisJd3JpdGVsKDB4MDAwMDAwMDIsIG1taW9fYmFzZSArIE1TR19DVEwpOworCS8qIENs
b2JiZXJpbmcgU09VVEhfQ0hJQ0tFTjIgcmVnaXN0ZXIgaXMgZmluZSBvbmx5IGlmIHRoZSBuZXh0
CisJICogZHJpdmVyIGxvYWRlZCBzZXRzIHRoZSByaWdodCBiaXRzLiBIb3dldmVyLCB0aGlzJ3Mg
YSByZXNldCBhbmQKKwkgKiB0aGUgYml0cyBoYXZlIGJlZW4gc2V0IGJ5IGk5MTUgcHJldmlvdXNs
eSwgc28gd2UgY2xvYmJlcgorCSAqIFNPVVRIX0NISUNLRU4yIHJlZ2lzdGVyIGRpcmVjdGx5IGhl
cmUuCisJICovCisJd3JpdGVsKDB4MDAwMDAwMDUsIG1taW9fYmFzZSArIFNPVVRIX0NISUNLRU4y
KTsKKwl2YWwgPSByZWFkbChtbWlvX2Jhc2UgKyBQQ0hfUFBfQ09OVFJPTCkgJiAweGZmZmZmZmZl
OworCXdyaXRlbCh2YWwsIG1taW9fYmFzZSArIFBDSF9QUF9DT05UUk9MKTsKKwl0aW1lb3V0ID0g
amlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoSUdEX09QRVJBVElPTl9USU1FT1VUKTsKKwl3aGls
ZSAodGltZV9iZWZvcmUoamlmZmllcywgdGltZW91dCkpIHsKKwkJdmFsID0gcmVhZGwobW1pb19i
YXNlICsgUENIX1BQX1NUQVRVUyk7CisJCWlmICgodmFsICYgMHhCMDAwMDAwMCkgPT0gMCkKKwkJ
CWJyZWFrOworCQljcHVfcmVsYXgoKTsKKwl9CisJd3JpdGVsKDB4MDAwMDAwMDIsIG1taW9fYmFz
ZSArIDB4ZDAxMDApOworCisJaW91bm1hcChwY2lfcmVzb3VyY2Vfc3RhcnQoZGV2LCAwKSk7CisJ
cmV0dXJuIDA7Cit9CisKICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF84MjU5OV9TRlBfVkYg
ICAweDEwZWQKKyNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9JVkJfTV9WR0EgICAgICAweDAx
NTYKKyNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9JVkJfTTJfVkdBICAgICAweDAxNjYKIAog
c3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2X3Jlc2V0X21ldGhvZHMgcGNpX2Rldl9yZXNldF9t
ZXRob2RzW10gPSB7CiAJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lfREVWSUNFX0lEX0lOVEVM
XzgyNTk5X1NGUF9WRiwKIAkJIHJlc2V0X2ludGVsXzgyNTk5X3NmcF92aXJ0Zm4gfSwKKwl7IFBD
SV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSVZCX01fVkdBLAorCQlyZXNl
dF9pdmJfaWdkIH0sCisJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lfREVWSUNFX0lEX0lOVEVM
X0lWQl9NMl9WR0EsCisJCXJlc2V0X2l2Yl9pZ2QgfSwKIAl7IFBDSV9WRU5ET1JfSURfSU5URUws
IFBDSV9BTllfSUQsCiAJCXJlc2V0X2ludGVsX2dlbmVyaWNfZGV2IH0sCiAJeyAwIH0KLS0gCjEu
Ni4wLnJjMQoK

--_002_403610A45A2B5242BD291EDAE8B37D300FD906DDSHSMSX102ccrcor_--
