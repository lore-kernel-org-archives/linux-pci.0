Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40612 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbbG3Neh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Jul 2015 09:34:37 -0400
Date: Thu, 30 Jul 2015 14:35:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150730133521.GA12999@red-moon>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 04:28:00PM +0100, Jayachandran C wrote:
> The current code in pci-host-generic.c uses pci_common_init_dev()
> from ARM platform to do some of the PCI initializations, and this
> prevents it from being used in ARM64.
> 
> The initialization done by pci_common_init_dev() that is needed
> by pci-host-generic.c is really limited, and can be done easily
> in the same file without using hw_pci API. The ARM platform
> requires a pci_sys_data as sysdata for the PCI bus, this can be
> handled by setting up gen_pci to have a pci_sys_data variable as
> the first element.

For the sake of enabling it on ARM64, I am okay with getting
this merged, keeping in mind that as I already said pci_sys_data
has to go, it is a hack and I do not want it to spread to
ALL PCI host drivers that have to work on both ARM/ARM64.

Comments and tags below.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> Here's v3 of the patchset.
> 
> v2-v3
>  - rebase to 4.2-rc
>  - fix PCI_PROBE_ONLY check before calling pcie configure
>  - added a comment above sysdata
>  - updated the commit message
> 
> v1->v2
>  - Address comments from Arnd Bergmann and Lorenzo Pieralisi
>     - move contents of gen_pci_init to gen_pci_probe
>     - assign resources only when !probe_only
>  - tested on ARM32 with qemu option -M virt
> 
> Notes:
>  - passing a zeroed out pci_sys_data for ARM looks ok, but I haven't
>    tested it on ARM.
>  - tested it on ARM64 fast model
>  - Any information on how this can be tested on arm is welcome.
>  - There is only one ifdef, and that can be removed when arm64 gets
>    a sysdata, or when arm loses its sysdata.
> 
>  drivers/pci/host/pci-host-generic.c | 55 ++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> index ba46e58..e9d9c80 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -38,7 +38,15 @@ struct gen_pci_cfg_windows {
>  	const struct gen_pci_cfg_bus_ops	*ops;
>  };
>  
> +/*
> + * ARM needs platform specific pci_sys_data as the sysdata for PCI.
> + * We add the sys as the first field below to handle this. sys will
> + * set to 0, so that the pci functions in do the right thing.
> + */
>  struct gen_pci {
> +#ifdef CONFIG_ARM
> +	struct pci_sys_data			sys;
> +#endif
>  	struct pci_host_bridge			host;
>  	struct gen_pci_cfg_windows		cfg;
>  	struct list_head			resources;
> @@ -48,8 +56,7 @@ static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
>  					     unsigned int devfn,
>  					     int where)
>  {
> -	struct pci_sys_data *sys = bus->sysdata;
> -	struct gen_pci *pci = sys->private_data;
> +	struct gen_pci *pci = bus->sysdata;
>  	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
>  
>  	return pci->cfg.win[idx] + ((devfn << 8) | where);
> @@ -64,8 +71,7 @@ static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
>  					      unsigned int devfn,
>  					      int where)
>  {
> -	struct pci_sys_data *sys = bus->sysdata;
> -	struct gen_pci *pci = sys->private_data;
> +	struct gen_pci *pci = bus->sysdata;
>  	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
>  
>  	return pci->cfg.win[idx] + ((devfn << 12) | where);
> @@ -198,13 +204,6 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	return 0;
>  }
>  
> -static int gen_pci_setup(int nr, struct pci_sys_data *sys)
> -{
> -	struct gen_pci *pci = sys->private_data;
> -	list_splice_init(&pci->resources, &sys->resources);
> -	return 1;
> -}
> -
>  static int gen_pci_probe(struct platform_device *pdev)
>  {
>  	int err;
> @@ -214,13 +213,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> -	struct hw_pci hw = {
> -		.nr_controllers	= 1,
> -		.private_data	= (void **)&pci,
> -		.setup		= gen_pci_setup,
> -		.map_irq	= of_irq_parse_and_map_pci,
> -		.ops		= &gen_pci_ops,
> -	};
> +	struct pci_bus *bus;
>  
>  	if (!pci)
>  		return -ENOMEM;
> @@ -258,7 +251,31 @@ static int gen_pci_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	pci_common_init_dev(dev, &hw);
> +	/* do not reassign resource if probe only */
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_add_flags(PCI_REASSIGN_ALL_RSRC);

You should add PCI_REASSIGN_ALL_BUS here. As I said in patch 2 comment,
please enable setup-irq.c in an explicit commit, re-sequence the
series and fold the Kconfig ARM64 enablement in this patch.

With those changes, for the patch series:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> +
> +	bus = pci_scan_root_bus(dev, 0, &gen_pci_ops, pci, &pci->resources);
> +	if (!bus) {
> +		dev_err(dev, "Scanning rootbus failed");
> +		return -ENODEV;
> +	}
> +
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +
> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +	}
> +	pci_bus_add_devices(bus);
> +
> +	/* Configure PCI Express settings */
> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		struct pci_bus *child;
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
> +	}
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
