Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 03/16] ntb: Enable link training for RP mode in the driver probe
Date: Wed, 20 May 2015 11:41:04 -0400
Message-Id: <ae66adf68441cdaf893d2a562924615c229489c0.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Link training for RP should be enabled in the driver probe. We should
not have to wait for transport loaded for this to hapen. Otherwise the
device will not show up on the transparent bridge side.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 05c4b77..d162f22 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1333,6 +1333,9 @@ static int snb_poll_link(struct intel_ntb_dev *ndev)
 
 static int snb_link_is_up(struct intel_ntb_dev *ndev)
 {
+	if (ndev->ntb.topo == NTB_TOPO_SEC)
+		return 1;
+
 	return NTB_LNK_STA_ACTIVE(ndev->lnk_sta);
 }
 
@@ -1642,6 +1645,7 @@ static int snb_setup_b2b_mw(struct intel_ntb_dev *ndev,
 static int snb_init_ntb(struct intel_ntb_dev *ndev)
 {
 	int rc;
+	u32 ntb_ctl;
 
 	if (ndev->bar4_split)
 		ndev->mw_count = HSX_SPLIT_BAR_MW_COUNT;
@@ -1658,6 +1662,12 @@ static int snb_init_ntb(struct intel_ntb_dev *ndev)
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

