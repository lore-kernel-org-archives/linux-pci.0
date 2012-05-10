Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39889 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab2EJRJX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 May 2012 13:09:23 -0400
Received: by dady13 with SMTP id y13so1946569dad.19
        for <linux-pci@vger.kernel.org>; Thu, 10 May 2012 10:09:22 -0700 (PDT)
Message-ID: <4FABF639.4070205@gmail.com>
Date: Fri, 11 May 2012 01:09:13 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Amos Kong <akong@redhat.com>
CC: mst@redhat.com, linux-pci@vger.kernel.org, seabios@seabios.org,
	qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	alex.williamson@redhat.com, kevin@koconnor.net
Subject: Re: [PATCH v3] pci: clean all funcs when hot-removing multifunc device
References: <1315976141-6684-1-git-send-email-akong@redhat.com> <20120510154423.11306.85353.stgit@t>
In-Reply-To: <20120510154423.11306.85353.stgit@t>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/10/2012 11:44 PM, Amos Kong wrote:

> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 806c44f..a7442d9 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -885,7 +885,7 @@ static void disable_bridges(struct pci_bus *bus)
>  static int disable_device(struct acpiphp_slot *slot)
>  {
>  	struct acpiphp_func *func;
> -	struct pci_dev *pdev;
> +	struct pci_dev *pdev, *tmp;
>  	struct pci_bus *bus = slot->bridge->pci_bus;
>  
>  	/* The slot will be enabled when func 0 is added, so check
> @@ -902,9 +902,10 @@ static int disable_device(struct acpiphp_slot *slot)
>  			func->bridge = NULL;
>  		}
>  
> -		pdev = pci_get_slot(slot->bridge->pci_bus,
> -				    PCI_DEVFN(slot->device, func->function));
> -		if (pdev) {
> +		list_for_each_entry_safe(pdev, tmp, &bus->devices, bus_list) {
> +			if (PCI_SLOT(pdev->devfn) != slot->device)
> +				continue;
> +
The pci_bus_sem lock should be acquired when walking the bus->devices list.
Otherwise it may cause invalid memory access if another thread is modifying
the bus->devices list concurrently.

BTW, what's the relationship with "[PATCH v3] hotplug: add device per func
in ACPI DSDT tables"? Seems they are both solving the same issue.

>  			pci_stop_bus_device(pdev);
>  			if (pdev->subordinate) {
>  				disable_bridges(pdev->subordinate);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

