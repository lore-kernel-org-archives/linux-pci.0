Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:53266 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbbETUmA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 16:42:00 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 04/16] Check the DID for certain workaround error flags to be set.
Date: Wed, 20 May 2015 11:41:05 -0400
Message-Id: <9c6ef6eec533bd94ddc6df96bb0b2d37baff75cf.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 196 +++++++++++++++++++-----------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  24 ++++-
 drivers/ntb/ntb_transport.c         |  16 +--
 3 files changed, 133 insertions(+), 103 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index d162f22..89fea50 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -503,7 +503,6 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	size_t buf_size;
 	ssize_t ret, off;
 	union { u64 v64; u32 v32; u16 v16; } u;
-	unsigned long reg;
 
 	ndev = filp->private_data;
 	mmio = ndev->self_mmio;
@@ -538,10 +537,10 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 
 	if (!ndev->reg->link_is_up(ndev)) {
 		off += scnprintf(buf + off, buf_size - off,
-				 "Link Satus -\t\tDown\n");
+				 "Link Status -\t\tDown\n");
 	} else {
 		off += scnprintf(buf + off, buf_size - off,
-				 "Link Satus -\t\tUp\n");
+				 "Link Status -\t\tUp\n");
 		off += scnprintf(buf + off, buf_size - off,
 				 "Link Speed -\t\tPCI-E Gen %u\n",
 				 NTB_LNK_STA_SPEED(ndev->lnk_sta));
@@ -568,36 +567,30 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "Doorbell Mask Cached -\t%#llx\n", ndev->db_mask);
 
-	reg = ndev->self_reg->db_mask;
-	u.v64 = ndev_db_read(ndev, mmio + reg);
+	u.v64 = ndev_db_read(ndev, mmio + ndev->self_reg->db_mask);
 	off += scnprintf(buf + off, buf_size - off,
 			 "Doorbell Mask -\t\t%#llx\n", u.v64);
 
-	reg = ndev->self_reg->db_bell;
-	u.v64 = ndev_db_read(ndev, mmio + reg);
+	u.v64 = ndev_db_read(ndev, mmio + ndev->self_reg->db_bell);
 	off += scnprintf(buf + off, buf_size - off,
 			 "Doorbell Bell -\t\t%#llx\n", u.v64);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "\nNTB Incoming XLAT:\n");
 
-	reg = bar2_off(ndev->xlat_reg->bar2_xlat, 2);
-	u.v64 = ioread64(mmio + reg);
+	u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_xlat, 2));
 	off += scnprintf(buf + off, buf_size - off,
 			 "XLAT23 -\t\t%#018llx\n", u.v64);
 
-	reg = bar2_off(ndev->xlat_reg->bar2_xlat, 4);
-	u.v64 = ioread64(mmio + reg);
+	u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_xlat, 4));
 	off += scnprintf(buf + off, buf_size - off,
 			 "XLAT45 -\t\t%#018llx\n", u.v64);
 
-	reg = bar2_off(ndev->xlat_reg->bar2_limit, 2);
-	u.v64 = ioread64(mmio + reg);
+	u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_limit, 2));
 	off += scnprintf(buf + off, buf_size - off,
 			 "LMT23 -\t\t\t%#018llx\n", u.v64);
 
-	reg = bar2_off(ndev->xlat_reg->bar2_limit, 4);
-	u.v64 = ioread64(mmio + reg);
+	u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_limit, 4));
 	off += scnprintf(buf + off, buf_size - off,
 			 "LMT45 -\t\t\t%#018llx\n", u.v64);
 
@@ -606,41 +599,34 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Outgoing B2B XLAT:\n");
 
-			reg = bar2_off(SNB_PBAR2XLAT_OFFSET, 2);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_PBAR23XLAT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B XLAT23 -\t\t%#018llx\n", u.v64);
 
-			reg = bar2_off(SNB_PBAR2XLAT_OFFSET, 4);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_PBAR45XLAT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B XLAT45 -\t\t%#018llx\n", u.v64);
 
-			reg = bar2_off(SNB_PBAR2LMT_OFFSET, 2);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_PBAR23LMT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B LMT23 -\t\t%#018llx\n", u.v64);
 
-			reg = bar2_off(SNB_PBAR2LMT_OFFSET, 4);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_PBAR45LMT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B LMT45 -\t\t%#018llx\n", u.v64);
 
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Secondary BAR:\n");
 
-			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 0);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_SBAR0BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR01 -\t\t%#018llx\n", u.v64);
 
-			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 2);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_SBAR23BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR23 -\t\t%#018llx\n", u.v64);
 
-			reg = bar0_off(SNB_SBAR0BASE_OFFSET, 4);
-			u.v64 = ioread64(mmio + reg);
+			u.v64 = ioread64(mmio + SNB_SBAR45BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR45 -\t\t%#018llx\n", u.v64);
 		}
@@ -648,31 +634,30 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 		off += scnprintf(buf + off, buf_size - off,
 				 "\nSNB NTB Statistics:\n");
 
-		reg = SNB_USMEMMISS_OFFSET;
-		u.v16 = ioread16(mmio + reg);
+		u.v16 = ioread16(mmio + SNB_USMEMMISS_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "Upstream Memory Miss -\t%u\n", u.v16);
 
 		off += scnprintf(buf + off, buf_size - off,
 				 "\nSNB NTB Hardware Errors:\n");
 
-		reg = SNB_DEVSTS_OFFSET;
-		if (!pci_read_config_word(ndev->ntb.pdev, reg, &u.v16))
+		if (!pci_read_config_word(ndev->ntb.pdev,
+					  SNB_DEVSTS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "DEVSTS -\t\t%#06x\n", u.v16);
 
-		reg = SNB_LINK_STATUS_OFFSET;
-		if (!pci_read_config_word(ndev->ntb.pdev, reg, &u.v16))
+		if (!pci_read_config_word(ndev->ntb.pdev,
+					  SNB_LINK_STATUS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "LNKSTS -\t\t%#06x\n", u.v16);
 
-		reg = SNB_UNCERRSTS_OFFSET;
-		if (!pci_read_config_dword(ndev->ntb.pdev, reg, &u.v32))
+		if (!pci_read_config_dword(ndev->ntb.pdev,
+					   SNB_UNCERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "UNCERRSTS -\t\t%#06x\n", u.v32);
 
-		reg = SNB_CORERRSTS_OFFSET;
-		if (!pci_read_config_dword(ndev->ntb.pdev, reg, &u.v32))
+		if (!pci_read_config_dword(ndev->ntb.pdev,
+					   SNB_CORERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "CORERRSTS -\t\t%#06x\n", u.v32);
 	}
@@ -1388,7 +1373,6 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 {
 	struct pci_dev *pdev;
 	void __iomem *mmio;
-	unsigned long off;
 	resource_size_t bar_size;
 	phys_addr_t bar_addr;
 	int b2b_bar;
@@ -1484,9 +1468,6 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		dev_dbg(ndev_dev(ndev), "SBAR5SZ %#x\n", bar_sz);
 	}
 
-	/* setup incoming bar base addresses */
-	off = SNB_SBAR0BASE_OFFSET;
-
 	/* SBAR01 hit by first part of the b2b bar */
 	if (b2b_bar == 0) {
 		bar_addr = addr->bar0_addr;
@@ -1504,7 +1485,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	}
 
 	dev_dbg(ndev_dev(ndev), "SBAR01 %#018llx\n", bar_addr);
-	iowrite64(bar_addr, mmio + bar0_off(off, 0));
+	iowrite64(bar_addr, mmio + SNB_SBAR0BASE_OFFSET);
 
 	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
 	 * The b2b bar is either disabled above, or configured half-size, and
@@ -1512,102 +1493,96 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 */
 
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
-	iowrite64(bar_addr, mmio + bar0_off(off, 2));
-	bar_addr = ioread64(mmio + bar0_off(off, 2));
+	iowrite64(bar_addr, mmio + SNB_SBAR23BASE_OFFSET);
+	bar_addr = ioread64(mmio + SNB_SBAR23BASE_OFFSET);
 	dev_dbg(ndev_dev(ndev), "SBAR23 %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite64(bar_addr, mmio + bar0_off(off, 4));
-		bar_addr = ioread64(mmio + bar0_off(off, 4));
+		iowrite64(bar_addr, mmio + SNB_SBAR45BASE_OFFSET);
+		bar_addr = ioread64(mmio + SNB_SBAR45BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR45 %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + bar0_off(off, 4));
-		bar_addr = ioread32(mmio + bar0_off(off, 4));
+		iowrite32(bar_addr, mmio + SNB_SBAR4BASE_OFFSET);
+		bar_addr = ioread32(mmio + SNB_SBAR4BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR4 %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + bar0_off(off, 5));
-		bar_addr = ioread32(mmio + bar0_off(off, 5));
+		iowrite32(bar_addr, mmio + SNB_SBAR5BASE_OFFSET);
+		bar_addr = ioread32(mmio + SNB_SBAR5BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR5 %#010llx\n", bar_addr);
 	}
 
 	/* setup incoming bar limits == base addrs (zero length windows) */
-	off = SNB_SBAR2LMT_OFFSET;
 
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
-	iowrite64(bar_addr, mmio + bar2_off(off, 2));
-	bar_addr = ioread64(mmio + bar2_off(off, 2));
+	iowrite64(bar_addr, mmio + SNB_SBAR23LMT_OFFSET);
+	bar_addr = ioread64(mmio + SNB_SBAR23LMT_OFFSET);
 	dev_dbg(ndev_dev(ndev), "SBAR23LMT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite64(bar_addr, mmio + bar2_off(off, 4));
-		bar_addr = ioread64(mmio + bar2_off(off, 4));
+		iowrite64(bar_addr, mmio + SNB_SBAR45LMT_OFFSET);
+		bar_addr = ioread64(mmio + SNB_SBAR45LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR45LMT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + bar2_off(off, 4));
-		bar_addr = ioread32(mmio + bar2_off(off, 4));
+		iowrite32(bar_addr, mmio + SNB_SBAR4LMT_OFFSET);
+		bar_addr = ioread32(mmio + SNB_SBAR4LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR4LMT %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + bar2_off(off, 5));
-		bar_addr = ioread32(mmio + bar2_off(off, 5));
+		iowrite32(bar_addr, mmio + SNB_SBAR5LMT_OFFSET);
+		bar_addr = ioread32(mmio + SNB_SBAR5LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR5LMT %#05llx\n", bar_addr);
 	}
 
 	/* zero incoming translation addrs */
-	off = SNB_SBAR2XLAT_OFFSET;
-
-	iowrite64(0, mmio + bar2_off(off, 2));
+	iowrite64(0, mmio + SNB_SBAR23XLAT_OFFSET);
 
 	if (!ndev->bar4_split) {
-		iowrite64(0, mmio + bar2_off(off, 4));
+		iowrite64(0, mmio + SNB_SBAR45XLAT_OFFSET);
 	} else {
-		iowrite32(0, mmio + bar2_off(off, 4));
-		iowrite32(0, mmio + bar2_off(off, 5));
+		iowrite32(0, mmio + SNB_SBAR4XLAT_OFFSET);
+		iowrite32(0, mmio + SNB_SBAR5XLAT_OFFSET);
 	}
 
 	/* zero outgoing translation limits (whole bar size windows) */
-	off = SNB_PBAR2LMT_OFFSET;
-	iowrite64(0, mmio + bar2_off(off, 2));
+	iowrite64(0, mmio + SNB_PBAR23LMT_OFFSET);
 	if (!ndev->bar4_split) {
-		iowrite64(0, mmio + bar2_off(off, 4));
+		iowrite64(0, mmio + SNB_PBAR45LMT_OFFSET);
 	} else {
-		iowrite32(0, mmio + bar2_off(off, 4));
-		iowrite32(0, mmio + bar2_off(off, 5));
+		iowrite32(0, mmio + SNB_PBAR4LMT_OFFSET);
+		iowrite32(0, mmio + SNB_PBAR5LMT_OFFSET);
 	}
 
 	/* set outgoing translation offsets */
-	off = SNB_PBAR2XLAT_OFFSET;
-
 	bar_addr = peer_addr->bar2_addr64;
-	iowrite64(bar_addr, mmio + bar2_off(off, 2));
-	bar_addr = ioread64(mmio + bar2_off(off, 2));
+	iowrite64(bar_addr, mmio + SNB_PBAR23XLAT_OFFSET);
+	bar_addr = ioread64(mmio + SNB_PBAR23XLAT_OFFSET);
 	dev_dbg(ndev_dev(ndev), "PBAR23XLAT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = peer_addr->bar4_addr64;
-		iowrite64(bar_addr, mmio + bar2_off(off, 4));
-		bar_addr = ioread64(mmio + bar2_off(off, 4));
+		iowrite64(bar_addr, mmio + SNB_PBAR45XLAT_OFFSET);
+		bar_addr = ioread64(mmio + SNB_PBAR45XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR45XLAT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = peer_addr->bar2_addr64;
-		iowrite32(bar_addr, mmio + bar2_off(off, 4));
-		bar_addr = ioread32(mmio + bar2_off(off, 4));
+		iowrite32(bar_addr, mmio + SNB_PBAR4XLAT_OFFSET);
+		bar_addr = ioread32(mmio + SNB_PBAR4XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR4XLAT %#010llx\n", bar_addr);
 
 		bar_addr = peer_addr->bar2_addr64;
-		iowrite32(bar_addr, mmio + bar2_off(off, 5));
-		bar_addr = ioread32(mmio + bar2_off(off, 5));
+		iowrite32(bar_addr, mmio + SNB_PBAR5XLAT_OFFSET);
+		bar_addr = ioread32(mmio + SNB_PBAR5XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR5XLAT %#010llx\n", bar_addr);
 	}
 
@@ -1747,29 +1722,68 @@ static int snb_init_dev(struct intel_ntb_dev *ndev)
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
@@ -2062,14 +2076,14 @@ static const struct intel_ntb_xlat_reg snb_pri_xlat = {
 	 * window by setting the limit equal to base, nor can it limit the size
 	 * of the memory window by setting the limit to base + size.
 	 */
-	.bar2_limit		= SNB_PBAR2LMT_OFFSET,
-	.bar2_xlat		= SNB_PBAR2XLAT_OFFSET,
+	.bar2_limit		= SNB_PBAR23LMT_OFFSET,
+	.bar2_xlat		= SNB_PBAR23XLAT_OFFSET,
 };
 
 static const struct intel_ntb_xlat_reg snb_sec_xlat = {
 	.bar0_base		= SNB_SBAR0BASE_OFFSET,
-	.bar2_limit		= SNB_SBAR2LMT_OFFSET,
-	.bar2_xlat		= SNB_SBAR2XLAT_OFFSET,
+	.bar2_limit		= SNB_SBAR23LMT_OFFSET,
+	.bar2_xlat		= SNB_SBAR23XLAT_OFFSET,
 };
 
 static const struct intel_b2b_addr snb_b2b_usd_addr = {
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 0224b1a..fec689d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -70,11 +70,27 @@
 
 /* SNB hardware (and JSF, IVT, HSX) */
 
-#define SNB_PBAR2LMT_OFFSET		0x0000
-#define SNB_PBAR2XLAT_OFFSET		0x0010
-#define SNB_SBAR2LMT_OFFSET		0x0020
-#define SNB_SBAR2XLAT_OFFSET		0x0030
+#define SNB_PBAR23LMT_OFFSET		0x0000
+#define SNB_PBAR45LMT_OFFSET		0x0008
+#define SNB_PBAR4LMT_OFFSET		0x0008
+#define SNB_PBAR5LMT_OFFSET		0x000c
+#define SNB_PBAR23XLAT_OFFSET		0x0010
+#define SNB_PBAR45XLAT_OFFSET		0x0018
+#define SNB_PBAR4XLAT_OFFSET		0x0018
+#define SNB_PBAR5XLAT_OFFSET		0x001c
+#define SNB_SBAR23LMT_OFFSET		0x0020
+#define SNB_SBAR45LMT_OFFSET		0x0028
+#define SNB_SBAR4LMT_OFFSET		0x0028
+#define SNB_SBAR5LMT_OFFSET		0x002c
+#define SNB_SBAR23XLAT_OFFSET		0x0030
+#define SNB_SBAR45XLAT_OFFSET		0x0038
+#define SNB_SBAR4XLAT_OFFSET		0x0038
+#define SNB_SBAR5XLAT_OFFSET		0x003c
 #define SNB_SBAR0BASE_OFFSET		0x0040
+#define SNB_SBAR23BASE_OFFSET		0x0048
+#define SNB_SBAR45BASE_OFFSET		0x0050
+#define SNB_SBAR4BASE_OFFSET		0x0050
+#define SNB_SBAR5BASE_OFFSET		0x0054
 #define SNB_SBDF_OFFSET			0x005c
 #define SNB_NTBCNTL_OFFSET		0x0058
 #define SNB_PDOORBELL_OFFSET		0x0060
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f1ed1b7..bb2eb85 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -204,8 +204,8 @@ struct ntb_transport_ctx {
 
 	bool link_is_up;
 	struct delayed_work link_work;
-	struct work_struct db_work;
 	struct work_struct link_cleanup;
+	struct tasklet_struct db_work;
 };
 
 enum {
@@ -241,7 +241,7 @@ enum {
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
-static void ntb_transport_doorbell_work(struct work_struct *ws);
+static void ntb_transport_doorbell_work(unsigned long data);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
 
@@ -1002,8 +1002,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	}
 
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
-	INIT_WORK(&nt->db_work, ntb_transport_doorbell_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
+	tasklet_init(&nt->db_work, ntb_transport_doorbell_work,
+		     (unsigned long)nt);
 
 	rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
 	if (rc)
@@ -1044,7 +1045,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	int i;
 
 	ntb_transport_link_cleanup(nt);
-	cancel_work_sync(&nt->db_work);
+	tasklet_disable(&nt->db_work);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
 
@@ -1850,10 +1851,9 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
-static void ntb_transport_doorbell_work(struct work_struct *work)
+static void ntb_transport_doorbell_work(unsigned long data)
 {
-	struct ntb_transport_ctx *nt = container_of(work,
-			struct ntb_transport_ctx, db_work);
+	struct ntb_transport_ctx *nt = (void *)data;
 	struct ntb_transport_qp *qp;
 	u64 db_mask, db_bits, db_again;
 	unsigned int qp_num;
@@ -1890,7 +1890,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 
 	ntb_db_set_mask(nt->ndev, ntb_db_valid_mask(nt->ndev));
 
-	schedule_work(&nt->db_work);
+	tasklet_schedule(&nt->db_work);
 }
 
 static const struct ntb_ctx_ops ntb_transport_ops = {
-- 
2.4.0.rc0.43.gcf8a8c6

