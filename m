Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53075 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423010AbbD2Me2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 08:34:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
Date: Wed, 29 Apr 2015 14:34:20 +0200
Message-ID: <6662179.AoBfCMOsxD@wuerfel>
In-Reply-To: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 29 April 2015 17:09:58 Jayachandran C wrote:
> The current code in pci-host-generic.c uses pci_common_init_dev()
> from the arch/arm/ to do a part of the PCI initialization, and this
> prevents it from being used on arm64.
> 
> The initialization done by pci_common_init_dev() that is really
> needed by pci-host-generic.c can be done in the same file without
> using the hw_pci API of ARM.
> 
> The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> this is be handled by setting up 'struct gen_pci' to embed a
> pci_sys_data variable as the first element on the ARM platform.
> 
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

This seems very useful

>  
> -static int gen_pci_setup(int nr, struct pci_sys_data *sys)
> +static int gen_pci_init(struct device *dev, struct gen_pci *pci)
>  {
> -	struct gen_pci *pci = sys->private_data;
> -	list_splice_init(&pci->resources, &sys->resources);
> -	return 1;
> +	struct pci_bus *bus;
> +
> +	pci_add_flags(PCI_REASSIGN_ALL_RSRC);

Do we want to set that flag unconditionally? At least for servers,
the resources should get assigned by firmware, and things might
go wrong if Linux tries to reassign them. This is probably the
case on kvmtool as well.

> +	bus = pci_scan_root_bus(dev, 0, &gen_pci_ops, pci, &pci->resources);
> +	if (!bus) {
> +		dev_err(dev, "Scanning rootbus failed");
> +		return -ENODEV;
> +	}
> +	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);

I thought this was done by default now. If it is not, can
we make the of_irq swizzling the default?

> +	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +	}
> +	pci_bus_add_devices(bus);
> +
> +	/* Configure PCI Express settings */
> +	if (pci_has_flag(PCI_PROBE_ONLY)) {
> +		struct pci_bus *child;
> +
> +		list_for_each_entry(child, &bus->children, node)
> +			pcie_bus_configure_settings(child);
> +	}
> +	return 0;
>  }

We should also try to come up wtih a way to make that
pcie_bus_configure_settings() automatic if it's required here.

>  static int gen_pci_probe(struct platform_device *pdev)
> @@ -214,13 +237,6 @@ static int gen_pci_probe(struct platform_device *pdev)
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
>  
>  	if (!pci)
>  		return -ENOMEM;
> @@ -258,8 +274,7 @@ static int gen_pci_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	pci_common_init_dev(dev, &hw);
> -	return 0;
> +	return gen_pci_init(dev, pci);

How about moving the new code right into the probe() function?

	Arnd
