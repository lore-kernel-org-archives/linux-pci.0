Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	jchandra@broadcom.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	ddaney@caviumnetworks.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jcm@redhat.com,
	msalter@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V1 2/2] PCI: thunder: Enable ACPI PCI controller for ThunderX pass1.x silicon version
Date: Tue, 15 Nov 2016 10:14:58 +0100
Message-Id: <1479201298-25494-3-git-send-email-tn@semihalf.com>
In-Reply-To: <1479201298-25494-1-git-send-email-tn@semihalf.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ThunderX pass1.x requires to emulate the EA headers for on-chip devices
hence it has to use custom pci_thunder_ecam_ops for accessing PCI config
space (pci-thuner-ecam.c). Add new entries to MCFG quirk array where it
can be applied while probing ACPI based PCI host controller.

ThunderX pass1.x is using the same way for accessing off-chip devices
(so-called PEM) as silicon pass-2.x so we need to add PEM quirk
entries too.

Quirk is considered for ThunderX silicon pass1.x only which is identified
via MCFG revision 2.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/acpi/pci_mcfg.c             | 15 +++++++++++++++
 drivers/pci/host/pci-thunder-ecam.c |  2 +-
 include/linux/pci-ecam.h            |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index e4e2b9b..5e16211 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -76,6 +76,21 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	/* SoC pass2.x */
 	THUNDER_MCFG_QUIRK(1, 0UL),
 	THUNDER_MCFG_QUIRK(1, 1UL),
+
+	/* SoC pass1.x */
+	THUNDER_MCFG_QUIRK(2, 0UL),
+	THUNDER_MCFG_QUIRK(2, 1UL),
+#endif
+#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+	/* SoC pass1.x */
+	{ "CAVIUM", "THUNDERX", 2, 0, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 1, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 2, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 3, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 10, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 11, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 12, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
+	{ "CAVIUM", "THUNDERX", 2, 13, MCFG_BUS_ANY, &pci_thunder_ecam_ops },
 #endif
 };
 
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index d50a3dc..b6c17e2 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -346,7 +346,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static struct pci_ecam_ops pci_thunder_ecam_ops = {
+struct pci_ecam_ops pci_thunder_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus        = pci_ecam_map_bus,
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3f2a98f..5a1f291 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,6 +62,9 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 #ifdef CONFIG_PCI_HOST_THUNDER_PEM
 extern struct pci_ecam_ops pci_thunder_pem_ops;
 #endif
+#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+extern struct pci_ecam_ops pci_thunder_ecam_ops;
+#endif
 
 /* ops for buggy ECAM that supports only 32-bit accesses */
 extern struct pci_ecam_ops pci_32b_ops;
-- 
2.7.4
