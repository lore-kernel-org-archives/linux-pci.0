Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 08/37] iommu/fault: Handle mm faults
Date: Mon, 12 Feb 2018 18:33:23 +0000
Message-Id: <20180212183352.22730-9-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/io-pgfault.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 33309ed316d2..565ec01a1b5f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -9,6 +9,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -82,8 +83,92 @@ static int iommu_fault_complete(struct iommu_domain *domain, struct device *dev,
 
 static int iommu_fault_handle_single(struct iommu_fault_context *fault)
 {
-	/* TODO */
-	return -ENODEV;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	int ret = IOMMU_PAGE_RESP_INVALID;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_event *evt = &fault->evt;
+
+	if (!evt->pasid_valid)
+		return ret;
+
+	/*
+	 * Special case: PASID Stop Marker (LRW = 0b100) doesn't expect a
+	 * response. A Stop Marker may be generated when disabling a PASID
+	 * (issuing a PASID stop request) in some PCI devices.
+	 *
+	 * When the mm_exit() callback returns from the device driver, no page
+	 * request is generated for this PASID anymore and outstanding ones have
+	 * been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1 and 10.4.1.2 -
+	 * Managing PASID TLP Prefix Usage). Some PCI devices will wait for all
+	 * outstanding page requests to come back with a response before
+	 * completing the PASID stop request. Others do not wait for page
+	 * responses, and instead issue this Stop Marker that tells us when the
+	 * PASID can be reallocated.
+	 *
+	 * We ignore the Stop Marker because:
+	 * a. Page requests, which are posted requests, have been flushed to the
+	 *    IOMMU when mm_exit() returns,
+	 * b. We flush all fault queues after mm_exit() returns and before
+	 *    freeing the PASID.
+	 *
+	 * So even though the Stop Marker might be issued by the device *after*
+	 * the stop request completes, outstanding faults will have been dealt
+	 * with by the time we free the PASID.
+	 */
+	if (evt->last_req &&
+	    !(evt->prot & (IOMMU_FAULT_READ | IOMMU_FAULT_WRITE)))
+		return IOMMU_PAGE_RESP_HANDLED;
+
+	mm = iommu_sva_find(evt->pasid);
+	if (!mm)
+		return ret;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, evt->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (evt->prot & IOMMU_FAULT_READ)
+		access_flags |= VM_READ;
+
+	if (evt->prot & IOMMU_FAULT_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (evt->prot & IOMMU_FAULT_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(evt->prot & IOMMU_FAULT_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, evt->addr, fault_flags);
+	ret = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+
+	/*
+	 * If the process exits while we're handling the fault on its mm, we
+	 * can't do mmput(). exit_mmap() would release the MMU notifier, calling
+	 * iommu_notifier_release(), which has to flush the fault queue that
+	 * we're executing on... So mmput_async() moves the release of the mm to
+	 * another thread, if we're the last user.
+	 */
+	mmput_async(mm);
+
+	return ret;
 }
 
 static void iommu_fault_handle_group(struct work_struct *work)
-- 
2.15.1

