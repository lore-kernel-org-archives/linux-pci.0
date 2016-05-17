Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <573AD142.6020107@semihalf.com>
Date: Tue, 17 May 2016 10:07:30 +0200
MIME-Version: 1.0
In-Reply-To: <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 14.04.2016 19:25, Lorenzo Pieralisi wrote:
> On DT based systems, the of_dma_configure() API implements DMA configuration
> for a given device. On ACPI systems an API equivalent to of_dma_configure()
> is missing which implies that it is currently not possible to set-up DMA
> operations for devices through the ACPI generic kernel layer.
>
> This patch fills the gap by introducing acpi_dma_configure/deconfigure()
> calls, that carry out IOMMU configuration through IORT (on systems where
> it is present) and call arch_setup_dma_ops(...) with the retrieved
> parameters.
>
> The DMA range size passed to arch_setup_dma_ops() is sized according
> to the device coherent_dma_mask (starting at address 0x0), mirroring the
> DT probing path behaviour when a dma-ranges property is not provided
> for the device being probed; this changes the current arch_setup_dma_ops()
> call parameters in the ACPI probing case, but since arch_setup_dma_ops()
> is a NOP on all architectures but ARM/ARM64 this patch does not change
> the current kernel behaviour on them.
>
> This patch updates ACPI and PCI core code to use the newly introduced
> acpi_dma_configure function, providing the same functionality
> as of_dma_configure on ARM systems and leaving behaviour unchanged
> for all other arches.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>   drivers/acpi/glue.c     |  4 +--
>   drivers/acpi/iort.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/acpi/scan.c     | 29 +++++++++++++++++
>   drivers/pci/probe.c     |  3 +-
>   include/acpi/acpi_bus.h |  2 ++
>   include/linux/acpi.h    |  5 +++
>   include/linux/iort.h    |  9 ++++++
>   7 files changed, 133 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 5ea5dc2..f8d6564 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -227,8 +227,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>
>   	attr = acpi_get_dma_attr(acpi_dev);
>   	if (attr != DEV_DMA_NOT_SUPPORTED)
> -		arch_setup_dma_ops(dev, 0, 0, NULL,
> -				   attr == DEV_DMA_COHERENT);
> +		acpi_dma_configure(dev, attr);
>
>   	acpi_physnode_link_name(physical_node_name, node_id);
>   	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
> @@ -251,6 +250,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>   	return 0;
>
>    err:
> +	acpi_dma_deconfigure(dev);
>   	ACPI_COMPANION_SET(dev, NULL);
>   	put_device(dev);
>   	put_device(&acpi_dev->dev);
> diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
> index 2b5ce65..b1bb8fb 100644
> --- a/drivers/acpi/iort.c
> +++ b/drivers/acpi/iort.c
> @@ -72,6 +72,31 @@ int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
>   	return 0;
>   }
>
> +/**
> + * iort_iommu_get_node - Retrieve iort_iommu_node associated with an IORT node.
> + *
> + * @node: IORT table node to be looked-up
> + *
> + * Returns: iort_iommu_node pointer on success
> + *          NULL on failure
> + */
> +static struct iort_iommu_node *iort_iommu_get_node(struct acpi_iort_node *node)
> +{
> +	struct iort_iommu_node *iommu_node;
> +
> +	spin_lock(&iort_iommu_lock);
> +	list_for_each_entry(iommu_node, &iort_iommu_list, list) {
> +		if (iommu_node->node == node)
> +			goto found;
> +	}
> +
> +	iommu_node = NULL;
> +found:
> +	spin_unlock(&iort_iommu_lock);
> +
> +	return iommu_node;
> +}
> +
>   typedef acpi_status (*iort_find_node_callback)
>   	(struct acpi_iort_node *node, void *context);
>
> @@ -405,6 +430,66 @@ iort_pci_get_domain(struct pci_dev *pdev, u32 req_id)
>   	return domain_handle;
>   }
>
> +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	u32 *rid = data;
> +
> +	*rid = alias;
> +	return 0;
> +}
> +
> +/**
> + * iort_iommu_configure - Set-up IOMMU configuration for a device.
> + *
> + * @dev: device that requires IOMMU set-up
> + *
> + * Returns: iommu_ops pointer on configuration success
> + *          NULL on configuration failure
> + */
> +struct iommu_ops *iort_iommu_configure(struct device *dev)
> +{
> +	struct acpi_iort_node *node, *parent;
> +	struct iommu_ops *ops = NULL;
> +	struct iommu_fwspec fwspec;
> +	struct iort_iommu_node *iommu_node;
> +	u32 rid = 0, devid = 0;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_bus *bus = to_pci_dev(dev)->bus;
> +
> +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> +				       &rid);
> +
> +		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +				      iort_find_dev_callback, &bus->dev);
> +	} else
> +		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +				      iort_find_dev_callback, dev);

I think this will not work for finding host bridge stream ID. We still 
need to use ACPI_IORT_NODE_PCI_ROOT_COMPLEX but 'dev' is not PCI device, 
right?

Thanks,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
