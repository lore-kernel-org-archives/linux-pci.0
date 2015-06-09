Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 17/18] NTB: Rename intel hw to proper platform names
Date: Tue,  9 Jun 2015 05:44:44 -0400
Message-Id: <c988b4b832003e065f0457c740e6d9a79e9d031d.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Instead of using code names, apply correct platform names to
respective Intel NTB hw.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ntb.txt               |  20 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c | 620 ++++++++++++++++++------------------
 drivers/ntb/hw/intel/ntb_hw_intel.h | 290 ++++++++---------
 3 files changed, 465 insertions(+), 465 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index b48249a7b607..1d9bbabb6c79 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -115,13 +115,13 @@ Module Parameters:
 * b2b\_mw\_share - If the peer ntb is to be accessed via a memory window, and if
 	the memory window is large enough, still allow the client to use the
 	second half of the memory window for address translation to the peer.
-* snb\_b2b\_usd\_bar2\_addr64 - If using B2B topology on Xeon hardware, use this
-	64 bit address on the bus between the NTB devices for the window at
-	BAR2, on the upstream side of the link.
-* snb\_b2b\_usd\_bar4\_addr64 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_usd\_bar4\_addr32 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_usd\_bar5\_addr32 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_dsd\_bar2\_addr64 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_dsd\_bar4\_addr64 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_dsd\_bar4\_addr32 - See *snb\_b2b\_bar2\_addr64*.
-* snb\_b2b\_dsd\_bar5\_addr32 - See *snb\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_usd\_bar2\_addr64 - If using B2B topology on Xeon hardware, use
+	this 64 bit address on the bus between the NTB devices for the window
+	at BAR2, on the upstream side of the link.
+* xeon\_b2b\_usd\_bar4\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_usd\_bar4\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_usd\_bar5\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_dsd\_bar2\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_dsd\_bar4\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_dsd\_bar4\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon\_b2b\_dsd\_bar5\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index a7f1b01cfdb3..c19a7eec72cd 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -72,20 +72,20 @@ MODULE_AUTHOR("Intel Corporation");
 #define bar0_off(base, bar) ((base) + ((bar) << 2))
 #define bar2_off(base, bar) bar0_off(base, (bar) - 2)
 
-static const struct intel_ntb_reg bwd_reg;
-static const struct intel_ntb_alt_reg bwd_pri_reg;
-static const struct intel_ntb_alt_reg bwd_sec_reg;
-static const struct intel_ntb_alt_reg bwd_b2b_reg;
-static const struct intel_ntb_xlat_reg bwd_pri_xlat;
-static const struct intel_ntb_xlat_reg bwd_sec_xlat;
-static const struct intel_ntb_reg snb_reg;
-static const struct intel_ntb_alt_reg snb_pri_reg;
-static const struct intel_ntb_alt_reg snb_sec_reg;
-static const struct intel_ntb_alt_reg snb_b2b_reg;
-static const struct intel_ntb_xlat_reg snb_pri_xlat;
-static const struct intel_ntb_xlat_reg snb_sec_xlat;
-static struct intel_b2b_addr snb_b2b_usd_addr;
-static struct intel_b2b_addr snb_b2b_dsd_addr;
+static const struct intel_ntb_reg atom_reg;
+static const struct intel_ntb_alt_reg atom_pri_reg;
+static const struct intel_ntb_alt_reg atom_sec_reg;
+static const struct intel_ntb_alt_reg atom_b2b_reg;
+static const struct intel_ntb_xlat_reg atom_pri_xlat;
+static const struct intel_ntb_xlat_reg atom_sec_xlat;
+static const struct intel_ntb_reg xeon_reg;
+static const struct intel_ntb_alt_reg xeon_pri_reg;
+static const struct intel_ntb_alt_reg xeon_sec_reg;
+static const struct intel_ntb_alt_reg xeon_b2b_reg;
+static const struct intel_ntb_xlat_reg xeon_pri_xlat;
+static const struct intel_ntb_xlat_reg xeon_sec_xlat;
+static struct intel_b2b_addr xeon_b2b_usd_addr;
+static struct intel_b2b_addr xeon_b2b_dsd_addr;
 static const struct ntb_dev_ops intel_ntb_ops;
 
 static const struct file_operations intel_ntb_debugfs_info;
@@ -105,45 +105,45 @@ MODULE_PARM_DESC(b2b_mw_share, "If the b2b mw is large enough, configure the "
 		 "the mw, so the second half can still be used as a mw.  Both "
 		 "sides MUST set the same value here!");
 
-module_param_named(snb_b2b_usd_bar2_addr64,
-		   snb_b2b_usd_addr.bar2_addr64, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
-		 "SNB B2B USD BAR 2 64-bit address");
-
-module_param_named(snb_b2b_usd_bar4_addr64,
-		   snb_b2b_usd_addr.bar4_addr64, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
-		 "SNB B2B USD BAR 4 64-bit address");
-
-module_param_named(snb_b2b_usd_bar4_addr32,
-		   snb_b2b_usd_addr.bar4_addr32, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
-		 "SNB B2B USD split-BAR 4 32-bit address");
-
-module_param_named(snb_b2b_usd_bar5_addr32,
-		   snb_b2b_usd_addr.bar5_addr32, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
-		 "SNB B2B USD split-BAR 5 32-bit address");
-
-module_param_named(snb_b2b_dsd_bar2_addr64,
-		   snb_b2b_dsd_addr.bar2_addr64, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
-		 "SNB B2B DSD BAR 2 64-bit address");
-
-module_param_named(snb_b2b_dsd_bar4_addr64,
-		   snb_b2b_dsd_addr.bar4_addr64, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
-		 "SNB B2B DSD BAR 4 64-bit address");
-
-module_param_named(snb_b2b_dsd_bar4_addr32,
-		   snb_b2b_dsd_addr.bar4_addr32, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
-		 "SNB B2B DSD split-BAR 4 32-bit address");
-
-module_param_named(snb_b2b_dsd_bar5_addr32,
-		   snb_b2b_dsd_addr.bar5_addr32, ullong, 0644);
-MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
-		 "SNB B2B DSD split-BAR 5 32-bit address");
+module_param_named(xeon_b2b_usd_bar2_addr64,
+		   xeon_b2b_usd_addr.bar2_addr64, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+		 "XEON B2B USD BAR 2 64-bit address");
+
+module_param_named(xeon_b2b_usd_bar4_addr64,
+		   xeon_b2b_usd_addr.bar4_addr64, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+		 "XEON B2B USD BAR 4 64-bit address");
+
+module_param_named(xeon_b2b_usd_bar4_addr32,
+		   xeon_b2b_usd_addr.bar4_addr32, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+		 "XEON B2B USD split-BAR 4 32-bit address");
+
+module_param_named(xeon_b2b_usd_bar5_addr32,
+		   xeon_b2b_usd_addr.bar5_addr32, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
+		 "XEON B2B USD split-BAR 5 32-bit address");
+
+module_param_named(xeon_b2b_dsd_bar2_addr64,
+		   xeon_b2b_dsd_addr.bar2_addr64, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+		 "XEON B2B DSD BAR 2 64-bit address");
+
+module_param_named(xeon_b2b_dsd_bar4_addr64,
+		   xeon_b2b_dsd_addr.bar4_addr64, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+		 "XEON B2B DSD BAR 4 64-bit address");
+
+module_param_named(xeon_b2b_dsd_bar4_addr32,
+		   xeon_b2b_dsd_addr.bar4_addr32, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+		 "XEON B2B DSD split-BAR 4 32-bit address");
+
+module_param_named(xeon_b2b_dsd_bar5_addr32,
+		   xeon_b2b_dsd_addr.bar5_addr32, ullong, 0644);
+MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
+		 "XEON B2B DSD split-BAR 5 32-bit address");
 
 #ifndef ioread64
 #ifdef readq
@@ -174,7 +174,7 @@ static inline void _iowrite64(u64 val, void __iomem *mmio)
 #endif
 #endif
 
-static inline int pdev_is_bwd(struct pci_dev *pdev)
+static inline int pdev_is_atom(struct pci_dev *pdev)
 {
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_NTB_B2B_BWD:
@@ -183,7 +183,7 @@ static inline int pdev_is_bwd(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline int pdev_is_snb(struct pci_dev *pdev)
+static inline int pdev_is_xeon(struct pci_dev *pdev)
 {
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
@@ -637,70 +637,70 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "LMT45 -\t\t\t%#018llx\n", u.v64);
 
-	if (pdev_is_snb(ndev->ntb.pdev)) {
+	if (pdev_is_xeon(ndev->ntb.pdev)) {
 		if (ntb_topo_is_b2b(ndev->ntb.topo)) {
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Outgoing B2B XLAT:\n");
 
-			u.v64 = ioread64(mmio + SNB_PBAR23XLAT_OFFSET);
+			u.v64 = ioread64(mmio + XEON_PBAR23XLAT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B XLAT23 -\t\t%#018llx\n", u.v64);
 
-			u.v64 = ioread64(mmio + SNB_PBAR45XLAT_OFFSET);
+			u.v64 = ioread64(mmio + XEON_PBAR45XLAT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B XLAT45 -\t\t%#018llx\n", u.v64);
 
-			u.v64 = ioread64(mmio + SNB_PBAR23LMT_OFFSET);
+			u.v64 = ioread64(mmio + XEON_PBAR23LMT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B LMT23 -\t\t%#018llx\n", u.v64);
 
-			u.v64 = ioread64(mmio + SNB_PBAR45LMT_OFFSET);
+			u.v64 = ioread64(mmio + XEON_PBAR45LMT_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "B2B LMT45 -\t\t%#018llx\n", u.v64);
 
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Secondary BAR:\n");
 
-			u.v64 = ioread64(mmio + SNB_SBAR0BASE_OFFSET);
+			u.v64 = ioread64(mmio + XEON_SBAR0BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR01 -\t\t%#018llx\n", u.v64);
 
-			u.v64 = ioread64(mmio + SNB_SBAR23BASE_OFFSET);
+			u.v64 = ioread64(mmio + XEON_SBAR23BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR23 -\t\t%#018llx\n", u.v64);
 
-			u.v64 = ioread64(mmio + SNB_SBAR45BASE_OFFSET);
+			u.v64 = ioread64(mmio + XEON_SBAR45BASE_OFFSET);
 			off += scnprintf(buf + off, buf_size - off,
 					 "SBAR45 -\t\t%#018llx\n", u.v64);
 		}
 
 		off += scnprintf(buf + off, buf_size - off,
-				 "\nSNB NTB Statistics:\n");
+				 "\nXEON NTB Statistics:\n");
 
-		u.v16 = ioread16(mmio + SNB_USMEMMISS_OFFSET);
+		u.v16 = ioread16(mmio + XEON_USMEMMISS_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "Upstream Memory Miss -\t%u\n", u.v16);
 
 		off += scnprintf(buf + off, buf_size - off,
-				 "\nSNB NTB Hardware Errors:\n");
+				 "\nXEON NTB Hardware Errors:\n");
 
 		if (!pci_read_config_word(ndev->ntb.pdev,
-					  SNB_DEVSTS_OFFSET, &u.v16))
+					  XEON_DEVSTS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "DEVSTS -\t\t%#06x\n", u.v16);
 
 		if (!pci_read_config_word(ndev->ntb.pdev,
-					  SNB_LINK_STATUS_OFFSET, &u.v16))
+					  XEON_LINK_STATUS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "LNKSTS -\t\t%#06x\n", u.v16);
 
 		if (!pci_read_config_dword(ndev->ntb.pdev,
-					   SNB_UNCERRSTS_OFFSET, &u.v32))
+					   XEON_UNCERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "UNCERRSTS -\t\t%#06x\n", u.v32);
 
 		if (!pci_read_config_dword(ndev->ntb.pdev,
-					   SNB_CORERRSTS_OFFSET, &u.v32))
+					   XEON_CORERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "CORERRSTS -\t\t%#06x\n", u.v32);
 	}
@@ -1092,67 +1092,67 @@ static int intel_ntb_peer_spad_write(struct ntb_dev *ntb,
 			       ndev->peer_reg->spad);
 }
 
-/* BWD */
+/* ATOM */
 
-static u64 bwd_db_ioread(void __iomem *mmio)
+static u64 atom_db_ioread(void __iomem *mmio)
 {
 	return ioread64(mmio);
 }
 
-static void bwd_db_iowrite(u64 bits, void __iomem *mmio)
+static void atom_db_iowrite(u64 bits, void __iomem *mmio)
 {
 	iowrite64(bits, mmio);
 }
 
-static int bwd_poll_link(struct intel_ntb_dev *ndev)
+static int atom_poll_link(struct intel_ntb_dev *ndev)
 {
 	u32 ntb_ctl;
 
-	ntb_ctl = ioread32(ndev->self_mmio + BWD_NTBCNTL_OFFSET);
+	ntb_ctl = ioread32(ndev->self_mmio + ATOM_NTBCNTL_OFFSET);
 
 	if (ntb_ctl == ndev->ntb_ctl)
 		return 0;
 
 	ndev->ntb_ctl = ntb_ctl;
 
-	ndev->lnk_sta = ioread32(ndev->self_mmio + BWD_LINK_STATUS_OFFSET);
+	ndev->lnk_sta = ioread32(ndev->self_mmio + ATOM_LINK_STATUS_OFFSET);
 
 	return 1;
 }
 
-static int bwd_link_is_up(struct intel_ntb_dev *ndev)
+static int atom_link_is_up(struct intel_ntb_dev *ndev)
 {
-	return BWD_NTB_CTL_ACTIVE(ndev->ntb_ctl);
+	return ATOM_NTB_CTL_ACTIVE(ndev->ntb_ctl);
 }
 
-static int bwd_link_is_err(struct intel_ntb_dev *ndev)
+static int atom_link_is_err(struct intel_ntb_dev *ndev)
 {
-	if (ioread32(ndev->self_mmio + BWD_LTSSMSTATEJMP_OFFSET)
-	    & BWD_LTSSMSTATEJMP_FORCEDETECT)
+	if (ioread32(ndev->self_mmio + ATOM_LTSSMSTATEJMP_OFFSET)
+	    & ATOM_LTSSMSTATEJMP_FORCEDETECT)
 		return 1;
 
-	if (ioread32(ndev->self_mmio + BWD_IBSTERRRCRVSTS0_OFFSET)
-	    & BWD_IBIST_ERR_OFLOW)
+	if (ioread32(ndev->self_mmio + ATOM_IBSTERRRCRVSTS0_OFFSET)
+	    & ATOM_IBIST_ERR_OFLOW)
 		return 1;
 
 	return 0;
 }
 
-static inline enum ntb_topo bwd_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
+static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 {
-	switch (ppd & BWD_PPD_TOPO_MASK) {
-	case BWD_PPD_TOPO_B2B_USD:
+	switch (ppd & ATOM_PPD_TOPO_MASK) {
+	case ATOM_PPD_TOPO_B2B_USD:
 		dev_dbg(ndev_dev(ndev), "PPD %d B2B USD\n", ppd);
 		return NTB_TOPO_B2B_USD;
 
-	case BWD_PPD_TOPO_B2B_DSD:
+	case ATOM_PPD_TOPO_B2B_DSD:
 		dev_dbg(ndev_dev(ndev), "PPD %d B2B DSD\n", ppd);
 		return NTB_TOPO_B2B_DSD;
 
-	case BWD_PPD_TOPO_PRI_USD:
-	case BWD_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
-	case BWD_PPD_TOPO_SEC_USD:
-	case BWD_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
+	case ATOM_PPD_TOPO_PRI_USD:
+	case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
+	case ATOM_PPD_TOPO_SEC_USD:
+	case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
 		dev_dbg(ndev_dev(ndev), "PPD %d non B2B disabled\n", ppd);
 		return NTB_TOPO_NONE;
 	}
@@ -1161,28 +1161,28 @@ static inline enum ntb_topo bwd_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
 	return NTB_TOPO_NONE;
 }
 
-static void bwd_link_hb(struct work_struct *work)
+static void atom_link_hb(struct work_struct *work)
 {
 	struct intel_ntb_dev *ndev = hb_ndev(work);
 	unsigned long poll_ts;
 	void __iomem *mmio;
 	u32 status32;
 
-	poll_ts = ndev->last_ts + BWD_LINK_HB_TIMEOUT;
+	poll_ts = ndev->last_ts + ATOM_LINK_HB_TIMEOUT;
 
 	/* Delay polling the link status if an interrupt was received,
 	 * unless the cached link status says the link is down.
 	 */
-	if (time_after(poll_ts, jiffies) && bwd_link_is_up(ndev)) {
+	if (time_after(poll_ts, jiffies) && atom_link_is_up(ndev)) {
 		schedule_delayed_work(&ndev->hb_timer, poll_ts - jiffies);
 		return;
 	}
 
-	if (bwd_poll_link(ndev))
+	if (atom_poll_link(ndev))
 		ntb_link_event(&ndev->ntb);
 
-	if (bwd_link_is_up(ndev) || !bwd_link_is_err(ndev)) {
-		schedule_delayed_work(&ndev->hb_timer, BWD_LINK_HB_TIMEOUT);
+	if (atom_link_is_up(ndev) || !atom_link_is_err(ndev)) {
+		schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
 		return;
 	}
 
@@ -1191,91 +1191,91 @@ static void bwd_link_hb(struct work_struct *work)
 	mmio = ndev->self_mmio;
 
 	/* Driver resets the NTB ModPhy lanes - magic! */
-	iowrite8(0xe0, mmio + BWD_MODPHY_PCSREG6);
-	iowrite8(0x40, mmio + BWD_MODPHY_PCSREG4);
-	iowrite8(0x60, mmio + BWD_MODPHY_PCSREG4);
-	iowrite8(0x60, mmio + BWD_MODPHY_PCSREG6);
+	iowrite8(0xe0, mmio + ATOM_MODPHY_PCSREG6);
+	iowrite8(0x40, mmio + ATOM_MODPHY_PCSREG4);
+	iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG4);
+	iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG6);
 
 	/* Driver waits 100ms to allow the NTB ModPhy to settle */
 	msleep(100);
 
 	/* Clear AER Errors, write to clear */
-	status32 = ioread32(mmio + BWD_ERRCORSTS_OFFSET);
+	status32 = ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
 	dev_dbg(ndev_dev(ndev), "ERRCORSTS = %x\n", status32);
 	status32 &= PCI_ERR_COR_REP_ROLL;
-	iowrite32(status32, mmio + BWD_ERRCORSTS_OFFSET);
+	iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
 
 	/* Clear unexpected electrical idle event in LTSSM, write to clear */
-	status32 = ioread32(mmio + BWD_LTSSMERRSTS0_OFFSET);
+	status32 = ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
 	dev_dbg(ndev_dev(ndev), "LTSSMERRSTS0 = %x\n", status32);
-	status32 |= BWD_LTSSMERRSTS0_UNEXPECTEDEI;
-	iowrite32(status32, mmio + BWD_LTSSMERRSTS0_OFFSET);
+	status32 |= ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
+	iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
 
 	/* Clear DeSkew Buffer error, write to clear */
-	status32 = ioread32(mmio + BWD_DESKEWSTS_OFFSET);
+	status32 = ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
 	dev_dbg(ndev_dev(ndev), "DESKEWSTS = %x\n", status32);
-	status32 |= BWD_DESKEWSTS_DBERR;
-	iowrite32(status32, mmio + BWD_DESKEWSTS_OFFSET);
+	status32 |= ATOM_DESKEWSTS_DBERR;
+	iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
 
-	status32 = ioread32(mmio + BWD_IBSTERRRCRVSTS0_OFFSET);
+	status32 = ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
 	dev_dbg(ndev_dev(ndev), "IBSTERRRCRVSTS0 = %x\n", status32);
-	status32 &= BWD_IBIST_ERR_OFLOW;
-	iowrite32(status32, mmio + BWD_IBSTERRRCRVSTS0_OFFSET);
+	status32 &= ATOM_IBIST_ERR_OFLOW;
+	iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
 
 	/* Releases the NTB state machine to allow the link to retrain */
-	status32 = ioread32(mmio + BWD_LTSSMSTATEJMP_OFFSET);
+	status32 = ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
 	dev_dbg(ndev_dev(ndev), "LTSSMSTATEJMP = %x\n", status32);
-	status32 &= ~BWD_LTSSMSTATEJMP_FORCEDETECT;
-	iowrite32(status32, mmio + BWD_LTSSMSTATEJMP_OFFSET);
+	status32 &= ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
+	iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
 
 	/* There is a potential race between the 2 NTB devices recovering at the
 	 * same time.  If the times are the same, the link will not recover and
 	 * the driver will be stuck in this loop forever.  Add a random interval
 	 * to the recovery time to prevent this race.
 	 */
-	schedule_delayed_work(&ndev->hb_timer, BWD_LINK_RECOVERY_TIME
-			      + prandom_u32() % BWD_LINK_RECOVERY_TIME);
+	schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_RECOVERY_TIME
+			      + prandom_u32() % ATOM_LINK_RECOVERY_TIME);
 }
 
-static int bwd_init_isr(struct intel_ntb_dev *ndev)
+static int atom_init_isr(struct intel_ntb_dev *ndev)
 {
 	int rc;
 
-	rc = ndev_init_isr(ndev, 1, BWD_DB_MSIX_VECTOR_COUNT,
-			   BWD_DB_MSIX_VECTOR_SHIFT, BWD_DB_TOTAL_SHIFT);
+	rc = ndev_init_isr(ndev, 1, ATOM_DB_MSIX_VECTOR_COUNT,
+			   ATOM_DB_MSIX_VECTOR_SHIFT, ATOM_DB_TOTAL_SHIFT);
 	if (rc)
 		return rc;
 
-	/* BWD doesn't have link status interrupt, poll on that platform */
+	/* ATOM doesn't have link status interrupt, poll on that platform */
 	ndev->last_ts = jiffies;
-	INIT_DELAYED_WORK(&ndev->hb_timer, bwd_link_hb);
-	schedule_delayed_work(&ndev->hb_timer, BWD_LINK_HB_TIMEOUT);
+	INIT_DELAYED_WORK(&ndev->hb_timer, atom_link_hb);
+	schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
 
 	return 0;
 }
 
-static void bwd_deinit_isr(struct intel_ntb_dev *ndev)
+static void atom_deinit_isr(struct intel_ntb_dev *ndev)
 {
 	cancel_delayed_work_sync(&ndev->hb_timer);
 	ndev_deinit_isr(ndev);
 }
 
-static int bwd_init_ntb(struct intel_ntb_dev *ndev)
+static int atom_init_ntb(struct intel_ntb_dev *ndev)
 {
-	ndev->mw_count = BWD_MW_COUNT;
-	ndev->spad_count = BWD_SPAD_COUNT;
-	ndev->db_count = BWD_DB_COUNT;
+	ndev->mw_count = ATOM_MW_COUNT;
+	ndev->spad_count = ATOM_SPAD_COUNT;
+	ndev->db_count = ATOM_DB_COUNT;
 
 	switch (ndev->ntb.topo) {
 	case NTB_TOPO_B2B_USD:
 	case NTB_TOPO_B2B_DSD:
-		ndev->self_reg = &bwd_pri_reg;
-		ndev->peer_reg = &bwd_b2b_reg;
-		ndev->xlat_reg = &bwd_sec_xlat;
+		ndev->self_reg = &atom_pri_reg;
+		ndev->peer_reg = &atom_b2b_reg;
+		ndev->xlat_reg = &atom_sec_xlat;
 
 		/* Enable Bus Master and Memory Space on the secondary side */
 		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
-			  ndev->self_mmio + BWD_SPCICMD_OFFSET);
+			  ndev->self_mmio + ATOM_SPCICMD_OFFSET);
 
 		break;
 
@@ -1288,31 +1288,31 @@ static int bwd_init_ntb(struct intel_ntb_dev *ndev)
 	return 0;
 }
 
-static int bwd_init_dev(struct intel_ntb_dev *ndev)
+static int atom_init_dev(struct intel_ntb_dev *ndev)
 {
 	u32 ppd;
 	int rc;
 
-	rc = pci_read_config_dword(ndev->ntb.pdev, BWD_PPD_OFFSET, &ppd);
+	rc = pci_read_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET, &ppd);
 	if (rc)
 		return -EIO;
 
-	ndev->ntb.topo = bwd_ppd_topo(ndev, ppd);
+	ndev->ntb.topo = atom_ppd_topo(ndev, ppd);
 	if (ndev->ntb.topo == NTB_TOPO_NONE)
 		return -EINVAL;
 
-	rc = bwd_init_ntb(ndev);
+	rc = atom_init_ntb(ndev);
 	if (rc)
 		return rc;
 
-	rc = bwd_init_isr(ndev);
+	rc = atom_init_isr(ndev);
 	if (rc)
 		return rc;
 
 	if (ndev->ntb.topo != NTB_TOPO_SEC) {
 		/* Initiate PCI-E link training */
-		rc = pci_write_config_dword(ndev->ntb.pdev, BWD_PPD_OFFSET,
-					    ppd | BWD_PPD_INIT_LINK);
+		rc = pci_write_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET,
+					    ppd | ATOM_PPD_INIT_LINK);
 		if (rc)
 			return rc;
 	}
@@ -1320,24 +1320,24 @@ static int bwd_init_dev(struct intel_ntb_dev *ndev)
 	return 0;
 }
 
-static void bwd_deinit_dev(struct intel_ntb_dev *ndev)
+static void atom_deinit_dev(struct intel_ntb_dev *ndev)
 {
-	bwd_deinit_isr(ndev);
+	atom_deinit_isr(ndev);
 }
 
-/* SNB */
+/* XEON */
 
-static u64 snb_db_ioread(void __iomem *mmio)
+static u64 xeon_db_ioread(void __iomem *mmio)
 {
 	return (u64)ioread16(mmio);
 }
 
-static void snb_db_iowrite(u64 bits, void __iomem *mmio)
+static void xeon_db_iowrite(u64 bits, void __iomem *mmio)
 {
 	iowrite16((u16)bits, mmio);
 }
 
-static int snb_poll_link(struct intel_ntb_dev *ndev)
+static int xeon_poll_link(struct intel_ntb_dev *ndev)
 {
 	u16 reg_val;
 	int rc;
@@ -1347,7 +1347,7 @@ static int snb_poll_link(struct intel_ntb_dev *ndev)
 			      ndev->self_reg->db_bell);
 
 	rc = pci_read_config_word(ndev->ntb.pdev,
-				  SNB_LINK_STATUS_OFFSET, &reg_val);
+				  XEON_LINK_STATUS_OFFSET, &reg_val);
 	if (rc)
 		return 0;
 
@@ -1359,7 +1359,7 @@ static int snb_poll_link(struct intel_ntb_dev *ndev)
 	return 1;
 }
 
-static int snb_link_is_up(struct intel_ntb_dev *ndev)
+static int xeon_link_is_up(struct intel_ntb_dev *ndev)
 {
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return 1;
@@ -1367,52 +1367,52 @@ static int snb_link_is_up(struct intel_ntb_dev *ndev)
 	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
 }
 
-static inline enum ntb_topo snb_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
+static inline enum ntb_topo xeon_ppd_topo(struct intel_ntb_dev *ndev, u8 ppd)
 {
-	switch (ppd & SNB_PPD_TOPO_MASK) {
-	case SNB_PPD_TOPO_B2B_USD:
+	switch (ppd & XEON_PPD_TOPO_MASK) {
+	case XEON_PPD_TOPO_B2B_USD:
 		return NTB_TOPO_B2B_USD;
 
-	case SNB_PPD_TOPO_B2B_DSD:
+	case XEON_PPD_TOPO_B2B_DSD:
 		return NTB_TOPO_B2B_DSD;
 
-	case SNB_PPD_TOPO_PRI_USD:
-	case SNB_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
+	case XEON_PPD_TOPO_PRI_USD:
+	case XEON_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
 		return NTB_TOPO_PRI;
 
-	case SNB_PPD_TOPO_SEC_USD:
-	case SNB_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
+	case XEON_PPD_TOPO_SEC_USD:
+	case XEON_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
 		return NTB_TOPO_SEC;
 	}
 
 	return NTB_TOPO_NONE;
 }
 
-static inline int snb_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
+static inline int xeon_ppd_bar4_split(struct intel_ntb_dev *ndev, u8 ppd)
 {
-	if (ppd & SNB_PPD_SPLIT_BAR_MASK) {
+	if (ppd & XEON_PPD_SPLIT_BAR_MASK) {
 		dev_dbg(ndev_dev(ndev), "PPD %d split bar\n", ppd);
 		return 1;
 	}
 	return 0;
 }
 
-static int snb_init_isr(struct intel_ntb_dev *ndev)
+static int xeon_init_isr(struct intel_ntb_dev *ndev)
 {
-	return ndev_init_isr(ndev, SNB_DB_MSIX_VECTOR_COUNT,
-			     SNB_DB_MSIX_VECTOR_COUNT,
-			     SNB_DB_MSIX_VECTOR_SHIFT,
-			     SNB_DB_TOTAL_SHIFT);
+	return ndev_init_isr(ndev, XEON_DB_MSIX_VECTOR_COUNT,
+			     XEON_DB_MSIX_VECTOR_COUNT,
+			     XEON_DB_MSIX_VECTOR_SHIFT,
+			     XEON_DB_TOTAL_SHIFT);
 }
 
-static void snb_deinit_isr(struct intel_ntb_dev *ndev)
+static void xeon_deinit_isr(struct intel_ntb_dev *ndev)
 {
 	ndev_deinit_isr(ndev);
 }
 
-static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
-			    const struct intel_b2b_addr *addr,
-			    const struct intel_b2b_addr *peer_addr)
+static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
+			     const struct intel_b2b_addr *addr,
+			     const struct intel_b2b_addr *peer_addr)
 {
 	struct pci_dev *pdev;
 	void __iomem *mmio;
@@ -1439,11 +1439,11 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 
 		dev_dbg(ndev_dev(ndev), "b2b bar size %#llx\n", bar_size);
 
-		if (b2b_mw_share && SNB_B2B_MIN_SIZE <= bar_size >> 1) {
+		if (b2b_mw_share && XEON_B2B_MIN_SIZE <= bar_size >> 1) {
 			dev_dbg(ndev_dev(ndev),
 				"b2b using first half of bar\n");
 			ndev->b2b_off = bar_size >> 1;
-		} else if (SNB_B2B_MIN_SIZE <= bar_size) {
+		} else if (XEON_B2B_MIN_SIZE <= bar_size) {
 			dev_dbg(ndev_dev(ndev),
 				"b2b using whole bar\n");
 			ndev->b2b_off = 0;
@@ -1461,7 +1461,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 * Note: code for each specific bar size register, because the register
 	 * offsets are not in a consistent order (bar5sz comes after ppd, odd).
 	 */
-	pci_read_config_byte(pdev, SNB_PBAR23SZ_OFFSET, &bar_sz);
+	pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &bar_sz);
 	dev_dbg(ndev_dev(ndev), "PBAR23SZ %#x\n", bar_sz);
 	if (b2b_bar == 2) {
 		if (ndev->b2b_off)
@@ -1469,12 +1469,12 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		else
 			bar_sz = 0;
 	}
-	pci_write_config_byte(pdev, SNB_SBAR23SZ_OFFSET, bar_sz);
-	pci_read_config_byte(pdev, SNB_SBAR23SZ_OFFSET, &bar_sz);
+	pci_write_config_byte(pdev, XEON_SBAR23SZ_OFFSET, bar_sz);
+	pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &bar_sz);
 	dev_dbg(ndev_dev(ndev), "SBAR23SZ %#x\n", bar_sz);
 
 	if (!ndev->bar4_split) {
-		pci_read_config_byte(pdev, SNB_PBAR45SZ_OFFSET, &bar_sz);
+		pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "PBAR45SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
@@ -1482,11 +1482,11 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 			else
 				bar_sz = 0;
 		}
-		pci_write_config_byte(pdev, SNB_SBAR45SZ_OFFSET, bar_sz);
-		pci_read_config_byte(pdev, SNB_SBAR45SZ_OFFSET, &bar_sz);
+		pci_write_config_byte(pdev, XEON_SBAR45SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "SBAR45SZ %#x\n", bar_sz);
 	} else {
-		pci_read_config_byte(pdev, SNB_PBAR4SZ_OFFSET, &bar_sz);
+		pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "PBAR4SZ %#x\n", bar_sz);
 		if (b2b_bar == 4) {
 			if (ndev->b2b_off)
@@ -1494,11 +1494,11 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 			else
 				bar_sz = 0;
 		}
-		pci_write_config_byte(pdev, SNB_SBAR4SZ_OFFSET, bar_sz);
-		pci_read_config_byte(pdev, SNB_SBAR4SZ_OFFSET, &bar_sz);
+		pci_write_config_byte(pdev, XEON_SBAR4SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "SBAR4SZ %#x\n", bar_sz);
 
-		pci_read_config_byte(pdev, SNB_PBAR5SZ_OFFSET, &bar_sz);
+		pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "PBAR5SZ %#x\n", bar_sz);
 		if (b2b_bar == 5) {
 			if (ndev->b2b_off)
@@ -1506,8 +1506,8 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 			else
 				bar_sz = 0;
 		}
-		pci_write_config_byte(pdev, SNB_SBAR5SZ_OFFSET, bar_sz);
-		pci_read_config_byte(pdev, SNB_SBAR5SZ_OFFSET, &bar_sz);
+		pci_write_config_byte(pdev, XEON_SBAR5SZ_OFFSET, bar_sz);
+		pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET, &bar_sz);
 		dev_dbg(ndev_dev(ndev), "SBAR5SZ %#x\n", bar_sz);
 	}
 
@@ -1526,7 +1526,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 		return -EIO;
 
 	dev_dbg(ndev_dev(ndev), "SBAR01 %#018llx\n", bar_addr);
-	iowrite64(bar_addr, mmio + SNB_SBAR0BASE_OFFSET);
+	iowrite64(bar_addr, mmio + XEON_SBAR0BASE_OFFSET);
 
 	/* Other SBAR are normally hit by the PBAR xlat, except for b2b bar.
 	 * The b2b bar is either disabled above, or configured half-size, and
@@ -1534,96 +1534,96 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	 */
 
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
-	iowrite64(bar_addr, mmio + SNB_SBAR23BASE_OFFSET);
-	bar_addr = ioread64(mmio + SNB_SBAR23BASE_OFFSET);
+	iowrite64(bar_addr, mmio + XEON_SBAR23BASE_OFFSET);
+	bar_addr = ioread64(mmio + XEON_SBAR23BASE_OFFSET);
 	dev_dbg(ndev_dev(ndev), "SBAR23 %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite64(bar_addr, mmio + SNB_SBAR45BASE_OFFSET);
-		bar_addr = ioread64(mmio + SNB_SBAR45BASE_OFFSET);
+		iowrite64(bar_addr, mmio + XEON_SBAR45BASE_OFFSET);
+		bar_addr = ioread64(mmio + XEON_SBAR45BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR45 %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + SNB_SBAR4BASE_OFFSET);
-		bar_addr = ioread32(mmio + SNB_SBAR4BASE_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_SBAR4BASE_OFFSET);
+		bar_addr = ioread32(mmio + XEON_SBAR4BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR4 %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + SNB_SBAR5BASE_OFFSET);
-		bar_addr = ioread32(mmio + SNB_SBAR5BASE_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_SBAR5BASE_OFFSET);
+		bar_addr = ioread32(mmio + XEON_SBAR5BASE_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR5 %#010llx\n", bar_addr);
 	}
 
 	/* setup incoming bar limits == base addrs (zero length windows) */
 
 	bar_addr = addr->bar2_addr64 + (b2b_bar == 2 ? ndev->b2b_off : 0);
-	iowrite64(bar_addr, mmio + SNB_SBAR23LMT_OFFSET);
-	bar_addr = ioread64(mmio + SNB_SBAR23LMT_OFFSET);
+	iowrite64(bar_addr, mmio + XEON_SBAR23LMT_OFFSET);
+	bar_addr = ioread64(mmio + XEON_SBAR23LMT_OFFSET);
 	dev_dbg(ndev_dev(ndev), "SBAR23LMT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = addr->bar4_addr64 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite64(bar_addr, mmio + SNB_SBAR45LMT_OFFSET);
-		bar_addr = ioread64(mmio + SNB_SBAR45LMT_OFFSET);
+		iowrite64(bar_addr, mmio + XEON_SBAR45LMT_OFFSET);
+		bar_addr = ioread64(mmio + XEON_SBAR45LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR45LMT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = addr->bar4_addr32 +
 			(b2b_bar == 4 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + SNB_SBAR4LMT_OFFSET);
-		bar_addr = ioread32(mmio + SNB_SBAR4LMT_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_SBAR4LMT_OFFSET);
+		bar_addr = ioread32(mmio + XEON_SBAR4LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR4LMT %#010llx\n", bar_addr);
 
 		bar_addr = addr->bar5_addr32 +
 			(b2b_bar == 5 ? ndev->b2b_off : 0);
-		iowrite32(bar_addr, mmio + SNB_SBAR5LMT_OFFSET);
-		bar_addr = ioread32(mmio + SNB_SBAR5LMT_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_SBAR5LMT_OFFSET);
+		bar_addr = ioread32(mmio + XEON_SBAR5LMT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "SBAR5LMT %#05llx\n", bar_addr);
 	}
 
 	/* zero incoming translation addrs */
-	iowrite64(0, mmio + SNB_SBAR23XLAT_OFFSET);
+	iowrite64(0, mmio + XEON_SBAR23XLAT_OFFSET);
 
 	if (!ndev->bar4_split) {
-		iowrite64(0, mmio + SNB_SBAR45XLAT_OFFSET);
+		iowrite64(0, mmio + XEON_SBAR45XLAT_OFFSET);
 	} else {
-		iowrite32(0, mmio + SNB_SBAR4XLAT_OFFSET);
-		iowrite32(0, mmio + SNB_SBAR5XLAT_OFFSET);
+		iowrite32(0, mmio + XEON_SBAR4XLAT_OFFSET);
+		iowrite32(0, mmio + XEON_SBAR5XLAT_OFFSET);
 	}
 
 	/* zero outgoing translation limits (whole bar size windows) */
-	iowrite64(0, mmio + SNB_PBAR23LMT_OFFSET);
+	iowrite64(0, mmio + XEON_PBAR23LMT_OFFSET);
 	if (!ndev->bar4_split) {
-		iowrite64(0, mmio + SNB_PBAR45LMT_OFFSET);
+		iowrite64(0, mmio + XEON_PBAR45LMT_OFFSET);
 	} else {
-		iowrite32(0, mmio + SNB_PBAR4LMT_OFFSET);
-		iowrite32(0, mmio + SNB_PBAR5LMT_OFFSET);
+		iowrite32(0, mmio + XEON_PBAR4LMT_OFFSET);
+		iowrite32(0, mmio + XEON_PBAR5LMT_OFFSET);
 	}
 
 	/* set outgoing translation offsets */
 	bar_addr = peer_addr->bar2_addr64;
-	iowrite64(bar_addr, mmio + SNB_PBAR23XLAT_OFFSET);
-	bar_addr = ioread64(mmio + SNB_PBAR23XLAT_OFFSET);
+	iowrite64(bar_addr, mmio + XEON_PBAR23XLAT_OFFSET);
+	bar_addr = ioread64(mmio + XEON_PBAR23XLAT_OFFSET);
 	dev_dbg(ndev_dev(ndev), "PBAR23XLAT %#018llx\n", bar_addr);
 
 	if (!ndev->bar4_split) {
 		bar_addr = peer_addr->bar4_addr64;
-		iowrite64(bar_addr, mmio + SNB_PBAR45XLAT_OFFSET);
-		bar_addr = ioread64(mmio + SNB_PBAR45XLAT_OFFSET);
+		iowrite64(bar_addr, mmio + XEON_PBAR45XLAT_OFFSET);
+		bar_addr = ioread64(mmio + XEON_PBAR45XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR45XLAT %#018llx\n", bar_addr);
 	} else {
 		bar_addr = peer_addr->bar4_addr32;
-		iowrite32(bar_addr, mmio + SNB_PBAR4XLAT_OFFSET);
-		bar_addr = ioread32(mmio + SNB_PBAR4XLAT_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_PBAR4XLAT_OFFSET);
+		bar_addr = ioread32(mmio + XEON_PBAR4XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR4XLAT %#010llx\n", bar_addr);
 
 		bar_addr = peer_addr->bar5_addr32;
-		iowrite32(bar_addr, mmio + SNB_PBAR5XLAT_OFFSET);
-		bar_addr = ioread32(mmio + SNB_PBAR5XLAT_OFFSET);
+		iowrite32(bar_addr, mmio + XEON_PBAR5XLAT_OFFSET);
+		bar_addr = ioread32(mmio + XEON_PBAR5XLAT_OFFSET);
 		dev_dbg(ndev_dev(ndev), "PBAR5XLAT %#010llx\n", bar_addr);
 	}
 
@@ -1643,13 +1643,13 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 
 	/* B2B_XLAT_OFFSET is 64bit, but can only take 32bit writes */
 	dev_dbg(ndev_dev(ndev), "B2BXLAT %#018llx\n", bar_addr);
-	iowrite32(bar_addr, mmio + SNB_B2B_XLAT_OFFSETL);
-	iowrite32(bar_addr >> 32, mmio + SNB_B2B_XLAT_OFFSETU);
+	iowrite32(bar_addr, mmio + XEON_B2B_XLAT_OFFSETL);
+	iowrite32(bar_addr >> 32, mmio + XEON_B2B_XLAT_OFFSETU);
 
 	if (b2b_bar) {
 		/* map peer ntb mmio config space registers */
 		ndev->peer_mmio = pci_iomap(pdev, b2b_bar,
-					    SNB_B2B_MIN_SIZE);
+					    XEON_B2B_MIN_SIZE);
 		if (!ndev->peer_mmio)
 			return -EIO;
 	}
@@ -1657,7 +1657,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 	return 0;
 }
 
-static int snb_init_ntb(struct intel_ntb_dev *ndev)
+static int xeon_init_ntb(struct intel_ntb_dev *ndev)
 {
 	int rc;
 	u32 ntb_ctl;
@@ -1665,11 +1665,11 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 	if (ndev->bar4_split)
 		ndev->mw_count = HSX_SPLIT_BAR_MW_COUNT;
 	else
-		ndev->mw_count = SNB_MW_COUNT;
+		ndev->mw_count = XEON_MW_COUNT;
 
-	ndev->spad_count = SNB_SPAD_COUNT;
-	ndev->db_count = SNB_DB_COUNT;
-	ndev->db_link_mask = SNB_DB_LINK_BIT;
+	ndev->spad_count = XEON_SPAD_COUNT;
+	ndev->db_count = XEON_DB_COUNT;
+	ndev->db_link_mask = XEON_DB_LINK_BIT;
 
 	switch (ndev->ntb.topo) {
 	case NTB_TOPO_PRI:
@@ -1685,9 +1685,9 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 
 		/* use half the spads for the peer */
 		ndev->spad_count >>= 1;
-		ndev->self_reg = &snb_pri_reg;
-		ndev->peer_reg = &snb_sec_reg;
-		ndev->xlat_reg = &snb_sec_xlat;
+		ndev->self_reg = &xeon_pri_reg;
+		ndev->peer_reg = &xeon_sec_reg;
+		ndev->xlat_reg = &xeon_sec_xlat;
 		break;
 
 	case NTB_TOPO_SEC:
@@ -1697,19 +1697,19 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 		}
 		/* use half the spads for the peer */
 		ndev->spad_count >>= 1;
-		ndev->self_reg = &snb_sec_reg;
-		ndev->peer_reg = &snb_pri_reg;
-		ndev->xlat_reg = &snb_pri_xlat;
+		ndev->self_reg = &xeon_sec_reg;
+		ndev->peer_reg = &xeon_pri_reg;
+		ndev->xlat_reg = &xeon_pri_xlat;
 		break;
 
 	case NTB_TOPO_B2B_USD:
 	case NTB_TOPO_B2B_DSD:
-		ndev->self_reg = &snb_pri_reg;
-		ndev->peer_reg = &snb_b2b_reg;
-		ndev->xlat_reg = &snb_sec_xlat;
+		ndev->self_reg = &xeon_pri_reg;
+		ndev->peer_reg = &xeon_b2b_reg;
+		ndev->xlat_reg = &xeon_sec_xlat;
 
 		if (ndev->hwerr_flags & NTB_HWERR_SDOORBELL_LOCKUP) {
-			ndev->peer_reg = &snb_pri_reg;
+			ndev->peer_reg = &xeon_pri_reg;
 
 			if (b2b_mw_idx < 0)
 				ndev->b2b_idx = b2b_mw_idx + ndev->mw_count;
@@ -1726,20 +1726,20 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 		}
 
 		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
-			rc = snb_setup_b2b_mw(ndev,
-					      &snb_b2b_dsd_addr,
-					      &snb_b2b_usd_addr);
+			rc = xeon_setup_b2b_mw(ndev,
+					       &xeon_b2b_dsd_addr,
+					       &xeon_b2b_usd_addr);
 		} else {
-			rc = snb_setup_b2b_mw(ndev,
-					      &snb_b2b_usd_addr,
-					      &snb_b2b_dsd_addr);
+			rc = xeon_setup_b2b_mw(ndev,
+					       &xeon_b2b_usd_addr,
+					       &xeon_b2b_dsd_addr);
 		}
 		if (rc)
 			return rc;
 
 		/* Enable Bus Master and Memory Space on the secondary side */
 		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
-			  ndev->self_mmio + SNB_SPCICMD_OFFSET);
+			  ndev->self_mmio + XEON_SPCICMD_OFFSET);
 
 		break;
 
@@ -1756,7 +1756,7 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 	return 0;
 }
 
-static int snb_init_dev(struct intel_ntb_dev *ndev)
+static int xeon_init_dev(struct intel_ntb_dev *ndev)
 {
 	struct pci_dev *pdev;
 	u8 ppd;
@@ -1822,20 +1822,20 @@ static int snb_init_dev(struct intel_ntb_dev *ndev)
 		break;
 	}
 
-	ndev->reg = &snb_reg;
+	ndev->reg = &xeon_reg;
 
-	rc = pci_read_config_byte(pdev, SNB_PPD_OFFSET, &ppd);
+	rc = pci_read_config_byte(pdev, XEON_PPD_OFFSET, &ppd);
 	if (rc)
 		return -EIO;
 
-	ndev->ntb.topo = snb_ppd_topo(ndev, ppd);
+	ndev->ntb.topo = xeon_ppd_topo(ndev, ppd);
 	dev_dbg(ndev_dev(ndev), "ppd %#x topo %s\n", ppd,
 		ntb_topo_string(ndev->ntb.topo));
 	if (ndev->ntb.topo == NTB_TOPO_NONE)
 		return -EINVAL;
 
 	if (ndev->ntb.topo != NTB_TOPO_PRI) {
-		ndev->bar4_split = snb_ppd_bar4_split(ndev, ppd);
+		ndev->bar4_split = xeon_ppd_bar4_split(ndev, ppd);
 		dev_dbg(ndev_dev(ndev), "ppd %#x bar4_split %d\n",
 			ppd, ndev->bar4_split);
 	} else {
@@ -1850,20 +1850,20 @@ static int snb_init_dev(struct intel_ntb_dev *ndev)
 			mem, ndev->bar4_split);
 	}
 
-	rc = snb_init_ntb(ndev);
+	rc = xeon_init_ntb(ndev);
 	if (rc)
 		return rc;
 
-	rc = snb_init_isr(ndev);
+	rc = xeon_init_isr(ndev);
 	if (rc)
 		return rc;
 
 	return 0;
 }
 
-static void snb_deinit_dev(struct intel_ntb_dev *ndev)
+static void xeon_deinit_dev(struct intel_ntb_dev *ndev)
 {
-	snb_deinit_isr(ndev);
+	xeon_deinit_isr(ndev);
 }
 
 static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
@@ -1968,7 +1968,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 
 	node = dev_to_node(&pdev->dev);
 
-	if (pdev_is_bwd(pdev)) {
+	if (pdev_is_atom(pdev)) {
 		ndev = kmalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
@@ -1981,11 +1981,11 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		if (rc)
 			goto err_init_pci;
 
-		rc = bwd_init_dev(ndev);
+		rc = atom_init_dev(ndev);
 		if (rc)
 			goto err_init_dev;
 
-	} else if (pdev_is_snb(pdev)) {
+	} else if (pdev_is_xeon(pdev)) {
 		ndev = kmalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
@@ -1998,7 +1998,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		if (rc)
 			goto err_init_pci;
 
-		rc = snb_init_dev(ndev);
+		rc = xeon_init_dev(ndev);
 		if (rc)
 			goto err_init_dev;
 
@@ -2021,10 +2021,10 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 
 err_register:
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_bwd(pdev))
-		bwd_deinit_dev(ndev);
-	else if (pdev_is_snb(pdev))
-		snb_deinit_dev(ndev);
+	if (pdev_is_atom(pdev))
+		atom_deinit_dev(ndev);
+	else if (pdev_is_xeon(pdev))
+		xeon_deinit_dev(ndev);
 err_init_dev:
 	intel_ntb_deinit_pci(ndev);
 err_init_pci:
@@ -2039,70 +2039,70 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
 
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_bwd(pdev))
-		bwd_deinit_dev(ndev);
-	else if (pdev_is_snb(pdev))
-		snb_deinit_dev(ndev);
+	if (pdev_is_atom(pdev))
+		atom_deinit_dev(ndev);
+	else if (pdev_is_xeon(pdev))
+		xeon_deinit_dev(ndev);
 	intel_ntb_deinit_pci(ndev);
 	kfree(ndev);
 }
 
-static const struct intel_ntb_reg bwd_reg = {
-	.poll_link		= bwd_poll_link,
-	.link_is_up		= bwd_link_is_up,
-	.db_ioread		= bwd_db_ioread,
-	.db_iowrite		= bwd_db_iowrite,
+static const struct intel_ntb_reg atom_reg = {
+	.poll_link		= atom_poll_link,
+	.link_is_up		= atom_link_is_up,
+	.db_ioread		= atom_db_ioread,
+	.db_iowrite		= atom_db_iowrite,
 	.db_size		= sizeof(u64),
-	.ntb_ctl		= BWD_NTBCNTL_OFFSET,
+	.ntb_ctl		= ATOM_NTBCNTL_OFFSET,
 	.mw_bar			= {2, 4},
 };
 
-static const struct intel_ntb_alt_reg bwd_pri_reg = {
-	.db_bell		= BWD_PDOORBELL_OFFSET,
-	.db_mask		= BWD_PDBMSK_OFFSET,
-	.spad			= BWD_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg atom_pri_reg = {
+	.db_bell		= ATOM_PDOORBELL_OFFSET,
+	.db_mask		= ATOM_PDBMSK_OFFSET,
+	.spad			= ATOM_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_alt_reg bwd_b2b_reg = {
-	.db_bell		= BWD_B2B_DOORBELL_OFFSET,
-	.spad			= BWD_B2B_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg atom_b2b_reg = {
+	.db_bell		= ATOM_B2B_DOORBELL_OFFSET,
+	.spad			= ATOM_B2B_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_xlat_reg bwd_sec_xlat = {
-	/* FIXME : .bar0_base	= BWD_SBAR0BASE_OFFSET, */
-	/* FIXME : .bar2_limit	= BWD_SBAR2LMT_OFFSET, */
-	.bar2_xlat		= BWD_SBAR2XLAT_OFFSET,
+static const struct intel_ntb_xlat_reg atom_sec_xlat = {
+	/* FIXME : .bar0_base	= ATOM_SBAR0BASE_OFFSET, */
+	/* FIXME : .bar2_limit	= ATOM_SBAR2LMT_OFFSET, */
+	.bar2_xlat		= ATOM_SBAR2XLAT_OFFSET,
 };
 
-static const struct intel_ntb_reg snb_reg = {
-	.poll_link		= snb_poll_link,
-	.link_is_up		= snb_link_is_up,
-	.db_ioread		= snb_db_ioread,
-	.db_iowrite		= snb_db_iowrite,
+static const struct intel_ntb_reg xeon_reg = {
+	.poll_link		= xeon_poll_link,
+	.link_is_up		= xeon_link_is_up,
+	.db_ioread		= xeon_db_ioread,
+	.db_iowrite		= xeon_db_iowrite,
 	.db_size		= sizeof(u32),
-	.ntb_ctl		= SNB_NTBCNTL_OFFSET,
+	.ntb_ctl		= XEON_NTBCNTL_OFFSET,
 	.mw_bar			= {2, 4, 5},
 };
 
-static const struct intel_ntb_alt_reg snb_pri_reg = {
-	.db_bell		= SNB_PDOORBELL_OFFSET,
-	.db_mask		= SNB_PDBMSK_OFFSET,
-	.spad			= SNB_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg xeon_pri_reg = {
+	.db_bell		= XEON_PDOORBELL_OFFSET,
+	.db_mask		= XEON_PDBMSK_OFFSET,
+	.spad			= XEON_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_alt_reg snb_sec_reg = {
-	.db_bell		= SNB_SDOORBELL_OFFSET,
-	.db_mask		= SNB_SDBMSK_OFFSET,
+static const struct intel_ntb_alt_reg xeon_sec_reg = {
+	.db_bell		= XEON_SDOORBELL_OFFSET,
+	.db_mask		= XEON_SDBMSK_OFFSET,
 	/* second half of the scratchpads */
-	.spad			= SNB_SPAD_OFFSET + (SNB_SPAD_COUNT << 1),
+	.spad			= XEON_SPAD_OFFSET + (XEON_SPAD_COUNT << 1),
 };
 
-static const struct intel_ntb_alt_reg snb_b2b_reg = {
-	.db_bell		= SNB_B2B_DOORBELL_OFFSET,
-	.spad			= SNB_B2B_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg xeon_b2b_reg = {
+	.db_bell		= XEON_B2B_DOORBELL_OFFSET,
+	.spad			= XEON_B2B_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_xlat_reg snb_pri_xlat = {
+static const struct intel_ntb_xlat_reg xeon_pri_xlat = {
 	/* Note: no primary .bar0_base visible to the secondary side.
 	 *
 	 * The secondary side cannot get the base address stored in primary
@@ -2113,28 +2113,28 @@ static const struct intel_ntb_xlat_reg snb_pri_xlat = {
 	 * window by setting the limit equal to base, nor can it limit the size
 	 * of the memory window by setting the limit to base + size.
 	 */
-	.bar2_limit		= SNB_PBAR23LMT_OFFSET,
-	.bar2_xlat		= SNB_PBAR23XLAT_OFFSET,
+	.bar2_limit		= XEON_PBAR23LMT_OFFSET,
+	.bar2_xlat		= XEON_PBAR23XLAT_OFFSET,
 };
 
-static const struct intel_ntb_xlat_reg snb_sec_xlat = {
-	.bar0_base		= SNB_SBAR0BASE_OFFSET,
-	.bar2_limit		= SNB_SBAR23LMT_OFFSET,
-	.bar2_xlat		= SNB_SBAR23XLAT_OFFSET,
+static const struct intel_ntb_xlat_reg xeon_sec_xlat = {
+	.bar0_base		= XEON_SBAR0BASE_OFFSET,
+	.bar2_limit		= XEON_SBAR23LMT_OFFSET,
+	.bar2_xlat		= XEON_SBAR23XLAT_OFFSET,
 };
 
-static struct intel_b2b_addr snb_b2b_usd_addr = {
-	.bar2_addr64		= SNB_B2B_BAR2_USD_ADDR64,
-	.bar4_addr64		= SNB_B2B_BAR4_USD_ADDR64,
-	.bar4_addr32		= SNB_B2B_BAR4_USD_ADDR32,
-	.bar5_addr32		= SNB_B2B_BAR5_USD_ADDR32,
+static struct intel_b2b_addr xeon_b2b_usd_addr = {
+	.bar2_addr64		= XEON_B2B_BAR2_USD_ADDR64,
+	.bar4_addr64		= XEON_B2B_BAR4_USD_ADDR64,
+	.bar4_addr32		= XEON_B2B_BAR4_USD_ADDR32,
+	.bar5_addr32		= XEON_B2B_BAR5_USD_ADDR32,
 };
 
-static struct intel_b2b_addr snb_b2b_dsd_addr = {
-	.bar2_addr64		= SNB_B2B_BAR2_DSD_ADDR64,
-	.bar4_addr64		= SNB_B2B_BAR4_DSD_ADDR64,
-	.bar4_addr32		= SNB_B2B_BAR4_DSD_ADDR32,
-	.bar5_addr32		= SNB_B2B_BAR5_DSD_ADDR32,
+static struct intel_b2b_addr xeon_b2b_dsd_addr = {
+	.bar2_addr64		= XEON_B2B_BAR2_DSD_ADDR64,
+	.bar4_addr64		= XEON_B2B_BAR4_DSD_ADDR64,
+	.bar4_addr32		= XEON_B2B_BAR4_DSD_ADDR32,
+	.bar5_addr32		= XEON_B2B_BAR5_DSD_ADDR32,
 };
 
 /* operations for primary side of local ntb */
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index fec689dc95cf..7ddaf387b679 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -68,141 +68,141 @@
 #define PCI_DEVICE_ID_INTEL_NTB_SS_HSX	0x2F0F
 #define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD	0x0C4E
 
-/* SNB hardware (and JSF, IVT, HSX) */
-
-#define SNB_PBAR23LMT_OFFSET		0x0000
-#define SNB_PBAR45LMT_OFFSET		0x0008
-#define SNB_PBAR4LMT_OFFSET		0x0008
-#define SNB_PBAR5LMT_OFFSET		0x000c
-#define SNB_PBAR23XLAT_OFFSET		0x0010
-#define SNB_PBAR45XLAT_OFFSET		0x0018
-#define SNB_PBAR4XLAT_OFFSET		0x0018
-#define SNB_PBAR5XLAT_OFFSET		0x001c
-#define SNB_SBAR23LMT_OFFSET		0x0020
-#define SNB_SBAR45LMT_OFFSET		0x0028
-#define SNB_SBAR4LMT_OFFSET		0x0028
-#define SNB_SBAR5LMT_OFFSET		0x002c
-#define SNB_SBAR23XLAT_OFFSET		0x0030
-#define SNB_SBAR45XLAT_OFFSET		0x0038
-#define SNB_SBAR4XLAT_OFFSET		0x0038
-#define SNB_SBAR5XLAT_OFFSET		0x003c
-#define SNB_SBAR0BASE_OFFSET		0x0040
-#define SNB_SBAR23BASE_OFFSET		0x0048
-#define SNB_SBAR45BASE_OFFSET		0x0050
-#define SNB_SBAR4BASE_OFFSET		0x0050
-#define SNB_SBAR5BASE_OFFSET		0x0054
-#define SNB_SBDF_OFFSET			0x005c
-#define SNB_NTBCNTL_OFFSET		0x0058
-#define SNB_PDOORBELL_OFFSET		0x0060
-#define SNB_PDBMSK_OFFSET		0x0062
-#define SNB_SDOORBELL_OFFSET		0x0064
-#define SNB_SDBMSK_OFFSET		0x0066
-#define SNB_USMEMMISS_OFFSET		0x0070
-#define SNB_SPAD_OFFSET			0x0080
-#define SNB_PBAR23SZ_OFFSET		0x00d0
-#define SNB_PBAR45SZ_OFFSET		0x00d1
-#define SNB_PBAR4SZ_OFFSET		0x00d1
-#define SNB_SBAR23SZ_OFFSET		0x00d2
-#define SNB_SBAR45SZ_OFFSET		0x00d3
-#define SNB_SBAR4SZ_OFFSET		0x00d3
-#define SNB_PPD_OFFSET			0x00d4
-#define SNB_PBAR5SZ_OFFSET		0x00d5
-#define SNB_SBAR5SZ_OFFSET		0x00d6
-#define SNB_WCCNTRL_OFFSET		0x00e0
-#define SNB_UNCERRSTS_OFFSET		0x014c
-#define SNB_CORERRSTS_OFFSET		0x0158
-#define SNB_LINK_STATUS_OFFSET		0x01a2
-#define SNB_SPCICMD_OFFSET		0x0504
-#define SNB_DEVCTRL_OFFSET		0x0598
-#define SNB_DEVSTS_OFFSET		0x059a
-#define SNB_SLINK_STATUS_OFFSET		0x05a2
-#define SNB_B2B_SPAD_OFFSET		0x0100
-#define SNB_B2B_DOORBELL_OFFSET		0x0140
-#define SNB_B2B_XLAT_OFFSETL		0x0144
-#define SNB_B2B_XLAT_OFFSETU		0x0148
-#define SNB_PPD_CONN_MASK		0x03
-#define SNB_PPD_CONN_TRANSPARENT	0x00
-#define SNB_PPD_CONN_B2B		0x01
-#define SNB_PPD_CONN_RP			0x02
-#define SNB_PPD_DEV_MASK		0x10
-#define SNB_PPD_DEV_USD			0x00
-#define SNB_PPD_DEV_DSD			0x10
-#define SNB_PPD_SPLIT_BAR_MASK		0x40
-
-#define SNB_PPD_TOPO_MASK	(SNB_PPD_CONN_MASK | SNB_PPD_DEV_MASK)
-#define SNB_PPD_TOPO_PRI_USD	(SNB_PPD_CONN_RP | SNB_PPD_DEV_USD)
-#define SNB_PPD_TOPO_PRI_DSD	(SNB_PPD_CONN_RP | SNB_PPD_DEV_DSD)
-#define SNB_PPD_TOPO_SEC_USD	(SNB_PPD_CONN_TRANSPARENT | SNB_PPD_DEV_USD)
-#define SNB_PPD_TOPO_SEC_DSD	(SNB_PPD_CONN_TRANSPARENT | SNB_PPD_DEV_DSD)
-#define SNB_PPD_TOPO_B2B_USD	(SNB_PPD_CONN_B2B | SNB_PPD_DEV_USD)
-#define SNB_PPD_TOPO_B2B_DSD	(SNB_PPD_CONN_B2B | SNB_PPD_DEV_DSD)
-
-#define SNB_MW_COUNT			2
+/* Intel Xeon hardware */
+
+#define XEON_PBAR23LMT_OFFSET		0x0000
+#define XEON_PBAR45LMT_OFFSET		0x0008
+#define XEON_PBAR4LMT_OFFSET		0x0008
+#define XEON_PBAR5LMT_OFFSET		0x000c
+#define XEON_PBAR23XLAT_OFFSET		0x0010
+#define XEON_PBAR45XLAT_OFFSET		0x0018
+#define XEON_PBAR4XLAT_OFFSET		0x0018
+#define XEON_PBAR5XLAT_OFFSET		0x001c
+#define XEON_SBAR23LMT_OFFSET		0x0020
+#define XEON_SBAR45LMT_OFFSET		0x0028
+#define XEON_SBAR4LMT_OFFSET		0x0028
+#define XEON_SBAR5LMT_OFFSET		0x002c
+#define XEON_SBAR23XLAT_OFFSET		0x0030
+#define XEON_SBAR45XLAT_OFFSET		0x0038
+#define XEON_SBAR4XLAT_OFFSET		0x0038
+#define XEON_SBAR5XLAT_OFFSET		0x003c
+#define XEON_SBAR0BASE_OFFSET		0x0040
+#define XEON_SBAR23BASE_OFFSET		0x0048
+#define XEON_SBAR45BASE_OFFSET		0x0050
+#define XEON_SBAR4BASE_OFFSET		0x0050
+#define XEON_SBAR5BASE_OFFSET		0x0054
+#define XEON_SBDF_OFFSET		0x005c
+#define XEON_NTBCNTL_OFFSET		0x0058
+#define XEON_PDOORBELL_OFFSET		0x0060
+#define XEON_PDBMSK_OFFSET		0x0062
+#define XEON_SDOORBELL_OFFSET		0x0064
+#define XEON_SDBMSK_OFFSET		0x0066
+#define XEON_USMEMMISS_OFFSET		0x0070
+#define XEON_SPAD_OFFSET		0x0080
+#define XEON_PBAR23SZ_OFFSET		0x00d0
+#define XEON_PBAR45SZ_OFFSET		0x00d1
+#define XEON_PBAR4SZ_OFFSET		0x00d1
+#define XEON_SBAR23SZ_OFFSET		0x00d2
+#define XEON_SBAR45SZ_OFFSET		0x00d3
+#define XEON_SBAR4SZ_OFFSET		0x00d3
+#define XEON_PPD_OFFSET			0x00d4
+#define XEON_PBAR5SZ_OFFSET		0x00d5
+#define XEON_SBAR5SZ_OFFSET		0x00d6
+#define XEON_WCCNTRL_OFFSET		0x00e0
+#define XEON_UNCERRSTS_OFFSET		0x014c
+#define XEON_CORERRSTS_OFFSET		0x0158
+#define XEON_LINK_STATUS_OFFSET		0x01a2
+#define XEON_SPCICMD_OFFSET		0x0504
+#define XEON_DEVCTRL_OFFSET		0x0598
+#define XEON_DEVSTS_OFFSET		0x059a
+#define XEON_SLINK_STATUS_OFFSET	0x05a2
+#define XEON_B2B_SPAD_OFFSET		0x0100
+#define XEON_B2B_DOORBELL_OFFSET	0x0140
+#define XEON_B2B_XLAT_OFFSETL		0x0144
+#define XEON_B2B_XLAT_OFFSETU		0x0148
+#define XEON_PPD_CONN_MASK		0x03
+#define XEON_PPD_CONN_TRANSPARENT	0x00
+#define XEON_PPD_CONN_B2B		0x01
+#define XEON_PPD_CONN_RP		0x02
+#define XEON_PPD_DEV_MASK		0x10
+#define XEON_PPD_DEV_USD		0x00
+#define XEON_PPD_DEV_DSD		0x10
+#define XEON_PPD_SPLIT_BAR_MASK		0x40
+
+#define XEON_PPD_TOPO_MASK	(XEON_PPD_CONN_MASK | XEON_PPD_DEV_MASK)
+#define XEON_PPD_TOPO_PRI_USD	(XEON_PPD_CONN_RP | XEON_PPD_DEV_USD)
+#define XEON_PPD_TOPO_PRI_DSD	(XEON_PPD_CONN_RP | XEON_PPD_DEV_DSD)
+#define XEON_PPD_TOPO_SEC_USD	(XEON_PPD_CONN_TRANSPARENT | XEON_PPD_DEV_USD)
+#define XEON_PPD_TOPO_SEC_DSD	(XEON_PPD_CONN_TRANSPARENT | XEON_PPD_DEV_DSD)
+#define XEON_PPD_TOPO_B2B_USD	(XEON_PPD_CONN_B2B | XEON_PPD_DEV_USD)
+#define XEON_PPD_TOPO_B2B_DSD	(XEON_PPD_CONN_B2B | XEON_PPD_DEV_DSD)
+
+#define XEON_MW_COUNT			2
 #define HSX_SPLIT_BAR_MW_COUNT		3
-#define SNB_DB_COUNT			15
-#define SNB_DB_LINK			15
-#define SNB_DB_LINK_BIT			BIT_ULL(SNB_DB_LINK)
-#define SNB_DB_MSIX_VECTOR_COUNT	4
-#define SNB_DB_MSIX_VECTOR_SHIFT	5
-#define SNB_DB_TOTAL_SHIFT		16
-#define SNB_SPAD_COUNT			16
-
-/* BWD hardware */
-
-#define BWD_SBAR2XLAT_OFFSET		0x0008
-#define BWD_PDOORBELL_OFFSET		0x0020
-#define BWD_PDBMSK_OFFSET		0x0028
-#define BWD_NTBCNTL_OFFSET		0x0060
-#define BWD_SPAD_OFFSET			0x0080
-#define BWD_PPD_OFFSET			0x00d4
-#define BWD_PBAR2XLAT_OFFSET		0x8008
-#define BWD_B2B_DOORBELL_OFFSET		0x8020
-#define BWD_B2B_SPAD_OFFSET		0x8080
-#define BWD_SPCICMD_OFFSET		0xb004
-#define BWD_LINK_STATUS_OFFSET		0xb052
-#define BWD_ERRCORSTS_OFFSET		0xb110
-#define BWD_IP_BASE			0xc000
-#define BWD_DESKEWSTS_OFFSET		(BWD_IP_BASE + 0x3024)
-#define BWD_LTSSMERRSTS0_OFFSET		(BWD_IP_BASE + 0x3180)
-#define BWD_LTSSMSTATEJMP_OFFSET	(BWD_IP_BASE + 0x3040)
-#define BWD_IBSTERRRCRVSTS0_OFFSET	(BWD_IP_BASE + 0x3324)
-#define BWD_MODPHY_PCSREG4		0x1c004
-#define BWD_MODPHY_PCSREG6		0x1c006
-
-#define BWD_PPD_INIT_LINK		0x0008
-#define BWD_PPD_CONN_MASK		0x0300
-#define BWD_PPD_CONN_TRANSPARENT	0x0000
-#define BWD_PPD_CONN_B2B		0x0100
-#define BWD_PPD_CONN_RP			0x0200
-#define BWD_PPD_DEV_MASK		0x1000
-#define BWD_PPD_DEV_USD			0x0000
-#define BWD_PPD_DEV_DSD			0x1000
-#define BWD_PPD_TOPO_MASK	(BWD_PPD_CONN_MASK | BWD_PPD_DEV_MASK)
-#define BWD_PPD_TOPO_PRI_USD	(BWD_PPD_CONN_TRANSPARENT | BWD_PPD_DEV_USD)
-#define BWD_PPD_TOPO_PRI_DSD	(BWD_PPD_CONN_TRANSPARENT | BWD_PPD_DEV_DSD)
-#define BWD_PPD_TOPO_SEC_USD	(BWD_PPD_CONN_RP | BWD_PPD_DEV_USD)
-#define BWD_PPD_TOPO_SEC_DSD	(BWD_PPD_CONN_RP | BWD_PPD_DEV_DSD)
-#define BWD_PPD_TOPO_B2B_USD	(BWD_PPD_CONN_B2B | BWD_PPD_DEV_USD)
-#define BWD_PPD_TOPO_B2B_DSD	(BWD_PPD_CONN_B2B | BWD_PPD_DEV_DSD)
-
-#define BWD_MW_COUNT			2
-#define BWD_DB_COUNT			34
-#define BWD_DB_VALID_MASK		(BIT_ULL(BWD_DB_COUNT) - 1)
-#define BWD_DB_MSIX_VECTOR_COUNT	34
-#define BWD_DB_MSIX_VECTOR_SHIFT	1
-#define BWD_DB_TOTAL_SHIFT		34
-#define BWD_SPAD_COUNT			16
-
-#define BWD_NTB_CTL_DOWN_BIT		BIT(16)
-#define BWD_NTB_CTL_ACTIVE(x)		!(x & BWD_NTB_CTL_DOWN_BIT)
-
-#define BWD_DESKEWSTS_DBERR		BIT(15)
-#define BWD_LTSSMERRSTS0_UNEXPECTEDEI	BIT(20)
-#define BWD_LTSSMSTATEJMP_FORCEDETECT	BIT(2)
-#define BWD_IBIST_ERR_OFLOW		0x7FFF7FFF
-
-#define BWD_LINK_HB_TIMEOUT		msecs_to_jiffies(1000)
-#define BWD_LINK_RECOVERY_TIME		msecs_to_jiffies(500)
+#define XEON_DB_COUNT			15
+#define XEON_DB_LINK			15
+#define XEON_DB_LINK_BIT			BIT_ULL(XEON_DB_LINK)
+#define XEON_DB_MSIX_VECTOR_COUNT	4
+#define XEON_DB_MSIX_VECTOR_SHIFT	5
+#define XEON_DB_TOTAL_SHIFT		16
+#define XEON_SPAD_COUNT			16
+
+/* Intel Atom hardware */
+
+#define ATOM_SBAR2XLAT_OFFSET		0x0008
+#define ATOM_PDOORBELL_OFFSET		0x0020
+#define ATOM_PDBMSK_OFFSET		0x0028
+#define ATOM_NTBCNTL_OFFSET		0x0060
+#define ATOM_SPAD_OFFSET			0x0080
+#define ATOM_PPD_OFFSET			0x00d4
+#define ATOM_PBAR2XLAT_OFFSET		0x8008
+#define ATOM_B2B_DOORBELL_OFFSET		0x8020
+#define ATOM_B2B_SPAD_OFFSET		0x8080
+#define ATOM_SPCICMD_OFFSET		0xb004
+#define ATOM_LINK_STATUS_OFFSET		0xb052
+#define ATOM_ERRCORSTS_OFFSET		0xb110
+#define ATOM_IP_BASE			0xc000
+#define ATOM_DESKEWSTS_OFFSET		(ATOM_IP_BASE + 0x3024)
+#define ATOM_LTSSMERRSTS0_OFFSET		(ATOM_IP_BASE + 0x3180)
+#define ATOM_LTSSMSTATEJMP_OFFSET	(ATOM_IP_BASE + 0x3040)
+#define ATOM_IBSTERRRCRVSTS0_OFFSET	(ATOM_IP_BASE + 0x3324)
+#define ATOM_MODPHY_PCSREG4		0x1c004
+#define ATOM_MODPHY_PCSREG6		0x1c006
+
+#define ATOM_PPD_INIT_LINK		0x0008
+#define ATOM_PPD_CONN_MASK		0x0300
+#define ATOM_PPD_CONN_TRANSPARENT	0x0000
+#define ATOM_PPD_CONN_B2B		0x0100
+#define ATOM_PPD_CONN_RP			0x0200
+#define ATOM_PPD_DEV_MASK		0x1000
+#define ATOM_PPD_DEV_USD			0x0000
+#define ATOM_PPD_DEV_DSD			0x1000
+#define ATOM_PPD_TOPO_MASK	(ATOM_PPD_CONN_MASK | ATOM_PPD_DEV_MASK)
+#define ATOM_PPD_TOPO_PRI_USD	(ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_USD)
+#define ATOM_PPD_TOPO_PRI_DSD	(ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_DSD)
+#define ATOM_PPD_TOPO_SEC_USD	(ATOM_PPD_CONN_RP | ATOM_PPD_DEV_USD)
+#define ATOM_PPD_TOPO_SEC_DSD	(ATOM_PPD_CONN_RP | ATOM_PPD_DEV_DSD)
+#define ATOM_PPD_TOPO_B2B_USD	(ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_USD)
+#define ATOM_PPD_TOPO_B2B_DSD	(ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_DSD)
+
+#define ATOM_MW_COUNT			2
+#define ATOM_DB_COUNT			34
+#define ATOM_DB_VALID_MASK		(BIT_ULL(ATOM_DB_COUNT) - 1)
+#define ATOM_DB_MSIX_VECTOR_COUNT	34
+#define ATOM_DB_MSIX_VECTOR_SHIFT	1
+#define ATOM_DB_TOTAL_SHIFT		34
+#define ATOM_SPAD_COUNT			16
+
+#define ATOM_NTB_CTL_DOWN_BIT		BIT(16)
+#define ATOM_NTB_CTL_ACTIVE(x)		!(x & ATOM_NTB_CTL_DOWN_BIT)
+
+#define ATOM_DESKEWSTS_DBERR		BIT(15)
+#define ATOM_LTSSMERRSTS0_UNEXPECTEDEI	BIT(20)
+#define ATOM_LTSSMSTATEJMP_FORCEDETECT	BIT(2)
+#define ATOM_IBIST_ERR_OFLOW		0x7FFF7FFF
+
+#define ATOM_LINK_HB_TIMEOUT		msecs_to_jiffies(1000)
+#define ATOM_LINK_RECOVERY_TIME		msecs_to_jiffies(500)
 
 /* Ntb control and link status */
 
@@ -224,19 +224,19 @@
 
 /* Use the following addresses for translation between b2b ntb devices in case
  * the hardware default values are not reliable. */
-#define SNB_B2B_BAR0_USD_ADDR		0x1000000000000000ull
-#define SNB_B2B_BAR2_USD_ADDR64		0x2000000000000000ull
-#define SNB_B2B_BAR4_USD_ADDR64		0x4000000000000000ull
-#define SNB_B2B_BAR4_USD_ADDR32		0x20000000u
-#define SNB_B2B_BAR5_USD_ADDR32		0x40000000u
-#define SNB_B2B_BAR0_DSD_ADDR		0x9000000000000000ull
-#define SNB_B2B_BAR2_DSD_ADDR64		0xa000000000000000ull
-#define SNB_B2B_BAR4_DSD_ADDR64		0xc000000000000000ull
-#define SNB_B2B_BAR4_DSD_ADDR32		0xa0000000u
-#define SNB_B2B_BAR5_DSD_ADDR32		0xc0000000u
+#define XEON_B2B_BAR0_USD_ADDR		0x1000000000000000ull
+#define XEON_B2B_BAR2_USD_ADDR64	0x2000000000000000ull
+#define XEON_B2B_BAR4_USD_ADDR64	0x4000000000000000ull
+#define XEON_B2B_BAR4_USD_ADDR32	0x20000000u
+#define XEON_B2B_BAR5_USD_ADDR32	0x40000000u
+#define XEON_B2B_BAR0_DSD_ADDR		0x9000000000000000ull
+#define XEON_B2B_BAR2_DSD_ADDR64	0xa000000000000000ull
+#define XEON_B2B_BAR4_DSD_ADDR64	0xc000000000000000ull
+#define XEON_B2B_BAR4_DSD_ADDR32	0xa0000000u
+#define XEON_B2B_BAR5_DSD_ADDR32	0xc0000000u
 
 /* The peer ntb secondary config space is 32KB fixed size */
-#define SNB_B2B_MIN_SIZE		0x8000
+#define XEON_B2B_MIN_SIZE		0x8000
 
 /* flags to indicate hardware errata */
 #define NTB_HWERR_SDOORBELL_LOCKUP	BIT_ULL(0)
-- 
2.4.0.rc0.43.gcf8a8c6

