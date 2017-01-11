Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 11 Jan 2017 15:37:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jorn Helgaas <bhelgaas@google.com>, liudongdong3@huawei.com,
        gabriele.paoloni@huawei.com, xuwei5@hisilicon.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: Fix bus range comparation in pci_mcfg_lookup
Message-ID: <20170111213727.GO14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1483513206-113046-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483513206-113046-1-git-send-email-wangzhou1@hisilicon.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 03:00:06PM +0800, Zhou Wang wrote:
> The configuration data provided by an MCFG region (ie PCI segment and
> bus range) may span multiple host bridges.
> 
> Current code in pci_mcfg_lookup() carries out an exact match of host
> bridge bus range start value against the MCFG region(s) bus range start
> value which would cause configurations like the following:
> 
> MCFG region:
> 	bus range: 0x00~0xff.
> 	segment: 0.
> 
> PCI host bridges configuration (segment numbers and bus ranges):
> 	host bridge 1:
> 		bus range: 0x00~0x1f.
> 		segment: 0.
> 	host bridge 2:
> 		bus range: 0x20~0x4f.
> 		segment: 0.
> 
> to fail, in that the bus range start value for host bridge 2 does
> not match the bus range start value of the respective MCFG region.
> 
> Relax the bus range check in pci_mcfg_lookup() to cater for
> PCI configurations with multiple host bridges sharing the same
> MCFG region.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied to pci/enumeration for v4.11 with the following changelog:

    PCI/ACPI: Fix bus range comparison in pci_mcfg_lookup()
    
    The configuration data provided by an MCFG entry, i.e., PCI segment and bus
    range, may span multiple host bridges.
    
    pci_mcfg_lookup() previously required an exact match of the host bridge
    starting bus and the MCFG starting bus, which made the following
    configuration fail:
    
      MCFG region:
        segment: 0
        bus range: 0x00-0xff
    
      host bridge
        segment: 0
        bus range: 0x20-0x4f
    
    Relax the bus range check in pci_mcfg_lookup() so we can use any MCFG entry
    that contains the required bus range, as we do in pci_mmconfig_lookup().
    
    [bhelgaas: changelog]
    Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
    Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> ---
>  drivers/acpi/pci_mcfg.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index a6a4cea..2944353 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -195,11 +195,10 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
>  		goto skip_lookup;
>  
>  	/*
> -	 * We expect exact match, unless MCFG entry end bus covers more than
> -	 * specified by caller.
> +	 * We expect the range in bus_res in the coverage of MCFG bus range.
>  	 */
>  	list_for_each_entry(e, &pci_mcfg_list, list) {
> -		if (e->segment == seg && e->bus_start == bus_res->start &&
> +		if (e->segment == seg && e->bus_start <= bus_res->start &&
>  		    e->bus_end >= bus_res->end) {
>  			root->mcfg_addr = e->addr;
>  		}
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
