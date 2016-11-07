Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbcKGLis (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Nov 2016 06:38:48 -0500
Date: Mon, 7 Nov 2016 11:39:43 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: iommu@lists.linux-foundation.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 09/16] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Message-ID: <20161107113942.GA30504@red-moon>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
 <20161018160414.1228-10-lorenzo.pieralisi@arm.com>
 <20161028155007.GA19523@red-moon>
 <20161101223022.GA1234@xora-yoga13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161101223022.GA1234@xora-yoga13>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 01, 2016 at 04:30:22PM -0600, Graeme Gregory wrote:
> On Fri, Oct 28, 2016 at 04:50:07PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Oct 18, 2016 at 05:04:07PM +0100, Lorenzo Pieralisi wrote:
> > > In ARM ACPI systems, IOMMU components are specified through static
> > > IORT table entries. In order to create platform devices for the
> > > corresponding ARM SMMU components, IORT kernel code should be made
> > > able to parse IORT table entries and create platform devices
> > > dynamically.
> > > 
> > > This patch adds the generic IORT infrastructure required to create
> > > platform devices for ARM SMMUs.
> > > 
> > > ARM SMMU versions have different resources requirement therefore this
> > > patch also introduces an IORT specific structure (ie iort_iommu_config)
> > > that contains hooks (to be defined when the corresponding ARM SMMU
> > > driver support is added to the kernel) to be used to define the
> > > platform devices names, init the IOMMUs, count their resources and
> > > finally initialize them.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > > Cc: Tomasz Nowicki <tn@semihalf.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > ---
> > >  drivers/acpi/arm64/iort.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 151 insertions(+)
> > > 
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index 1433de3..2eda2f5 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -19,9 +19,11 @@
> > >  #define pr_fmt(fmt)	"ACPI: IORT: " fmt
> > >  
> > >  #include <linux/acpi_iort.h>
> > > +#include <linux/iommu.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/list.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/slab.h>
> > >  
> > >  struct iort_its_msi_chip {
> > > @@ -457,6 +459,153 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
> > >  	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
> > >  }
> > >  
> > > +struct iort_iommu_config {
> > > +	const char *name;
> > > +	int (*iommu_init)(struct acpi_iort_node *node);
> > > +	bool (*iommu_is_coherent)(struct acpi_iort_node *node);
> > > +	int (*iommu_count_resources)(struct acpi_iort_node *node);
> > > +	void (*iommu_init_resources)(struct resource *res,
> > > +				     struct acpi_iort_node *node);
> > > +};
> > > +
> > > +static __init
> > > +const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
> > > +{
> > > +	return NULL;
> > > +}
> > > +
> > > +/**
> > > + * iort_add_smmu_platform_device() - Allocate a platform device for SMMU
> > > + * @node: Pointer to SMMU ACPI IORT node
> > > + *
> > > + * Returns: 0 on success, <0 failure
> > > + */
> > > +static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> > > +{
> > > +	struct fwnode_handle *fwnode;
> > > +	struct platform_device *pdev;
> > > +	struct resource *r;
> > > +	enum dev_dma_attr attr;
> > > +	int ret, count;
> > > +	const struct iort_iommu_config *ops = iort_get_iommu_cfg(node);
> > > +
> > > +	if (!ops)
> > > +		return -ENODEV;
> > > +
> > > +	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
> > > +	if (!pdev)
> > > +		return PTR_ERR(pdev);
> > > +
> > > +	count = ops->iommu_count_resources(node);
> > > +
> > > +	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> > > +	if (!r) {
> > > +		ret = -ENOMEM;
> > > +		goto dev_put;
> > > +	}
> > > +
> > > +	ops->iommu_init_resources(r, node);
> > > +
> > > +	ret = platform_device_add_resources(pdev, r, count);
> > > +	/*
> > > +	 * Resources are duplicated in platform_device_add_resources,
> > > +	 * free their allocated memory
> > > +	 */
> > > +	kfree(r);
> > > +
> > > +	if (ret)
> > > +		goto dev_put;
> > > +
> > > +	/*
> > > +	 * Add a copy of IORT node pointer to platform_data to
> > > +	 * be used to retrieve IORT data information.
> > > +	 */
> > > +	ret = platform_device_add_data(pdev, &node, sizeof(node));
> > > +	if (ret)
> > > +		goto dev_put;
> > > +
> > > +	/*
> > > +	 * We expect the dma masks to be equivalent for
> > > +	 * all SMMUs set-ups
> > > +	 */
> > > +	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
> > > +
> > > +	fwnode = iort_get_fwnode(node);
> > > +
> > > +	if (!fwnode) {
> > > +		ret = -ENODEV;
> > > +		goto dev_put;
> > > +	}
> > > +
> > > +	pdev->dev.fwnode = fwnode;
> > > +
> > > +	attr = ops->iommu_is_coherent(node) ?
> > > +			     DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
> > > +
> > > +	/* Configure DMA for the page table walker */
> > > +	acpi_dma_configure(&pdev->dev, attr);
> > > +
> > > +	ret = platform_device_add(pdev);
> > > +	if (ret)
> > > +		goto dma_deconfigure;
> > > +
> > > +	return 0;
> > > +
> > > +dma_deconfigure:
> > > +	acpi_dma_deconfigure(&pdev->dev);
> > > +dev_put:
> > > +	platform_device_put(pdev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void __init iort_init_platform_devices(void)
> > > +{
> > > +	struct acpi_iort_node *iort_node, *iort_end;
> > > +	struct acpi_table_iort *iort;
> > > +	struct fwnode_handle *fwnode;
> > > +	int i, ret;
> > > +
> > > +	/*
> > > +	 * iort_table and iort both point to the start of IORT table, but
> > > +	 * have different struct types
> > > +	 */
> > > +	iort = (struct acpi_table_iort *)iort_table;
> > > +
> > > +	/* Get the first IORT node */
> > > +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > > +				 iort->node_offset);
> > > +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > > +				iort_table->length);
> > > +
> > > +	for (i = 0; i < iort->node_count; i++) {
> > > +		if (iort_node >= iort_end) {
> > > +			pr_err("iort node pointer overflows, bad table\n");
> > > +			return;
> > > +		}
> > > +
> > > +		if ((iort_node->type == ACPI_IORT_NODE_SMMU) ||
> > > +			(iort_node->type == ACPI_IORT_NODE_SMMU_V3)) {
> > > +
> > > +			fwnode = acpi_alloc_fwnode_static();
> > > +			if (!fwnode)
> > > +				return;
> > > +
> > > +			iort_set_fwnode(iort_node, fwnode);
> > > +
> > > +			ret = iort_add_smmu_platform_device(iort_node);
> > > +			if (ret) {
> > > +				iort_delete_fwnode(iort_node);
> > > +				acpi_free_fwnode_static(fwnode);
> > > +				return;
> > > +			}
> > > +		}
> > > +
> > > +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > > +					 iort_node->length);
> > > +	}
> > > +}
> > > +
> > >  void __init acpi_iort_init(void)
> > >  {
> > >  	acpi_status status;
> > > @@ -468,5 +617,7 @@ void __init acpi_iort_init(void)
> > >  		return;
> > >  	}
> > >  
> > 
> > Slipped through the cracks while rebasing v6, I should add code that
> > returns if no IORT table found here to prevent calling:
> > 
> > iort_init_platform_devices()
> > 
> > I will update the next version, it is just a heads-up for testers,
> > I can push an updated/fixed branch if needed.
> > 
> 
> I could do with the updated branch.

Done, please find it here, I will post a v7 this week with updates.

git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/iort-smmu-v6

Lorenzo
