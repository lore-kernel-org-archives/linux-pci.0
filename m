Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751550AbdB0ULP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [RFC PATCH 10/30] iommu/arm-smmu-v3: Add task contexts
Date: Mon, 27 Feb 2017 19:54:21 +0000
Message-Id: <20170227195441.5170-11-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we support substreams, add the required infrastructure to use
them. Each device can be attached to multiple address spaces. The default
address space is the domain, and additional ones are tasks. Each task can
be attached to multiple devices as well.

            +------------+       +---------------+
            | group      |       |        domain |
            |            +-------+               |
            |            |       |               |  (c)
     (a) ,-----[master]-------------[context 1]---------[task]--. (d)
        /   |         \  |  (b)  |               |               \
       /    |          `------------[context 2]----.             [SMMU]
      /     |            |       |               |  \             /
   [SMMU]   +------------+       +---------------+   \           /
      \                                               `-[task]--'
       \    +------------+       +---------------+    /
        \   |            |       |               |   /
         \----.          |       |               |  /
          `----[master]-------------[context 1]----'
            |            |       |               |
            |            +-------+               |
            | group      |  (e)  |        domain |
            +------------+       +---------------+

(a) Add a rbtree of streams in each SMMU instance, indexed by stream ID.
Each stream points to a single master, and masters can be identified by
multiple stream IDs. PCIe endpoints are, for the moment, expected to have
a unique stream ID (RID), but see the discussion about groups below.
Platform devices may issue multiple stream IDs.

(b) Add a rbtree of contexts in each SVM-capable master, indexed by
substream ID. A context is the link between a device and a task. It is
bidirectional since we need to lookup all devices attached to a task when
invalidating a mapping, and all tasks attached to a device when handling a
device fault (PRI).

Both these rbtrees will allow fast lookup of an address space when
handling a fault.

(c) Add a task in each context. We need tasks and contexts to be separate
entities with their own refcounting for at least two reasons. To reduce
the number of mmu notifiers and simplify ASID tracking, tasks are allowed
to be attached to multiple masters. It is also necessary for sane PASID
invalidation but we won't go into that now.

(d) Add a list of tasks in each SMMU instance. This allows to find
existing tasks when binding to a device. We could make it an rbtree, but
it's not clear whether we need this complication yet.

Lifetime of contexts and tasks is the following:

* arm_smmu_alloc_task creates smmu_task and adds it to the list.
* arm_smmu_attach_task allocates an SSID, creates smmu_context and
  connects task to master. Context descriptor is written, so the SSID is
  active and can be used in transactions.
* users may get krefs to task and contexts temporarily, and release them
  with put_task/put_context.
* arm_smmu_detach_task severs the link between context and task, and drops
  the task's refcount. If the task was only attached to one master, it is
  freed and removed from the list. arm_smmu_detach_task also clears the
  context descriptor, after which any transaction with this SSID would
  result in a fault.
* arm_smmu_put_context is called later, freeing the dangling context.

All these structures are protected by a single context_lock spinlock for
each SMMU instance. Therefore context_lock also serializes modifications
of the context descriptors. Any update of the krefs must be done while
holding the lock. Reads of lists and context->task as well. As we expect a
lot more reads than writes on the structures introduced by this patch,
especially for handling page requests, we hope to make use of the RCU in
the future.

(e) A group still has a default DMA domain, represented by context 0 (no
SSID). When attaching to a different domain, for example a VFIO domain, we
also want to destroy all active contexts. If VFIO is handing control of a
device to a guest for instance, we do not want the guest to have access to
host tasks through bound contexts. So contexts are conceptually contained
in the domain, although we do not need to maintain any structure for this.
When detaching a domain from a group, all contexts attached to this group
are also detached.

An IOMMU group contains all devices that can't be distinguished from one
another by their IOMMU. For PCIe this may be due to buggy devices, lack of
ACS isolation, legacy or non-transparent bridges. Since PCIe SVM platforms
on ARM have yet to be seen in the wild, legacy issues don't matter and SVM
through NTB is pretty far off.

So for prototyping, we currently bypass the concept of IOMMU groups, since
we expect SVM-capable devices to be properly integrated. This might change
as soon as someone starts taping out devices. There will then be some
complication in attaching a task to a group instead of an individual
device (for instance, finding a consensus for PASID sizes of all devices
in the group, which may be altered by hotplugging a device in a group),
but the current design doesn't prevent this change.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 316 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 314 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2724788157a5..5b4d1f265194 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -701,6 +701,16 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	spinlock_t			contexts_lock;
+	struct rb_root			streams;
+	struct list_head		tasks;
+};
+
+struct arm_smmu_stream {
+	u32				id;
+	struct arm_smmu_master_data	*master;
+	struct rb_node			node;
 };
 
 /* SMMU private data for each master */
@@ -710,6 +720,9 @@ struct arm_smmu_master_data {
 
 	struct device			*dev;
 	struct list_head		group_head;
+
+	struct arm_smmu_stream		*streams;
+	struct rb_root			contexts;
 };
 
 /* SMMU private data for an IOMMU domain */
@@ -738,6 +751,31 @@ struct arm_smmu_domain {
 	spinlock_t			groups_lock;
 };
 
+struct arm_smmu_task {
+	struct pid			*pid;
+
+	struct arm_smmu_device		*smmu;
+	struct list_head		smmu_head;
+
+	struct list_head		contexts;
+
+	struct arm_smmu_s1_cfg		s1_cfg;
+
+	struct kref			kref;
+};
+
+struct arm_smmu_context {
+	u32				ssid;
+
+	struct arm_smmu_task		*task;
+	struct arm_smmu_master_data	*master;
+
+	struct list_head		task_head;
+	struct rb_node			master_node;
+
+	struct kref			kref;
+};
+
 struct arm_smmu_group {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
@@ -1363,7 +1401,6 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
 	cfg->num_entries = 0;
 }
 
-__maybe_unused
 static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
 {
 	int ssid;
@@ -1401,7 +1438,6 @@ static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
 	return -ENOSPC;
 }
 
-__maybe_unused
 static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32 ssid)
 {
 	unsigned long l1_idx, idx;
@@ -1961,6 +1997,195 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+__maybe_unused
+static struct arm_smmu_context *
+arm_smmu_attach_task(struct arm_smmu_task *smmu_task,
+		     struct arm_smmu_master_data *master)
+{
+	int ssid;
+	int ret = 0;
+	struct arm_smmu_context *smmu_context, *ctx;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct rb_node **new_node, *parent_node = NULL;
+
+	smmu_context = kzalloc(sizeof(*smmu_context), GFP_KERNEL);
+	if (!smmu_context)
+		return ERR_PTR(-ENOMEM);
+
+	smmu_context->task = smmu_task;
+	smmu_context->master = master;
+	kref_init(&smmu_context->kref);
+
+	spin_lock(&smmu->contexts_lock);
+
+	/* Allocate a context descriptor and SSID */
+	ssid = arm_smmu_alloc_cd(master);
+	if (ssid <= 0) {
+		if (WARN_ON_ONCE(ssid == 0))
+			ret = -EEXIST;
+		else
+			ret = ssid;
+		goto err_free_context;
+	}
+
+	smmu_context->ssid = ssid;
+
+	arm_smmu_write_ctx_desc(master, ssid, &smmu_task->s1_cfg);
+
+	list_add(&smmu_context->task_head, &smmu_task->contexts);
+
+	/* Insert into master context list */
+	new_node = &(master->contexts.rb_node);
+	while (*new_node) {
+		ctx = rb_entry(*new_node, struct arm_smmu_context,
+			       master_node);
+		parent_node = *new_node;
+		if (ctx->ssid > ssid) {
+			new_node = &((*new_node)->rb_left);
+		} else if (ctx->ssid < ssid) {
+			new_node = &((*new_node)->rb_right);
+		} else {
+			dev_warn(master->dev, "context %u already exists\n",
+				 ctx->ssid);
+			ret = -EEXIST;
+			goto err_remove_context;
+		}
+	}
+
+	rb_link_node(&smmu_context->master_node, parent_node, new_node);
+	rb_insert_color(&smmu_context->master_node, &master->contexts);
+
+	spin_unlock(&smmu->contexts_lock);
+
+	return smmu_context;
+
+err_remove_context:
+	list_del(&smmu_context->task_head);
+	arm_smmu_write_ctx_desc(master, ssid, NULL);
+	arm_smmu_free_cd(master, ssid);
+
+err_free_context:
+	spin_unlock(&smmu->contexts_lock);
+
+	kfree(smmu_context);
+
+	return ERR_PTR(ret);
+}
+
+/* Caller must hold contexts_lock */
+static void arm_smmu_free_context(struct kref *kref)
+{
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_context *smmu_context;
+
+	smmu_context = container_of(kref, struct arm_smmu_context, kref);
+
+	WARN_ON_ONCE(smmu_context->task);
+
+	master = smmu_context->master;
+
+	arm_smmu_free_cd(master, smmu_context->ssid);
+
+	rb_erase(&smmu_context->master_node, &master->contexts);
+
+	kfree(smmu_context);
+}
+
+static void _arm_smmu_put_context(struct arm_smmu_context *smmu_context)
+{
+	kref_put(&smmu_context->kref, arm_smmu_free_context);
+}
+
+__maybe_unused
+static void arm_smmu_put_context(struct arm_smmu_device *smmu,
+				 struct arm_smmu_context *smmu_context)
+{
+	spin_lock(&smmu->contexts_lock);
+	_arm_smmu_put_context(smmu_context);
+	spin_unlock(&smmu->contexts_lock);
+}
+
+__maybe_unused
+static struct arm_smmu_task *arm_smmu_alloc_task(struct arm_smmu_device *smmu,
+						 struct task_struct *task)
+{
+	struct arm_smmu_task *smmu_task;
+
+	smmu_task = kzalloc(sizeof(*smmu_task), GFP_KERNEL);
+	if (!smmu_task)
+		return ERR_PTR(-ENOMEM);
+
+	smmu_task->smmu = smmu;
+	smmu_task->pid = get_task_pid(task, PIDTYPE_PID);
+	INIT_LIST_HEAD(&smmu_task->contexts);
+	kref_init(&smmu_task->kref);
+
+	spin_lock(&smmu->contexts_lock);
+	list_add(&smmu_task->smmu_head, &smmu->tasks);
+	spin_unlock(&smmu->contexts_lock);
+
+	return smmu_task;
+}
+
+/* Caller must hold contexts_lock */
+static void arm_smmu_free_task(struct kref *kref)
+{
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_task *smmu_task;
+	struct arm_smmu_master_data *master;
+	struct arm_smmu_context *smmu_context, *next;
+
+	smmu_task = container_of(kref, struct arm_smmu_task, kref);
+	smmu = smmu_task->smmu;
+
+	if (WARN_ON_ONCE(!list_empty(&smmu_task->contexts))) {
+		list_for_each_entry_safe(smmu_context, next,
+					 &smmu_task->contexts, task_head) {
+			master = smmu_context->master;
+
+			arm_smmu_write_ctx_desc(master, smmu_context->ssid, NULL);
+			smmu_context->task = NULL;
+			list_del(&smmu_context->task_head);
+		}
+	}
+
+	list_del(&smmu_task->smmu_head);
+
+	put_pid(smmu_task->pid);
+	kfree(smmu_task);
+}
+
+static void _arm_smmu_put_task(struct arm_smmu_task *smmu_task)
+{
+	kref_put(&smmu_task->kref, arm_smmu_free_task);
+}
+
+/* Caller must hold contexts_lock */
+static void arm_smmu_detach_task(struct arm_smmu_context *smmu_context)
+{
+	struct arm_smmu_task *smmu_task = smmu_context->task;
+
+	smmu_context->task = NULL;
+	list_del(&smmu_context->task_head);
+	_arm_smmu_put_task(smmu_task);
+
+	arm_smmu_write_ctx_desc(smmu_context->master, smmu_context->ssid, NULL);
+}
+
+__maybe_unused
+static void arm_smmu_put_task(struct arm_smmu_device *smmu,
+			      struct arm_smmu_task *smmu_task)
+{
+	spin_lock(&smmu->contexts_lock);
+	_arm_smmu_put_task(smmu_task);
+	spin_unlock(&smmu->contexts_lock);
+}
+
+static bool arm_smmu_master_supports_svm(struct arm_smmu_master_data *master)
+{
+	return false;
+}
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
@@ -2173,12 +2398,31 @@ static struct arm_smmu_group *arm_smmu_group_alloc(struct iommu_group *group)
 static void arm_smmu_detach_dev(struct device *dev)
 {
 	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_context *smmu_context;
+	struct rb_node *node, *next;
 
 	master->ste.bypass = true;
 	if (arm_smmu_install_ste_for_dev(dev->iommu_fwspec) < 0)
 		dev_warn(dev, "failed to install bypass STE\n");
 
 	arm_smmu_write_ctx_desc(master, 0, NULL);
+
+	if (!master->ste.valid)
+		return;
+
+	spin_lock(&smmu->contexts_lock);
+	for (node = rb_first(&master->contexts); node; node = next) {
+		smmu_context = rb_entry(node, struct arm_smmu_context,
+					master_node);
+		next = rb_next(node);
+
+		if (smmu_context->task)
+			arm_smmu_detach_task(smmu_context);
+
+		_arm_smmu_put_context(smmu_context);
+	}
+	spin_unlock(&smmu->contexts_lock);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2418,6 +2662,54 @@ static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
 	pci_disable_ats(pdev);
 }
 
+static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
+				  struct arm_smmu_master_data *master)
+{
+	int i;
+	int ret = 0;
+	struct arm_smmu_stream *new_stream, *cur_stream;
+	struct rb_node **new_node, *parent_node = NULL;
+	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
+
+	master->streams = kcalloc(fwspec->num_ids,
+				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
+	if (!master->streams)
+		return -ENOMEM;
+
+	spin_lock(&smmu->contexts_lock);
+	for (i = 0; i < fwspec->num_ids && !ret; i++) {
+		new_stream = &master->streams[i];
+		new_stream->id = fwspec->ids[i];
+		new_stream->master = master;
+
+		new_node = &(smmu->streams.rb_node);
+		while (*new_node) {
+			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
+					      node);
+			parent_node = *new_node;
+			if (cur_stream->id > new_stream->id) {
+				new_node = &((*new_node)->rb_left);
+			} else if (cur_stream->id < new_stream->id) {
+				new_node = &((*new_node)->rb_right);
+			} else {
+				dev_warn(master->dev,
+					 "stream %u already in tree\n",
+					 cur_stream->id);
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		if (!ret) {
+			rb_link_node(&new_stream->node, parent_node, new_node);
+			rb_insert_color(&new_stream->node, &smmu->streams);
+		}
+	}
+	spin_unlock(&smmu->contexts_lock);
+
+	return ret;
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static int arm_smmu_add_device(struct device *dev)
@@ -2452,6 +2744,8 @@ static int arm_smmu_add_device(struct device *dev)
 		master->smmu = smmu;
 		master->dev = dev;
 		fwspec->iommu_priv = master;
+
+		master->contexts = RB_ROOT;
 	}
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -2475,6 +2769,9 @@ static int arm_smmu_add_device(struct device *dev)
 
 	ats_enabled = !arm_smmu_enable_ats(master);
 
+	if (arm_smmu_master_supports_svm(master))
+		arm_smmu_insert_master(smmu, master);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
@@ -2510,6 +2807,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct iommu_group *group;
 	unsigned long flags;
+	int i;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -2520,6 +2818,16 @@ static void arm_smmu_remove_device(struct device *dev)
 		arm_smmu_detach_dev(dev);
 
 	if (master) {
+		if (master->streams) {
+			spin_lock(&smmu->contexts_lock);
+			for (i = 0; i < fwspec->num_ids; i++)
+				rb_erase(&master->streams[i].node,
+					 &smmu->streams);
+			spin_unlock(&smmu->contexts_lock);
+
+			kfree(master->streams);
+		}
+
 		group = iommu_group_get(dev);
 		smmu_group = to_smmu_group(group);
 
@@ -2820,6 +3128,10 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	spin_lock_init(&smmu->contexts_lock);
+	smmu->streams = RB_ROOT;
+	INIT_LIST_HEAD(&smmu->tasks);
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.11.0
