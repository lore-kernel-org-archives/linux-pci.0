Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Aug 2016 12:26:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF
 agnostic
Message-ID: <20160811112624.GA26187@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
 <1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
 <20160725154103.GA28507@red-moon>
 <856415fc-b9bf-ca44-cc70-85d454574e53@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <856415fc-b9bf-ca44-cc70-85d454574e53@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 25, 2016 at 04:51:00PM +0100, Robin Murphy wrote:
> On 25/07/16 16:41, Lorenzo Pieralisi wrote:
> [...]
> >>> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> >>> index 308791f..2362232 100644
> >>> --- a/include/linux/of_iommu.h
> >>> +++ b/include/linux/of_iommu.h
> >>> @@ -15,13 +15,8 @@ extern void of_iommu_init(void);
> >>>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
> >>>  					struct device_node *master_np);
> >>>  
> >>> -struct iommu_fwspec {
> >>> -	const struct iommu_ops	*iommu_ops;
> >>> -	struct device_node	*iommu_np;
> >>> -	void			*iommu_priv;
> >>> -	unsigned int		num_ids;
> >>> -	u32			ids[];
> >>> -};
> >>> +void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
> >>> +const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
> >>
> >> Is there some reason we need to retain the existing definitions of
> >> these? I was assuming we'd be able to move the entire implementation
> >> over to the fwspec code and leave behind nothing more than trivial
> >> wrappers, e.g.:
> >>
> >> #define of_iommu_get_ops(np) iommu_fwspec_get_ops(&(np)->fwnode_handle)
> > 
> > Yep, that's exactly what I did but then I was bitten by config
> > dependencies. If we implement of_iommu_get/set_ops() as wrappers,
> > we have to compile iommu_fwspec_get/set_ops() on arches that may
> > not have struct dev_archdata.iommu, unless we introduce yet another
> > config symbol to avoid compiling that code (see eg iommu_fwspec_init(),
> > we can't compile it on eg x86 even though we do need of_iommu_get_ops()
> > on it - so iommu_fwspec_get_ops(), that lives in the same compilation
> > unit as eg iommu_fwspec_init()).
> > 
> > So short answer is: there is no reason apart from dev_archdata.iommu
> > being arch specific, if we were able to move iommu_fwspec to generic
> > code (ie struct device, somehow) I would certainly get rid of this
> > stupid code duplication (or as I said I can add a config entry for
> > that, more ideas are welcome).
> 
> OK, given Rob's comment as well, I guess breaking that dependency is to
> everyone's benefit. Since it's quite closely related, how about if we
> follow the arch_setup_dma_ops() pattern with an
> arch_{get,set}_iommu_fwspec(dev) type thing?

How about this (on top of your current iommu/generic branch):

If that's ok feel free to squash it in for the next posting,
or I can add it to my IORT series (I'd argue though that the
problem it solves is not strictly related to ACPI), please
let me know.

Thanks !
Lorenzo

-- >8 --
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d601d7..dfd331d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -58,6 +58,7 @@ config ARM
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_IDE if PCI || ISA || PCMCIA
+	select HAVE_IOMMU_FWSPEC if IOMMU_API
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/arm/include/asm/iommu-fwspec.h b/arch/arm/include/asm/iommu-fwspec.h
new file mode 100644
index 0000000..d6581a1
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
+				         struct iommu_fwspec *fwspec)
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
index 69c8787..90d420f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -82,6 +82,7 @@ config ARM64
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
+	select HAVE_IOMMU_FWSPEC if IOMMU_API
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
diff --git a/arch/arm64/include/asm/iommu-fwspec.h b/arch/arm64/include/asm/iommu-fwspec.h
new file mode 100644
index 0000000..d6581a1
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
+				         struct iommu_fwspec *fwspec)
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
 
