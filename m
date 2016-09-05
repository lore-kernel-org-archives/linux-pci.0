Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4 01/15] drivers: iommu: add FWNODE_IOMMU fwnode type
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-2-git-send-email-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <448e5f36-3cfe-73e6-04da-b390ce078f22@linaro.org>
Date: Mon, 5 Sep 2016 19:11:18 +0800
MIME-Version: 1.0
In-Reply-To: <1471274620-20754-2-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <marc.zyngier@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-acpi@vger.kernel.org, Nate Watterson <nwatters@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>, Dennis Chen <dennis.chen@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/8/15 23:23, Lorenzo Pieralisi wrote:
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
>  };
>
>  struct fwnode_handle {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a35fb8b..6f703cb 100644
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
> +	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_ATOMIC);
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
>

This is the similar mechanism as FWNODE_IRQCHIP as mentioned in
change log,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
