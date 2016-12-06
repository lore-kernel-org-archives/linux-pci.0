Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2] ACPI/IORT: Make dma masks set-up IORT specific
Date: Tue,  6 Dec 2016 14:20:11 +0000
Message-Id: <20161206142011.11859-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Dennis Chen <dennis.chen@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Sricharan R <sricharan@codeaurora.org>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of acpi_dma_configure() allows to configure DMA
and related IOMMU for any device that is DMA capable. To achieve
that goal it ensures DMA masks are set-up to sane default values
before proceeding with IOMMU and DMA ops configuration.

On x86/ia64 systems, through acpi_bind_one(), acpi_dma_configure() is
called for every device that has an ACPI companion, in that every device
is considered DMA capable on x86/ia64 systems (ie acpi_get_dma_attr() API),
which has the side effect of initializing dma masks also for
pseudo-devices (eg CPUs and memory nodes) and potentially for devices
whose dma masks were not set-up before the acpi_dma_configure() API was
introduced, which may have noxious side effects.

Therefore, in preparation for IORT firmware specific DMA masks set-up,
wrap the default DMA masks set-up in acpi_dma_configure() inside an IORT
specific wrapper that reverts to a NOP on x86/ia64 systems, restoring the
default expected behaviour on x86/ia64 systems and keeping DMA default
masks set-up on IORT based (ie ARM) arch configurations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sricharan R <sricharan@codeaurora.org>
---
Hi Joerg,

as discussed please apply it to your arm/smmu branch (and consequently
to -next) in order to get this queued along with the rest of the ACPI IORT
SMMU series for v4.10.

Thank you !
Lorenzo

v1 -> v2
	- Added review tags

 drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
 drivers/acpi/scan.c       | 14 +-------------
 include/linux/acpi_iort.h |  2 ++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 47bace8..e0d2e6e 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -547,6 +547,28 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 }
 
 /**
+ * iort_set_dma_mask - Set-up dma mask for a device.
+ *
+ * @dev: device to configure
+ */
+void iort_set_dma_mask(struct device *dev)
+{
+	/*
+	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
+	 * setup the correct supported mask.
+	 */
+	if (!dev->coherent_dma_mask)
+		dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	/*
+	 * Set it to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+}
+
+/**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
  * @dev: device to configure
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 80698d3..93b00cf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1380,19 +1380,7 @@ void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
 	const struct iommu_ops *iommu;
 
-	/*
-	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
-	 * setup the correct supported mask.
-	 */
-	if (!dev->coherent_dma_mask)
-		dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
+	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index dcb2b60..77e0809 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -35,6 +35,7 @@ bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 /* IOMMU interface */
+void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
@@ -45,6 +46,7 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
 /* IOMMU interface */
+static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
