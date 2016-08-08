Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 8 Aug 2016 17:16:18 +0100
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
Message-ID: <20160808161618.GC22306@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-14-git-send-email-lorenzo.pieralisi@arm.com>
 <016fb1080595ef61ec7a91da15ef2430@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <016fb1080595ef61ec7a91da15ef2430@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Nate,

thanks for having a look.

On Wed, Aug 03, 2016 at 10:19:43AM -0400, nwatters@codeaurora.org wrote:
> On 2016-07-20 07:23, Lorenzo Pieralisi wrote:
> >DT based systems have a generic kernel API to configure IOMMUs
> >for devices (ie of_iommu_configure()).
> >
> >On ARM based ACPI systems, the of_iommu_configure() equivalent can
> >be implemented atop ACPI IORT kernel API, with the corresponding
> >functions to map device identifiers to IOMMUs and retrieve the
> >corresponding IOMMU operations necessary for DMA operations set-up.
> >
> >By relying on the iommu_fwspec generic kernel infrastructure,
> >implement the IORT based IOMMU configuration for ARM ACPI systems
> >and hook it up in the ACPI kernel layer that implements DMA
> >configuration for a device.
> >
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Cc: Hanjun Guo <hanjun.guo@linaro.org>
> >Cc: Tomasz Nowicki <tn@semihalf.com>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >---
> > drivers/acpi/iort.c  | 64
> >++++++++++++++++++++++++++++++++++++++++++++++++++++
> > drivers/acpi/scan.c  |  7 +++++-
> > include/linux/iort.h |  4 ++++
> > 3 files changed, 74 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
> >index c116b68..a12a4ff 100644
> >--- a/drivers/acpi/iort.c
> >+++ b/drivers/acpi/iort.c
> >@@ -18,6 +18,7 @@
> >
> > #define pr_fmt(fmt)	"ACPI: IORT: " fmt
> >
> >+#include <linux/iommu-fwspec.h>
> > #include <linux/iort.h>
> > #include <linux/kernel.h>
> > #include <linux/list.h>
> >@@ -27,6 +28,8 @@
> >
> > #define IORT_TYPE_MASK(type)	(1 << (type))
> > #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
> >+#define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
> >+				(1 << ACPI_IORT_NODE_SMMU_V3))
> >
> > struct iort_its_msi_chip {
> > 	struct list_head	list;
> >@@ -458,6 +461,67 @@ iort_get_device_domain(struct device *dev,
> >u32 req_id)
> > 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> > }
> >
> >+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> >+{
> >+	u32 *rid = data;
> >+
> >+	*rid = alias;
> >+	return 0;
> >+}
> >+
> >+static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
> >+			       struct fwnode_handle *fwnode)
> >+{
> >+	int ret = iommu_fwspec_init(dev, fwnode);
> >+
> >+	if (!ret)
> >+		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
> >+
> >+	return 0;
> 
> Are you intentionally returning 0 instead of ret? How about doing
> this instead?
> 
> 	return ret ? ret : iommu_fwspec_add_ids(dev, &streamid, 1);

No, that's a bug, I will return ret as the of_xlate() function in
the ARM SMMU v3 driver does, thanks.

> >+}
> >+
> >+/**
> >+ * iort_iommu_configure - Set-up IOMMU configuration for a device.
> >+ *
> >+ * @dev: device to configure
> >+ *
> >+ * Returns: iommu_ops pointer on configuration success
> >+ *          NULL on configuration failure
> >+ */
> >+const struct iommu_ops *iort_iommu_configure(struct device *dev)
> >+{
> >+	struct acpi_iort_node *node, *parent;
> >+	struct fwnode_handle *iort_fwnode;
> >+	u32 rid = 0, devid = 0;
> 
> Since this routine maps the RID space of a device to the StreamID
> space of its parent smmu, would you consider renaming the devid
> variable to some form of sid or streamid?

Yes, I will do.

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

Yes, that's a good point, what I am doing currently for named
components is not correct I will update the handling in the next
version. In particular, I think that we should support only
single mappings for named components for the time being and add
code to carry out the mapping as it is done in DT through the
iommus property handling in of_iommu_configure().

> >+			return fwspec_iommu_get_ops(iort_fwnode);
> >+		}
> >+	}
> >+
> >+	return NULL;
> >+}
> 
> It should be noted that while trying out the approach described above,
> I noticed that each of the smmu attached named components described in
> my iort were ending up with an extra stream id. The culprit appears to
> be that the range checking in iort_id_map() is overly permissive on
> the upper bounds. For example, mappings with input_base=N and
> id_count=1 were matching both N and N+1. The following change fixed
> the issue.

I will ask Tomasz to fix it up.

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
> If dev has a matching named component iort entry with a non-zero value
> for memory_address_limit, why not use that as the size input to
> arch_setup_dma_ops?

I was hoping to address this through something more generic (ie
_DMA object - I am not sure it was ever used in x86 world though)
in ACPI rather than relying on IORT named component specific
firmware data (similar to "dma-ranges" handling in DT), I will
certainly keep this in mind though.

Thanks !
Lorenzo
