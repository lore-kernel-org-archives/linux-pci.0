Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbcLEX1C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:27:02 -0500
Subject: [PATCH v11 13/15] PCI: Add MCFG quirks for Cavium ThunderX pass2.x
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
Date: Mon, 05 Dec 2016 17:26:58 -0600
Message-ID: <20161205232657.3957.97517.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Tomasz Nowicki <tn@semihalf.com>

ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
compliant with ECAM standard. It uses non-standard configuration space
accessors (see thunder_pem_ecam_ops) and custom configuration space
granulation (see bus_shift = 24). In order to access configuration space
and probe PEM as ACPI-based PCI host controller we need to add MCFG quirk
infrastructure. This involves:
1. A new thunder_pem_acpi_init() init function to locate PEM-specific
   register ranges using ACPI.
2. Export PEM thunder_pem_ecam_ops structure so it is visible to MCFG quirk
   code.
3. New quirk entries for each PEM segment. Each contains platform IDs,
   mentioned thunder_pem_ecam_ops and CFG resources.

Quirk is considered for ThunderX silicon pass2.x only which is identified
via MCFG revision 1.

[bhelgaas: adapt to use acpi_get_rc_resources(), update Makefile/ifdefs so
quirk doesn't depend on CONFIG_PCI_HOST_THUNDER_PEM]
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_mcfg.c            |   19 ++++++++++++++++
 drivers/pci/host/Kconfig           |    3 ++
 drivers/pci/host/Makefile          |    2 +-
 drivers/pci/host/pci-thunder-pem.c |   44 ++++++++++++++++++++++++++++++++++++
 include/linux/pci-ecam.h           |    1 +
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 540515f..4044b8b 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -74,6 +74,25 @@ static struct mcfg_fixup mcfg_quirks[] = {
 	HISI_QUAD_DOM("HIP07   ",  4, &hisi_pcie_ops),
 	HISI_QUAD_DOM("HIP07   ",  8, &hisi_pcie_ops),
 	HISI_QUAD_DOM("HIP07   ", 12, &hisi_pcie_ops),
+
+#define THUNDER_PEM_RES(addr, seg) \
+	DEFINE_RES_MEM(addr + (seg << 44), 0x39 * SZ_16M)
+#define THUNDER_PEM_QUIRK(rev, seg) \
+	{ "CAVIUM", "THUNDERX", rev, 4 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88001f000000UL, seg) },  \
+	{ "CAVIUM", "THUNDERX", rev, 5 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x884057000000UL, seg) },  \
+	{ "CAVIUM", "THUNDERX", rev, 6 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x88808f000000UL, seg) },  \
+	{ "CAVIUM", "THUNDERX", rev, 7 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89001f000000UL, seg) },  \
+	{ "CAVIUM", "THUNDERX", rev, 8 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL, seg) },  \
+	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * seg), MCFG_BUS_ANY,	    \
+	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, seg) }
+	/* SoC pass2.x */
+	THUNDER_PEM_QUIRK(1, 0UL),
+	THUNDER_PEM_QUIRK(1, 1UL),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d7e7c0a..1239a8e 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -240,7 +240,8 @@ config PCIE_QCOM
 
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
-	depends on OF && ARM64
+	depends on ARM64
+	depends on OF || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 64845f0..97e6bfc 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_PCIE_ALTERA_MSI) += pcie-altera-msi.o
 obj-$(CONFIG_ARM64) += pcie-hisi.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
-obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
+obj-$(CONFIG_ARM64) += pci-thunder-pem.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index c3276ee..af722eb 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,8 +18,12 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
+#include "../pci.h"
+
+#if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
 #define PEM_CFG_WR 0x28
 #define PEM_CFG_RD 0x30
@@ -313,6 +317,43 @@ static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg,
 	return 0;
 }
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+
+static int thunder_pem_acpi_init(struct pci_config_window *cfg)
+{
+	struct device *dev = cfg->parent;
+	struct acpi_device *adev = to_acpi_device(dev);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+	struct resource *res_pem;
+	int ret;
+
+	res_pem = devm_kzalloc(&adev->dev, sizeof(*res_pem), GFP_KERNEL);
+	if (!res_pem)
+		return -ENOMEM;
+
+	ret = acpi_get_rc_resources(dev, "THRX0002", root->segment, res_pem);
+	if (ret) {
+		dev_err(dev, "can't get rc base address\n");
+		return ret;
+	}
+
+	return thunder_pem_init(dev, cfg, res_pem);
+}
+
+struct pci_ecam_ops thunder_pem_ecam_ops = {
+	.bus_shift	= 24,
+	.init		= thunder_pem_acpi_init,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= thunder_pem_config_read,
+		.write		= thunder_pem_config_write,
+	}
+};
+
+#endif
+
+#ifdef CONFIG_PCI_HOST_THUNDER_PEM
+
 static int thunder_pem_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -364,3 +405,6 @@ static struct platform_driver thunder_pem_driver = {
 	.probe = thunder_pem_probe,
 };
 builtin_platform_driver(thunder_pem_driver);
+
+#endif
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index bdacbc8..e88d7db 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -62,6 +62,7 @@ extern struct pci_ecam_ops pci_generic_ecam_ops;
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
 extern struct pci_ecam_ops hisi_pcie_ops;	/* HiSilicon */
+extern struct pci_ecam_ops thunder_pem_ecam_ops; /* Cavium ThunderX 2.x */
 #endif
 
 #ifdef CONFIG_PCI_HOST_GENERIC

