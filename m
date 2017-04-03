Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jayachandran C <jnair@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Date: Mon,  3 Apr 2017 13:15:04 +0000
Message-Id: <1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
In-Reply-To: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Jayachandran C <jnair@caviumnetworks.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
topology is slightly unusual. For a multi-node system, it looks like:

[node level PCI bridges - one per node]
    [SoC PCI devices with MSI-X but no IOMMU]
    [PCI-PCIe "glue" bridges - upto 14, one per real port below]
        [PCIe real root ports associated with IOMMU and GICv3 ITS]
            [External PCI devices connected to PCIe links]

The top two levels of bridges should have introduced aliases since they
are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
In the case of external PCIe devices, the "real" root ports are connected
to the SMMU and the GIC ITS, so PCI-PCIe bridge does not introduce an
alias. The SoC PCI devices are directly connected to the GIC ITS, so the
node level bridges do not introduce an alias either.

To handle this quirk, we mark the real PCIe root ports and node level
PCI bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
