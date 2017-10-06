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
Subject: [RFCv2 PATCH 08/36] iommu/fault: Handle mm faults
Date: Fri,  6 Oct 2017 14:31:35 +0100
Message-Id: <20171006133203.22803-9-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a recoverable page fault is handled by the fault workqueue, find the
associated process and call handle_mm_fault.

In theory, we don't even need to take a reference to the iommu_process,
because any release of the structure is preceded by a flush of the queue.
I don't feel comfortable removing the pinning at the moment, though.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/io-pgfault.c | 83 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index f31bc24534b0..532bdb9ce519 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -21,6 +21,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -83,8 +84,86 @@ static int iommu_fault_finish(struct iommu_domain *domain, struct device *dev,
 
 static int iommu_fault_handle_single(struct iommu_fault_context *fault)
 {
-	/* TODO */
-	return -ENODEV;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct iommu_process *process;
+	int ret = IOMMU_FAULT_STATUS_INVALID;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault *params = &fault->params;
+
+	if (!(params->flags & IOMMU_FAULT_PASID))
+		return ret;
+
+	process = iommu_process_find(params->pasid);
+	if (!process)
+		return ret;
+
+	if ((params->flags & (IOMMU_FAULT_LAST | IOMMU_FAULT_READ |
+			      IOMMU_FAULT_WRITE)) == IOMMU_FAULT_LAST) {
+		/* Special case: PASID Stop Marker doesn't require a response */
+		ret = IOMMU_FAULT_STATUS_IGNORE;
+		goto out_put_process;
+	}
+
+	mm = process->mm;
+	if (!mmget_not_zero(mm)) {
+		/* Process is dead */
+		goto out_put_process;
+	}
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, params->address);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (params->flags & IOMMU_FAULT_READ)
+		access_flags |= VM_READ;
+
+	if (params->flags & IOMMU_FAULT_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (params->flags & IOMMU_FAULT_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(params->flags & IOMMU_FAULT_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, params->address, fault_flags);
+	ret = ret & VM_FAULT_ERROR ? IOMMU_FAULT_STATUS_INVALID :
+		IOMMU_FAULT_STATUS_HANDLED;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+
+	/*
+	 * Here's a fun scenario: the process exits while we're handling the
+	 * fault on its mm. Since we're the last mm_user, mmput will call
+	 * mm_exit immediately. exit_mm releases the mmu notifier, which calls
+	 * iommu_notifier_release, which has to flush the fault queue that we're
+	 * executing on... It's actually easy to reproduce with a DMA engine,
+	 * and I did observe a lockdep splat. Therefore move the release of the
+	 * mm to another thread, if we're the last user.
+	 *
+	 * mmput_async was removed in 4.14, and added back in 4.15(?)
+	 * https://patchwork.kernel.org/patch/9952257/
+	 */
+	mmput_async(mm);
+
+out_put_process:
+	iommu_process_put(process);
+
+	return ret;
 }
 
 static void iommu_fault_handle_group(struct work_struct *work)
-- 
2.13.3

