Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45150 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423864AbcFMTFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 15:05:54 -0400
Subject: [PATCH v6 3/3] PCI: Add PTM clock granularity information
To: Jonathan Yong <jonathan.yong@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Date: Mon, 13 Jun 2016 14:05:50 -0500
Message-ID: <20160613190550.12503.18319.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I don't know how to figure out clock granularity for Root Complex
Integrated Endpoints.  The spec (PCIe r3.1, sec 7.32.3) says:

  system software must set [Effective Granularity] to the value reported in
  the Local Clock Granularity field by the associated PTM Time Source

but I don't know how to identify the associated PTM Time Source.  An
integrated endpoint has no upstream bridge.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c        |   29 +++++++++++++++++++++++++++--
 include/linux/pci.h           |    1 +
 include/uapi/linux/pci_regs.h |    1 +
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 9cfa64a..a6ec4ae 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -19,7 +19,22 @@
 
 static void pci_ptm_info(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "PTM enabled%s\n", dev->ptm_root ? " (root)" : "");
+	char clock_desc[8];
+
+	switch (dev->ptm_granularity) {
+	case 0:
+		snprintf(clock_desc, sizeof(clock_desc), "unknown");
+		break;
+	case 255:
+		snprintf(clock_desc, sizeof(clock_desc), ">254ns");
+		break;
+	default:
+		snprintf(clock_desc, sizeof(clock_desc), "%udns",
+			 dev->ptm_granularity);
+		break;
+	}
+	dev_info(&dev->dev, "PTM enabled%s, %s granularity\n",
+		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
 void pci_ptm_init(struct pci_dev *dev)
@@ -27,6 +42,7 @@ void pci_ptm_init(struct pci_dev *dev)
 	int pos;
 	struct pci_dev *ups;
 	u32 cap, ctrl;
+	u8 local_clock;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -45,6 +61,7 @@ void pci_ptm_init(struct pci_dev *dev)
 		return;
 
 	pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
+	local_clock = (cap & PCI_PTM_GRANULARITY_MASK) >> 8;
 
 	/*
 	 * There's no point in enabling PTM unless it's enabled in the
@@ -55,14 +72,20 @@ void pci_ptm_init(struct pci_dev *dev)
 	ups = pci_upstream_bridge(dev);
 	if (ups && ups->ptm_enabled) {
 		ctrl = PCI_PTM_CTRL_ENABLE;
+		if (ups->ptm_granularity == 0)
+			dev->ptm_granularity = 0;
+		else if (ups->ptm_granularity > local_clock)
+			dev->ptm_granularity = ups->ptm_granularity;
 	} else {
 		if (cap & PCI_PTM_CAP_ROOT) {
 			ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
 			dev->ptm_root = 1;
+			dev->ptm_granularity = local_clock;
 		} else
 			return;
 	}
 
+	ctrl |= dev->ptm_granularity << 8;
 	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
 
@@ -103,6 +126,8 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	if (!(cap & PCI_PTM_CAP_REQ))
 		return -EINVAL;
 
+	dev->ptm_granularity = ups->ptm_granularity;
+
 	ctrl = PCI_PTM_CTRL_ENABLE;
 	pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
 	dev->ptm_enabled = 1;
@@ -110,6 +135,6 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
 	pci_ptm_info(dev);
 
 	if (granularity)
-		*granularity = 0;
+		*granularity = dev->ptm_granularity;
 	return 0;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 593b2c1..73b70d3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -365,6 +365,7 @@ struct pci_dev {
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
 	unsigned int	ptm_enabled:1;
+	u8		ptm_granularity;
 #endif
 #ifdef CONFIG_PCI_MSI
 	const struct attribute_group **msi_irq_groups;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 72bbe14..d812172 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -969,6 +969,7 @@
 #define PCI_PTM_CAP			0x04	    /* PTM Capability */
 #define  PCI_PTM_CAP_REQ		0x00000001  /* Requester capable */
 #define  PCI_PTM_CAP_ROOT		0x00000004  /* Root capable */
+#define  PCI_PTM_GRANULARITY_MASK	0x0000FF00  /* Clock granularity */
 #define PCI_PTM_CTRL			0x08	    /* PTM Control */
 #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
 #define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */

