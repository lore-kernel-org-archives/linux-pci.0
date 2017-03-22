Return-Path: <SRS0=nzUO=27=cavium.com=Jayachandran.Nair@kernel.org>
Return-Path: <SRS0=nzUO=27=cavium.com=Jayachandran.Nair@kernel.org>
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org
Cc: Jayachandran C <jchandra@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Jon Masters <jcm@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH v3 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Date: Wed, 22 Mar 2017 08:51:11 +0000
Message-Id: <1490172671-2648-3-git-send-email-jnair@caviumnetworks.com>
In-Reply-To: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
References: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

From: Jayachandran C <jchandra@broadcom.com>

The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
topology is slightly unusual. For a multi-node system, it looks like:

[node level PCI bridges - one per node]
    [SoC PCI devices with MSI-X but no IOMMU]
    [PCI-PCIe "glue" bridges - upto 14, one per real bridge below]
        [PCIe real root ports associated with IOMMU and GICv3 ITS]
            [External PCI devices connected to PCIe links]

The top two levels of bridges should have introduced aliases since they
are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
In the case of external PCIe devices, the "real" root ports are connected
to the SMMU and the GIC ITS, so there is no aliases. The SoC PCI devices
are directly connected to the GIC ITS and the bridges do not introduce
an alias either.

To handle this quirk, we mark the real PCIe root ports and node level
PCIe bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
pci_for_each_dma_alias() works correctly for external PCIe devices and
SoC PCI devices.

For the current revision of Cavium ThunderX2, the VendorID and Device ID
are from Broadcom Vulcan (14e4:90XX).

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/pci/quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6736836..564a84a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3958,6 +3958,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
 
 /*
+ * The IOMMU and interrupt controller on Broadcom Vulcan/Cavium ThunderX2 are
+ * associated not at the root bus, but at a bridge below. This quirk flag
+ * will ensure that the aliases are identified correctly.
+ */
+static void quirk_bridge_cavm_thrx2_pcie_root(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9000,
+				quirk_bridge_cavm_thrx2_pcie_root);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BROADCOM, 0x9084,
+				quirk_bridge_cavm_thrx2_pcie_root);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
-- 
2.7.4
