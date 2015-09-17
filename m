Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX SoCs.
Date: Thu, 17 Sep 2015 15:41:33 -0700
Message-Id: <1442529694-1792-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

The on-chip devices all have fixed bars.  So, fix them up.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/pci/host/Kconfig          |  6 +++
 drivers/pci/host/Makefile         |  1 +
 drivers/pci/host/quirks-thunder.c | 95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/pci/host/quirks-thunder.c

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index d5e58ba..20d700d 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -145,4 +145,10 @@ config PCIE_IPROC_BCMA
 	  Say Y here if you want to use the Broadcom iProc PCIe controller
 	  through the BCMA bus interface
 
+config PCI_QUIRKS_THUNDER
+	bool "PCI quirks for Cavium ThunderX SoCs"
+	depends on ARM64
+	help
+	  Say Y here to support ThunderX SoCs
+
 endmenu
diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
index 140d66f..3ce7456 100644
--- a/drivers/pci/host/Makefile
+++ b/drivers/pci/host/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
 obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
 obj-$(CONFIG_PCIE_IPROC_PLATFORM) += pcie-iproc-platform.o
 obj-$(CONFIG_PCIE_IPROC_BCMA) += pcie-iproc-bcma.o
+obj-$(CONFIG_PCI_QUIRKS_THUNDER) += quirks-thunder.o
diff --git a/drivers/pci/host/quirks-thunder.c b/drivers/pci/host/quirks-thunder.c
new file mode 100644
index 0000000..d615fd8
--- /dev/null
+++ b/drivers/pci/host/quirks-thunder.c
@@ -0,0 +1,95 @@
+/*
+ * PCIe quirks for Cavium Thunder SOC
+ *
+ * Copyright (C) 2014, 2015 Cavium Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#define PCI_DEVICE_ID_THUNDER_BRIDGE		0xa002
+
+/*
+ * All PCIe devices in Thunder have fixed resources, shouldn't be
+ * reassigned.
+ */
+static void thunder_pci_fixup_header(struct pci_dev *dev)
+{
+	int resno;
+
+	/* Only fixup Thunder on-chip devices. */
+	if ((dev->device & 0xff00) != 0xa000)
+		return;
+
+	for (resno = 0; resno < PCI_NUM_RESOURCES; resno++)
+		if (dev->resource[resno].flags)
+			dev->resource[resno].flags |= IORESOURCE_PCI_FIXED;
+#ifdef CONFIG_PCI_IOV
+	if (dev->device == 0xa01e) {
+		dev->resource[PCI_IOV_RESOURCES + 0] = dev->resource[0];
+		dev->resource[PCI_IOV_RESOURCES + 0].start += 0xa0000000;
+		dev->resource[PCI_IOV_RESOURCES + 0].end =
+			dev->resource[PCI_IOV_RESOURCES + 0].start + 0x200000 - 1;
+		dev->resource[PCI_IOV_RESOURCES + 4] = dev->resource[0];
+		dev->resource[PCI_IOV_RESOURCES + 4].start += 0xe0000000;
+		dev->resource[PCI_IOV_RESOURCES + 4].end =
+			dev->resource[PCI_IOV_RESOURCES + 4].start + 0x200000 - 1;
+	}
+#endif
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, thunder_pci_fixup_header);
+
+static void thunder_pci_fixup_final(struct pci_dev *dev)
+{
+	struct resource *res;
+	int resno;
+
+	/* Only fixup Thunder on-chip devices. */
+	if ((dev->device & 0xff00) != 0xa000)
+		return;
+
+	if (dev->device == PCI_DEVICE_ID_THUNDER_BRIDGE) {
+		/*
+		 * This bridge is just for the sake of supporting ARI
+		 * for downstream devices. No resources are attached
+		 * to it.  Copy upstream root bus resources to bridge
+		 * which aide in resource claiming for downstream
+		 * devices
+		 */
+
+		struct pci_bus *bus;
+		int resno;
+
+		bus = dev->subordinate;
+		for (resno = 0; resno < PCI_BRIDGE_RESOURCE_NUM; resno++) {
+			bus->resource[resno] = pci_bus_resource_n(bus->parent,
+								  PCI_BRIDGE_RESOURCE_NUM + resno);
+		}
+
+		for (resno = PCI_BRIDGE_RESOURCES;
+		     resno <= PCI_BRIDGE_RESOURCE_END; resno++) {
+			dev->resource[resno].start = dev->resource[resno].end = 0;
+			dev->resource[resno].flags = 0;
+		}
+	} else {
+		/*
+		 * Claim the device's valid resources to set
+		 * 'res->parent' hierarchy.
+		 */
+		for (resno = 0; resno < PCI_BRIDGE_RESOURCES; resno++) {
+			res = &dev->resource[resno];
+			if (res->parent || !(res->flags & IORESOURCE_MEM))
+				continue;
+			pci_claim_resource(dev, resno);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, thunder_pci_fixup_final);
+
+MODULE_DESCRIPTION("PCI quirks for Cavium Thunder ECAM based devices");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

