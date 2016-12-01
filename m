Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 Nov 2016 18:28:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Message-ID: <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1479201298-25494-2-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
 liudongdong3@huawei.com, msalter@redhat.com, arnd@arndb.de, jcm@redhat.com,
 Christopher Covington <cov@codeaurora.org>, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tomasz,

On Tue, Nov 15, 2016 at 10:14:57AM +0100, Tomasz Nowicki wrote:
> ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
> compliant with ECAM standard. It uses non-standard configuration space
> accessors (see pci_thunder_pem_ops) and custom configuration space granulation
> (see bus_shift = 24). In order to access configuration space and
> probe PEM as ACPI based PCI host controller we need to add MCFG quirk
> infrastructure. This involves:
> 1. thunder_pem_init() ACPI extension so that we can probe PEM-specific
>    register ranges analogously to DT
> 2. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
>    code.
> 3. New quirk entries for each PEM segment. Each contains platform IDs,
>    mentioned pci_thunder_pem_ops and CFG resources.
> 
> Quirk is considered for ThunderX silicon pass2.x only which is identified
> via MCFG revision 1.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/pci_mcfg.c            |  20 +++++++
>  drivers/pci/host/pci-thunder-pem.c | 107 ++++++++++++++++++++++++++++++++-----
>  include/linux/pci-ecam.h           |   4 ++
>  3 files changed, 117 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index ac21db3..e4e2b9b 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -57,6 +57,26 @@ static struct mcfg_fixup mcfg_quirks[] = {
>  	{ "QCOM  ", "QDF2432 ", 1, 5, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 6, MCFG_BUS_ANY, &pci_32b_ops },
>  	{ "QCOM  ", "QDF2432 ", 1, 7, MCFG_BUS_ANY, &pci_32b_ops },
> +#ifdef CONFIG_PCI_HOST_THUNDER_PEM
> +#define THUNDER_MCFG_RES(addr, node) \
> +	DEFINE_RES_MEM(addr + (node << 44), 0x39 * SZ_16M)
> +#define THUNDER_MCFG_QUIRK(rev, node) \
> +	{ "CAVIUM", "THUNDERX", rev, 4 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88001f000000UL, node) }, \
> +	{ "CAVIUM", "THUNDERX", rev, 5 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x884057000000UL, node) }, \
> +	{ "CAVIUM", "THUNDERX", rev, 6 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x88808f000000UL, node) }, \
> +	{ "CAVIUM", "THUNDERX", rev, 7 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89001f000000UL, node) }, \
> +	{ "CAVIUM", "THUNDERX", rev, 8 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x894057000000UL, node) }, \
> +	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * node), MCFG_BUS_ANY, \
> +	  &pci_thunder_pem_ops, THUNDER_MCFG_RES(0x89808f000000UL, node) }
> +	/* SoC pass2.x */
> +	THUNDER_MCFG_QUIRK(1, 0UL),
> +	THUNDER_MCFG_QUIRK(1, 1UL),
> +#endif

I want all these quirks to work without having to enable
device-specific config options like CONFIG_PCI_HOST_THUNDER_PEM.

I tweaked the preceding MCFG quirk support to wrap it in
CONFIG_PCI_QUIRKS.  I also tweaked the qualcomm and hisi patches to
move the meat of them to pci/quirks.c.  My work-in-progress is on
pci/ecam, but I can't easily build for arm64, so there are likely some
issues to be resolved.

I'm hoping to end up with something like this:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469

The problem with ThunderX is that the config accessors are much bigger
and I don't really want to duplicate them in both pci/quirks.c and
pci-thunder-pem.c.

Actually, that raises a question for qualcomm and hisi: in the DT
model, we use non-ECAM config accessors in the driver, but in the ACPI
model, we use ECAM accessors.  It seems like the accessors should be
the same regardless of whether we discover the bridge via DT or ACPI.

Anyway, it's almost like we want to build pci-thunder-pem.o if
CONFIG_PCI_HOST_THUNDER_PEM || (CONFIG_PCI_QUIRKS && CONFIG_ARM64).
I don't know how to express that nicely.

I was trying to avoid adding an ecam-quirks.c, but maybe we need to
add it and collect all the different accessors there and add #ifdefs
inside.

Sorry, this is only half-baked, but I just wanted to throw this out in
case you have any ideas.

>  };
>  
>  static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
> diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
> index 6abaf80..7bdc4cd 100644
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
> @@ -284,6 +285,84 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
>  	return pci_generic_config_write(bus, devfn, where, size, val);
>  }
>  
> +#ifdef CONFIG_ACPI
> +
> +/*
> + * Retrieve PEM bridge register base and size from PNP0C02 sub-device under
> + * the RC.
> + *
> + * Device (RES0)
> + * {
> + *	Name (_HID, "THRX0002")
> + *	Name (_CID, "PNP0C02")
> + *	Name (_CRS, ResourceTemplate () {
> + *		// Device specific registers range
> + *		QWordMemory(ResourceConsumer, PosDecode, MinFixed,
> + *		MaxFixed, Cacheable, ReadWrite, 0,
> + *		0x87e0c2000000, 0x87E0C2FFFFFF, 0, 0x1000000)
> + *	})
> + * }
> + */
> +
> +static const struct acpi_device_id thunder_pem_reg_ids[] = {
> +	{"THRX0002", 0},
> +	{"", 0},
> +};
> +
> +static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	struct acpi_device *child_adev;
> +	struct resource *res_pem;
> +
> +	res_pem = devm_kzalloc(dev, sizeof(*res_pem), GFP_KERNEL);
> +	if (!res_pem) {
> +		dev_err(dev, "failed to allocate PEM resource\n");
> +		return NULL;
> +	}
> +
> +	list_for_each_entry(child_adev, &adev->children, node) {
> +		struct resource_entry *entry;
> +		struct list_head list;
> +		unsigned long flags;
> +		int ret;
> +
> +		ret = acpi_match_device_ids(child_adev, thunder_pem_reg_ids);
> +		if (ret)
> +			continue;
> +
> +		INIT_LIST_HEAD(&list);
> +		flags = IORESOURCE_MEM;
> +		ret = acpi_dev_get_resources(child_adev, &list,
> +					     acpi_dev_filter_resource_type_cb,
> +					     (void *)flags);
> +		if (ret < 0) {
> +			dev_err(&child_adev->dev,
> +				"failed to parse _CRS method, error code %d\n",
> +				ret);
> +			return NULL;
> +		} else if (ret == 0) {
> +			dev_err(&child_adev->dev,
> +				"no memory resources present in _CRS\n");
> +			return NULL;
> +		}
> +
> +		entry = list_first_entry(&list, struct resource_entry, node);
> +		*res_pem = *entry->res;
> +		acpi_dev_free_resource_list(&list);
> +		return res_pem;
> +	}
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
> @@ -292,24 +371,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
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
> @@ -332,7 +411,7 @@ static int thunder_pem_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -static struct pci_ecam_ops pci_thunder_pem_ops = {
> +struct pci_ecam_ops pci_thunder_pem_ops = {
>  	.bus_shift	= 24,
>  	.init		= thunder_pem_init,
>  	.pci_ops	= {
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index f5740b7..3f2a98f 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -58,6 +58,10 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
>  			       int where);
>  /* default ECAM ops */
>  extern struct pci_ecam_ops pci_generic_ecam_ops;
> +/* ECAM ops for known quirks */
> +#ifdef CONFIG_PCI_HOST_THUNDER_PEM
> +extern struct pci_ecam_ops pci_thunder_pem_ops;
> +#endif
>  
>  /* ops for buggy ECAM that supports only 32-bit accesses */
>  extern struct pci_ecam_ops pci_32b_ops;
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
