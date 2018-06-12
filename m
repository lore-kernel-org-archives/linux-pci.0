Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=GJIr=I6=broadcom.com=ray.jui@kernel.org>
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-pci@vger.kernel.org,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 3/5] PCI: iproc: Disable MSI parsing in certain PAXC blocks
Date: Mon, 11 Jun 2018 17:21:05 -0700
Message-Id: <1528762867-16823-4-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

The internal MSI parsing logic in certain revisions of PAXC root
complexes does not work properly and can casue corruptions on the
writes. They need to be disabled

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 680f6b1..0804aa2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1197,10 +1197,22 @@ static int iproc_pcie_paxb_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
 	return ret;
 }
 
-static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr)
+static void iproc_pcie_paxc_v2_msi_steer(struct iproc_pcie *pcie, u64 msi_addr,
+					 bool enable)
 {
 	u32 val;
 
+	if (!enable) {
+		/*
+		 * Disable PAXC MSI steering. All write transfers will be
+		 * treated as non-MSI transfers
+		 */
+		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_MSI_EN_CFG);
+		val &= ~MSI_ENABLE_CFG;
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_MSI_EN_CFG, val);
+		return;
+	}
+
 	/*
 	 * Program bits [43:13] of address of GITS_TRANSLATER register into
 	 * bits [30:0] of the MSI base address register.  In fact, in all iProc
@@ -1254,7 +1266,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
 			return ret;
 		break;
 	case IPROC_PCIE_PAXC_V2:
-		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr);
+		iproc_pcie_paxc_v2_msi_steer(pcie, msi_addr, true);
 		break;
 	default:
 		return -EINVAL;
@@ -1480,6 +1492,24 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 }
 EXPORT_SYMBOL(iproc_pcie_remove);
 
+/*
+ * The MSI parsing logic in certain revisions of Broadcom PAXC based root
+ * complex does not work and needs to be disabled
+ */
+static void quirk_paxc_disable_msi_parsing(struct pci_dev *pdev)
+{
+	struct iproc_pcie *pcie = iproc_data(pdev->bus);
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		iproc_pcie_paxc_v2_msi_steer(pcie, 0, false);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0,
+			quirk_paxc_disable_msi_parsing);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
+			quirk_paxc_disable_msi_parsing);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
+			quirk_paxc_disable_msi_parsing);
+
 MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
 MODULE_LICENSE("GPL v2");
-- 
2.1.4
