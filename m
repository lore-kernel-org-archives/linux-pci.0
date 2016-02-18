Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 18 Feb 2016 12:32:16 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	jchandra@broadcom.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com
Subject: Re: [PATCH V5 04/15] pci, acpi, ecam: Add flag to indicate whether
 ECAM region was hot added or not.
Message-ID: <20160218123216.GB12626@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <1455630825-27253-5-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455630825-27253-5-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 16, 2016 at 02:53:34PM +0100, Tomasz Nowicki wrote:
> There are two ways we can get ECAM (aka MCFG) regions using ACPI,
> first from MCFG static table and second from _CBA method. We cannot remove
> static regions, however regions coming from _CBA should be removed while
> removing bridge device.
> 
> In the light of above we need flag to mark hot added ECAM entries
> and user to call pci_mmconfig_insert while adding regions from _CBA method.
> Similarly pci_mmconfig_delete while removing hot added regions.

"According to the PCI firmware specification, ACPI provides two standard
mechanisms to retrieve ECAM memory mapped configuration regions (aka MCFG).
For non-hot-removable bridges, ECAM bridge configurations are retrieved from
the static MCFG table and have to be considered non-hot-removable for the
current boot; hot-removable PCI host bridges configurations are retrieved
through bridges _CBA methods.

When ECAM regions are added through _CBA methods, they can be marked
as hot-added so that, upon respective PCI host bridge hot-removal, they can
be unmapped and deleted in that no longer needed.

This patch adds a flag to MCFG regions allowing to mark them as hot-added,
so that upon corresponding PCI bridge hot-removal they can be deleted since
no longer needed."

> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Duc Dang <dhdang@apm.com>
> Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_mcfg.c  | 4 +++-
>  include/linux/pci-acpi.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)

It would be great if x86 people can have a look, we no longer
associate a MCFG region to a bridge structure, the end result
should be equivalent though, so:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 0467b00..3282f2a 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -74,6 +74,7 @@ static struct pci_mmcfg_region *pci_mmconfig_alloc(int segment, int start,
>  	new->segment = segment;
>  	new->start_bus = start;
>  	new->end_bus = end;
> +	new->hot_added = false;
>  
>  	res = &new->res;
>  	res->start = addr + PCI_MMCFG_BUS_OFFSET(start);
> @@ -205,6 +206,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
>  	}
>  	rc = pci_mmconfig_map_resource(dev, cfg);
>  	if (!rc) {
> +		cfg->hot_added = true;
>  		list_add_sorted(cfg);
>  		dev_info(dev, "MMCONFIG at %pR (base %#lx)\n",
>  				 &cfg->res, (unsigned long)addr);
> @@ -228,7 +230,7 @@ int pci_mmconfig_delete(u16 seg, u8 start, u8 end)
>  	mutex_lock(&pci_mmcfg_lock);
>  	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
>  		if (cfg->segment == seg && cfg->start_bus == start &&
> -		    cfg->end_bus == end) {
> +		    cfg->end_bus == end && cfg->hot_added) {
>  			list_del_rcu(&cfg->list);
>  			synchronize_rcu();
>  			pci_mmconfig_unmap_resource(cfg);
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index e9450ef..94d8f38 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -119,6 +119,7 @@ struct pci_mmcfg_region {
>  	u8 start_bus;
>  	u8 end_bus;
>  	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> +	bool hot_added;
>  };
>  
>  extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
> -- 
> 1.9.1
> 
