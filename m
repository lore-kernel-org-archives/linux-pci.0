Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754503AbcI2OOz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Sep 2016 10:14:55 -0400
Date: Thu, 29 Sep 2016 15:15:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org, rjw@rjwysocki.net
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 01/14] drivers: iommu: add FWNODE_IOMMU fwnode type
Message-ID: <20160929141520.GA29244@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-2-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160909142343.13314-2-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael,

On Fri, Sep 09, 2016 at 03:23:30PM +0100, Lorenzo Pieralisi wrote:
> On systems booting with a device tree, every struct device is
> associated with a struct device_node, that represents its DT
> representation. The device node can be used in generic kernel
> contexts (eg IRQ translation, IOMMU streamid mapping), to
> retrieve the properties associated with the device and carry
> out kernel operation accordingly. Owing to the 1:1 relationship
> between the device and its device_node, the device_node can also
> be used as a look-up token for the device (eg looking up a device
> through its device_node), to retrieve the device in kernel paths
> where the device_node is available.
> 
> On systems booting with ACPI, the same abstraction provided by
> the device_node is required to provide look-up functionality.
> 
> Therefore, mirroring the approach implemented in the IRQ domain
> kernel layer, this patch adds an additional fwnode type FWNODE_IOMMU.
> 
> This patch also implements a glue kernel layer that allows to
> allocate/free FWNODE_IOMMU fwnode_handle structures and associate
> them with IOMMU devices.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  include/linux/fwnode.h |  1 +
>  include/linux/iommu.h  | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 8516717..6e10050 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -19,6 +19,7 @@ enum fwnode_type {
>  	FWNODE_ACPI_DATA,
>  	FWNODE_PDATA,
>  	FWNODE_IRQCHIP,
> +	FWNODE_IOMMU,

This patch provides groundwork for this series and it is key for
the rest of it, basically the point here is that we need a fwnode
to differentiate platform devices created out of static ACPI tables
entries (ie IORT), that represent IOMMU components.

The corresponding device is not an ACPI device (I could fabricate one as
it is done for other static tables entries eg FADT power button, but I
do not necessarily see the reason for doing that given that all we need
the fwnode for is a token identifier), so FWNODE_ACPI does not apply
here.

Please let me know if it is reasonable how I sorted this out (it
is basically identical to IRQCHIP, just another enum entry), the
remainder of the code depends on this.

Thanks !
Lorenzo

>  };
>  
>  struct fwnode_handle {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a35fb8b..6456528 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -38,6 +38,7 @@ struct bus_type;
>  struct device;
>  struct iommu_domain;
>  struct notifier_block;
> +struct fwnode_handle;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -543,4 +544,28 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
>  
>  #endif /* CONFIG_IOMMU_API */
>  
> +/* IOMMU fwnode handling */
> +static inline bool is_fwnode_iommu(struct fwnode_handle *fwnode)
> +{
> +	return fwnode && fwnode->type == FWNODE_IOMMU;
> +}
> +
> +static inline struct fwnode_handle *iommu_alloc_fwnode(void)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_KERNEL);
> +	fwnode->type = FWNODE_IOMMU;
> +
> +	return fwnode;
> +}
> +
> +static inline void iommu_free_fwnode(struct fwnode_handle *fwnode)
> +{
> +	if (WARN_ON(!is_fwnode_iommu(fwnode)))
> +		return;
> +
> +	kfree(fwnode);
> +}
> +
>  #endif /* __LINUX_IOMMU_H */
> -- 
> 2.10.0
> 
