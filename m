Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbcIIOXg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Sep 2016 10:23:36 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 02/14] drivers: iommu: implement arch_{set/get}_iommu_fwspec API
Date: Fri,  9 Sep 2016 15:23:31 +0100
Message-Id: <20160909142343.13314-3-lorenzo.pieralisi@arm.com>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The iommu fwspec configuration mechanism currently relies on
the arch specific struct dev_archdata.iommu member to stash
the struct iommu_fwspec pointer set-up for streamid translation.

The struct dev_archdata.iommu member is arch specific and is not present
on all arches that make use of the struct iommu_fwspec infrastructure,
hence an arch specific kernel API is required to set-up and retrieve
struct iommu_fwspec pointers safely from generic iommu code, hiding
the arch specific details.

Implement the arch_{set/get}_iommu_fwspec() generic kernel infrastructure
and add the ARM/ARM64 back-end implementations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/arm/Kconfig                      |  1 +
 arch/arm/include/asm/iommu-fwspec.h   | 30 ++++++++++++++++++++++++++++++
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/iommu-fwspec.h | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig                 |  3 +++
 drivers/iommu/of_iommu.c              | 14 +++++++-------
 include/linux/of_iommu.h              | 10 ++++++++++
 7 files changed, 82 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/include/asm/iommu-fwspec.h
 create mode 100644 arch/arm64/include/asm/iommu-fwspec.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..e84f62e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -59,6 +59,7 @@ config ARM
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_IDE if PCI || ISA || PCMCIA
+	select HAVE_IOMMU_FWSPEC if IOMMU_API
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/arm/include/asm/iommu-fwspec.h b/arch/arm/include/asm/iommu-fwspec.h
new file mode 100644
index 0000000..2e87d8b
--- /dev/null
+++ b/arch/arm/include/asm/iommu-fwspec.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_IOMMU_FWSPEC_H
+#define __ASM_IOMMU_FWSPEC_H
+
+static inline void arch_set_iommu_fwspec(struct device *dev,
+					 struct iommu_fwspec *fwspec)
+{
+	dev->archdata.iommu = fwspec;
+}
+
+static inline struct iommu_fwspec *arch_get_iommu_fwspec(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
+#endif
+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index bc3f00f..10c9b3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -83,6 +83,7 @@ config ARM64
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOMMU_FWSPEC if IOMMU_API
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
diff --git a/arch/arm64/include/asm/iommu-fwspec.h b/arch/arm64/include/asm/iommu-fwspec.h
new file mode 100644
index 0000000..2e87d8b
--- /dev/null
+++ b/arch/arm64/include/asm/iommu-fwspec.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_IOMMU_FWSPEC_H
+#define __ASM_IOMMU_FWSPEC_H
+
+static inline void arch_set_iommu_fwspec(struct device *dev,
+					 struct iommu_fwspec *fwspec)
+{
+	dev->archdata.iommu = fwspec;
+}
+
+static inline struct iommu_fwspec *arch_get_iommu_fwspec(struct device *dev)
+{
+	return dev->archdata.iommu;
+}
+#endif
+
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d7..101cb17 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -67,6 +67,9 @@ config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
 
+config HAVE_IOMMU_FWSPEC
+	bool
+
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
 	bool
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 04d616d..38669b8 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -229,7 +229,7 @@ postcore_initcall_sync(of_iommu_init);
 
 int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
 {
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
 
 	if (fwspec)
 		return 0;
@@ -240,13 +240,13 @@ int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
 
 	fwspec->iommu_np = of_node_get(iommu_np);
 	fwspec->iommu_ops = of_iommu_get_ops(iommu_np);
-	dev->archdata.iommu = fwspec;
+	arch_set_iommu_fwspec(dev, fwspec);
 	return 0;
 }
 
 void iommu_fwspec_free(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
 
 	if (fwspec) {
 		of_node_put(fwspec->iommu_np);
@@ -256,7 +256,7 @@ void iommu_fwspec_free(struct device *dev)
 
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
 	size_t size;
 	int i;
 
@@ -264,7 +264,7 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 		return -EINVAL;
 
 	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
-	fwspec = krealloc(dev->archdata.iommu, size, GFP_KERNEL);
+	fwspec = krealloc(fwspec, size, GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -272,11 +272,11 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 		fwspec->ids[fwspec->num_ids + i] = ids[i];
 
 	fwspec->num_ids += num_ids;
-	dev->archdata.iommu = fwspec;
+	arch_set_iommu_fwspec(dev, fwspec);
 	return 0;
 }
 
 inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
 {
-	return dev->archdata.iommu;
+	return arch_get_iommu_fwspec(dev);
 }
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index accdc05..358db49 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -46,6 +46,16 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
 
+#ifdef CONFIG_HAVE_IOMMU_FWSPEC
+#include <asm/iommu-fwspec.h>
+#else /* !CONFIG_HAVE_IOMMU_FWSPEC */
+static inline void arch_set_iommu_fwspec(struct device *dev,
+					 struct iommu_fwspec *fwspec) {}
+
+static inline struct iommu_fwspec *
+arch_get_iommu_fwspec(struct device *dev) { return NULL; }
+#endif
+
 void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
 const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
-- 
2.10.0

