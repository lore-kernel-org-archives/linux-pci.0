Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 Nov 2016 15:55:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 11/16] drivers: iommu: arm-smmu-v3: add IORT
 configuration
Message-ID: <20161118155543.GV13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-12-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20161116152936.22955-12-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, Eric Auger <eric.auger@redhat.com>,
 iommu@lists.linux-foundation.org, Hanjun Guo <hanjun.guo@linaro.org>,
 Jon Masters <jcm@redhat.com>, Dennis Chen <dennis.chen@arm.com>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 16, 2016 at 03:29:31PM +0000, Lorenzo Pieralisi wrote:
> In ACPI bases systems, in order to be able to create platform
> devices and initialize them for ARM SMMU v3 components, the IORT
> kernel implementation requires a set of static functions to be
> used by the IORT kernel layer to configure platform devices for
> ARM SMMU v3 components.
> 
> Add static configuration functions to the IORT kernel layer for
> the ARM SMMU v3 components, so that the ARM SMMU v3 driver can
> initialize its respective platform device by relying on the IORT
> kernel infrastructure and by adding a corresponding ACPI device
> early probe section entry.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/acpi/arm64/iort.c   | 103 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/arm-smmu-v3.c |  49 ++++++++++++++++++++-
>  2 files changed, 150 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ed563307..9315bf3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -20,6 +20,8 @@
>   * This driver is powered by bad coffee and bombay mix.
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/err.h>
> @@ -2559,6 +2561,36 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +				      struct arm_smmu_device *smmu,
> +				      bool *bypass)
> +{
> +	struct acpi_iort_smmu_v3 *iort_smmu;
> +	struct device *dev = smmu->dev;
> +	struct acpi_iort_node *node;
> +
> +	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
> +
> +	/* Retrieve SMMUv3 specific data */
> +	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
> +		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> +
> +	*bypass = false;
> +
> +	return 0;
> +}
> +#else
> +static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +					     struct arm_smmu_device *smmu,
> +					     bool *bypass)
> +{
> +	return -ENODEV;
> +}
> +#endif

Same bypass comments as before, but you'll probably need to do something
so that you *can* abort the probe if !ACPI, perhaps by allocating two
error codes to distinguish the "I no nothing about this SMMU" from "I know
enough to put it into bypass, but nothing more".

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
