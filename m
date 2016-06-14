Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60915 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbcFNSjo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 14:39:44 -0400
Date: Tue, 14 Jun 2016 19:39:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 11/15] drivers: iommu: arm-smmu-v3: add IORT iommu
 configuration
Message-ID: <20160614183939.GL16531@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465306270-27076-12-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465306270-27076-12-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 07, 2016 at 02:31:06PM +0100, Lorenzo Pieralisi wrote:
> In ACPI bases systems, in order to be able to create platform
> devices and initialize them for arm-smmu-v3 components, the IORT
> infrastructure requires ARM SMMU drivers to initialize a set of
> operations that are used by the IORT kernel layer to configure platform
> devices for ARM SMMU components in turn.
> 
> This patch adds the IORT IOMMU configuration for the ARM SMMU v3 kernel
> driver.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iort.h        |  12 +++++-
>  2 files changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 90745a8..7acb6b5 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2687,6 +2687,107 @@ static int __init arm_smmu_of_init(struct device_node *np)
>  }
>  IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
>  
> +#ifdef CONFIG_ACPI
> +static int acpi_smmu_init(struct acpi_iort_node *node)
> +{
> +	iort_smmu_set_ops(node, &arm_smmu_ops, NULL);
> +
> +	return 0;
> +}
> +
> +static void acpi_smmu_register_irq(int hwirq, const char *name,
> +				   struct resource *res)
> +{
> +	int irq = acpi_register_gsi(NULL, hwirq, ACPI_EDGE_SENSITIVE,
> +				    ACPI_ACTIVE_HIGH);
> +
> +	if (irq < 0) {
> +		pr_err("could not register gsi hwirq %d name [%s]\n", hwirq,
> +								      name);
> +		return;
> +	}
> +
> +	res->start = irq;
> +	res->end = irq;
> +	res->flags = IORESOURCE_IRQ;
> +	res->name = name;
> +}
> +
> +static int arm_smmu_count_resources(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +	/* Always present mem resource */
> +	int num_res = 1;
> +
> +	/* Retrieve SMMUv3 specific data */
> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	if (smmu->event_gsiv)
> +		num_res++;
> +
> +	if (smmu->pri_gsiv)
> +		num_res++;
> +
> +	if (smmu->gerr_gsiv)
> +		num_res++;
> +
> +	if (smmu->sync_gsiv)
> +		num_res++;
> +
> +	return num_res;
> +}
> +
> +static void arm_smmu_init_resources(struct resource *res,
> +				    struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +	int num_res = 0;
> +
> +	/* Retrieve SMMUv3 specific data */
> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	res[num_res].start = smmu->base_address;
> +	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].flags = IORESOURCE_MEM;
> +
> +	num_res++;
> +
> +	if (smmu->event_gsiv)
> +		acpi_smmu_register_irq(smmu->event_gsiv, "eventq",
> +				       &res[num_res++]);
> +
> +	if (smmu->pri_gsiv)
> +		acpi_smmu_register_irq(smmu->pri_gsiv, "priq",
> +				       &res[num_res++]);
> +
> +	if (smmu->gerr_gsiv)
> +		acpi_smmu_register_irq(smmu->gerr_gsiv, "gerror",
> +				       &res[num_res++]);
> +
> +	if (smmu->sync_gsiv)
> +		acpi_smmu_register_irq(smmu->sync_gsiv, "cmdq-sync",
> +				       &res[num_res++]);
> +}
> +
> +static bool arm_smmu_is_coherent(struct acpi_iort_node *node)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +
> +	/* Retrieve SMMUv3 specific data */
> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
> +}
> +
> +const struct iort_iommu_config iort_arm_smmu_v3_cfg = {
> +	.name = "arm-smmu-v3",
> +	.iommu_init = acpi_smmu_init,
> +	.iommu_is_coherent = arm_smmu_is_coherent,
> +	.iommu_count_resources = arm_smmu_count_resources,
> +	.iommu_init_resources = arm_smmu_init_resources
> +};
> +#endif
> +
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iort.h b/include/linux/iort.h
> index ced3054..5dcfa09 100644
> --- a/include/linux/iort.h
> +++ b/include/linux/iort.h
> @@ -55,7 +55,17 @@ struct iort_iommu_config {
>  static inline const struct iort_iommu_config *
>  iort_get_iommu_config(struct acpi_iort_node *node)
>  {
> -	return NULL;
> +	switch (node->type) {
> +#if IS_ENABLED(CONFIG_ARM_SMMU_V3)
> +	case ACPI_IORT_NODE_SMMU_V3: {
> +		extern const struct iort_iommu_config iort_arm_smmu_v3_cfg;
> +
> +		return &iort_arm_smmu_v3_cfg;
> +	}
> +#endif

Oh, yuck! I really don't like this mixture of SMMU driver code and IORT
code over two files using a global structure of largely stateless function
pointers.

I think you have two options:

  (1) Move this all into iort.c (my preference)
  (2) Introduce something like SMMU_ACPI_DECLARE which allows drivers to
      register a callback if they're matched in the IORT.

that at least keeps internal data in one place, rather than spreading it
around.

Cheers,

Will
