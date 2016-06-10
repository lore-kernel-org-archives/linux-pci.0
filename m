Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH v2 13/15] drivers: acpi: iort: introduce
 iort_iommu_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-14-git-send-email-lorenzo.pieralisi@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <575AB6C0.4050808@semihalf.com>
Date: Fri, 10 Jun 2016 14:46:56 +0200
MIME-Version: 1.0
In-Reply-To: <1465306270-27076-14-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 07.06.2016 15:31, Lorenzo Pieralisi wrote:
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
> + * @dev: device to configure
> + *
> + * Returns: iommu_ops pointer on configuration success
> + *          NULL on configuration failure
> + */
> +const struct iommu_ops *iort_iommu_configure(struct device *dev)
> +{
> +	struct acpi_iort_node *node, *parent;
> +	const struct iort_ops_node *iort_ops;
> +	u32 rid = 0, devid = 0;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_bus *bus = to_pci_dev(dev)->bus;
> +
> +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> +				       &rid);

I think we should find here the root bus which is connected to RC IORT node.

> +
> +		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +				      iort_find_dev_callback, &bus->dev);
> +	} else {
> +		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
> +				      iort_find_dev_callback, dev);
> +	}
> +
> +	if (!node)
> +		return NULL;
> +
> +	parent = iort_find_parent_node(node);
> +
> +	if (!parent)
> +		return NULL;
> +
> +	iort_ops = iort_smmu_get_ops_node(parent);
> +
> +	if (iort_ops && iort_ops->iommu_xlate) {
> +		iort_dev_map_rid(node, rid, &devid, parent->type);
> +		iort_ops->iommu_xlate(dev, devid, parent);
> +		return iort_ops->ops;
> +	}
> +
> +	return NULL;
> +}
> +

Thanks,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
