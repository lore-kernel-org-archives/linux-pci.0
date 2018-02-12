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
Subject: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
Date: Mon, 12 Feb 2018 18:33:16 +0000
Message-Id: <20180212183352.22730-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Shared Virtual Addressing (SVA) provides a way for device drivers to bind
process address spaces to devices. This requires the IOMMU to support the
same page table format as CPUs, and requires the system to support I/O
Page Faults (IOPF) and Process Address Space ID (PASID). When all of these
are available, DMA can access virtual addresses of a process. A PASID is
allocated for each process, and the device driver programs it into the
device in an implementation-specific way.

Add a new API for sharing process page tables with devices. Introduce two
IOMMU operations, sva_device_init() and sva_device_shutdown(), that
prepare the IOMMU driver for SVA. For example allocate PASID tables and
fault queues. Subsequent patches will implement the bind() and unbind()
operations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/Kconfig     | 10 ++++++
 drivers/iommu/Makefile    |  1 +
 drivers/iommu/iommu-sva.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     | 32 +++++++++++++++++
 4 files changed, 133 insertions(+)
 create mode 100644 drivers/iommu/iommu-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..555147a61f7c 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -74,6 +74,16 @@ config IOMMU_DMA
 	select IOMMU_IOVA
 	select NEED_SG_DMA_LENGTH
 
+config IOMMU_SVA
+	bool "Shared Virtual Addressing API for the IOMMU"
+	select IOMMU_API
+	help
+	  Enable process address space management for the IOMMU API. In systems
+	  that support it, device drivers can bind process address spaces to
+	  devices and share their page tables using this API.
+
+	  If unsure, say N here.
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..1dbcc89ebe4c 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
new file mode 100644
index 000000000000..cab5d723520f
--- /dev/null
+++ b/drivers/iommu/iommu-sva.c
@@ -0,0 +1,90 @@
+/*
+ * Track processes address spaces bound to devices and allocate PASIDs.
+ *
+ * Copyright (C) 2018 ARM Ltd.
+ * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/iommu.h>
+
+/**
+ * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a device
+ * @dev: the device
+ * @features: bitmask of features that need to be initialized
+ * @max_pasid: max PASID value supported by the device
+ *
+ * Users of the bind()/unbind() API must call this function to initialize all
+ * features required for SVA.
+ *
+ * - If the device should support multiple address spaces (e.g. PCI PASID),
+ *   IOMMU_SVA_FEAT_PASID must be requested.
+ *
+ *   By default the PASID allocated during bind() is limited by the IOMMU
+ *   capacity, and by the device PASID width defined in the PCI capability or in
+ *   the firmware description. Setting @max_pasid to a non-zero value smaller
+ *   than this limit overrides it.
+ *
+ * - If the device should support I/O Page Faults (e.g. PCI PRI),
+ *   IOMMU_SVA_FEAT_IOPF must be requested.
+ *
+ * The device should not be be performing any DMA while this function is
+ * running.
+ *
+ * Return 0 if initialization succeeded, or an error.
+ */
+int iommu_sva_device_init(struct device *dev, unsigned long features,
+			  unsigned int max_pasid)
+{
+	int ret;
+	unsigned int min_pasid = 0;
+	struct iommu_param *dev_param = dev->iommu_param;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain || !dev_param || !domain->ops->sva_device_init)
+		return -ENODEV;
+
+	/*
+	 * IOMMU driver updates the limits depending on the IOMMU and device
+	 * capabilities.
+	 */
+	ret = domain->ops->sva_device_init(dev, features, &min_pasid,
+					   &max_pasid);
+	if (ret)
+		return ret;
+
+	/* FIXME: racy. Next version should have a mutex (same as fault handler) */
+	dev_param->sva_features = features;
+	dev_param->min_pasid = min_pasid;
+	dev_param->max_pasid = max_pasid;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_device_init);
+
+/**
+ * iommu_sva_device_shutdown() - Shutdown Shared Virtual Addressing for a device
+ * @dev: the device
+ *
+ * Disable SVA. The device should not be performing any DMA while this function
+ * is running.
+ */
+int iommu_sva_device_shutdown(struct device *dev)
+{
+	struct iommu_param *dev_param = dev->iommu_param;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (!domain)
+		return -ENODEV;
+
+	if (domain->ops->sva_device_shutdown)
+		domain->ops->sva_device_shutdown(dev);
+
+	dev_param->sva_features = 0;
+	dev_param->min_pasid = 0;
+	dev_param->max_pasid = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_device_shutdown);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 66ef406396e9..e9e09eecdece 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -60,6 +60,11 @@ typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
 
+/* Request PASID support */
+#define IOMMU_SVA_FEAT_PASID		(1 << 0)
+/* Request I/O page fault support */
+#define IOMMU_SVA_FEAT_IOPF		(1 << 1)
+
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
@@ -197,6 +202,8 @@ struct page_response_msg {
  * @domain_free: free iommu domain
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
+ * @sva_device_init: initialize Shared Virtual Adressing for a device
+ * @sva_device_shutdown: shutdown Shared Virtual Adressing for a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
@@ -230,6 +237,10 @@ struct iommu_ops {
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*sva_device_init)(struct device *dev, unsigned long features,
+			       unsigned int *min_pasid,
+			       unsigned int *max_pasid);
+	void (*sva_device_shutdown)(struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
@@ -385,6 +396,9 @@ struct iommu_fault_param {
  */
 struct iommu_param {
 	struct iommu_fault_param *fault_param;
+	unsigned long sva_features;
+	unsigned int min_pasid;
+	unsigned int max_pasid;
 };
 
 int  iommu_device_register(struct iommu_device *iommu);
@@ -878,4 +892,22 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_SVA
+extern int iommu_sva_device_init(struct device *dev, unsigned long features,
+				 unsigned int max_pasid);
+extern int iommu_sva_device_shutdown(struct device *dev);
+#else /* CONFIG_IOMMU_SVA */
+static inline int iommu_sva_device_init(struct device *dev,
+					unsigned long features,
+					unsigned int max_pasid)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_device_shutdown(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_IOMMU_SVA */
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.15.1

