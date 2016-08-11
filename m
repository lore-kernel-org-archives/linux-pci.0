Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Aug 2016 09:44:46 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: nwatters@codeaurora.org
Cc: iommu@lists.linux-foundation.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 13/13] drivers: acpi: iort: introduce
 iort_iommu_configure
Message-ID: <20160811084446.GA6581@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-14-git-send-email-lorenzo.pieralisi@arm.com>
 <016fb1080595ef61ec7a91da15ef2430@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <016fb1080595ef61ec7a91da15ef2430@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 03, 2016 at 10:19:43AM -0400, nwatters@codeaurora.org wrote:

[...]

> >+const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >+{
> >+	struct acpi_iort_node *node, *parent;
> >+	struct fwnode_handle *iort_fwnode;
> >+	u32 rid = 0, devid = 0;
> 
> Since this routine maps the RID space of a device to the StreamID
> space of its
> parent smmu, would you consider renaming the devid variable to some
> form of sid
> or streamid?
> 
> >+
> >+	if (dev_is_pci(dev)) {
> >+		struct pci_bus *bus = to_pci_dev(dev)->bus;
> >+
> >+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> >+				       &rid);
> >+
> >+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> >+				      iort_match_node_callback, &bus->dev);
> >+	} else {
> >+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> >+				      iort_match_node_callback, dev);
> >+	}
> >+
> >+	if (!node)
> >+		return NULL;
> >+
> >+	parent = iort_node_map_rid(node, rid, &devid, IORT_IOMMU_TYPE);
> >+	if (parent) {
> >+		iort_fwnode = iort_get_fwnode(parent);
> >+		if (iort_fwnode) {
> >+			arm_smmu_iort_xlate(dev, devid, iort_fwnode);
> 
> What about named components with multiple stream ids? Since
> establishing the relationship between a named component and its parent
> smmu is already dependent on there being an appropriate mapping of rid
> 0, it stands to reason that all of the stream ids for a named
> component could be enumerated by mapping increasing rid values until
> the output parent no longer matches that returned for rid 0.

I have reworked the code since for named component it makes no
sense to carry out a mapping that depends on an input id given
that we do not have one. Instead what we will do is the same
thing DT does (ie "iommus" property), namely walk the array of
single mappings for a given named component (that do not depend
on the input rid, there is not any) and add them to the translation
as we find them.

Ergo, mappings that are not single mappings are pretty much useless
for named components (for the time being), and I won't allow them.

Thoughts ?

Lorenzo

> 
> >+			return fwspec_iommu_get_ops(iort_fwnode);
> >+		}
> >+	}
> >+
> >+	return NULL;
> >+}
> 
> It should be noted that while trying out the approach described
> above, I noticed
> that each of the smmu attached named components described in my iort
> were ending
> up with an extra stream id. The culprit appears to be that the range
> checking in
> iort_id_map() is overly permissive on the upper bounds. For example,
> mappings
> with input_base=N and id_count=1 were matching both N and N+1. The
> following
> change fixed the issue.
> 
> @@ -296,7 +296,7 @@ iort_id_map(struct acpi_iort_id_mapping *map, u8
> type, u32 rid_in, u32 *rid_out)
>         }
> 
>         if (rid_in < map->input_base ||
> -           (rid_in > map->input_base + map->id_count))
> +           (rid_in >= map->input_base + map->id_count))
>                 return -ENXIO;
> 
>         *rid_out = map->output_base + (rid_in - map->input_base);
> 
> >+
> > static void acpi_smmu_v3_register_irq(int hwirq, const char *name,
> > 				      struct resource *res)
> > {
> >diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> >index b4b9064..de28825 100644
> >--- a/drivers/acpi/scan.c
> >+++ b/drivers/acpi/scan.c
> >@@ -7,6 +7,7 @@
> > #include <linux/slab.h>
> > #include <linux/kernel.h>
> > #include <linux/acpi.h>
> >+#include <linux/iort.h>
> > #include <linux/signal.h>
> > #include <linux/kthread.h>
> > #include <linux/dmi.h>
> >@@ -1365,11 +1366,15 @@ enum dev_dma_attr acpi_get_dma_attr(struct
> >acpi_device *adev)
> >  */
> > void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> > {
> >+	const struct iommu_ops *iommu;
> >+
> >+	iommu = iort_iommu_configure(dev);
> >+
> > 	/*
> > 	 * Assume dma valid range starts at 0 and covers the whole
> > 	 * coherent_dma_mask.
> > 	 */
> >-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
> >+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
> > 			   attr == DEV_DMA_COHERENT);
> 
> If dev has a matching named component iort entry with a non-zero
> value for
> memory_address_limit, why not use that as the size input to
> arch_setup_dma_ops?
> 
> > }
> >
> >diff --git a/include/linux/iort.h b/include/linux/iort.h
> >index 18e6836..bbe08ef 100644
> >--- a/include/linux/iort.h
> >+++ b/include/linux/iort.h
> >@@ -34,6 +34,8 @@ struct irq_domain *iort_get_device_domain(struct
> >device *dev, u32 req_id);
> > /* IOMMU interface */
> > int iort_add_smmu_platform_device(struct fwnode_handle *fwnode,
> > 				  struct acpi_iort_node *node);
> >+
> >+const struct iommu_ops *iort_iommu_configure(struct device *dev);
> > #else
> > static inline bool iort_node_match(u8 type) { return false; }
> > static inline void iort_table_detect(void) { }
> >@@ -48,6 +50,8 @@ iort_add_smmu_platform_device(struct
> >fwnode_handle *fwnode,
> > {
> > 	return -ENODEV;
> > }
> >+static inline const struct iommu_ops *
> >+iort_iommu_configure(struct device *dev) { return NULL; }
> > #endif
> >
> > #define IORT_ACPI_DECLARE(name, table_id, fn)		\
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a
> Linux Foundation Collaborative Project.
> 
