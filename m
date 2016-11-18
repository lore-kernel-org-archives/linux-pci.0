Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 Nov 2016 16:08:09 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 13/16] drivers: iommu: arm-smmu: add IORT configuration
Message-ID: <20161118160808.GX13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-14-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20161116152936.22955-14-lorenzo.pieralisi@arm.com>
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

On Wed, Nov 16, 2016 at 03:29:33PM +0000, Lorenzo Pieralisi wrote:
> In ACPI bases systems, in order to be able to create platform
> devices and initialize them for ARM SMMU components, the IORT
> kernel implementation requires a set of static functions to be
> used by the IORT kernel layer to configure platform devices for
> ARM SMMU components.
> 
> Add static configuration functions to the IORT kernel layer for
> the ARM SMMU components, so that the ARM SMMU driver can
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
>  drivers/acpi/arm64/iort.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi_iort.h |  3 ++
>  3 files changed, 166 insertions(+), 1 deletion(-)

[...]

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 573b2b6..21d1892 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -28,6 +28,8 @@
>  
>  #define pr_fmt(fmt) "arm-smmu: " fmt
>  
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
> @@ -1904,6 +1906,70 @@ static const struct of_device_id arm_smmu_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>  
> +#ifdef CONFIG_ACPI
> +static int acpi_smmu_get_data(u32 model, u32 *version, u32 *impl)

You should use the enum type for the version, rather than a u32.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
