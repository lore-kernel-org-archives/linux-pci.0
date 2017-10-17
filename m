Return-Path: <linux-kernel-owner@vger.kernel.org>
From: dmeyer@gigaio.com
To: kurt.schwemmer@microsemi.com, stephen.bates@microsemi.com,
        logang@deltatee.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Doug Meyer <dmeyer@gigaio.com>
Subject: [PATCH] NTB: ntb_hw_switchtec: Fix peer BAR bug in switchtec_ntb_init_shared_mw
Date: Tue, 17 Oct 2017 13:22:53 -0700
Message-Id: <1508271773-17827-1-git-send-email-dmeyer@gigaio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Doug Meyer <dmeyer@gigaio.com>

This resolves a bug which may incorrectly configure the peer host's
LUT for shared memory window access. The code was using the local
host's first BAR number, rather than the peer hosts's first BAR
number, to determine what peer NT control register to program.

The bug will cause the Switchtec NTB link to work only if both peers
have the same first NTB BAR configured. In all other configurations,
the link will not come up, failing silently.

When both hosts have the same first BAR, the configuration works only
because the first BAR numbers happent to be the same. When the hosts
do not have the same first BAR, then the LUT translation will not be
configured in the correct peer LUT and will not give the peer the
shared memory window access required for the link to operate.

Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index afe8ed6..ca0334a 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -964,7 +964,8 @@ static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
 static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 {
 	struct ntb_ctrl_regs __iomem *ctl = sndev->mmio_peer_ctrl;
-	int bar = sndev->direct_mw_to_bar[0];
+	int self_bar = sndev->direct_mw_to_bar[0];
+	int peer_bar = sndev->peer_direct_mw_to_bar[0];
 	u32 ctl_val;
 	int rc;
 
@@ -985,12 +986,12 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 	if (rc)
 		goto unalloc_and_exit;
 
-	ctl_val = ioread32(&ctl->bar_entry[bar].ctl);
+	ctl_val = ioread32(&ctl->bar_entry[peer_bar].ctl);
 	ctl_val &= 0xFF;
 	ctl_val |= NTB_CTRL_BAR_LUT_WIN_EN;
 	ctl_val |= ilog2(LUT_SIZE) << 8;
 	ctl_val |= (sndev->nr_lut_mw - 1) << 14;
-	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
+	iowrite32(ctl_val, &ctl->bar_entry[peer_bar].ctl);
 
 	iowrite64((NTB_CTRL_LUT_EN | (sndev->self_partition << 1) |
 		   sndev->self_shared_dma),
@@ -1009,7 +1010,7 @@ static int switchtec_ntb_init_shared_mw(struct switchtec_ntb *sndev)
 		goto unalloc_and_exit;
 	}
 
-	sndev->peer_shared = pci_iomap(sndev->stdev->pdev, bar, LUT_SIZE);
+	sndev->peer_shared = pci_iomap(sndev->stdev->pdev, self_bar, LUT_SIZE);
 	if (!sndev->peer_shared) {
 		rc = -ENOMEM;
 		goto unalloc_and_exit;
-- 
1.8.3.1
