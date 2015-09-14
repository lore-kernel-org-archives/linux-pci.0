Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 14 Sep 2015 11:34:11 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V3 2/4] ACPI/scan: Clean up acpi_check_dma
Message-ID: <20150914163411.GL829@google.com>
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1440597279-11802-3-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440597279-11802-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 26, 2015 at 08:54:37PM +0700, Suravee Suthikulpanit wrote:
> The original name of acpi_check_dma() function does not clearly tell what
> exactly it is checking. Also, returning two boolean values (one to indicate
> device is DMA capability, and the other to inidicate device coherency

s/inidicate/indicate/

> attribute) can be confusing.
> 
> So, in order to simplify the function, this patch renames acpi_check_dma()
> to acpi_check_dma_coherency() to clearly indicate the purpose of this
> function, and only returns an integer where -1 means DMA not supported,
> 1 means coherent DMA, and 0 means non-coherent DMA.

I think acpi_check_dma_coherency() is better, but only slightly.  It
still doesn't give a hint about the *sense* of the return value.  I
think it'd be easier to read if there were two functions, e.g.,

  int acpi_dma_supported(struct acpi_device *adev)
  {
    if (!adev)
      return 0;

    if (adev->flags.cca_seen)
      return 1;

    /*
     * Per ACPI 6.0 sec 6.2.17, assume devices can do cache-coherent
     * DMA on "Intel platforms".  Presumably that includes all x86 and
     * ia64, and other arches will set CONFIG_ACPI_CCA_REQUIRED=y.
     */
    if (!IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED))
      return 1;

    return 0;
  }

  int acpi_dma_is_coherent(struct acpi_device *adev)
  {
    if (!acpi_dma_supported(adev))
      return 0;

    return adev->flags.coherent_dma;
  }

  struct platform_device *acpi_create_platform_device(...)
  {
    ...
    if (acpi_dma_supported(adev))
      pdevinfo.dma_mask = DMA_BIT_MASK(32);

  int acpi_bind_one(...)
  {
    ...
    if (acpi_dma_supported(acpi_dev))
      arch_setup_dma_ops(dev, 0, 0, NULL, retval);

  bool device_dma_is_coherent(...)
  {
    ...
    return acpi_dma_is_coherent(ACPI_COMPANION(dev)):

> Also, this patch moves the function into drivers/acpi/scan.c since
> it is easier to follow the logic in the acpi_init_coherency() in the
> same file here.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/acpi/acpi_platform.c |  7 ++++++-
>  drivers/acpi/glue.c          |  6 +++---
>  drivers/acpi/scan.c          | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/base/property.c      | 10 +++++++---
>  include/acpi/acpi_bus.h      | 36 ++----------------------------------
>  include/linux/acpi.h         |  4 ++--
>  6 files changed, 59 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 06a67d5..0b17a78 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -103,7 +103,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>  	pdevinfo.res = resources;
>  	pdevinfo.num_res = count;
>  	pdevinfo.fwnode = acpi_fwnode_handle(adev);
> -	pdevinfo.dma_mask = acpi_check_dma(adev, NULL) ? DMA_BIT_MASK(32) : 0;
> +
> +	if (acpi_check_dma_coherency(adev) < 0)
> +		pdevinfo.dma_mask = 0;
> +	else
> +		pdevinfo.dma_mask = DMA_BIT_MASK(32);
> +
>  	pdev = platform_device_register_full(&pdevinfo);
>  	if (IS_ERR(pdev))
>  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index b9657af..9be7f0f 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -168,7 +168,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	struct list_head *physnode_list;
>  	unsigned int node_id;
>  	int retval = -EINVAL;
> -	bool coherent;
>  
>  	if (has_acpi_companion(dev)) {
>  		if (acpi_dev) {
> @@ -225,8 +224,9 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	if (!has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(dev, acpi_dev);
>  
> -	if (acpi_check_dma(acpi_dev, &coherent))
> -		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
> +	retval = acpi_check_dma_coherency(acpi_dev);
> +	if (retval >= 0)
> +		arch_setup_dma_ops(dev, 0, 0, NULL, retval);
>  
>  	acpi_physnode_link_name(physical_node_name, node_id);
>  	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index ec25635..1d68289 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2182,6 +2182,45 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
>  	kfree(pnp->unique_id);
>  }
>  
> +/**
> + * acpi_check_dma_coherency - Check DMA coherency for the specified device.
> + * @adev: The pointer to acpi device to check coherency attribute
> + *
> + * Return -ENOTSUPP if DMA is not supported. Otherwise, return 1 if the
> + * device support coherent DMA, or 0 for non-coherent DMA.
> + */
> +int acpi_check_dma_coherency(struct acpi_device *adev)
> +{
> +	int ret = -ENOTSUPP;
> +
> +	if (!adev)
> +		return ret;

There's no need for the local "ret".  You can "return -ENOTSUPP" here and
below, which is easier to read than looking back to see where "ret" was
defined and whether it was modified after being initialized.

> +
> +	/**
> +	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
> +	 * This should be equivalent to specifying dma-coherent for
> +	 * a device in OF.
> +	 *
> +	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
> +	 * we have two choices:
> +	 *   1. Do not support and disable DMA.

I know you didn't write this comment, but do we actually *disable* DMA in
the sense of turning off PCI bus mastering or calling an ACPI method that
disables DMA by this device?  I suspect we just don't set up DMA ops and
masks for this device.

> +	 *   2. Support but rely on arch-specific cache maintenance for
> +	 *      non-coherenje DMA operations.

s/Support but/Support DMA but/ ?
s/non-coherenje/non-coherent/

> +	 * Currently, we implement case 2 above.
> +	 *
> +	 * For the case when _CCA is missing (i.e. cca_seen=0) and
> +	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
> +	 * and fallback to arch-specific default handling.
> +	 *
> +	 * See acpi_init_coherency() for more info.
> +	 */
> +	if (!adev->flags.cca_seen && IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED))
> +		return ret;
> +
> +	return adev->flags.coherent_dma;
> +}
> +EXPORT_SYMBOL_GPL(acpi_check_dma_coherency);
> +
>  static void acpi_init_coherency(struct acpi_device *adev)
>  {
>  	unsigned long long cca = 0;
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f3f6d16..cd45dfc 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -525,10 +525,14 @@ bool device_dma_is_coherent(struct device *dev)
>  {
>  	bool coherent = false;
>  
> -	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
> +	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>  		coherent = of_dma_is_coherent(dev->of_node);
> -	else
> -		acpi_check_dma(ACPI_COMPANION(dev), &coherent);
> +	} else {
> +		int ret = acpi_check_dma_coherency(ACPI_COMPANION(dev));
> +
> +		if (ret >= 0)
> +			coherent = ret;
> +	}
>  
>  	return coherent;
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7ecb8e4..baf43ea 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -382,40 +382,6 @@ struct acpi_device {
>  	void (*remove)(struct acpi_device *);
>  };
>  
> -static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
> -{
> -	bool ret = false;
> -
> -	if (!adev)
> -		return ret;
> -
> -	/**
> -	 * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
> -	 * This should be equivalent to specifyig dma-coherent for
> -	 * a device in OF.
> -	 *
> -	 * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
> -	 * There are two cases:
> -	 * case 1. Do not support and disable DMA.
> -	 * case 2. Support but rely on arch-specific cache maintenance for
> -	 *         non-coherence DMA operations.
> -	 * Currently, we implement case 2 above.
> -	 *
> -	 * For the case when _CCA is missing (i.e. cca_seen=0) and
> -	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
> -	 * and fallback to arch-specific default handling.
> -	 *
> -	 * See acpi_init_coherency() for more info.
> -	 */
> -	if (adev->flags.coherent_dma ||
> -	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
> -		ret = true;
> -		if (coherent)
> -			*coherent = adev->flags.coherent_dma;
> -	}
> -	return ret;
> -}
> -
>  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>  {
>  	return fwnode && fwnode->type == FWNODE_ACPI;
> @@ -640,6 +606,8 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  	return adev->power.states[ACPI_STATE_D3_COLD].flags.valid;
>  }
>  
> +int acpi_check_dma_coherency(struct acpi_device *adev);
> +
>  #else	/* CONFIG_ACPI */
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d2445fa..d350c9e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -562,9 +562,9 @@ static inline int acpi_device_modalias(struct device *dev,
>  	return -ENODEV;
>  }
>  
> -static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
> +static inline int acpi_check_dma_coherency(struct acpi_device *adev)
>  {
> -	return false;
> +	return -ENOTSUPP;
>  }
>  
>  #define ACPI_PTR(_ptr)	(NULL)
> -- 
> 2.1.0
> 
