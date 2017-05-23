Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V11 08/11] drivers: acpi: Handle IOMMU lookup failure with
 deferred probing or error
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
 will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org,
 robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
References: <1491823266-1209-1-git-send-email-sricharan@codeaurora.org>
 <1491823266-1209-9-git-send-email-sricharan@codeaurora.org>
From: Nate Watterson <nwatters@codeaurora.org>
Message-ID: <41668eff-271c-1c4c-7665-3bf0faa74669@codeaurora.org>
Date: Tue, 23 May 2017 02:26:10 -0400
MIME-Version: 1.0
In-Reply-To: <1491823266-1209-9-git-send-email-sricharan@codeaurora.org>
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

On 4/10/2017 7:21 AM, Sricharan R wrote:
> This is an equivalent to the DT's handling of the iommu master's probe
> with deferred probing when the corrsponding iommu is not probed yet.
> The lack of a registered IOMMU can be caused by the lack of a driver for
> the IOMMU, the IOMMU device probe not having been performed yet, having
> been deferred, or having failed.
> 
> The first case occurs when the firmware describes the bus master and
> IOMMU topology correctly but no device driver exists for the IOMMU yet
> or the device driver has not been compiled in. Return NULL, the caller
> will configure the device without an IOMMU.
> 
> The second and third cases are handled by deferring the probe of the bus
> master device which will eventually get reprobed after the IOMMU.
> 
> The last case is currently handled by deferring the probe of the bus
> master device as well. A mechanism to either configure the bus master
> device without an IOMMU or to fail the bus master device probe depending
> on whether the IOMMU is optional or mandatory would be a good
> enhancement.
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> [Lorenzo: Added fixes for dma_coherent_mask overflow, acpi_dma_configure
>            called multiple times for same device]
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>   drivers/acpi/arm64/iort.c  | 33 ++++++++++++++++++++++++++++++++-
>   drivers/acpi/scan.c        | 11 ++++++++---
>   drivers/base/dma-mapping.c |  2 +-
>   include/acpi/acpi_bus.h    |  2 +-
>   include/linux/acpi.h       |  7 +++++--
>   5 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3dd9ec3..e323ece 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -543,6 +543,14 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>   	const struct iommu_ops *ops = NULL;
>   	int ret = -ENODEV;
>   	struct fwnode_handle *iort_fwnode;
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +
> +	/*
> +	 * If we already translated the fwspec there
> +	 * is nothing left to do, return the iommu_ops.
> +	 */
> +	if (fwspec && fwspec->ops)
> +		return fwspec->ops;

Is this logic strictly required? It breaks masters with multiple SIDs
as only the first SID is actually added to the master's fwspec.

>   
>   	if (node) {
>   		iort_fwnode = iort_get_fwnode(node);
> @@ -550,8 +558,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>   			return NULL;
>   
>   		ops = iommu_ops_from_fwnode(iort_fwnode);
> +		/*
> +		 * If the ops look-up fails, this means that either
> +		 * the SMMU drivers have not been probed yet or that
> +		 * the SMMU drivers are not built in the kernel;
> +		 * Depending on whether the SMMU drivers are built-in
> +		 * in the kernel or not, defer the IOMMU configuration
> +		 * or just abort it.
> +		 */
>   		if (!ops)
> -			return NULL;
> +			return iort_iommu_driver_enabled(node->type) ?
> +			       ERR_PTR(-EPROBE_DEFER) : NULL;
>   
>   		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
>   	}
> @@ -625,12 +642,26 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>   
>   		while (parent) {
>   			ops = iort_iommu_xlate(dev, parent, streamid);
> +			if (IS_ERR_OR_NULL(ops))
> +				return ops;
>   
>   			parent = iort_node_get_id(node, &streamid,
>   						  IORT_IOMMU_TYPE, i++);
>   		}
>   	}
>   
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * add_device callback for dev, replay it to get things in order.
> +	 */
> +	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
> +	    dev->bus && !dev->iommu_group) {
> +		int err = ops->add_device(dev);
> +
> +		if (err)
> +			ops = ERR_PTR(err);
> +	}
> +
>   	return ops;
>   }
>   
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1926918..2a513cc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1373,20 +1373,25 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>    * @dev: The pointer to the device
>    * @attr: device dma attributes
>    */
> -void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> +int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
>   {
>   	const struct iommu_ops *iommu;
> +	u64 size;
>   
>   	iort_set_dma_mask(dev);
>   
>   	iommu = iort_iommu_configure(dev);
> +	if (IS_ERR(iommu))
> +		return PTR_ERR(iommu);
>   
> +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>   	/*
>   	 * Assume dma valid range starts at 0 and covers the whole
>   	 * coherent_dma_mask.
>   	 */
> -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
> -			   attr == DEV_DMA_COHERENT);
> +	arch_setup_dma_ops(dev, 0, size, iommu, attr == DEV_DMA_COHERENT);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(acpi_dma_configure);
>   
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 82bd45c..755a2b5 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -368,7 +368,7 @@ int dma_configure(struct device *dev)
>   	} else if (has_acpi_companion(dma_dev)) {
>   		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
>   		if (attr != DEV_DMA_NOT_SUPPORTED)
> -			acpi_dma_configure(dev, attr);
> +			ret = acpi_dma_configure(dev, attr);
>   	}
>   
>   	if (bridge)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index ef0ae8a..2a9a5de 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -575,7 +575,7 @@ struct acpi_pci_root {
>   
>   bool acpi_dma_supported(struct acpi_device *adev);
>   enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
> -void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
> +int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
>   void acpi_dma_deconfigure(struct device *dev);
>   
>   struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9b05886..79d06ef6 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -762,8 +762,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
>   	return DEV_DMA_NOT_SUPPORTED;
>   }
>   
> -static inline void acpi_dma_configure(struct device *dev,
> -				      enum dev_dma_attr attr) { }
> +static inline int acpi_dma_configure(struct device *dev,
> +				     enum dev_dma_attr attr)
> +{
> +	return 0;
> +}
>   
>   static inline void acpi_dma_deconfigure(struct device *dev) { }
>   
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
