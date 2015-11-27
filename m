Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Hans de Bruin <jmdebruin@xmsnet.nl>
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Date: Fri, 27 Nov 2015 17:06:01 +0100
Message-ID: <8206751.4eTpiUuo7l@vostro.rjw.lan>
In-Reply-To: <1448593953-12364-1-git-send-email-jiang.liu@linux.intel.com>
References: <5655B392.7070701@intel.com> <1448593953-12364-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 27, 2015 11:12:33 AM Jiang Liu wrote:
> From: Liu Jiang <jiang.liu@linux.intel.com>
> 
> Commit 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support
> PCI host bridge") converted x86 to use the common interface
> acpi_pci_root_create, but the conversion missed on code piece in
> arch/x86/pci/bus_numa.c, which causes regression on some legacy
> AMD platforms as reported by Arthur Marsh <arthur.marsh@internode.on.net>.
> The root causes is that acpi_pci_root_create() fails to insert
> host bridge resources into iomem_resource/ioport_resource because
> x86_pci_root_bus_resources() has already inserted those resources.
> So change x86_pci_root_bus_resources() to not insert resources into
> iomem_resource/ioport_resource.
> 
> Fixes: 4d6b4e69a245 ("x86/PCI/ACPI: Use common interface to support PCI host bridge")
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Reported-and-tested-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Arthur Marsh <arthur.marsh@internode.on.net>
> Cc: Hans de Bruin <jmdebruin@xmsnet.nl>

What exactly has changed between this version and the previous one?


> ---
>  arch/x86/pci/bus_numa.c |   13 ++-----------
>  drivers/acpi/pci_root.c |    7 +++++++
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
> index 7bcf06a7cd12..6eb3c8af96e2 100644
> --- a/arch/x86/pci/bus_numa.c
> +++ b/arch/x86/pci/bus_numa.c
> @@ -50,18 +50,9 @@ void x86_pci_root_bus_resources(int bus, struct list_head *resources)
>  	if (!found)
>  		pci_add_resource(resources, &info->busn);
>  
> -	list_for_each_entry(root_res, &info->resources, list) {
> -		struct resource *res;
> -		struct resource *root;
> +	list_for_each_entry(root_res, &info->resources, list)
> +		pci_add_resource(resources, &root_res->res);
>  
> -		res = &root_res->res;
> -		pci_add_resource(resources, res);
> -		if (res->flags & IORESOURCE_IO)
> -			root = &ioport_resource;
> -		else
> -			root = &iomem_resource;
> -		insert_resource(root, res);
> -	}
>  	return;
>  
>  default_resources:
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 850d7bf0c873..ae3fe4e64203 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -768,6 +768,13 @@ static void pci_acpi_root_add_resources(struct acpi_pci_root_info *info)
>  		else
>  			continue;
>  
> +		/*
> +		 * Some legacy x86 host bridge drivers use iomem_resource and
> +		 * ioport_resource as default resource pool, skip it.
> +		 */
> +		if (res == root)
> +			continue;
> +
>  		conflict = insert_resource_conflict(root, res);
>  		if (conflict) {
>  			dev_info(&info->bridge->dev,
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
