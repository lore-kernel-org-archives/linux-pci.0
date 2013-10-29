Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51845 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751287Ab3J2XUl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 19:20:41 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] PCI: Report pci_pme_active() kmalloc failure
Date: Wed, 30 Oct 2013 00:32:50 +0100
Message-ID: <2930311.2be2J0XGoi@vostro.rjw.lan>
In-Reply-To: <20131029231437.19711.61623.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131029231437.19711.61623.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 29, 2013 05:14:38 PM Bjorn Helgaas wrote:
> Previously, if kmalloc() failed, we claimed "PME# enabled" in dmesg,
> even though we didn't add the device to the pci_pme_list.  This prints
> a more correct warning.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ad7fc72..36cc8d5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1638,8 +1638,10 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
>  		if (enable) {
>  			pme_dev = kmalloc(sizeof(struct pci_pme_device),
>  					  GFP_KERNEL);
> -			if (!pme_dev)
> -				goto out;
> +			if (!pme_dev) {
> +				dev_warn(&dev->dev, "can't enable PME#\n");
> +				return;
> +			}
>  			pme_dev->dev = dev;
>  			mutex_lock(&pci_pme_list_mutex);
>  			list_add(&pme_dev->list, &pci_pme_list);
> @@ -1660,7 +1662,6 @@ void pci_pme_active(struct pci_dev *dev, bool enable)
>  		}
>  	}
>  
> -out:
>  	dev_dbg(&dev->dev, "PME# %s\n", enable ? "enabled" : "disabled");
>  }
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
