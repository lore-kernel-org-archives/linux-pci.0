Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57430 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760086AbbBIJr4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Feb 2015 04:47:56 -0500
Message-ID: <54D8823F.9080900@canonical.com>
Date: Mon, 09 Feb 2015 10:47:43 +0100
From: Stefan Bader <stefan.bader@canonical.com>
MIME-Version: 1.0
To: Sander Eikelenboom <linux@eikelenboom.it>,
	Jiang Liu <jiang.liu@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Bugfix 0/3] Xen IRQ related hotfixes for v3.19
References: <1421720467-7709-1-git-send-email-jiang.liu@linux.intel.com> <1369609199.20150205210757@eikelenboom.it>
In-Reply-To: <1369609199.20150205210757@eikelenboom.it>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9GJi1Kxxu4vGegBWqAPKq1i5TOHdvHmV4"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9GJi1Kxxu4vGegBWqAPKq1i5TOHdvHmV4
Content-Type: multipart/mixed;
 boundary="------------010905020801010205030104"

This is a multi-part message in MIME format.
--------------010905020801010205030104
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05.02.2015 21:07, Sander Eikelenboom wrote:
>=20
> Tuesday, January 20, 2015, 3:21:04 AM, you wrote:
>=20
>> Hi Thomas,
>>         This patch set includes three hotfixes related Xen IRQ for v3.=
19.
>> Sorry for the long delay to get these two regressions fixed, it really=

>> cost me some time to read and understand Xen IRQ code.
>=20
>> Patch 1 fixes the failure to register ACPI SCI interrupt on Xen
>> domain0 by reworking acpi_gsi_to_irq(). I will backport it to v3.18
>> too once it reaches the mainstream kernel.
>=20
>> Patch 2 fixes the regression in Xen PCI device passthrough(pciback).
>> It's a temporary solution, I will send the formal fix for v3.20 and
>> it has passed tests too.
>=20
>> Patch 3 fixes an issue found when reading code. There's no real bug
>> reports related to this issue yet.
>=20
>> Great thanks to Konrad and Sander for testing fixes for these regressi=
ons.
>=20
>> Regards,
>> Gerry
>=20
> Hi Gerry,
>=20
> Since these patches now are: tested, reviewed and have landed into main=
line,
> could you also provide the backports for 3.17 and 3.18 where required ?=


This would be my attempt of backporting those to 3.18 (I have not tried w=
hether
they would apply to 3.17 as well). Those seem to work when test-booting a=
nd
Sander said he will give them a try as well. But better check yourself I =
did not
mess anything up while backporting. One of the three patches seemed not t=
o be
required at all.

-Stefan

>=20
> The number of people running into these (subtle) issues with these stab=
le
> kernels seems to be steadily increasing.
>=20
> --
> Sander
>=20
>> Jiang Liu (3):
>>   xen/pci: Kill function xen_setup_acpi_sci()
>>   xen/irq, ACPI: Fix regression in xen PCI passthrough caused by
>>     cffe0a2b5a34
>>   xen/irq: Override ACPI IRQ management callback __acpi_unregister_gsi=

>=20
>>  arch/x86/include/asm/acpi.h |    1 +
>>  arch/x86/kernel/acpi/boot.c |   26 +++++++++++------------
>>  arch/x86/pci/xen.c          |   49 ++--------------------------------=
---------
>>  drivers/acpi/pci_irq.c      |    1 -
>>  4 files changed, 16 insertions(+), 61 deletions(-)
>=20
>=20


--------------010905020801010205030104
Content-Type: text/x-diff;
 name="0001-x86-xen-Treat-SCI-interrupt-as-normal-GSI-interrupt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-x86-xen-Treat-SCI-interrupt-as-normal-GSI-interrupt.pat";
 filename*1="ch"

=46rom 8b5b328b62248d95743ca9af7aa71c06dd808dfe Mon Sep 17 00:00:00 2001
From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Tue, 20 Jan 2015 10:21:05 +0800
Subject: [PATCH 1/2] x86/xen: Treat SCI interrupt as normal GSI interrupt=


Currently Xen Domain0 has special treatment for ACPI SCI interrupt,
that is initialize irq for ACPI SCI at early stage in a special way as:
xen_init_IRQ()
	->pci_xen_initial_domain()
		->xen_setup_acpi_sci()
			Allocate and initialize irq for ACPI SCI

Function xen_setup_acpi_sci() calls acpi_gsi_to_irq() to get an irq
number for ACPI SCI. But unfortunately acpi_gsi_to_irq() depends on
IOAPIC irqdomains through following path
acpi_gsi_to_irq()
	->mp_map_gsi_to_irq()
		->mp_map_pin_to_irq()
			->check IOAPIC irqdomain

For PV domains, it uses Xen event based interrupt manangement and
doesn't make uses of native IOAPIC, so no irqdomains created for IOAPIC.
This causes Xen domain0 fail to install interrupt handler for ACPI SCI
and all ACPI events will be lost. Please refer to:
https://lkml.org/lkml/2014/12/19/178

So the fix is to get rid of special treatment for ACPI SCI, just treat
ACPI SCI as normal GSI interrupt as:
acpi_gsi_to_irq()
	->acpi_register_gsi()
		->acpi_register_gsi_xen()
			->xen_register_gsi()

With above change, there's no need for xen_setup_acpi_sci() anymore.
The above change also works with bare metal kernel too.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Tony Luck <tony.luck@intel.com>
Cc: xen-devel@lists.xenproject.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: http://lkml.kernel.org/r/1421720467-7709-2-git-send-email-jiang.liu=
@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
---
 arch/x86/kernel/acpi/boot.c | 23 +++++++++++-----------
 arch/x86/pci/xen.c          | 47 ---------------------------------------=
------
 2 files changed, 12 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index a142e77..460f498 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -604,18 +604,19 @@ void __init acpi_pic_sci_set_trigger(unsigned int i=
rq, u16 trigger)
=20
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
 {
-	int irq;
-
-	if (acpi_irq_model =3D=3D ACPI_IRQ_MODEL_PIC) {
-		*irqp =3D gsi;
-	} else {
-		irq =3D mp_map_gsi_to_irq(gsi,
-					IOAPIC_MAP_ALLOC | IOAPIC_MAP_CHECK);
-		if (irq < 0)
-			return -1;
-		*irqp =3D irq;
+	int rc, irq, trigger, polarity;
+
+	rc =3D acpi_get_override_irq(gsi, &trigger, &polarity);
+	if (rc =3D=3D 0) {
+		trigger =3D trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		polarity =3D polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+		irq =3D acpi_register_gsi(NULL, gsi, trigger, polarity);
+		if (irq >=3D 0) {
+			*irqp =3D irq;
+			return 0;
+		}
 	}
-	return 0;
+	return -1;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
=20
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 093f5f4..6b3cf7c 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -452,52 +452,6 @@ int __init pci_xen_hvm_init(void)
 }
=20
 #ifdef CONFIG_XEN_DOM0
-static __init void xen_setup_acpi_sci(void)
-{
-	int rc;
-	int trigger, polarity;
-	int gsi =3D acpi_sci_override_gsi;
-	int irq =3D -1;
-	int gsi_override =3D -1;
-
-	if (!gsi)
-		return;
-
-	rc =3D acpi_get_override_irq(gsi, &trigger, &polarity);
-	if (rc) {
-		printk(KERN_WARNING "xen: acpi_get_override_irq failed for acpi"
-				" sci, rc=3D%d\n", rc);
-		return;
-	}
-	trigger =3D trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
-	polarity =3D polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
-
-	printk(KERN_INFO "xen: sci override: global_irq=3D%d trigger=3D%d "
-			"polarity=3D%d\n", gsi, trigger, polarity);
-
-	/* Before we bind the GSI to a Linux IRQ, check whether
-	 * we need to override it with bus_irq (IRQ) value. Usually for
-	 * IRQs below IRQ_LEGACY_IRQ this holds IRQ =3D=3D GSI, as so:
-	 *  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
-	 * but there are oddballs where the IRQ !=3D GSI:
-	 *  ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 low level)
-	 * which ends up being: gsi_to_irq[9] =3D=3D 20
-	 * (which is what acpi_gsi_to_irq ends up calling when starting the
-	 * the ACPI interpreter and keels over since IRQ 9 has not been
-	 * setup as we had setup IRQ 20 for it).
-	 */
-	if (acpi_gsi_to_irq(gsi, &irq) =3D=3D 0) {
-		/* Use the provided value if it's valid. */
-		if (irq >=3D 0)
-			gsi_override =3D irq;
-	}
-
-	gsi =3D xen_register_gsi(gsi, gsi_override, trigger, polarity);
-	printk(KERN_INFO "xen: acpi sci %d\n", gsi);
-
-	return;
-}
-
 int __init pci_xen_initial_domain(void)
 {
 	int irq;
@@ -509,7 +463,6 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.msi_mask_irq =3D xen_nop_msi_mask_irq;
 	x86_msi.msix_mask_irq =3D xen_nop_msix_mask_irq;
 #endif
-	xen_setup_acpi_sci();
 	__acpi_register_gsi =3D acpi_register_gsi_xen;
 	/* Pre-allocate legacy irqs */
 	for (irq =3D 0; irq < nr_legacy_irqs(); irq++) {
--=20
1.9.1


--------------010905020801010205030104
Content-Type: text/x-diff;
 name="0002-x86-xen-Override-ACPI-IRQ-management-callback-__acpi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0002-x86-xen-Override-ACPI-IRQ-management-callback-__acpi.pa";
 filename*1="tch"

=46rom 96f1d05b484334ff01ea2ee2b66798e294e34d96 Mon Sep 17 00:00:00 2001
From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Tue, 20 Jan 2015 10:21:07 +0800
Subject: [PATCH 2/2] x86/xen: Override ACPI IRQ management callback
 __acpi_unregister_gsi

Xen overrides __acpi_register_gsi and leaves __acpi_unregister_gsi as is.=

That means, an IRQ allocated by acpi_register_gsi_xen_hvm() or
acpi_register_gsi_xen() will be freed by acpi_unregister_gsi_ioapic(),
which may cause undesired effects. So override __acpi_unregister_gsi to
NULL for safety.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
Cc: Tony Luck <tony.luck@intel.com>
Cc: xen-devel@lists.xenproject.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Lv Zheng <lv.zheng@intel.com>
Link: http://lkml.kernel.org/r/1421720467-7709-4-git-send-email-jiang.liu=
@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
---
 arch/x86/include/asm/acpi.h | 1 +
 arch/x86/pci/xen.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 0ab4f9f..3a45668 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -50,6 +50,7 @@ void acpi_pic_sci_set_trigger(unsigned int, u16);
=20
 extern int (*__acpi_register_gsi)(struct device *dev, u32 gsi,
 				  int trigger, int polarity);
+extern void (*__acpi_unregister_gsi)(u32 gsi);
=20
 static inline void disable_acpi(void)
 {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 6b3cf7c..3c41716 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -442,6 +442,7 @@ int __init pci_xen_hvm_init(void)
 	 * just how GSIs get registered.
 	 */
 	__acpi_register_gsi =3D acpi_register_gsi_xen_hvm;
+	__acpi_unregister_gsi =3D NULL;
 #endif
=20
 #ifdef CONFIG_PCI_MSI
@@ -464,6 +465,7 @@ int __init pci_xen_initial_domain(void)
 	x86_msi.msix_mask_irq =3D xen_nop_msix_mask_irq;
 #endif
 	__acpi_register_gsi =3D acpi_register_gsi_xen;
+	__acpi_unregister_gsi =3D NULL;
 	/* Pre-allocate legacy irqs */
 	for (irq =3D 0; irq < nr_legacy_irqs(); irq++) {
 		int trigger, polarity;
--=20
1.9.1


--------------010905020801010205030104--

--9GJi1Kxxu4vGegBWqAPKq1i5TOHdvHmV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU2IJGAAoJEOhnXe7L7s6jbEsQALyc2yL/urFmSxsC4zxZEV9h
sslTmOpvceioK7V6rbJptlEPiGb6gKKQha/SxkYjobp3NPRjFP5uCEVAEkj0vfQQ
kACmdENmkDn8UF7umiqXum3jtbULtAhSiio4puuwItPf2L6NNksvnAU4jhNZNtL1
m1BvhFevVtEmeb/rd0JcUByxGXXB+8RGb7mkyHCk1Ak+YXDET5iz8+zL7ujyHoEQ
MEM2Abl9bla2xJz91vXlsHglTvMzpAf6J1qWkWzfvXlcWJnO1/Qza0/4nWtyfrxZ
O8nZEWUKBT1P1YLmXAuODf5IVGOclc8Ut8MHkGh8HPgpG7VgOVtYV0LR5AmEt2DS
Y6tMvhtzK92n7l5zBs4AZw6fQxI1xIJeWRvaRAj1Pb334xYSz/LJxSTTS+P4Leuy
uiwFVzWMAPkV8yEjz4VcBnnvewOdYE42z4O/M/3bUT0T91N1QGAbLi5SVoewEnNh
1oa/SuU1NKJdT6A4BAqO43iWRpe3Q+URvcO0ou0IOWhg08lNg/4KMG8jvNIEmmoc
2/ODkDzkbZi+xyzkq/Okgq/OhNnEoCNiejkxOOsPyGbb5pp+T8o/feUKYZY1gzm3
vBnuSVa8GYaPpXS1Rs4oGXYfo196jBt2MyCtX6Fx15XfrMwDsS2JDeIPkPFsSGII
Q55L27qQS14uUlLNL7AI
=6pWP
-----END PGP SIGNATURE-----

--9GJi1Kxxu4vGegBWqAPKq1i5TOHdvHmV4--
