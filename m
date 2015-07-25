Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36682 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbbGYIM5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2015 04:12:57 -0400
Received: by pachj5 with SMTP id hj5so25411672pac.3
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2015 01:12:56 -0700 (PDT)
Message-ID: <55B34500.50805@linaro.org>
Date: Sat, 25 Jul 2015 16:12:48 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH v5 03/19] device core: Introduce per-device MSI domain
 pointer
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <1437643598-19795-4-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-4-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2015 05:26 PM, Marc Zyngier wrote:
> As MSI-type features are creeping into non-PCI devices, it is
> starting to make sense to give our struct device some form of
> support for this, by allowing a pointer to an MSI irq domain to
> be set/retrieved.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   include/linux/device.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 22227e7..7c49b48 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -714,6 +714,7 @@ struct device_dma_parameters {
>    * @pins:	For device pin management.
>    *		See Documentation/pinctrl.txt for details.
>    * @msi_list:	Hosts MSI descriptors
> + * @msi_domain: The generic MSI domain this device is using.
>    * @numa_node:	NUMA node this device is close to.
>    * @dma_mask:	Dma mask (if dma'ble device).
>    * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
> @@ -774,6 +775,9 @@ struct device {
>   	struct dev_pm_info	power;
>   	struct dev_pm_domain	*pm_domain;
>
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +	struct irq_domain	*msi_domain; /* MSI domain device uses */
> +#endif
>   #ifdef CONFIG_PINCTRL
>   	struct dev_pin_info	*pins;
>   #endif
> @@ -864,6 +868,22 @@ static inline void set_dev_node(struct device *dev, int node)
>   }
>   #endif
>
> +static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
> +{
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +	return dev->msi_domain;
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
> +{
> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> +	dev->msi_domain = d;
> +#endif
> +}
> +
>   static inline void *dev_get_drvdata(const struct device *dev)
>   {
>   	return dev->driver_data;


Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
