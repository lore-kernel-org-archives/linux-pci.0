Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57858 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457AbcEDXOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 May 2016 19:14:23 -0400
Date: Wed, 4 May 2016 18:14:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: catalin.marinas@arm.com, linux-pci@vger.kernel.org,
	will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>, ddaney@caviumnetworks.com,
	robert.richter@caviumnetworks.com, msalter@redhat.com,
	Liviu.Dudau@arm.com, jchandra@broadcom.com,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/3] [RFC] pci: host-common: use new pci_register_host
 interface
Message-ID: <20160504231418.GE3117@localhost>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de>
 <1461970899-4150603-3-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461970899-4150603-3-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 30, 2016 at 01:01:38AM +0200, Arnd Bergmann wrote:
> This changes the pci-host-common implementation to call the
> new pci_register_host() interface instead of pci_scan_root_bus().
> 
> As a result, we get to share the pci_host_bridge structure
> as it was originally intended anyway: We ended up having two
> copies of pci_host_bridge here because we never got it done
> until now. We can also remove the now unused "resources"
> list_head, as we add the resources to the pci_host_bridge
> directly.
> 
> On top of this, further generalizations are possible to shrink
> the pci-host-common.c file, in particular requesting the
> resources and scanning for child devices can be moved
> into pci_register_host().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/host/pci-host-common.c | 38 ++++++++++++++++++++++++--------------
>  drivers/pci/host/pci-host-common.h |  1 -
>  2 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
> index e9f850f07968..3fc529f0297e 100644
> --- a/drivers/pci/host/pci-host-common.c
> +++ b/drivers/pci/host/pci-host-common.c
> @@ -26,7 +26,7 @@
>  
>  static void gen_pci_release_of_pci_ranges(struct gen_pci *pci)
>  {
> -	pci_free_resource_list(&pci->resources);
> +	pci_free_resource_list(&pci->host.windows);
>  }
>  
>  static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
> @@ -37,12 +37,12 @@ static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
>  	resource_size_t iobase;
>  	struct resource_entry *win;
>  
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> +	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->host.windows,
>  					       &iobase);
>  	if (err)
>  		return err;
>  
> -	resource_list_for_each_entry(win, &pci->resources) {
> +	resource_list_for_each_entry(win, &pci->host.windows) {
>  		struct resource *parent, *res = win->res;
>  
>  		switch (resource_type(res)) {
> @@ -130,6 +130,14 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>  	return 0;
>  }
>  
> +static void gen_pci_release(struct device *dev)
> +{
> +	struct gen_pci *pci = container_of(dev, struct gen_pci, host.dev);
> +
> +	gen_pci_release_of_pci_ranges(pci);
> +	kfree(pci);
> +}

I don't really like the fact that the alloc of struct gen_pci is so
far away from the free.  I haven't looked hard enough to figure out if
it's reasonable to put them closer.

>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct gen_pci *pci)
>  {
> @@ -137,7 +145,7 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	const char *type;
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct pci_bus *bus, *child;
> +	struct pci_bus *child;
>  
>  	type = of_get_property(np, "device_type", NULL);
>  	if (!type || strcmp(type, "pci")) {
> @@ -148,8 +156,8 @@ int pci_host_common_probe(struct platform_device *pdev,
>  	of_pci_check_probe_only();
>  
>  	pci->host.dev.parent = dev;
> +	pci->host.dev.release = gen_pci_release;
>  	INIT_LIST_HEAD(&pci->host.windows);
> -	INIT_LIST_HEAD(&pci->resources);
>  
>  	/* Parse our PCI ranges and request their resources */
>  	err = gen_pci_parse_request_of_pci_ranges(pci);
> @@ -168,24 +176,26 @@ int pci_host_common_probe(struct platform_device *pdev,
>  		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
>  
>  
> -	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
> -				&pci->cfg.ops->ops, pci, &pci->resources);
> -	if (!bus) {
> -		dev_err(dev, "Scanning rootbus failed");
> -		return -ENODEV;
> +	pci->host.ops = &pci->cfg.ops->ops;
> +	pci->host.sysdata = pci;
> +	pci->host.busnr = pci->cfg.bus_range->start;
> +	err = pci_register_host(&pci->host);
> +	if (!err) {
> +		dev_err(dev, "registering host failed");
> +		return err;
>  	}

Where do we actually scan the bus here?  I don't see it in
pci_register_host().

>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  
>  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> -		pci_bus_size_bridges(bus);
> -		pci_bus_assign_resources(bus);
> +		pci_bus_size_bridges(pci->host.bus);
> +		pci_bus_assign_resources(pci->host.bus);
>  
> -		list_for_each_entry(child, &bus->children, node)
> +		list_for_each_entry(child, &pci->host.bus->children, node)
>  			pcie_bus_configure_settings(child);
>  	}
>  
> -	pci_bus_add_devices(bus);
> +	pci_bus_add_devices(pci->host.bus);
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/host/pci-host-common.h b/drivers/pci/host/pci-host-common.h
> index 09f3fa0a55d7..c89a756420ee 100644
> --- a/drivers/pci/host/pci-host-common.h
> +++ b/drivers/pci/host/pci-host-common.h
> @@ -38,7 +38,6 @@ struct gen_pci_cfg_windows {
>  struct gen_pci {
>  	struct pci_host_bridge			host;
>  	struct gen_pci_cfg_windows		cfg;
> -	struct list_head			resources;
>  };
>  
>  int pci_host_common_probe(struct platform_device *pdev,
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
