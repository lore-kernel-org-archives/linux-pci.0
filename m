Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbdJFN2o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Oct 2017 09:28:44 -0400
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
Subject: [RFCv2 PATCH 10/36] vfio: Add support for Shared Virtual Memory
Date: Fri,  6 Oct 2017 14:31:37 +0100
Message-Id: <20171006133203.22803-11-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add two new ioctl for VFIO containers. VFIO_DEVICE_BIND_PROCESS creates a
bond between a container and a process address space, identified by a
device-specific ID named PASID. This allows the device to target DMA
transactions at the process virtual addresses without a need for mapping
and unmapping buffers explicitly in the IOMMU. The process page tables are
shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
handle faults. VFIO_DEVICE_UNBIND_PROCESS removed a bond identified by a
PASID.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/vfio/vfio_iommu_type1.c | 243 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       |  69 ++++++++++++
 2 files changed, 311 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 92155cce926d..4bfb92273cb5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -30,6 +30,7 @@
 #include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/ptrace.h>
 #include <linux/rbtree.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
@@ -60,6 +61,7 @@ MODULE_PARM_DESC(disable_hugepages,
 
 struct vfio_iommu {
 	struct list_head	domain_list;
+	struct list_head	process_list;
 	struct vfio_domain	*external_domain; /* domain for external user */
 	struct mutex		lock;
 	struct rb_root		dma_list;
@@ -92,6 +94,12 @@ struct vfio_group {
 	struct list_head	next;
 };
 
+struct vfio_process {
+	int			pasid;
+	struct pid		*pid;
+	struct list_head	next;
+};
+
 /*
  * Guest RAM pinning working set or DMA target
  */
@@ -1114,6 +1122,25 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 	return 0;
 }
 
+static int vfio_iommu_replay_bind(struct vfio_iommu *iommu, struct vfio_group *group)
+{
+	int ret;
+	u32 pasid;
+	struct vfio_process *vfio_process;
+
+	list_for_each_entry(vfio_process, &iommu->process_list, next) {
+		struct task_struct *task = get_pid_task(vfio_process->pid,
+							PIDTYPE_PID);
+
+		ret = iommu_process_bind_group(group->iommu_group, task, &pasid, 0);
+		put_task_struct(task);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * We change our unmap behavior slightly depending on whether the IOMMU
  * supports fine-grained superpages.  IOMMUs like AMD-Vi will use a superpage
@@ -1301,8 +1328,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
+				ret = vfio_iommu_replay_bind(iommu, group);
 				mutex_unlock(&iommu->lock);
-				return 0;
+				return ret;
 			}
 
 			ret = iommu_attach_group(domain->domain, iommu_group);
@@ -1318,6 +1346,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	ret = vfio_iommu_replay_bind(iommu, group);
+	if (ret)
+		goto out_detach;
+
 	if (resv_msi) {
 		ret = iommu_get_msi_cookie(domain->domain, resv_msi_base);
 		if (ret)
@@ -1349,6 +1381,21 @@ static void vfio_iommu_unmap_unpin_all(struct vfio_iommu *iommu)
 		vfio_remove_dma(iommu, rb_entry(node, struct vfio_dma, node));
 }
 
+static void vfio_iommu_unbind_all(struct vfio_iommu *iommu)
+{
+	struct vfio_process *process, *process_tmp;
+
+	list_for_each_entry_safe(process, process_tmp, &iommu->process_list, next) {
+		/*
+		 * No need to unbind manually, iommu_detach_group should
+		 * do it for us.
+		 */
+		put_pid(process->pid);
+		kfree(process);
+	}
+	INIT_LIST_HEAD(&iommu->process_list);
+}
+
 static void vfio_iommu_unmap_unpin_reaccount(struct vfio_iommu *iommu)
 {
 	struct rb_node *n, *p;
@@ -1438,6 +1485,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_all(iommu);
 				else
 					vfio_iommu_unmap_unpin_reaccount(iommu);
+				vfio_iommu_unbind_all(iommu);
 			}
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
@@ -1472,6 +1520,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	}
 
 	INIT_LIST_HEAD(&iommu->domain_list);
+	INIT_LIST_HEAD(&iommu->process_list);
 	iommu->dma_list = RB_ROOT;
 	mutex_init(&iommu->lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
@@ -1506,6 +1555,7 @@ static void vfio_iommu_type1_release(void *iommu_data)
 		kfree(iommu->external_domain);
 	}
 
+	vfio_iommu_unbind_all(iommu);
 	vfio_iommu_unmap_unpin_all(iommu);
 
 	list_for_each_entry_safe(domain, domain_tmp,
@@ -1534,6 +1584,159 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 	return ret;
 }
 
+static long vfio_iommu_type1_bind_process(struct vfio_iommu *iommu,
+					  void __user *arg,
+					  struct vfio_iommu_type1_bind *bind)
+{
+	struct vfio_iommu_type1_bind_process params;
+	struct vfio_process *vfio_process;
+	struct vfio_domain *domain;
+	struct task_struct *task;
+	struct vfio_group *group;
+	struct mm_struct *mm;
+	unsigned long minsz;
+	struct pid *pid;
+	int ret;
+
+	minsz = sizeof(*bind) + sizeof(params);
+	if (bind->argsz < minsz)
+		return -EINVAL;
+
+	arg += sizeof(*bind);
+	ret = copy_from_user(&params, arg, sizeof(params));
+	if (ret)
+		return -EFAULT;
+
+	if (params.flags & ~VFIO_IOMMU_BIND_PID)
+		return -EINVAL;
+
+	if (params.flags & VFIO_IOMMU_BIND_PID) {
+		pid_t vpid;
+
+		minsz += sizeof(pid_t);
+		if (bind->argsz < minsz)
+			return -EINVAL;
+
+		ret = copy_from_user(&vpid, arg + sizeof(params), sizeof(pid_t));
+		if (ret)
+			return -EFAULT;
+
+		rcu_read_lock();
+		task = find_task_by_vpid(vpid);
+		if (task)
+			get_task_struct(task);
+		rcu_read_unlock();
+		if (!task)
+			return -ESRCH;
+
+		/* Ensure current has RW access on the mm */
+		mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
+		if (!mm || IS_ERR(mm)) {
+			put_task_struct(task);
+			return IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		}
+		mmput(mm);
+	} else {
+		get_task_struct(current);
+		task = current;
+	}
+
+	pid = get_task_pid(task, PIDTYPE_PID);
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(vfio_process, &iommu->process_list, next) {
+		if (vfio_process->pid != pid)
+			continue;
+
+		params.pasid = vfio_process->pasid;
+
+		mutex_unlock(&iommu->lock);
+		put_pid(pid);
+		put_task_struct(task);
+		return copy_to_user(arg, &params, sizeof(params)) ?
+			-EFAULT : 0;
+	}
+
+	vfio_process = kzalloc(sizeof(*vfio_process), GFP_KERNEL);
+	if (!vfio_process) {
+		mutex_unlock(&iommu->lock);
+		put_pid(pid);
+		put_task_struct(task);
+		return -ENOMEM;
+	}
+
+	list_for_each_entry(domain, &iommu->domain_list, next) {
+		list_for_each_entry(group, &domain->group_list, next) {
+			ret = iommu_process_bind_group(group->iommu_group, task,
+						       &params.pasid, 0);
+			if (ret)
+				break;
+		}
+		if (ret)
+			break;
+	}
+
+	if (!ret) {
+		vfio_process->pid = pid;
+		vfio_process->pasid = params.pasid;
+		list_add(&vfio_process->next, &iommu->process_list);
+	}
+
+	mutex_unlock(&iommu->lock);
+
+	put_task_struct(task);
+
+	if (ret)
+		kfree(vfio_process);
+	else
+		ret = copy_to_user(arg, &params, sizeof(params)) ?
+			-EFAULT : 0;
+
+	return ret;
+}
+
+static long vfio_iommu_type1_unbind_process(struct vfio_iommu *iommu,
+					    void __user *arg,
+					    struct vfio_iommu_type1_bind *bind)
+{
+	int ret = -EINVAL;
+	unsigned long minsz;
+	struct vfio_process *process;
+	struct vfio_group *group;
+	struct vfio_domain *domain;
+	struct vfio_iommu_type1_bind_process params;
+
+	minsz = sizeof(*bind) + sizeof(params);
+	if (bind->argsz < minsz)
+		return -EINVAL;
+
+	arg += sizeof(*bind);
+	ret = copy_from_user(&params, arg, sizeof(params));
+	if (ret)
+		return -EFAULT;
+
+	if (params.flags)
+		return -EINVAL;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(process, &iommu->process_list, next) {
+		if (process->pasid != params.pasid)
+			continue;
+
+		list_for_each_entry(domain, &iommu->domain_list, next)
+			list_for_each_entry(group, &domain->group_list, next)
+				iommu_process_unbind_group(group->iommu_group,
+							   process->pasid);
+
+		put_pid(process->pid);
+		list_del(&process->next);
+		kfree(process);
+		break;
+	}
+	mutex_unlock(&iommu->lock);
+
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1604,6 +1807,44 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 
 		return copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
+
+	} else if (cmd == VFIO_IOMMU_BIND) {
+		struct vfio_iommu_type1_bind bind;
+
+		minsz = offsetofend(struct vfio_iommu_type1_bind, mode);
+
+		if (copy_from_user(&bind, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (bind.argsz < minsz)
+			return -EINVAL;
+
+		switch (bind.mode) {
+		case VFIO_IOMMU_BIND_PROCESS:
+			return vfio_iommu_type1_bind_process(iommu, (void *)arg,
+							     &bind);
+		default:
+			return -EINVAL;
+		}
+
+	} else if (cmd == VFIO_IOMMU_UNBIND) {
+		struct vfio_iommu_type1_bind bind;
+
+		minsz = offsetofend(struct vfio_iommu_type1_bind, mode);
+
+		if (copy_from_user(&bind, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (bind.argsz < minsz)
+			return -EINVAL;
+
+		switch (bind.mode) {
+		case VFIO_IOMMU_BIND_PROCESS:
+			return vfio_iommu_type1_unbind_process(iommu, (void *)arg,
+							       &bind);
+		default:
+			return -EINVAL;
+		}
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ae461050661a..6da8321c33dc 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -565,6 +565,75 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/*
+ * Allocate a PASID for a local process, and use it to attach this process to
+ * devices in the container. Devices can then tag their DMA traffic with the
+ * returned @pasid to perform transactions on the associated virtual address
+ * space. Mapping and unmapping of buffers is performed by standard functions
+ * such as mmap and malloc.
+ *
+ * If flag is VFIO_IOMMU_BIND_PID, bind to a process different from the calling
+ * one. data contains the pid of that process, a s32. Given that the caller owns
+ * the device, setting this flag grants the caller read and write permissions on
+ * the entire address space of foreign process described by @pid. Therefore,
+ * permission to perform the bind operation on a foreign process is governed by
+ * the ptrace access mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2)
+ * for more information.
+ *
+ * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
+ * ID is unique to a process and can be used on all devices in the container.
+ *
+ * On fork, the child inherits the device fd and can use the bonds setup by its
+ * parent. Consequently, the child has R/W access on the address spaces bound by
+ * its parent. After an execv, the device fd is closed and the child doesn't
+ * have access to the address space anymore.
+ */
+struct vfio_iommu_type1_bind_process {
+	__u32	flags;
+#define VFIO_IOMMU_BIND_PID		(1 << 0)
+	__u32	pasid;
+	__u8	data[];
+};
+
+/*
+ * Only mode supported at the moment is VFIO_IOMMU_BIND_PROCESS, which takes
+ * vfio_iommu_type1_bind_process in data.
+ */
+struct vfio_iommu_type1_bind {
+	__u32	argsz;
+	__u32	mode;
+#define VFIO_IOMMU_BIND_PROCESS		(1 << 0)
+	__u8	data[];
+};
+
+/*
+ * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 22, struct vfio_iommu_bind)
+ *
+ * Manage address spaces of devices in this container. Initially a TYPE1
+ * container can only have one address space, managed with
+ * VFIO_IOMMU_MAP/UNMAP_DMA.
+ *
+ * An IOMMU of type VFIO_TYPE1_NESTING_IOMMU can be managed by both MAP/UNMAP
+ * and BIND ioctls at the same time. MAP/UNMAP acts on the stage-2 (host) page
+ * tables, and BIND manages the stage-1 (guest) page tables. Other types of
+ * IOMMU may allow MAP/UNMAP and BIND to coexist, where MAP/UNMAP controls
+ * non-PASID traffic and BIND controls PASID traffic. But this depends on the
+ * underlying IOMMU architecture and isn't guaranteed.
+ *
+ * Availability of this feature depends on the device, its bus, the underlying
+ * IOMMU and the CPU architecture.
+ *
+ * returns: 0 on success, -errno on failure.
+ */
+#define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)
+
+/*
+ * VFIO_IOMMU_UNBIND - _IOWR(VFIO_TYPE, VFIO_BASE + 23, struct vfio_iommu_bind)
+ *
+ * Undo what was done by the corresponding VFIO_IOMMU_BIND ioctl.
+ */
+#define VFIO_IOMMU_UNBIND	_IO(VFIO_TYPE, VFIO_BASE + 23)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.13.3
