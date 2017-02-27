Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbdB0UYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 15:24:45 -0500
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>,
        Will Deacon <will.deacon@arm.com>,
        Shanker Donthineni <shankerd@qti.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@qti.qualcomm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nate Watterson <nwatters@qti.qualcomm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [RFC PATCH 26/30] iommu/arm-smmu-v3: Fix PRI queue overflow acknowledgement
Date: Mon, 27 Feb 2017 19:54:37 +0000
Message-Id: <20170227195441.5170-27-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When an overflow occurs in the PRI queue, the SMMU toggles the overflow
flag in the PROD register. To exit the overflow condition, the PRI thread
is supposed to acknowledge it by toggling this flag in the CONS register.

Currently with an overflow condition, the flag is toggled in q->cons after
clearing the PRI queue, but is never published to the hardware. It would
be done next time we execute the thread. However, we never get a chance
because the SMMU doesn't append anything to the queue while in overflow
condition, and the thread is not scheduled unless the queue transitions
from empty to non-empty. To fix it, synchronize the hardware CONS register
before leaving the PRIQ thread.

This bug doesn't affect the event queue, since the SMMU still adds
elements to that queue when the overflow condition is active. Even missing
an overflow condition because one is already active doesn't matter. We
won't miss fault records for stalled transactions. But it feels nicer to
keep the SMMU in sync when possible, so do it there as well.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2f1ec09aeaec..b5d45c1e14d1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -932,6 +932,16 @@ static void queue_inc_cons(struct arm_smmu_queue *q)
 	writel(q->cons, q->cons_reg);
 }
 
+static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
+{
+	/* Acknowledge overflow condition if any */
+	if (Q_OVF(q, q->prod) == Q_OVF(q, q->cons))
+		return;
+
+	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	writel(q->cons, q->cons_reg);
+}
+
 static int queue_sync_prod(struct arm_smmu_queue *q)
 {
 	int ret = 0;
@@ -1782,7 +1792,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
@@ -1846,7 +1856,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	queue_sync_cons_ovf(q);
 
 	smmu->priq.batch++;
 	wake_up_locked(&smmu->priq.wq);
-- 
2.11.0
