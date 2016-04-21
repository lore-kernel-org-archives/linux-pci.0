Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
Date: Fri, 22 Apr 2016 01:45:38 +0300
Message-ID: <CAHp75VesfEDSnyjKunPzyJ1qUrdi8qE8Q2sOYpwo7h39ePjdow@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 8:25 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
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

Nitpicks below.

> --- a/drivers/acpi/iort.c
> +++ b/drivers/acpi/iort.c
> @@ -72,6 +72,31 @@ int iort_iommu_set_node(struct iommu_ops *ops, struct acpi_iort_node *node,
>         return 0;
>  }
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
> +       struct iort_iommu_node *iommu_node;
> +
> +       spin_lock(&iort_iommu_lock);
> +       list_for_each_entry(iommu_node, &iort_iommu_list, list) {
> +               if (iommu_node->node == node)
> +                       goto found;
> +       }
> +
> +       iommu_node = NULL;
> +found:
> +       spin_unlock(&iort_iommu_lock);
> +
> +       return iommu_node;

Ouch, and why not to

strut iommu_node = NULL;

lock
list for each() {
 if ()
  break;
}
unlock

return iommu_node;

?

> +}


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
> +       struct acpi_iort_node *node, *parent;
> +       struct iommu_ops *ops = NULL;
> +       struct iommu_fwspec fwspec;
> +       struct iort_iommu_node *iommu_node;
> +       u32 rid = 0, devid = 0;
> +
> +       if (dev_is_pci(dev)) {
> +               struct pci_bus *bus = to_pci_dev(dev)->bus;
> +
> +               pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> +                                      &rid);
> +
> +               node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +                                     iort_find_dev_callback, &bus->dev);

> +       } else

checkpatch.pl ?

> +               node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +                                     iort_find_dev_callback, dev);
> +
> +       if (!node)
> +               return NULL;
> +
> +       iort_dev_map_rid(node, rid, &devid, ACPI_IORT_NODE_SMMU);
> +
> +       parent = iort_find_parent_node(node, ACPI_IORT_NODE_SMMU);

> +

Redundant.

> +       if (!parent)
> +               return NULL;
> +
> +       iommu_node = iort_iommu_get_node(parent);
> +       ops = iommu_node->ops;
> +
> +       fwspec.fwnode = iommu_node->fwnode;
> +       fwspec.param_count = 1;
> +       fwspec.param[0] = devid;
> +
> +       if (!ops || !ops->fw_xlate || ops->fw_xlate(dev, &fwspec))
> +               return NULL;
> +
> +       return ops;
> +}
> +

-- 
With Best Regards,
Andy Shevchenko
