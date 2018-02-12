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
Subject: [PATCH 06/37] iommu/sva: Search mm by PASID
Date: Mon, 12 Feb 2018 18:33:21 +0000
Message-Id: <20180212183352.22730-7-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up. A future
optimization could find the io_mm from the struct device passed to the
fault handler, since it's readily accessible.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu-sva.c | 26 ++++++++++++++++++++++++++
 include/linux/iommu.h     |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 9108adb54ec7..4bc2a8c12465 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -10,6 +10,7 @@
 #include <linux/idr.h>
 #include <linux/iommu.h>
 #include <linux/mmu_notifier.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/spinlock.h>
@@ -770,3 +771,28 @@ int iommu_unregister_mm_exit_handler(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_unregister_mm_exit_handler);
+
+/*
+ * iommu_sva_find() - Find mm associated to the given PASID
+ *
+ * Returns the mm corresponding to this PASID, or NULL if not found. A reference
+ * to the mm is taken, and must be released with mmput().
+ */
+struct mm_struct *iommu_sva_find(int pasid)
+{
+	struct io_mm *io_mm;
+	struct mm_struct *mm = NULL;
+
+	spin_lock(&iommu_sva_lock);
+	io_mm = idr_find(&iommu_pasid_idr, pasid);
+	if (io_mm && io_mm_get_locked(io_mm)) {
+		if (mmget_not_zero(io_mm->mm))
+			mm = io_mm->mm;
+
+		io_mm_put_locked(io_mm);
+	}
+	spin_unlock(&iommu_sva_lock);
+
+	return mm;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index afec7b1d3301..226ab4f3ae0e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -958,6 +958,7 @@ extern int iommu_register_mm_exit_handler(struct device *dev,
 					  iommu_mm_exit_handler_t handler);
 extern int iommu_unregister_mm_exit_handler(struct device *dev);
 
+extern struct mm_struct *iommu_sva_find(int pasid);
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_sva_device_init(struct device *dev,
 					unsigned long features,
@@ -997,6 +998,11 @@ static inline int iommu_unregister_mm_exit_handler(struct device *dev)
 {
 	return -ENODEV;
 }
+
+static inline struct mm_struct *iommu_sva_find(int pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.15.1

