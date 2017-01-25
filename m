Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for
 error handling
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
 will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com>
Date: Wed, 25 Jan 2017 18:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sricharan,

On 23.01.2017 17:18, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> In preparation for some upcoming cleverness, rework the control flow in
> of_iommu_configure() to minimise duplication and improve the propogation
> of errors. It's also as good a time as any to switch over from the
> now-just-a-compatibility-wrapper of_iommu_get_ops() to using the generic
> IOMMU instance interface directly.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/of_iommu.c | 83 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 0f57ddc..ee49081 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -96,6 +96,28 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>  }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
>
> +static const struct iommu_ops
> +*of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
> +{
> +	const struct iommu_ops *ops;
> +	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
> +	int err;
> +
> +	ops = iommu_get_instance(fwnode);
> +	if (!ops || !ops->of_xlate)
> +		return NULL;
> +
> +	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	err = ops->of_xlate(dev, iommu_spec);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return ops;
> +}
> +
>  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>  {
>  	struct of_phandle_args *iommu_spec = data;
> @@ -105,10 +127,11 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>  }
>
>  static const struct iommu_ops
> -*of_pci_iommu_configure(struct pci_dev *pdev, struct device_node *bridge_np)
> +*of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
>  {
>  	const struct iommu_ops *ops;
>  	struct of_phandle_args iommu_spec;
> +	int err;
>
>  	/*
>  	 * Start by tracing the RID alias down the PCI topology as
> @@ -123,56 +146,56 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>  	 * bus into the system beyond, and which IOMMU it ends up at.
>  	 */
>  	iommu_spec.np = NULL;
> -	if (of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
> -			   "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
> -		return NULL;
> +	err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
> +			     "iommu-map-mask", &iommu_spec.np,
> +			     iommu_spec.args);
> +	if (err)
> +		return ERR_PTR(err);
>
> -	ops = of_iommu_get_ops(iommu_spec.np);
> -	if (!ops || !ops->of_xlate ||
> -	    iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
> -	    ops->of_xlate(&pdev->dev, &iommu_spec))
> -		ops = NULL;
> +	ops = of_iommu_xlate(&pdev->dev, &iommu_spec);
>
>  	of_node_put(iommu_spec.np);
>  	return ops;
>  }
>
> -const struct iommu_ops *of_iommu_configure(struct device *dev,
> -					   struct device_node *master_np)
> +static const struct iommu_ops
> +*of_platform_iommu_init(struct device *dev, struct device_node *np)
>  {
>  	struct of_phandle_args iommu_spec;
> -	struct device_node *np;
>  	const struct iommu_ops *ops = NULL;
>  	int idx = 0;
>
> -	if (dev_is_pci(dev))
> -		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
> -
>  	/*
>  	 * We don't currently walk up the tree looking for a parent IOMMU.
>  	 * See the `Notes:' section of
>  	 * Documentation/devicetree/bindings/iommu/iommu.txt
>  	 */
> -	while (!of_parse_phandle_with_args(master_np, "iommus",
> -					   "#iommu-cells", idx,
> -					   &iommu_spec)) {
> -		np = iommu_spec.np;
> -		ops = of_iommu_get_ops(np);
> -
> -		if (!ops || !ops->of_xlate ||
> -		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
> -		    ops->of_xlate(dev, &iommu_spec))
> -			goto err_put_node;
> -
> -		of_node_put(np);
> +	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
> +					   idx, &iommu_spec)) {
> +		ops = of_iommu_xlate(dev, &iommu_spec);
> +		of_node_put(iommu_spec.np);
>  		idx++;
> +		if (IS_ERR_OR_NULL(ops))
> +			break;
>  	}
>
>  	return ops;
> +}
> +
> +const struct iommu_ops *of_iommu_configure(struct device *dev,
> +					   struct device_node *master_np)
> +{
> +	const struct iommu_ops *ops;
> +
> +	if (!master_np)
> +		return NULL;
> +
> +	if (dev_is_pci(dev))
> +		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);

I gave the whole patch set a try on ThunderX. really_probe() is failing 
on dma_configure()->of_pci_iommu_init() for each PCI device. 
of_pci_iommu_init() tries to setup firmware stuff via "iommu-map" but 
ThunderX is using legacy "mmu-masters" binding. We need to take care of 
that case too.

> +	else
> +		ops = of_platform_iommu_init(dev, master_np);
>
> -err_put_node:
> -	of_node_put(np);
> -	return NULL;
> +	return IS_ERR(ops) ? NULL : ops;
>  }
>
>  static int __init of_iommu_init(void)
>

Thanks,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
