Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        gabriele.paoloni@huawei.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com
Subject: [RFCv2 PATCH 27/36] iommu/arm-smmu-v3: Register fault workqueue
Date: Fri,  6 Oct 2017 14:31:54 +0100
Message-Id: <20171006133203.22803-28-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When using PRI or Stall, the PRI or event handler enqueues faults into the
core fault queue. Register it based on the SMMU features.

When the core stops using a PASID, it notifies the SMMU to flush all
instances of this PASID from the PRI queue. Add a way to flush the PRI and
event queue. PRI and event thread now take a spinlock while processing the
queue. The flush handler takes this lock to inspect the queue state.
We avoid livelock, where the SMMU adds fault to the queue faster than we
can consume them, by incrementing a 'batch' number on every cycle so the
flush handler only has to wait a complete cycle (two batch increments.)

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 104 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2b2e2be03de7..7d68c6aecb14 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -570,6 +570,10 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+	/* Event and PRI */
+	u64				batch;
+	wait_queue_head_t		wq;
 };
 
 struct arm_smmu_cmdq {
@@ -716,6 +720,9 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	/* Notifier for the fault queue */
+	struct notifier_block		faultq_nb;
 };
 
 /* SMMU private data for each master */
@@ -1568,19 +1575,27 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int i;
+	int num_handled = 0;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
+	size_t queue_size = 1 << q->max_n_shift;
 	u64 evt[EVTQ_ENT_DWORDS];
 
+	spin_lock(&q->wq.lock);
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
 
+			if (++num_handled == queue_size) {
+				q->batch++;
+				wake_up_locked(&q->wq);
+				num_handled = 0;
+			}
+
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
 			for (i = 0; i < ARRAY_SIZE(evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
 					 (unsigned long long)evt[i]);
-
 		}
 
 		/*
@@ -1593,6 +1608,11 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+
+	q->batch++;
+	wake_up_locked(&q->wq);
+	spin_unlock(&q->wq.lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -1636,13 +1656,24 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 {
+	int num_handled = 0;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
+	size_t queue_size = 1 << q->max_n_shift;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	spin_lock(&q->wq.lock);
 	do {
-		while (!queue_remove_raw(q, evt))
+		while (!queue_remove_raw(q, evt)) {
+			spin_unlock(&q->wq.lock);
 			arm_smmu_handle_ppr(smmu, evt);
+			spin_lock(&q->wq.lock);
+			if (++num_handled == queue_size) {
+				q->batch++;
+				wake_up_locked(&q->wq);
+				num_handled = 0;
+			}
+		}
 
 		if (queue_sync_prod(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
@@ -1650,9 +1681,65 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+
+	q->batch++;
+	wake_up_locked(&q->wq);
+	spin_unlock(&q->wq.lock);
+
 	return IRQ_HANDLED;
 }
 
+/*
+ * arm_smmu_flush_queue - wait until all events/PRIs currently in the queue have
+ * been consumed.
+ *
+ * Wait until the queue thread finished a batch, or until the queue is empty.
+ * Note that we don't handle overflows on q->batch. If it occurs, just wait for
+ * the queue to be empty.
+ */
+static int arm_smmu_flush_queue(struct arm_smmu_device *smmu,
+				struct arm_smmu_queue *q, const char *name)
+{
+	int ret;
+	u64 batch;
+
+	spin_lock(&q->wq.lock);
+	if (queue_sync_prod(q) == -EOVERFLOW)
+		dev_err(smmu->dev, "%s overflow detected -- requests lost\n", name);
+
+	batch = q->batch;
+	ret = wait_event_interruptible_locked(q->wq, queue_empty(q) ||
+					      q->batch >= batch + 2);
+	spin_unlock(&q->wq.lock);
+
+	return ret;
+}
+
+static int arm_smmu_flush_queues(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct arm_smmu_device *smmu = container_of(nb, struct arm_smmu_device,
+						    faultq_nb);
+	struct device *dev = data;
+	struct arm_smmu_master_data *master = NULL;
+
+	if (dev)
+		master = dev->iommu_fwspec->iommu_priv;
+
+	if (master) {
+		/* TODO: add support for PRI and Stall */
+		return 0;
+	}
+
+	/* No target device, flush all queues. */
+	if (smmu->features & ARM_SMMU_FEAT_STALLS)
+		arm_smmu_flush_queue(smmu, &smmu->evtq.q, "evtq");
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		arm_smmu_flush_queue(smmu, &smmu->priq.q, "priq");
+
+	return 0;
+}
+
 static irqreturn_t arm_smmu_cmdq_sync_handler(int irq, void *dev)
 {
 	/* We don't actually use CMD_SYNC interrupts for anything */
@@ -2697,6 +2784,10 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 		     << Q_BASE_LOG2SIZE_SHIFT;
 
 	q->prod = q->cons = 0;
+
+	init_waitqueue_head(&q->wq);
+	q->batch = 0;
+
 	return 0;
 }
 
@@ -3594,6 +3685,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
+		smmu->faultq_nb.notifier_call = arm_smmu_flush_queues;
+		ret = iommu_fault_queue_register(&smmu->faultq_nb);
+		if (ret)
+			return ret;
+	}
+
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
@@ -3636,6 +3734,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	iommu_fault_queue_unregister(&smmu->faultq_nb);
+
 	arm_smmu_device_disable(smmu);
 
 	return 0;
-- 
2.13.3

