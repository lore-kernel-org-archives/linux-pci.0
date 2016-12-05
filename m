Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbcLEX1J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:27:09 -0500
Subject: [PATCH v11 14/15] PCI: Add MCFG quirks for Cavium ThunderX pass1.x
 host controller
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:27:05 -0600
Message-ID: <20161205232705.3957.99341.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tn@semihalf.com>

ThunderX pass1.x requires to emulate the EA headers for on-chip devices
hence it has to use custom pci_thunder_ecam_ops for accessing PCI config
space (pci-thuner-ecam.c). Add new entries to MCFG quirk array where it can
be applied while probing ACPI based PCI host controller.

ThunderX pass1.x is using the same way for accessing off-chip devices
(so-called PEM) as silicon pass-2.x so we need to add PEM quirk entries
too.

Quirk is considered for ThunderX silicon pass1.x only which is identified
via MCFG revision 2.

[bhelgaas: change Makefile/ifdefs so quirk doesn't depend on
CONFIG_PCI_HOST_THUNDER_ECAM]
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_mcfg.c             |   15 +++++++++++++++
 drivers/pci/host/Kconfig            |    3 ++-
 drivers/pci/host/Makefile           |    2 +-
 drivers/pci/host/pci-thunder-ecam.c |    9 ++++++++-
 include/linux/pci-ecam.h            |    3 ++-
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 4044b8b..8913c5a 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -93,6 +93,21 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	/* SoC pass2.x */
 	THUNDER_PEM_QUIRK(1, 0UL),
 	THUNDER_PEM_QUIRK(1, 1UL),
+
+#define THUNDER_ECAM_QUIRK(rev, seg)					\
+	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
+	&pci_thunder_ecam_ops }
+	/* SoC pass1.x */
+	THUNDER_PEM_QUIRK(2,  0UL),	/* off-chip devices */
+	THUNDER_PEM_QUIRK(2,  1UL),	/* off-chip devices */
+	THUNDER_ECAM_QUIRK(2,  0),
+	THUNDER_ECAM_QUIRK(2,  1),
+	THUNDER_ECAM_QUIRK(2,  2),
+	THUNDER_ECAM_QUIRK(2,  3),
+	THUNDER_ECAM_QUIRK(2, 10),
+	THUNDER_ECAM_QUIRK(2, 11),
+	THUNDER_ECAM_QUIRK(2, 12),
+	THUNDER_ECAM_QUIRK(2, 13),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1239a8e..c983892 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -248,7 +248,8 @@ config PCI_HOST_THUNDER_PEM
 
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
-	depends on OF && ARM64
+	depends on ARM64
+	depends on OF || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 97e6bfc..639494a 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_PCIE_ALTERA) += pcie-altera.o
 obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
-obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
+obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
 obj-$(CONFIG_ARM64) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index d50a3dc..3f54a43 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -14,6 +14,8 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#if defined(CONFIG_PCI_HOST_THUNDER_ECAM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
+
 static void set_val(u32 v, int where, int size, u32 *val)
 {
 	int shift = (where & 3) * 8;
@@ -346,7 +348,7 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static struct pci_ecam_ops pci_thunder_ecam_ops = {
+struct pci_ecam_ops pci_thunder_ecam_ops = {
 	.bus_shift	= 20,
 	.pci_ops	= {
 		.map_bus        = pci_ecam_map_bus,
@@ -355,6 +357,8 @@ static struct pci_ecam_ops pci_thunder_ecam_ops = {
 	}
 };
 
+#ifdef CONFIG_PCI_HOST_THUNDER_ECAM
+
 static const struct of_device_id thunder_ecam_of_match[] = {
 	{ .compatible = "cavium,pci-host-thunder-ecam" },
 	{ },
@@ -373,3 +377,6 @@ static struct platform_driver thunder_ecam_driver = {
 	.probe = thunder_ecam_probe,
 };
 builtin_platform_driver(thunder_ecam_driver);
+
+#endif
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index e88d7db..00eb8eb 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,7 +62,8 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
 extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
-extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 2.x */
+extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 1.x & 2.x */
+extern struct pci_ecam_ops pci_thunder_ecam_ops; /* Cavium ThunderX 1.x */
 #endif
 
 #ifdef CONFIG_PCI_HOST_GENERIC

