Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 19 Sep 2016 13:09:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
        dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
Message-ID: <20160919180900.GB13775@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-4-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473449047-10499-4-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 09, 2016 at 09:24:05PM +0200, Tomasz Nowicki wrote:
> thunder-pem driver stands for being ACPI based PCI host controller.
> However, there is no standard way to describe its PEM-specific register
> ranges in ACPI tables. Thus we add thunder_pem_init() ACPI extension
> to obtain hardcoded addresses from static resource array.
> Although it is not pretty, it prevents from creating standard mechanism to
> handle similar cases in future.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/pci/host/pci-thunder-pem.c | 61 ++++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index 6abaf80..b048761 100644
> --- a/drivers/pci/host/pci-thunder-pem.c
> +++ b/drivers/pci/host/pci-thunder-pem.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  
> @@ -284,6 +285,40 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
>  	return pci_generic_config_write(bus, devfn, where, size, val);
>  }
>  
> +#ifdef CONFIG_ACPI
> +static struct resource thunder_pem_reg_res[] = {
> +	[4] = DEFINE_RES_MEM(0x87e0c0000000UL, SZ_16M),
> +	[5] = DEFINE_RES_MEM(0x87e0c1000000UL, SZ_16M),
> +	[6] = DEFINE_RES_MEM(0x87e0c2000000UL, SZ_16M),
> +	[7] = DEFINE_RES_MEM(0x87e0c3000000UL, SZ_16M),
> +	[8] = DEFINE_RES_MEM(0x87e0c4000000UL, SZ_16M),
> +	[9] = DEFINE_RES_MEM(0x87e0c5000000UL, SZ_16M),
> +	[14] = DEFINE_RES_MEM(0x97e0c0000000UL, SZ_16M),
> +	[15] = DEFINE_RES_MEM(0x97e0c1000000UL, SZ_16M),
> +	[16] = DEFINE_RES_MEM(0x97e0c2000000UL, SZ_16M),
> +	[17] = DEFINE_RES_MEM(0x97e0c3000000UL, SZ_16M),
> +	[18] = DEFINE_RES_MEM(0x97e0c4000000UL, SZ_16M),
> +	[19] = DEFINE_RES_MEM(0x97e0c5000000UL, SZ_16M),

1) The "correct" way to discover the resources consumed by an ACPI
   device is to use the _CRS method.  I know there are some issues
   there for bridges (not the fault of ThunderX!) because there's not
   a good way to distinguish windows from resources consumed directly
   by the bridge.

   But we should either do this correctly, or include a comment about
   why we're doing it wrong, so we don't give the impression that this
   is the right way to do it.

   I seem to recall some discussion about why we're doing it this way,
   but I don't remember the details.  It'd be nice to include a
   summary here.

2) This is a little weird because here we define the resource size as
   16MB, in the OF case we get the resource size from OF, in either
   case we ioremap 64K of it, and then as far as I can tell, we only
   ever access PEM_CFG_WR and PEM_CFG_RD, at offsets 0x28 and 0x30
   into the space.

   If the hardware actually decodes the entire 16MB, we should ioremap
   the whole 16MB.  (Strictly speaking, drivers only need to ioremap
   the parts they're using, but in this case nobody claims the entire
   resource because of deficiencies in the ACPI and OF cores, so the
   driver should ioremap the entire thing to help prevent conflicts
   with other devices.)

   It'd be nice if we didn't have the 64KB magic number.  I think
   using devm_ioremap_resource() would be nice.

> +};
> +
> +static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
> +{
> +	struct acpi_device *adev = to_acpi_device(cfg->parent);
> +	struct acpi_pci_root *root = acpi_driver_data(adev);
> +
> +	if ((root->segment >= 4 && root->segment <= 9) ||
> +	    (root->segment >= 14 && root->segment <= 19))
> +		return &thunder_pem_reg_res[root->segment];
> +
> +	return NULL;
> +}
> +#else
> +static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int thunder_pem_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -292,24 +327,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
>  	struct thunder_pem_pci *pem_pci;
>  	struct platform_device *pdev;
>  
> -	/* Only OF support for now */
> -	if (!dev->of_node)
> -		return -EINVAL;
> -
>  	pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
>  	if (!pem_pci)
>  		return -ENOMEM;
>  
> -	pdev = to_platform_device(dev);
> -
> -	/*
> -	 * The second register range is the PEM bridge to the PCIe
> -	 * bus.  It has a different config access method than those
> -	 * devices behind the bridge.
> -	 */
> -	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (acpi_disabled) {
> +		pdev = to_platform_device(dev);
> +
> +		/*
> +		 * The second register range is the PEM bridge to the PCIe
> +		 * bus.  It has a different config access method than those
> +		 * devices behind the bridge.
> +		 */
> +		res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	} else {
> +		res_pem = thunder_pem_acpi_res(cfg);
> +	}
>  	if (!res_pem) {
> -		dev_err(dev, "missing \"reg[1]\"property\n");
> +		dev_err(dev, "missing configuration region\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 1.9.1
> 
