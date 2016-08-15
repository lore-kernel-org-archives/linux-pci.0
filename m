Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v4 02/15] drivers: iommu: implement
 arch_{set/get}_iommu_fwspec API
Date: Mon, 15 Aug 2016 16:23:27 +0100
Message-Id: <1471274620-20754-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, Dennis Chen <dennis.chen@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>,
 Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
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
 drivers/iommu/of_iommu.c              | 12 ++++++------
 include/linux/of_iommu.h              | 10 ++++++++++
 7 files changed, 81 insertions(+), 6 deletions(-)
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
index bec51eb..e30f860 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -222,7 +222,7 @@ postcore_initcall_sync(of_iommu_init);
 
 int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
 {
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
 
 	if (fwspec)
 		return 0;
@@ -233,13 +233,13 @@ int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
 
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
@@ -249,7 +249,7 @@ void iommu_fwspec_free(struct device *dev)
 
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev->archdata.iommu;
+	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
 	size_t size;
 
 	if (!fwspec)
@@ -263,11 +263,11 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	while (num_ids--)
 		fwspec->ids[fwspec->num_ids++] = *ids++;
 
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
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
