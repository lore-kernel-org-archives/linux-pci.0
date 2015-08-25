Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: bhelgaas@google.com, lenb@kernel.org, catalin.marinas@arm.com,
	will.deacon@arm.com, hanjun.guo@linaro.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 2/4] ACPI/scan: Clean up acpi_check_dma
Date: Wed, 26 Aug 2015 01:48:10 +0200
Message-ID: <1659571.paO1iYcMuM@vostro.rjw.lan>
In-Reply-To: <1440524009-5359-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1440524009-5359-3-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 26, 2015 12:33:27 AM Suravee Suthikulpanit wrote:
> The original name of acpi_check_dma() function does not clearly tell what
> exactly it is checking. Also, returning two boolean values (one to indicate
> device is DMA capability, and the other to inidicate device coherency
> attribute) can be confusing.
> 
> So, in order to simplify the function, this patch renames acpi_check_dma()
> to acpi_check_dma_coherency() to clearly indicate the purpose of this
> function, and only returns an integer where -1 means DMA not supported,
> 1 means coherent DMA, and 0 means non-coherent DMA.
> 
> Also, this patch moves the function into drivers/acpi/scan.c since
> it is easier to follow the logic in the acpi_init_coherency() in the
> same file here.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  drivers/acpi/acpi_platform.c |  7 ++++++-
>  drivers/acpi/glue.c          |  5 +++--
>  drivers/acpi/scan.c          | 39 +++++++++++++++++++++++++++++++++++++++
>  drivers/base/property.c      |  8 ++++++--
>  include/acpi/acpi_bus.h      | 36 ++----------------------------------
>  include/linux/acpi.h         |  4 ++--
>  6 files changed, 58 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 06a67d5..2261e85 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -103,7 +103,12 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev)
>  	pdevinfo.res = resources;
>  	pdevinfo.num_res = count;
>  	pdevinfo.fwnode = acpi_fwnode_handle(adev);
> -	pdevinfo.dma_mask = acpi_check_dma(adev, NULL) ? DMA_BIT_MASK(32) : 0;
> +
> +	if (-1 != acpi_check_dma_coherency(adev))
> +		pdevinfo.dma_mask = DMA_BIT_MASK(32);
> +	else
> +		pdevinfo.dma_mask = 0;
> +
>  	pdev = platform_device_register_full(&pdevinfo);
>  	if (IS_ERR(pdev))
>  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index b9657af..55cf916 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -168,7 +168,7 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	struct list_head *physnode_list;
>  	unsigned int node_id;
>  	int retval = -EINVAL;
> -	bool coherent;
> +	int coherent;

enum, anyone?  With clearly defined values?


>  
>  	if (has_acpi_companion(dev)) {
>  		if (acpi_dev) {
> @@ -225,7 +225,8 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>  	if (!has_acpi_companion(dev))
>  		ACPI_COMPANION_SET(dev, acpi_dev);
>  
> -	if (acpi_check_dma(acpi_dev, &coherent))
> +	coherent = acpi_check_dma_coherency(acpi_dev);
> +	if (coherent != -1)

Like here I'm not sure why -1 is special?


>  		arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>  
>  	acpi_physnode_link_name(physical_node_name, node_id);

Thanks,
Rafael

