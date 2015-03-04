Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55667 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752207AbbCDOBn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 09:01:43 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Voegtle <tv@lio96.de>, Hudd <hedede.l@gmail.com>,
	Prakash Punnoor <prakash@punnoor.de>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Dave Airlie <airlied@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
Subject: Re: [Bugfix 1/2] x86/PCI/ACPI: Ignore resources consumed by host bridge itself
Date: Wed, 04 Mar 2015 15:25:17 +0100
Message-ID: <10992995.sRFs1pmEco@vostro.rjw.lan>
In-Reply-To: <1425458832-28777-1-git-send-email-jiang.liu@linux.intel.com>
References: <1425458832-28777-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, March 04, 2015 04:47:11 PM Jiang Liu wrote:
> When parsing resources for PCI host bridge, we should ignore resources
> consumed by host bridge itself and only report window resources available
> to child PCI busses.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Queued up for 4.0-rc3, thanks!

> ---
>  arch/x86/pci/acpi.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 6ac273832f28..e4695985f9de 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -331,7 +331,7 @@ static void probe_pci_root_info(struct pci_root_info *info,
>  				struct list_head *list)
>  {
>  	int ret;
> -	struct resource_entry *entry;
> +	struct resource_entry *entry, *tmp;
>  
>  	sprintf(info->name, "PCI Bus %04x:%02x", domain, busnum);
>  	info->bridge = device;
> @@ -345,8 +345,13 @@ static void probe_pci_root_info(struct pci_root_info *info,
>  		dev_dbg(&device->dev,
>  			"no IO and memory resources present in _CRS\n");
>  	else
> -		resource_list_for_each_entry(entry, list)
> -			entry->res->name = info->name;
> +		resource_list_for_each_entry_safe(entry, tmp, list) {
> +			if ((entry->res->flags & IORESOURCE_WINDOW) == 0 ||
> +			    (entry->res->flags & IORESOURCE_DISABLED))
> +				resource_list_destroy_entry(entry);
> +			else
> +				entry->res->name = info->name;
> +		}
>  }
>  
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
