Return-Path: <jchandra@broadcom.com>
Return-Path: <jchandra@broadcom.com>
From: Jayachandran C <jchandra@broadcom.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Cc: Jayachandran C <jchandra@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: Handle Broadcom Vulcan DMA alias calculation quirk
Date: Sun,  8 May 2016 15:03:21 +0530
Message-Id: <1462700001-30086-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1462700001-30086-1-git-send-email-jchandra@broadcom.com>
References: <1462700001-30086-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <linux-pci@vger.kernel.org>
References: <linux-pci@vger.kernel.org>
List-ID: <linux-pci.vger.kernel.org>

The Broadcom Vulcan PCI topology is slightly unusual, for a multi-node
system, it looks like:

 [bus 0]
     |
     +--[node 0 PCI bridge 0.0.0]
     |           |
     |        [bus 1]
     |           +---[SoC PCI devices 1.4.x, 1.5.x] ........
     |           +---[Glue bridges    1.a.x, 1.b.x]         \
     |                    |                        .....{node 0 GIC ITS}
     |                    |                       /
     |                    +----[SoC PCIe controller root ports]
     |                                |         \...... {SMMUv3 0..3}
     |                                |
     |                                +---- [external PCI devices]
     +- [node 1 PCI bridge 0.0.1]
     |           |
     |        [bus n - similar to bus 1 above]
     ...

The for_each_dma_alias call for external PCI devices should not go
beyond the PCIe controllers where the SMMU and ITS is associated, going
further above to the glue bridges or the node bridges will find aliases
which are not valid. For internal devices, the association is at the
node level bridge and the alias search should not go further.

To handle this quirk, we mark the SoC PCIe bridges and node PCI bridge
with flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT so that the alias and RID
calculations are correct.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8e67802..62664b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3734,6 +3734,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * The IOMMU and interrupt controller of Broadcom vulcan are associated
+ * not at the root bus, but at a bridge below. The DMA alias search should
+ * not go above the bridge at which the association exists.
+ */
+static void quirk_bridge_brcm_vulcan_pcie_root(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_ROOT;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
+				quirk_bridge_brcm_vulcan_pcie_root);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
+				quirk_bridge_brcm_vulcan_pcie_root);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
-- 
1.9.1
