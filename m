Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 05/17] NTB: Add parameters for Intel SNB B2B addresses
Date: Thu, 21 May 2015 04:20:49 -0400
Message-Id: <64ddbb8af4594d7c5053831f26f55b18ae905217.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
References: <cover.1432192681.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432196075.git.Allen.Hubbe@emc.com>
References: <cover.1432196075.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add module parameters for the addresses to be used in b2b topology.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 Documentation/ntb.txt               | 10 +++++
 drivers/ntb/hw/intel/ntb_hw_intel.c | 77 ++++++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index 725ba1e..00a3f92 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -56,3 +56,13 @@ Module Parameters:
 * b2b\_mw\_share - If the peer ntb is to be accessed via a memory window, and if
 	the memory window is large enough, still allow the client to use the
 	second half of the memory window for address translation to the peer.
+* snb\_b2b\_usd\_bar2\_addr64 - If using B2B topology on Xeon hardware, use this
+	64 bit address on the bus between the NTB devices for the window at
+	BAR2, on the upstream side of the link.
+* snb\_b2b\_usd\_bar4\_addr64 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_usd\_bar4\_addr32 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_usd\_bar5\_addr32 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_dsd\_bar2\_addr64 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_dsd\_bar4\_addr64 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_dsd\_bar4\_addr32 - See *snb\_b2b\_bar2\_addr64*.
+* snb\_b2b\_dsd\_bar5\_addr32 - See *snb\_b2b\_bar2\_addr64*.
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 89fea50..7e19d46 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -72,20 +72,6 @@ MODULE_AUTHOR("Intel Corporation");
 #define bar0_off(base, bar) ((base) + ((bar) << 2))
 #define bar2_off(base, bar) bar0_off(base, (bar) - 2)
 
-static int b2b_mw_idx = -1;
-module_param(b2b_mw_idx, int, 0644);
-MODULE_PARM_DESC(b2b_mw_idx, "Use this mw idx to access the peer ntb.  A "
-		 "value of zero or positive starts from first mw idx, and a "
-		 "negative value starts from last mw idx.  Both sides MUST "
-		 "set the same value here!");
-
-static unsigned int b2b_mw_share;
-module_param(b2b_mw_share, uint, 0644);
-MODULE_PARM_DESC(b2b_mw_share, "If the b2b mw is large enough, configure the "
-		 "ntb so that the peer ntb only occupies the first half of "
-		 "the mw, so the second half can still be used as a mw.  Both "
-		 "sides MUST set the same value here!");
-
 static const struct intel_ntb_reg bwd_reg;
 static const struct intel_ntb_alt_reg bwd_pri_reg;
 static const struct intel_ntb_alt_reg bwd_sec_reg;
@@ -98,14 +84,67 @@ static const struct intel_ntb_alt_reg snb_sec_reg;
 static const struct intel_ntb_alt_reg snb_b2b_reg;
 static const struct intel_ntb_xlat_reg snb_pri_xlat;
 static const struct intel_ntb_xlat_reg snb_sec_xlat;
-static const struct intel_b2b_addr snb_b2b_usd_addr;
-static const struct intel_b2b_addr snb_b2b_dsd_addr;
-
+static struct intel_b2b_addr snb_b2b_usd_addr;
+static struct intel_b2b_addr snb_b2b_dsd_addr;
 static const struct ntb_dev_ops intel_ntb_ops;
 
 static const struct file_operations intel_ntb_debugfs_info;
 static struct dentry *debugfs_dir;
 
+static int b2b_mw_idx = -1;
+module_param(b2b_mw_idx, int, 0644);
+MODULE_PARM_DESC(b2b_mw_idx, "Use this mw idx to access the peer ntb.  A "
+		 "value of zero or positive starts from first mw idx, and a "
+		 "negative value starts from last mw idx.  Both sides MUST "
+		 "set the same value here!");
+
+static unsigned int b2b_mw_share;
+module_param(b2b_mw_share, uint, 0644);
+MODULE_PARM_DESC(b2b_mw_share, "If the b2b mw is large enough, configure the "
+		 "ntb so that the peer ntb only occupies the first half of "
+		 "the mw, so the second half can still be used as a mw.  Both "
+		 "sides MUST set the same value here!");
+
+module_param_named(snb_b2b_usd_bar2_addr64,
+		   snb_b2b_usd_addr.bar2_addr64, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
+		 "SNB B2B USD BAR 2 64-bit address");
+
+module_param_named(snb_b2b_usd_bar4_addr64,
+		   snb_b2b_usd_addr.bar4_addr64, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
+		 "SNB B2B USD BAR 4 64-bit address");
+
+module_param_named(snb_b2b_usd_bar4_addr32,
+		   snb_b2b_usd_addr.bar4_addr32, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
+		 "SNB B2B USD split-BAR 4 32-bit address");
+
+module_param_named(snb_b2b_usd_bar5_addr32,
+		   snb_b2b_usd_addr.bar5_addr32, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_usd_bar2_addr64,
+		 "SNB B2B USD split-BAR 5 32-bit address");
+
+module_param_named(snb_b2b_dsd_bar2_addr64,
+		   snb_b2b_dsd_addr.bar2_addr64, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
+		 "SNB B2B DSD BAR 2 64-bit address");
+
+module_param_named(snb_b2b_dsd_bar4_addr64,
+		   snb_b2b_dsd_addr.bar4_addr64, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
+		 "SNB B2B DSD BAR 4 64-bit address");
+
+module_param_named(snb_b2b_dsd_bar4_addr32,
+		   snb_b2b_dsd_addr.bar4_addr32, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
+		 "SNB B2B DSD split-BAR 4 32-bit address");
+
+module_param_named(snb_b2b_dsd_bar5_addr32,
+		   snb_b2b_dsd_addr.bar5_addr32, ullong, 0644);
+MODULE_PARM_DESC(snb_b2b_dsd_bar2_addr64,
+		 "SNB B2B DSD split-BAR 5 32-bit address");
+
 #ifndef ioread64
 #ifdef readq
 #define ioread64 readq
@@ -2086,14 +2125,14 @@ static const struct intel_ntb_xlat_reg snb_sec_xlat = {
 	.bar2_xlat		= SNB_SBAR23XLAT_OFFSET,
 };
 
-static const struct intel_b2b_addr snb_b2b_usd_addr = {
+static struct intel_b2b_addr snb_b2b_usd_addr = {
 	.bar2_addr64		= SNB_B2B_BAR2_USD_ADDR64,
 	.bar4_addr64		= SNB_B2B_BAR4_USD_ADDR64,
 	.bar4_addr32		= SNB_B2B_BAR4_USD_ADDR32,
 	.bar5_addr32		= SNB_B2B_BAR5_USD_ADDR32,
 };
 
-static const struct intel_b2b_addr snb_b2b_dsd_addr = {
+static struct intel_b2b_addr snb_b2b_dsd_addr = {
 	.bar2_addr64		= SNB_B2B_BAR2_DSD_ADDR64,
 	.bar4_addr64		= SNB_B2B_BAR4_DSD_ADDR64,
 	.bar4_addr32		= SNB_B2B_BAR4_DSD_ADDR32,
-- 
2.4.0.rc0.43.gcf8a8c6

