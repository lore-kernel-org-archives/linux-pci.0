Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 2 Nov 2015 12:02:25 +0800
From: Dennis Chen <dennis.chen@arm.com>
To: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com
Cc: hanjun.guo@linaro.org, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jeremy.linton@arm.com, Suravee.Suthikulpanit@amd.com,
	robh+dt@kernel.org
Subject: Re: [PATCH V5 1/9] ACPI: Honor ACPI _CCA attribute setting
Message-ID: <20151102040224.GA16979@arm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 6:50 AM, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:
> From: Jeremy Linton <jeremy.linton@arm.com>
> 
> ACPI configurations can now mark devices as noncoherent,
> support that choice.
> 
> NOTE: This is required to support USB on ARM Juno Development Board.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  include/acpi/acpi_bus.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index d11eff8..0f131d2 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -407,7 +407,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>  	 * case 1. Do not support and disable DMA.
>  	 * case 2. Support but rely on arch-specific cache maintenance for
>  	 *         non-coherence DMA operations.
> -	 * Currently, we implement case 1 above.
> +	 * Currently, we implement case 2 above.
>  	 *
>  	 * For the case when _CCA is missing (i.e. cca_seen=0) and
>  	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
> @@ -415,7 +415,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>  	 *
>  	 * See acpi_init_coherency() for more info.
>  	 */
> -	if (adev->flags.coherent_dma) {
> +	if (adev->flags.coherent_dma ||
> +	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
>  		ret = true;
>  		if (coherent)
>  			*coherent = adev->flags.coherent_dma;

Hi Suravee,

The acpi_check_dma function has been removed in patch 6 of this patch set, why it is still be used
here, am I missing something? If the acpi_check_dma will be used in the future, personally I'd like
to use IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED) while not CONFIG_ARM64 macro here, or since _CCA attribute
is arch-specific, it's reasonable to leave the _CCA handling policy to the arch-specific code. For example,
with a link weak function like acpi_arch_check_dma() as a default handling if no arch-specific code 
provided, the actual _CCA handling will be implemented in the ARM, Intel or other Arch if required.

Thanks,
Dennis

> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

