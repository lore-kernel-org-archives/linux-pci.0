Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbeEKTI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 May 2018 15:08:27 -0400
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, liudongdong3@huawei.com,
        shunyong.yang@hxt-semitech.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com, rgummal@xilinx.com,
        felix.kuehling@amd.com, akpm@linux-foundation.org
Subject: [PATCH v2 10/40] mm: export symbol mm_access
Date: Fri, 11 May 2018 20:06:11 +0100
Message-Id: <20180511190641.23008-11-jean-philippe.brucker@arm.com>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some devices can access process address spaces directly. When creating
such bond, to check that a process controlling the device is allowed to
access the target address space, the device driver uses mm_access(). Since
the drivers (in this case VFIO) can be built as a module, export the
mm_access symbol.

Cc: felix.kuehling@amd.com
Cc: akpm@linux-foundation.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

---
This patch was already sent last year for AMD KFD. I'm resending it for
VFIO, trying to address Andrew Morton's request to comment the exported
function: http://lkml.iu.edu/hypermail/linux/kernel/1705.2/06774.html
---
 kernel/fork.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..1062f7450e97 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1098,6 +1098,19 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 }
 EXPORT_SYMBOL_GPL(get_task_mm);
 
+/**
+ * mm_access - check access permission to a task and and acquire a reference to
+ * its mm.
+ * @task: target task
+ * @mode: selects type of access and caller credentials
+ *
+ * Return the task's mm on success, or %NULL if it cannot be accessed.
+ *
+ * Check if the caller is allowed to read or write the target task's pages.
+ * @mode describes the access mode and credentials using ptrace access flags.
+ * See ptrace_may_access() for more details. On success, a reference to the mm
+ * is taken.
+ */
 struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 {
 	struct mm_struct *mm;
@@ -1117,6 +1130,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 
 	return mm;
 }
+EXPORT_SYMBOL_GPL(mm_access);
 
 static void complete_vfork_done(struct task_struct *tsk)
 {
-- 
2.17.0
