Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Matthew Garrett <mjg59@coreos.com>, Julia Cartwright <julia@ni.com>,
	Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: [PATCH] Force to clear ASPM bits if CONFIG_PCIEASPM_PERFORMANCE is
 set
Date: Wed, 2 Nov 2016 09:26:55 +0000
Message-ID: <95e1fc6e84cf42e094d4a8478c37b18e@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On systems that have PCIe ASPM support in the BIOS enabled
the commit 387d37577fdd05e9472c20885464c2a53b3c945f may lead
to the situation that accesses to registers of enabled
PCIe devices are extremely slow.
This happens if the ACPI FADT declares incorrectly that the
system doesn't support PCIe ASPM even if this is enabled in
the BIOS.
In this case the function pcie_no_aspm() will be called.
However this sets the aspm_policy to POLICY_DEFAULT even
if CONFIG_PCIEASPM_PERFORMANCE has been configured.
As result, the ASPM on a PCIe may still be set even if=20
this is not expected.

This happens e.g. on a HP workstation 800 G1 together with
an Intel dual port Ethernet server adapter i350 plugged in.
Whenever ASPM is enabled in the BIOS the access to the=20
LAN registers are really slow (read access: slower than 20us).
In this setup the LnkCap of the two LAN controllers and
of the integrated PCIe switch is set to "ASPM L1 Enabled"=20
even if the controller is configured to be up and running.
There has been a lengthy discussion on this performance issue
due to this issue on the linux-rt-users list:
http://marc.info/?l=3Dlinux-rt-users&m=3D147454824515022&w=3D2


This patch solves this issue by forcing to disable ASPM
if CONFIG_PCIEASPM_PERFORMANCE has been set.

Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>

---
 drivers/pci/pcie/aspm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-4.8/drivers/pci/pcie/aspm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-4.8.orig/drivers/pci/pcie/aspm.c
+++ linux-4.8/drivers/pci/pcie/aspm.c
@@ -79,10 +79,13 @@ static LIST_HEAD(link_list);
=20
 #ifdef CONFIG_PCIEASPM_PERFORMANCE
 static int aspm_policy =3D POLICY_PERFORMANCE;
+static int aspm_default_config_policy =3D POLICY_PERFORMANCE;
 #elif defined CONFIG_PCIEASPM_POWERSAVE
 static int aspm_policy =3D POLICY_POWERSAVE;
+static int aspm_default_config_policy =3D POLICY_POWERSAFE;
 #else
 static int aspm_policy;
+static int aspm_default_config_policy;
 #endif
=20
 static const char *policy_str[] =3D {
@@ -946,7 +949,7 @@ void pcie_no_aspm(void)
 	 * (b) prevent userspace from changing policy
 	 */
 	if (!aspm_force) {
-		aspm_policy =3D POLICY_DEFAULT;
+		aspm_policy =3D aspm_default_config_policy;
 		aspm_disabled =3D 1;
 	}
 }
