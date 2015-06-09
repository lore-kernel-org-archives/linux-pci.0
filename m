Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:56822 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933016AbbFIOpa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2015 10:45:30 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 05/18] NTB: Check the device ID to set errata flags
Date: Tue,  9 Jun 2015 05:44:32 -0400
Message-Id: <530e415992e4c4e23831bfbdf7b25cca1811378d.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Set errata flags for the specific device IDs to which they apply,
instead of the whole xeon hardware class.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 49 +++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 64ce690d9616..3686ac1a3ee2 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1719,29 +1719,68 @@ static int snb_init_dev(struct intel_ntb_dev *ndev)
 	u8 ppd;
 	int rc, mem;
 
+	pdev = ndev_pdev(ndev);
+
+	switch (pdev->device) {
 	/* There is a Xeon hardware errata related to writes to SDOORBELL or
 	 * B2BDOORBELL in conjunction with inbound access to NTB MMIO Space,
 	 * which may hang the system.  To workaround this use the second memory
 	 * window to access the interrupt and scratch pad registers on the
 	 * remote system.
 	 */
-	ndev->hwerr_flags |= NTB_HWERR_SDOORBELL_LOCKUP;
+	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+		ndev->hwerr_flags |= NTB_HWERR_SDOORBELL_LOCKUP;
+		break;
+	}
 
+	switch (pdev->device) {
 	/* There is a hardware errata related to accessing any register in
 	 * SB01BASE in the presence of bidirectional traffic crossing the NTB.
 	 */
-	ndev->hwerr_flags |= NTB_HWERR_SB01BASE_LOCKUP;
+	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+		ndev->hwerr_flags |= NTB_HWERR_SB01BASE_LOCKUP;
+		break;
+	}
 
+	switch (pdev->device) {
 	/* HW Errata on bit 14 of b2bdoorbell register.  Writes will not be
 	 * mirrored to the remote system.  Shrink the number of bits by one,
 	 * since bit 14 is the last bit.
 	 */
-	ndev->hwerr_flags |= NTB_HWERR_B2BDOORBELL_BIT14;
+	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_JSF:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_SNB:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_IVT:
+	case PCI_DEVICE_ID_INTEL_NTB_SS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_PS_HSX:
+	case PCI_DEVICE_ID_INTEL_NTB_B2B_HSX:
+		ndev->hwerr_flags |= NTB_HWERR_B2BDOORBELL_BIT14;
+		break;
+	}
 
 	ndev->reg = &snb_reg;
 
-	pdev = ndev_pdev(ndev);
-
 	rc = pci_read_config_byte(pdev, SNB_PPD_OFFSET, &ppd);
 	if (rc)
 		return -EIO;
-- 
2.4.0.rc0.43.gcf8a8c6

