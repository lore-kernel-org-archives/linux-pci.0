Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdB0ULP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 15:11:15 -0500
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
Subject: [RFC PATCH 25/30] iommu/arm-smmu-v3: Safe invalidation and recycling of PASIDs
Date: Mon, 27 Feb 2017 19:54:36 +0000
Message-Id: <20170227195441.5170-26-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch proposes a solution for safely reusing a context after it is
released with iommu_unbind_task. Let's first describe the lifetime of a
context.

A context is a bond between device and task, identified by a PASID. (I
will be using "PASID" and "context" interchangeably.) We identify four
states for a PASID: USED, STALE, INVALID, FREE.

                     (2) .----- INVALID <-----. (3a)
                         |                    |
                         v        (1)         |
           (init)----> FREE ---------------> USED
                         ^                    |
                         |                    |
                    (3b) '------ STALE <------' (2)

Initially, all PASIDs are free for use. A call to bind_task (1) allocates
a PASID. A call to unbind_task (2) puts the context into STALE state. At
this point we mandate that the device doesn't generate any new traffic for
the PASID. If the device isn't using PRI (3a), we can free the PASID.
Otherwise, we cannot re-allocate the PASID until we are certain that there
are no pending page request for that PASID. This is done by a bus- and
device-specific PASID invalidation operation (3b). Once that operation
completes, the PASID can be reallocated for a new context. The PASID
invalidation could also be observed prior to receiving an unbind_task call
(3a). In that case, the PASID can be reused immediately.

The PCIe ATS specification defines two mechanisms for invalidating PASIDs
(4.1.2. Managing PASID TLP Prefix Usage):

* When ceasing to use a PASID, the device finishes to transmit any related
  request and waits for them to come back with a response.

* When ceasing to use a PASID, the device marks all related outstanding
  requests as stale and send a Stop Marker. Any page request with that
  PASID received after the Stop Marker is related to a different context.

In the first case, the device driver might know that the PASID has been
invalidated before calling unbind_task, in which case it should pass
IOMMU_PASID_CLEAN to iommu_unbind_task. This indicate that the PASID can
be safely reused immediately. In any other implementation, it is
impossible to know which happens first, (2) or (3).

When unbind_task is called, there could still be transactions with the
affected PASID in the system buffers:

 (A) making their way towards the SMMU,
 (B) waiting in the PRI queue to be processed by the handler,
 (C) waiting in the fault work queue.

We consider (A) to be a bug. The PCIe specification requires all "Posted
Requests addressing host memory" to be flushed to the host before
completing the device-specific stop request mechanism (6.20.1 Managing
PASID TLP Prefix Usage). We mandate the device driver to perform this stop
request before calling iommu_unbind, and ensure that no transaction
referring to this PASID is pending in the PCIe system. We'll have to put
the same requirement on non-PCIe buses.

(B) is the SMMU driver's responsibility, and is quite a drag, because we
can't inspect the PRI queue without adding locks around producer and
consumer registers, or else we would race with the PRI handling thread.
(C) is easier, we have a direct way to drain a work queue.

A major complication of the second point is that even when a device
properly implements Stop Markers, we might lose them if the SMMU's PRI
queue overflows. Indeed, in case of an overflow the SMMU is able to
auto-respond to page faults, but Stop Markers are discarded. So a safe
implementation that takes overflow into account cannot solely rely on Stop
Markers for freeing contexts. Stop Markers only allow to speed up the
freeing process.

                                   *
                                  * *

This patch adds context state tracking and delayed invalidation, in order
to safely recycle contexts.

arm_smmu_unbind_task atomically sets the context's state to STALE. If the
state was already INVALIDATED, either by Stop Marker or by a flag passed
to unbind, then we can immediately release the context. Otherwise release
only the address space. Transitions between states are done atomically, so
for example when a transition from STALE to FREE is successful, the thread
doing the transition can safely release the context.

A stale context that wasn't released during unbind may be released later
when the fault handler receives a Stop Marker. The fault handler, when it
receives such marker, sets the context's state to INVALIDATED. If the
state was already STALE, the context can be released. Unlike any other
PPR, no reply is expected for a stop marker.

Someone then needs to sweep stale contexts that never received a Stop
Marker. Introduce a work "sweep_context" for each master, that cleans the
context list by inspecting the state of each context and releasing it when
its time has come. The work is scheduled whenever the number of stale
contexts reaches a watermark. For the moment we arbitrarily define this
limit as a fourth of the total number of contexts supported by a master.

Knowing when a stale context can be invalidated is a bit tricky as
explained above, because it requires to know the state of the PRI queue.
The sweeper waits for the queue to be empty or the PRIQ thread to read the
whole queue (do a cycle), whichever comes first. After that, we can
consider that any reference to the PASID present in the PRIQ when we
marked the context stale, has now been removed and pushed out to the fault
work queue. Flush the work queue and remove the context.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 269 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 261 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3ba7f65020f9..2f1ec09aeaec 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -474,6 +474,8 @@ enum fault_status {
 	ARM_SMMU_FAULT_FAIL,
 	/* Fault has been handled, the access should be retried */
 	ARM_SMMU_FAULT_SUCC,
+	/* Do not send any reply to the device */
+	ARM_SMMU_FAULT_IGNORE,
 };
 
 enum arm_smmu_msi_index {
@@ -593,6 +595,9 @@ struct arm_smmu_evtq {
 
 struct arm_smmu_priq {
 	struct arm_smmu_queue		q;
+
+	u64				batch;
+	wait_queue_head_t		wq;
 };
 
 /* High-level stream table and context descriptor structures */
@@ -742,6 +747,10 @@ struct arm_smmu_master_data {
 
 	bool				can_fault;
 	u32				avail_contexts;
+	struct work_struct		sweep_contexts;
+#define STALE_CONTEXTS_LIMIT(master)	((master)->avail_contexts / 4)
+	u32				stale_contexts;
+
 	const struct iommu_svm_ops	*svm_ops;
 };
 
@@ -825,8 +834,15 @@ struct arm_smmu_context {
 
 	struct list_head		task_head;
 	struct rb_node			master_node;
+	struct list_head		flush_head;
 
 	struct kref			kref;
+
+#define ARM_SMMU_CONTEXT_STALE		(1 << 0)
+#define ARM_SMMU_CONTEXT_INVALIDATED	(1 << 1)
+#define ARM_SMMU_CONTEXT_FREE		(ARM_SMMU_CONTEXT_STALE |\
+					 ARM_SMMU_CONTEXT_INVALIDATED)
+	atomic64_t			state;
 };
 
 struct arm_smmu_group {
@@ -1179,7 +1195,7 @@ static void arm_smmu_fault_reply(struct arm_smmu_fault *fault,
 		},
 	};
 
-	if (!fault->last)
+	if (!fault->last || resp == ARM_SMMU_FAULT_IGNORE)
 		return;
 
 	arm_smmu_cmdq_issue_cmd(fault->smmu, &cmd);
@@ -1807,11 +1823,23 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
+	size_t queue_size = 1 << q->max_n_shift;
 	u64 evt[PRIQ_ENT_DWORDS];
+	size_t i = 0;
+
+	spin_lock(&smmu->priq.wq.lock);
 
 	do {
-		while (!queue_remove_raw(q, evt))
+		while (!queue_remove_raw(q, evt)) {
+			spin_unlock(&smmu->priq.wq.lock);
 			arm_smmu_handle_ppr(smmu, evt);
+			spin_lock(&smmu->priq.wq.lock);
+			if (++i == queue_size) {
+				smmu->priq.batch++;
+				wake_up_locked(&smmu->priq.wq);
+				i = 0;
+			}
+		}
 
 		if (queue_sync_prod(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
@@ -1819,6 +1847,12 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+
+	smmu->priq.batch++;
+	wake_up_locked(&smmu->priq.wq);
+
+	spin_unlock(&smmu->priq.wq.lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -2684,6 +2718,22 @@ static enum fault_status _arm_smmu_handle_fault(struct arm_smmu_fault *fault)
 		return resp;
 	}
 
+	if (fault->last && !fault->read && !fault->write) {
+		/* Special case: stop marker invalidates the PASID */
+		u64 val = atomic64_fetch_or(ARM_SMMU_CONTEXT_INVALIDATED,
+					    &smmu_context->state);
+		if (val == ARM_SMMU_CONTEXT_STALE) {
+			spin_lock(&smmu->contexts_lock);
+			_arm_smmu_put_context(smmu_context);
+			smmu_context->master->stale_contexts--;
+			spin_unlock(&smmu->contexts_lock);
+		}
+
+		/* No reply expected */
+		resp = ARM_SMMU_FAULT_IGNORE;
+		goto out_put_context;
+	}
+
 	fault->ssv = smmu_context->master->ste.prg_response_needs_ssid;
 
 	spin_lock(&smmu->contexts_lock);
@@ -2693,6 +2743,7 @@ static enum fault_status _arm_smmu_handle_fault(struct arm_smmu_fault *fault)
 	spin_unlock(&smmu->contexts_lock);
 
 	if (!smmu_task)
+		/* Stale context */
 		goto out_put_context;
 
 	list_for_each_entry(tmp_prg, &smmu_task->prgs, list) {
@@ -2744,7 +2795,7 @@ static void arm_smmu_handle_fault(struct work_struct *work)
 						    work);
 
 	resp = _arm_smmu_handle_fault(fault);
-	if (resp != ARM_SMMU_FAULT_SUCC)
+	if (resp != ARM_SMMU_FAULT_SUCC && resp != ARM_SMMU_FAULT_IGNORE)
 		dev_info_ratelimited(fault->smmu->dev, "%s fault:\n"
 			"\t0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova "
 			"0x%016llx\n",
@@ -2759,6 +2810,81 @@ static void arm_smmu_handle_fault(struct work_struct *work)
 	kfree(fault);
 }
 
+static void arm_smmu_sweep_contexts(struct work_struct *work)
+{
+	u64 batch;
+	int ret, i = 0;
+	struct arm_smmu_priq *priq;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_context *smmu_context, *tmp;
+	struct list_head flush_list = LIST_HEAD_INIT(flush_list);
+
+	master = container_of(work, struct arm_smmu_master_data, sweep_contexts);
+	smmu = master->smmu;
+	priq = &smmu->priq;
+
+	spin_lock(&smmu->contexts_lock);
+	dev_dbg(smmu->dev, "Sweeping contexts %u/%u\n",
+		master->stale_contexts, master->avail_contexts);
+
+	rbtree_postorder_for_each_entry_safe(smmu_context, tmp,
+					     &master->contexts, master_node) {
+		u64 val = atomic64_cmpxchg(&smmu_context->state,
+					   ARM_SMMU_CONTEXT_STALE,
+					   ARM_SMMU_CONTEXT_FREE);
+		if (val != ARM_SMMU_CONTEXT_STALE)
+			continue;
+
+		/*
+		 * We volunteered for deleting this context by setting the state
+		 * atomically. This guarantees that no one else writes to its
+		 * flush_head field.
+		 */
+		list_add(&smmu_context->flush_head, &flush_list);
+	}
+	spin_unlock(&smmu->contexts_lock);
+
+	if (list_empty(&flush_list))
+		return;
+
+	/*
+	 * Now wait until the priq thread finishes a batch, or until the queue
+	 * is empty. After that, we are certain that the last references to this
+	 * context have been flushed to the fault work queue. Note that we don't
+	 * handle overflows on priq->batch. If it occurs, just wait for the
+	 * queue to be empty.
+	 */
+	spin_lock(&priq->wq.lock);
+	if (queue_sync_prod(&priq->q) == -EOVERFLOW)
+		dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+	batch = priq->batch;
+	ret = wait_event_interruptible_locked(priq->wq, queue_empty(&priq->q) ||
+					      priq->batch >= batch + 2);
+	spin_unlock(&priq->wq.lock);
+
+	if (ret) {
+		/* Woops, rollback. */
+		spin_lock(&smmu->contexts_lock);
+		list_for_each_entry(smmu_context, &flush_list, flush_head)
+			atomic64_xchg(&smmu_context->state,
+				      ARM_SMMU_CONTEXT_STALE);
+		spin_unlock(&smmu->contexts_lock);
+		return;
+	}
+
+	flush_workqueue(smmu->fault_queue);
+
+	spin_lock(&smmu->contexts_lock);
+	list_for_each_entry_safe(smmu_context, tmp, &flush_list, flush_head) {
+		_arm_smmu_put_context(smmu_context);
+		i++;
+	}
+
+	master->stale_contexts -= i;
+	spin_unlock(&smmu->contexts_lock);
+}
+
 static bool arm_smmu_master_supports_svm(struct arm_smmu_master_data *master)
 {
 	return dev_is_pci(master->dev) && master->can_fault &&
@@ -2782,6 +2908,18 @@ static int arm_smmu_set_svm_ops(struct device *dev,
 	return 0;
 }
 
+static int arm_smmu_invalidate_context(struct arm_smmu_context *smmu_context)
+{
+	struct arm_smmu_master_data *master = smmu_context->master;
+
+	if (!master->svm_ops || !master->svm_ops->invalidate_pasid)
+		return 0;
+
+	return master->svm_ops->invalidate_pasid(master->dev,
+						 smmu_context->ssid,
+						 smmu_context->priv);
+}
+
 static int arm_smmu_bind_task(struct device *dev, struct task_struct *task,
 			      int *pasid, int flags, void *priv)
 {
@@ -2876,6 +3014,10 @@ static int arm_smmu_bind_task(struct device *dev, struct task_struct *task,
 
 static int arm_smmu_unbind_task(struct device *dev, int pasid, int flags)
 {
+	int ret;
+	unsigned long val;
+	unsigned int pasid_state;
+	bool put_context = false;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_data *master;
 	struct arm_smmu_context *smmu_context = NULL;
@@ -2895,22 +3037,53 @@ static int arm_smmu_unbind_task(struct device *dev, int pasid, int flags)
 
 	dev_dbg(dev, "unbind PASID %d\n", pasid);
 
+	pasid_state = flags & (IOMMU_PASID_FLUSHED | IOMMU_PASID_CLEAN);
+	if (!pasid_state)
+		pasid_state = arm_smmu_invalidate_context(smmu_context);
+
+	if (!pasid_state) {
+		/* PASID is in use, we can't do anything. */
+		ret = -EBUSY;
+		goto err_put_context;
+	}
+
 	/*
 	 * There isn't any "ATC invalidate all by PASID" command. If this isn't
 	 * good enough, we'll need fine-grained invalidation for each vma.
 	 */
 	arm_smmu_atc_invalidate_context(smmu_context, 0, -1);
 
+	val = atomic64_fetch_or(ARM_SMMU_CONTEXT_STALE, &smmu_context->state);
+	if (val == ARM_SMMU_CONTEXT_INVALIDATED || !master->can_fault) {
+		/* We already received a stop marker for this context. */
+		put_context = true;
+	} else if (pasid_state & IOMMU_PASID_CLEAN) {
+		/* We are allowed to free the PASID now! */
+		val = atomic64_fetch_or(ARM_SMMU_CONTEXT_INVALIDATED,
+					&smmu_context->state);
+		if (val == ARM_SMMU_CONTEXT_STALE)
+			put_context = true;
+	}
+
 	spin_lock(&smmu->contexts_lock);
 	if (smmu_context->task)
 		arm_smmu_detach_task(smmu_context);
 
 	/* Release the ref we got earlier in this function */
 	_arm_smmu_put_context(smmu_context);
-	_arm_smmu_put_context(smmu_context);
+
+	if (put_context)
+		_arm_smmu_put_context(smmu_context);
+	else if (++master->stale_contexts >= STALE_CONTEXTS_LIMIT(master))
+		queue_work(system_long_wq, &master->sweep_contexts);
 	spin_unlock(&smmu->contexts_lock);
 
 	return 0;
+
+err_put_context:
+	arm_smmu_put_context(smmu, smmu_context);
+
+	return ret;
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -3137,6 +3310,7 @@ static void arm_smmu_detach_dev(struct device *dev)
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_context *smmu_context;
 	struct rb_node *node, *next;
+	int new_stale_contexts = 0;
 
 	mutex_lock(&smmu->domains_mutex);
 
@@ -3151,17 +3325,64 @@ static void arm_smmu_detach_dev(struct device *dev)
 	if (!master->ste.valid)
 		return;
 
+	/* Try to clean the contexts. */
 	spin_lock(&smmu->contexts_lock);
 	for (node = rb_first(&master->contexts); node; node = next) {
+		u64 val;
+		int pasid_state = 0;
+
 		smmu_context = rb_entry(node, struct arm_smmu_context,
 					master_node);
 		next = rb_next(node);
 
-		if (smmu_context->task)
-			arm_smmu_detach_task(smmu_context);
+		val = atomic64_fetch_or(ARM_SMMU_CONTEXT_STALE,
+					&smmu_context->state);
+		if (val == ARM_SMMU_CONTEXT_FREE)
+			/* Someone else is waiting to free this context */
+			continue;
+
+		if (!(val & ARM_SMMU_CONTEXT_STALE)) {
+			pasid_state = arm_smmu_invalidate_context(smmu_context);
+			if (!pasid_state) {
+				/*
+				 * This deserves a slap, since there still
+				 * might be references to that PASID hanging
+				 * around downstream of the SMMU and we can't
+				 * do anything about it.
+				 */
+				dev_warn(dev, "PASID %u was still bound!\n",
+					 smmu_context->ssid);
+			}
+
+			if (smmu_context->task)
+				arm_smmu_detach_task(smmu_context);
+			else
+				dev_warn(dev, "bound without a task?!");
+
+			new_stale_contexts++;
+		}
+
+		if (!(val & ARM_SMMU_CONTEXT_INVALIDATED) && master->can_fault &&
+		    !(pasid_state & IOMMU_PASID_CLEAN)) {
+			/*
+			 * We can't free the context yet, its PASID might still
+			 * be waiting in the pipe.
+			 */
+			continue;
+		}
+
+		val = atomic64_fetch_or(ARM_SMMU_CONTEXT_INVALIDATED,
+					&smmu_context->state);
+		if (val == ARM_SMMU_CONTEXT_FREE)
+			continue;
 
 		_arm_smmu_put_context(smmu_context);
+		new_stale_contexts--;
 	}
+
+	master->stale_contexts += new_stale_contexts;
+	if (master->stale_contexts)
+		queue_work(system_long_wq, &master->sweep_contexts);
 	spin_unlock(&smmu->contexts_lock);
 }
 
@@ -3581,6 +3802,8 @@ static int arm_smmu_add_device(struct device *dev)
 		fwspec->iommu_priv = master;
 
 		master->contexts = RB_ROOT;
+
+		INIT_WORK(&master->sweep_contexts, arm_smmu_sweep_contexts);
 	}
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -3653,11 +3876,14 @@ static int arm_smmu_add_device(struct device *dev)
 static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct arm_smmu_context *smmu_context;
 	struct arm_smmu_master_data *master;
 	struct arm_smmu_group *smmu_group;
 	struct arm_smmu_device *smmu;
+	struct rb_node *node, *next;
 	struct iommu_group *group;
 	unsigned long flags;
+	u64 val;
 	int i;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
@@ -3669,16 +3895,40 @@ static void arm_smmu_remove_device(struct device *dev)
 		arm_smmu_detach_dev(dev);
 
 	if (master) {
+		cancel_work_sync(&master->sweep_contexts);
+
+		spin_lock(&smmu->contexts_lock);
+
+		for (node = rb_first(&master->contexts); node; node = next) {
+			smmu_context = rb_entry(node, struct arm_smmu_context,
+						master_node);
+			next = rb_next(node);
+
+			/*
+			 * Force removal of remaining contexts. They were marked
+			 * stale by detach_dev, but haven't been invalidated
+			 * since. Page requests might be pending but we can't
+			 * afford to wait for them anymore. Bad things will
+			 * happen.
+			 */
+			dev_warn(dev, "PASID %u wasn't invalidated\n",
+				 smmu_context->ssid);
+			val = atomic64_xchg(&smmu_context->state,
+					    ARM_SMMU_CONTEXT_FREE);
+			if (val != ARM_SMMU_CONTEXT_FREE)
+				_arm_smmu_put_context(smmu_context);
+		}
+
 		if (master->streams) {
-			spin_lock(&smmu->contexts_lock);
 			for (i = 0; i < fwspec->num_ids; i++)
 				rb_erase(&master->streams[i].node,
 					 &smmu->streams);
-			spin_unlock(&smmu->contexts_lock);
 
 			kfree(master->streams);
 		}
 
+		spin_unlock(&smmu->contexts_lock);
+
 		group = iommu_group_get(dev);
 		smmu_group = to_smmu_group(group);
 
@@ -3864,6 +4114,9 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
+	init_waitqueue_head(&smmu->priq.wq);
+	smmu->priq.batch = 0;
+
 	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
 				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
 }
-- 
2.11.0
