Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 04/18] NTB: Enable link for Intel root port mode in probe
Date: Tue,  9 Jun 2015 05:44:31 -0400
Message-Id: <5ef61ff1b2b5ab0f49dded7056b90917237ef714.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Link training should be enabled in the driver probe for root port mode.
We should not have to wait for transport to be loaded for this to
happen.  Otherwise the ntb device will not show up on the transparent
bridge side of the link.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 10ca18af4106..64ce690d9616 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1318,6 +1318,9 @@ static int snb_poll_link(struct intel_ntb_dev *ndev)
 
 static int snb_link_is_up(struct intel_ntb_dev *ndev)
 {
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return 1;
+
 	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
 }
 
@@ -1614,6 +1617,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 static int snb_init_ntb(struct intel_ntb_dev *ndev)
 {
 	int rc;
+	u32 ntb_ctl;
 
 	if (ndev->bar4_split)
 		ndev->mw_count = HSX_SPLIT_BAR_MW_COUNT;
@@ -1630,6 +1634,12 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
 			dev_err(ndev_dev(ndev), "NTB Primary config disabled\n");
 			return -EINVAL;
 		}
+
+		/* enable link to allow secondary side device to appear */
+		ntb_ctl = ioread32(ndev->self_mmio + ndev->reg->ntb_ctl);
+		ntb_ctl &= ~NTB_CTL_DISABLE;
+		iowrite32(ntb_ctl, ndev->self_mmio + ndev->reg->ntb_ctl);
+
 		/* use half the spads for the peer */
 		ndev->spad_count >>= 1;
 		ndev->self_reg = &snb_pri_reg;
-- 
2.4.0.rc0.43.gcf8a8c6

