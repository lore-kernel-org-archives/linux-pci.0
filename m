Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755795AbdLOXDG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Dec 2017 18:03:06 -0500
Subject: [PATCH] qed: Remove unused QED_RDMA_DEV_CAP_* symbols and
 dev->dev_caps
From: Bjorn Helgaas <helgaas@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Ariel Elior <Ariel.Elior@cavium.com>,
        everest-linux-l2@cavium.com
Date: Fri, 15 Dec 2017 17:03:01 -0600
Message-ID: <20171215230301.177993.80284.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The QED_RDMA_DEV_CAP_* symbols are only used to set bits in dev->dev_caps.
Nobody ever looks at those bits.  Remove the symbols and dev_caps itself.

Note that if these are ever used and added back, it looks incorrect to set
QED_RDMA_DEV_CAP_ATOMIC_OP based on PCI_EXP_DEVCTL2_LTR_EN.  LTR is the
Latency Tolerance Reporting mechanism, which has nothing to do with Atomic
Ops.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c |   20 ----------
 include/linux/qed/qed_rdma_if.h            |   55 +---------------------------
 2 files changed, 1 insertion(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index c8c4b3940564..1091b6aae0c6 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -394,7 +394,6 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 {
 	struct qed_rdma_device *dev = p_hwfn->p_rdma_info->dev;
 	struct qed_dev *cdev = p_hwfn->cdev;
-	u32 pci_status_control;
 	u32 num_qps;
 
 	/* Vendor specific information */
@@ -468,25 +467,6 @@ static void qed_rdma_init_devinfo(struct qed_hwfn *p_hwfn,
 	dev->max_ah = p_hwfn->p_rdma_info->num_qps;
 	dev->max_stats_queues = (u8)RESC_NUM(p_hwfn, QED_RDMA_STATS_QUEUE);
 
-	/* Set capablities */
-	dev->dev_caps = 0;
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_RNR_NAK, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_PORT_ACTIVE_EVENT, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_PORT_CHANGE_EVENT, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_RESIZE_CQ, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_BASE_MEMORY_EXT, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_BASE_QUEUE_EXT, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_ZBVA, 1);
-	SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_LOCAL_INV_FENCE, 1);
-
-	/* Check atomic operations support in PCI configuration space. */
-	pci_read_config_dword(cdev->pdev,
-			      cdev->pdev->pcie_cap + PCI_EXP_DEVCTL2,
-			      &pci_status_control);
-
-	if (pci_status_control & PCI_EXP_DEVCTL2_LTR_EN)
-		SET_FIELD(dev->dev_caps, QED_RDMA_DEV_CAP_ATOMIC_OP, 1);
-
 	if (QED_IS_IWARP_PERSONALITY(p_hwfn))
 		qed_iwarp_init_devinfo(p_hwfn);
 }
diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
index 4dd72ba210f5..a8db5572d3c2 100644
--- a/include/linux/qed/qed_rdma_if.h
+++ b/include/linux/qed/qed_rdma_if.h
@@ -109,60 +109,7 @@ struct qed_rdma_device {
 	u8 max_pkey;
 	u16 max_srq_wr;
 	u8 max_stats_queues;
-	u32 dev_caps;
-
-	/* Abilty to support RNR-NAK generation */
-
-#define QED_RDMA_DEV_CAP_RNR_NAK_MASK                           0x1
-#define QED_RDMA_DEV_CAP_RNR_NAK_SHIFT                  0
-	/* Abilty to support shutdown port */
-#define QED_RDMA_DEV_CAP_SHUTDOWN_PORT_MASK                     0x1
-#define QED_RDMA_DEV_CAP_SHUTDOWN_PORT_SHIFT                    1
-	/* Abilty to support port active event */
-#define QED_RDMA_DEV_CAP_PORT_ACTIVE_EVENT_MASK         0x1
-#define QED_RDMA_DEV_CAP_PORT_ACTIVE_EVENT_SHIFT                2
-	/* Abilty to support port change event */
-#define QED_RDMA_DEV_CAP_PORT_CHANGE_EVENT_MASK         0x1
-#define QED_RDMA_DEV_CAP_PORT_CHANGE_EVENT_SHIFT                3
-	/* Abilty to support system image GUID */
-#define QED_RDMA_DEV_CAP_SYS_IMAGE_MASK                 0x1
-#define QED_RDMA_DEV_CAP_SYS_IMAGE_SHIFT                        4
-	/* Abilty to support bad P_Key counter support */
-#define QED_RDMA_DEV_CAP_BAD_PKEY_CNT_MASK                      0x1
-#define QED_RDMA_DEV_CAP_BAD_PKEY_CNT_SHIFT                     5
-	/* Abilty to support atomic operations */
-#define QED_RDMA_DEV_CAP_ATOMIC_OP_MASK                 0x1
-#define QED_RDMA_DEV_CAP_ATOMIC_OP_SHIFT                        6
-#define QED_RDMA_DEV_CAP_RESIZE_CQ_MASK                 0x1
-#define QED_RDMA_DEV_CAP_RESIZE_CQ_SHIFT                        7
-	/* Abilty to support modifying the maximum number of
-	 * outstanding work requests per QP
-	 */
-#define QED_RDMA_DEV_CAP_RESIZE_MAX_WR_MASK                     0x1
-#define QED_RDMA_DEV_CAP_RESIZE_MAX_WR_SHIFT                    8
-	/* Abilty to support automatic path migration */
-#define QED_RDMA_DEV_CAP_AUTO_PATH_MIG_MASK                     0x1
-#define QED_RDMA_DEV_CAP_AUTO_PATH_MIG_SHIFT                    9
-	/* Abilty to support the base memory management extensions */
-#define QED_RDMA_DEV_CAP_BASE_MEMORY_EXT_MASK                   0x1
-#define QED_RDMA_DEV_CAP_BASE_MEMORY_EXT_SHIFT          10
-#define QED_RDMA_DEV_CAP_BASE_QUEUE_EXT_MASK                    0x1
-#define QED_RDMA_DEV_CAP_BASE_QUEUE_EXT_SHIFT                   11
-	/* Abilty to support multipile page sizes per memory region */
-#define QED_RDMA_DEV_CAP_MULTI_PAGE_PER_MR_EXT_MASK             0x1
-#define QED_RDMA_DEV_CAP_MULTI_PAGE_PER_MR_EXT_SHIFT            12
-	/* Abilty to support block list physical buffer list */
-#define QED_RDMA_DEV_CAP_BLOCK_MODE_MASK                        0x1
-#define QED_RDMA_DEV_CAP_BLOCK_MODE_SHIFT                       13
-	/* Abilty to support zero based virtual addresses */
-#define QED_RDMA_DEV_CAP_ZBVA_MASK                              0x1
-#define QED_RDMA_DEV_CAP_ZBVA_SHIFT                             14
-	/* Abilty to support local invalidate fencing */
-#define QED_RDMA_DEV_CAP_LOCAL_INV_FENCE_MASK                   0x1
-#define QED_RDMA_DEV_CAP_LOCAL_INV_FENCE_SHIFT          15
-	/* Abilty to support Loopback on QP */
-#define QED_RDMA_DEV_CAP_LB_INDICATOR_MASK                      0x1
-#define QED_RDMA_DEV_CAP_LB_INDICATOR_SHIFT                     16
+
 	u64 page_size_caps;
 	u8 dev_ack_delay;
 	u32 reserved_lkey;
