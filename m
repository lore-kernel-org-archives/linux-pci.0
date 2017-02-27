Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from PRI
Date: Mon, 27 Feb 2017 19:54:32 +0000
Message-Id: <20170227195441.5170-22-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When we receive a PRI Page Request (PPR) from the SMMU, it contains a
context identifier SID:SSID, an IOVA and the requested access flags.

Search the domain corresponding to SID:SSID, and call handle_mm_fault on
its mm. If memory management is able to fix the fault, we ask the device
to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.

PPRs can be sent in batches identified by a Page Request Group (PRG). The
last request of a group is always marked with a flag, which tells the
fault handler to send a reply for the group. If a page request in the
group failed, reply with PRI_FAIL for the whole group.

Each device gets a number of credits, describing the number of PPRs it can
have in flight. The SMMU architecture says that the kernel should
carefully assign those credits such that the sum of all credits isn't
greater than the PRI queue size. Otherwise it is a programming error, says
the spec. This is impossible for us since we have no idea how many devices
will use PRI when we start assigning credits. In addition, new PRI-capable
devices might get hotplugged at any time, which would require us to stop
all existing devices and shrink their credits if we wanted to be fair.
This is not viable. Overcommit the PRI queue size and hand a fixed number
of credits to each device.

Our priority is therefore on relieving the PRI queue as fast as possible,
by moving all PPRs to a workqueue that we'll call "fault queue". When
adding support for handling page faults from platform devices, we'll
receive these events on the event queue, and inject them in the same fault
queue. Note that stall support is just around the corner, so this patch
attempts to abstract PCI notions where necessary.

The PCI specification defines a special PPR called "Stop Marker Message",
characterized by flags Read=Write=Last=0. This tells software that all
previous PPRs containing this PASID are invalid, and the next PPRs with
this PASID belong to a different address space. Subsequent patches handle
Stop Markers and overflow of the queue.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 434 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 392 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 37fd061405e9..5e0008ac68cb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -270,6 +270,8 @@
 #define STRTAB_STE_1_S1COR_SHIFT	4
 #define STRTAB_STE_1_S1CSH_SHIFT	6
 
+#define STRTAB_STE_1_PPAR		(1UL << 18)
+
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
 #define STRTAB_STE_1_EATS_ABT		0UL
@@ -465,10 +467,13 @@ module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_ats_check,
 	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
 
-enum pri_resp {
-	PRI_RESP_DENY,
-	PRI_RESP_FAIL,
-	PRI_RESP_SUCC,
+enum fault_status {
+	/* Non-paging error. SMMU will not handle any fault from this device */
+	ARM_SMMU_FAULT_DENY,
+	/* Page fault is permanent, device shouldn't retry this access */
+	ARM_SMMU_FAULT_FAIL,
+	/* Fault has been handled, the access should be retried */
+	ARM_SMMU_FAULT_SUCC,
 };
 
 enum arm_smmu_msi_index {
@@ -553,7 +558,7 @@ struct arm_smmu_cmdq_ent {
 			u32			sid;
 			u32			ssid;
 			u16			grpid;
-			enum pri_resp		resp;
+			enum fault_status	resp;
 		} pri;
 
 		#define CMDQ_OP_CMD_SYNC	0x46
@@ -642,6 +647,8 @@ struct arm_smmu_strtab_ent {
 	struct arm_smmu_cd_cfg		cd_cfg;
 	struct arm_smmu_s1_cfg		*s1_cfg;
 	struct arm_smmu_s2_cfg		*s2_cfg;
+
+	bool				prg_response_needs_ssid;
 };
 
 struct arm_smmu_strtab_cfg {
@@ -710,6 +717,8 @@ struct arm_smmu_device {
 	struct rb_root			streams;
 	struct list_head		tasks;
 
+	struct workqueue_struct		*fault_queue;
+
 	struct list_head		domains;
 	struct mutex			domains_mutex;
 };
@@ -731,6 +740,7 @@ struct arm_smmu_master_data {
 	struct arm_smmu_stream		*streams;
 	struct rb_root			contexts;
 
+	bool				can_fault;
 	u32				avail_contexts;
 };
 
@@ -762,6 +772,31 @@ struct arm_smmu_domain {
 	struct list_head		list; /* For domain search by ASID */
 };
 
+struct arm_smmu_fault {
+	struct arm_smmu_device		*smmu;
+	u32				sid;
+	u32				ssid;
+	bool				ssv;
+	u16				grpid;
+
+	u64				iova;
+	bool				read;
+	bool				write;
+	bool				exec;
+	bool				priv;
+
+	bool				last;
+
+	struct work_struct		work;
+};
+
+struct arm_smmu_pri_group {
+	u16				index;
+	enum fault_status		resp;
+
+	struct list_head		list;
+};
+
 struct arm_smmu_task {
 	struct pid			*pid;
 
@@ -775,6 +810,8 @@ struct arm_smmu_task {
 	struct mmu_notifier		mmu_notifier;
 	struct mm_struct		*mm;
 
+	struct list_head		prgs;
+
 	struct kref			kref;
 };
 
@@ -815,6 +852,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static struct kmem_cache *arm_smmu_fault_cache;
+
 #define to_smmu_group iommu_group_get_iommudata
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
@@ -1019,13 +1058,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= (u64)ent->pri.sid << CMDQ_PRI_0_SID_SHIFT;
 		cmd[1] |= ent->pri.grpid << CMDQ_PRI_1_GRPID_SHIFT;
 		switch (ent->pri.resp) {
-		case PRI_RESP_DENY:
+		case ARM_SMMU_FAULT_DENY:
 			cmd[1] |= CMDQ_PRI_1_RESP_DENY;
 			break;
-		case PRI_RESP_FAIL:
+		case ARM_SMMU_FAULT_FAIL:
 			cmd[1] |= CMDQ_PRI_1_RESP_FAIL;
 			break;
-		case PRI_RESP_SUCC:
+		case ARM_SMMU_FAULT_SUCC:
 			cmd[1] |= CMDQ_PRI_1_RESP_SUCC;
 			break;
 		default:
@@ -1124,6 +1163,28 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 }
 
+static void arm_smmu_fault_reply(struct arm_smmu_fault *fault,
+				 enum fault_status resp)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode			= CMDQ_OP_PRI_RESP,
+		.substream_valid	= fault->ssv,
+		.pri			= {
+			.sid	= fault->sid,
+			.ssid	= fault->ssid,
+			.grpid	= fault->grpid,
+			.resp	= resp,
+		},
+	};
+
+	if (!fault->last)
+		return;
+
+	arm_smmu_cmdq_issue_cmd(fault->smmu, &cmd);
+	cmd.opcode = CMDQ_OP_CMD_SYNC;
+	arm_smmu_cmdq_issue_cmd(fault->smmu, &cmd);
+}
+
 /* Context descriptor manipulation functions */
 static void arm_smmu_sync_cd(struct arm_smmu_master_data *master, u32 ssid,
 			     bool leaf)
@@ -1587,6 +1648,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 			  STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1) <<
 			 STRTAB_STE_1_STRW_SHIFT);
 
+		if (ste->prg_response_needs_ssid)
+			dst[1] |= STRTAB_STE_1_PPAR;
+
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
@@ -1704,42 +1768,37 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void arm_smmu_handle_fault(struct work_struct *work);
+
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
-	u32 sid, ssid;
-	u16 grpid;
-	bool ssv, last;
-
-	sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
-	ssv = evt[0] & PRIQ_0_SSID_V;
-	ssid = ssv ? evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK : 0;
-	last = evt[0] & PRIQ_0_PRG_LAST;
-	grpid = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK;
-
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-		 sid, ssid, grpid, last ? "L" : "",
-		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
-
-	if (last) {
-		struct arm_smmu_cmdq_ent cmd = {
-			.opcode			= CMDQ_OP_PRI_RESP,
-			.substream_valid	= ssv,
-			.pri			= {
-				.sid	= sid,
-				.ssid	= ssid,
-				.grpid	= grpid,
-				.resp	= PRI_RESP_DENY,
-			},
-		};
+	struct arm_smmu_fault *fault;
+	struct arm_smmu_fault params = {
+		.smmu	= smmu,
+
+		.sid	= evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK,
+		.ssv	= evt[0] & PRIQ_0_SSID_V,
+		.ssid	= evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK,
+		.last	= evt[0] & PRIQ_0_PRG_LAST,
+		.grpid	= evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK,
+
+		.iova	= evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT,
+		.read	= evt[0] & PRIQ_0_PERM_READ,
+		.write	= evt[0] & PRIQ_0_PERM_WRITE,
+		.exec	= evt[0] & PRIQ_0_PERM_EXEC,
+		.priv	= evt[0] & PRIQ_0_PERM_PRIV,
+	};
 
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	fault = kmem_cache_alloc(arm_smmu_fault_cache, GFP_KERNEL);
+	if (!fault) {
+		/* Out of memory, tell the device to retry later */
+		arm_smmu_fault_reply(&params, ARM_SMMU_FAULT_SUCC);
+		return;
 	}
+
+	*fault = params;
+	INIT_WORK(&fault->work, arm_smmu_handle_fault);
+	queue_work(smmu->fault_queue, &fault->work);
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
@@ -2138,7 +2197,6 @@ static void _arm_smmu_put_context(struct arm_smmu_context *smmu_context)
 	kref_put(&smmu_context->kref, arm_smmu_free_context);
 }
 
-__maybe_unused
 static void arm_smmu_put_context(struct arm_smmu_device *smmu,
 				 struct arm_smmu_context *smmu_context)
 {
@@ -2147,6 +2205,62 @@ static void arm_smmu_put_context(struct arm_smmu_device *smmu,
 	spin_unlock(&smmu->contexts_lock);
 }
 
+/*
+ * Find context associated to a (@sid, @ssid) pair. If found, take a reference
+ * to the context and return it. Otherwise, return NULL. If a non-NULL master
+ * is provided, search context by @ssid, ignoring argument @sid.
+ */
+static struct arm_smmu_context *
+arm_smmu_get_context_by_id(struct arm_smmu_device *smmu,
+			   struct arm_smmu_master_data *master,
+			   u32 sid, u32 ssid)
+{
+	struct rb_node *node;
+	struct arm_smmu_stream *stream;
+	struct arm_smmu_context *cur_context, *smmu_context = NULL;
+
+	spin_lock(&smmu->contexts_lock);
+
+	if (!master) {
+		node = smmu->streams.rb_node;
+		while (node) {
+			stream = rb_entry(node, struct arm_smmu_stream, node);
+			if (stream->id < sid) {
+				node = node->rb_right;
+			} else if (stream->id > sid) {
+				node = node->rb_left;
+			} else {
+				master = stream->master;
+				break;
+			}
+		}
+	}
+
+	if (!master)
+		goto out_unlock;
+
+	node = master->contexts.rb_node;
+	while (node) {
+		cur_context = rb_entry(node, struct arm_smmu_context,
+				       master_node);
+
+		if (cur_context->ssid < ssid) {
+			node = node->rb_right;
+		} else if (cur_context->ssid > ssid) {
+			node = node->rb_left;
+		} else {
+			smmu_context = cur_context;
+			kref_get(&smmu_context->kref);
+			break;
+		}
+	}
+
+out_unlock:
+	spin_unlock(&smmu->contexts_lock);
+
+	return smmu_context;
+}
+
 static struct arm_smmu_task *mn_to_task(struct mmu_notifier *mn)
 {
 	return container_of(mn, struct arm_smmu_task, mmu_notifier);
@@ -2353,6 +2467,7 @@ static struct arm_smmu_task *arm_smmu_alloc_task(struct arm_smmu_device *smmu,
 	smmu_task->mmu_notifier.ops = &arm_smmu_mmu_notifier_ops;
 	smmu_task->mm = mm;
 	INIT_LIST_HEAD(&smmu_task->contexts);
+	INIT_LIST_HEAD(&smmu_task->prgs);
 	kref_init(&smmu_task->kref);
 
 	ret = arm_smmu_init_task_pgtable(smmu_task);
@@ -2399,6 +2514,7 @@ static void arm_smmu_free_task(struct kref *kref)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_task *smmu_task;
 	struct arm_smmu_master_data *master;
+	struct arm_smmu_pri_group *prg, *next_prg;
 	struct arm_smmu_context *smmu_context, *next;
 
 	smmu_task = container_of(kref, struct arm_smmu_task, kref);
@@ -2428,6 +2544,9 @@ static void arm_smmu_free_task(struct kref *kref)
 
 	mmu_notifier_unregister(&smmu_task->mmu_notifier, smmu_task->mm);
 
+	list_for_each_entry_safe(prg, next_prg, &smmu_task->prgs, list)
+		list_del(&prg->list);
+
 	put_pid(smmu_task->pid);
 	kfree(smmu_task);
 
@@ -2451,7 +2570,6 @@ static void arm_smmu_detach_task(struct arm_smmu_context *smmu_context)
 	arm_smmu_write_ctx_desc(smmu_context->master, smmu_context->ssid, NULL);
 }
 
-__maybe_unused
 static void arm_smmu_put_task(struct arm_smmu_device *smmu,
 			      struct arm_smmu_task *smmu_task)
 {
@@ -2460,6 +2578,167 @@ static void arm_smmu_put_task(struct arm_smmu_device *smmu,
 	spin_unlock(&smmu->contexts_lock);
 }
 
+static int arm_smmu_handle_mm_fault(struct arm_smmu_device *smmu,
+				    struct mm_struct *mm,
+				    struct arm_smmu_fault *fault)
+{
+	int ret;
+	struct vm_area_struct *vma;
+	unsigned long access_flags = 0;
+	unsigned long fault_flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
+
+	/*
+	 * We're holding smmu_task, which holds the mmu notifier, so mm is
+	 * guaranteed to be here, but mm_users might still drop to zero when
+	 * the task exits.
+	 */
+	if (!mmget_not_zero(mm)) {
+		dev_dbg(smmu->dev, "mm dead\n");
+		return -EINVAL;
+	}
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, fault->iova);
+	if (!vma) {
+		ret = -ESRCH;
+		dev_dbg(smmu->dev, "VMA not found\n");
+		goto out_release;
+	}
+
+	if (fault->read)
+		access_flags |= VM_READ;
+
+	if (fault->write) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (fault->exec) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (access_flags & ~vma->vm_flags) {
+		ret = -EFAULT;
+		dev_dbg(smmu->dev, "access flags mismatch\n");
+		goto out_release;
+	}
+
+	ret = handle_mm_fault(vma, fault->iova, fault_flags);
+	dev_dbg(smmu->dev, "handle_mm_fault(%#x:%#x:%#llx, %#lx) -> %#x\n",
+		fault->sid, fault->ssid, fault->iova, fault_flags, ret);
+
+	ret = ret & VM_FAULT_ERROR ? -EFAULT : 0;
+
+out_release:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	return ret;
+}
+
+static enum fault_status _arm_smmu_handle_fault(struct arm_smmu_fault *fault)
+{
+	struct arm_smmu_task *smmu_task = NULL;
+	struct arm_smmu_device *smmu = fault->smmu;
+	struct arm_smmu_context *smmu_context = NULL;
+	enum fault_status resp = ARM_SMMU_FAULT_FAIL;
+	struct arm_smmu_pri_group *prg = NULL, *tmp_prg;
+
+	if (!fault->ssv)
+		return ARM_SMMU_FAULT_DENY;
+
+	if (fault->priv)
+		return resp;
+
+	smmu_context = arm_smmu_get_context_by_id(smmu, NULL, fault->sid,
+						  fault->ssid);
+	if (!smmu_context) {
+		dev_dbg(smmu->dev, "unable to find context %#x:%#x\n",
+			fault->sid, fault->ssid);
+		/*
+		 * Note that we don't have prg_response_needs_ssid yet. Reply
+		 * might be inconsistent with what the device expects.
+		 */
+		return resp;
+	}
+
+	fault->ssv = smmu_context->master->ste.prg_response_needs_ssid;
+
+	spin_lock(&smmu->contexts_lock);
+	smmu_task = smmu_context->task;
+	if (smmu_task)
+		kref_get(&smmu_task->kref);
+	spin_unlock(&smmu->contexts_lock);
+
+	if (!smmu_task)
+		goto out_put_context;
+
+	list_for_each_entry(tmp_prg, &smmu_task->prgs, list) {
+		if (tmp_prg->index == fault->grpid) {
+			prg = tmp_prg;
+			break;
+		}
+	}
+
+	if (!prg && !fault->last) {
+		prg = kzalloc(sizeof(*prg), GFP_KERNEL);
+		if (!prg) {
+			resp = ARM_SMMU_FAULT_SUCC;
+			goto out_put_task;
+		}
+
+		prg->index = fault->grpid;
+		list_add(&prg->list, &smmu_task->prgs);
+	} else if (prg && prg->resp != ARM_SMMU_FAULT_SUCC) {
+		resp = prg->resp;
+		goto out_put_task;
+	}
+
+	if (!arm_smmu_handle_mm_fault(smmu, smmu_task->mm, fault))
+		resp = ARM_SMMU_FAULT_SUCC;
+
+	if (prg) {
+		if (fault->last) {
+			list_del(&prg->list);
+			kfree(prg);
+		} else {
+			prg->resp = resp;
+		}
+	}
+
+out_put_task:
+	arm_smmu_put_task(smmu, smmu_task);
+
+out_put_context:
+	arm_smmu_put_context(smmu, smmu_context);
+
+	return resp;
+}
+
+static void arm_smmu_handle_fault(struct work_struct *work)
+{
+	enum fault_status resp;
+	struct arm_smmu_fault *fault = container_of(work, struct arm_smmu_fault,
+						    work);
+
+	resp = _arm_smmu_handle_fault(fault);
+	if (resp != ARM_SMMU_FAULT_SUCC)
+		dev_info_ratelimited(fault->smmu->dev, "%s fault:\n"
+			"\t0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova "
+			"0x%016llx\n",
+			resp == ARM_SMMU_FAULT_DENY ? "unexpected" : "unhandled",
+			fault->sid, fault->ssid, fault->grpid,
+			fault->last ? "L" : "", fault->priv ? "" : "un",
+			fault->read ? "R" : "", fault->write ? "W" : "",
+			fault->exec ? "X" : "", fault->iova);
+
+	arm_smmu_fault_reply(fault, resp);
+
+	kfree(fault);
+}
+
 static bool arm_smmu_master_supports_svm(struct arm_smmu_master_data *master)
 {
 	return false;
@@ -2997,6 +3276,57 @@ static void arm_smmu_disable_ssid(struct arm_smmu_master_data *master)
 	pci_disable_pasid(pdev);
 }
 
+static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
+{
+	int ret, pos;
+	struct pci_dev *pdev;
+	size_t max_requests = 64;
+	struct arm_smmu_device *smmu = master->smmu;
+
+	/* Do not enable PRI if SVM isn't supported */
+	unsigned long feat_mask = ARM_SMMU_FEAT_PRI | ARM_SMMU_FEAT_SVM;
+
+	if ((smmu->features & feat_mask) != feat_mask || !dev_is_pci(master->dev))
+		return -ENOSYS;
+
+	pdev = to_pci_dev(master->dev);
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return -ENOSYS;
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_pri(pdev, max_requests);
+	if (ret) {
+		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
+		return ret;
+	}
+
+	master->can_fault = true;
+	master->ste.prg_response_needs_ssid = pci_prg_resp_requires_prefix(pdev);
+
+	dev_dbg(master->dev, "enabled PRI");
+
+	return 0;
+}
+
+static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
+{
+	struct pci_dev *pdev;
+
+	if (!master->can_fault || !dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	pci_disable_pri(pdev);
+
+	master->can_fault = false;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master_data *master)
 {
@@ -3114,6 +3444,8 @@ static int arm_smmu_add_device(struct device *dev)
 	master->avail_contexts = nr_ssids - 1;
 
 	ats_enabled = !arm_smmu_enable_ats(master);
+	if (ats_enabled)
+		arm_smmu_enable_pri(master);
 
 	if (arm_smmu_master_supports_svm(master))
 		arm_smmu_insert_master(smmu, master);
@@ -3138,6 +3470,7 @@ static int arm_smmu_add_device(struct device *dev)
 	return 0;
 
 err_disable_ats:
+	arm_smmu_disable_pri(master);
 	arm_smmu_disable_ats(master);
 
 	arm_smmu_free_cd_tables(master);
@@ -3186,6 +3519,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 		iommu_group_put(group);
 
+		arm_smmu_disable_pri(master);
 		/* PCIe PASID must be disabled after ATS */
 		arm_smmu_disable_ats(master);
 		arm_smmu_disable_ssid(master);
@@ -3490,6 +3824,18 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if (smmu->features & ARM_SMMU_FEAT_SVM &&
+	    smmu->features & ARM_SMMU_FEAT_PRI) {
+		/*
+		 * Ensure strict ordering of the queue. We can't go reordering
+		 * page faults willy nilly since they work in groups, with a
+		 * flag "last" denoting when we should send a PRI response.
+		 */
+		smmu->fault_queue = alloc_ordered_workqueue("smmu_fault_queue", 0);
+		if (!smmu->fault_queue)
+			return -ENOMEM;
+	}
+
 	return arm_smmu_init_strtab(smmu);
 }
 
@@ -4250,6 +4596,10 @@ static int __init arm_smmu_init(void)
 	int ret = 0;
 
 	if (!registered) {
+		arm_smmu_fault_cache = KMEM_CACHE(arm_smmu_fault, 0);
+		if (!arm_smmu_fault_cache)
+			return -ENOMEM;
+
 		ret = platform_driver_register(&arm_smmu_driver);
 		registered = !ret;
 	}
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
