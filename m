Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 May 2015 17:39:30 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCIe / hotplug: Drop pointless label from pciehp_probe()
Message-ID: <20150522223930.GK32152@google.com>
References: <23117851.vMYBozkkxg@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23117851.vMYBozkkxg@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 23, 2015 at 12:38:57AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The err_out_none label in pciehp_probe() only leads to a return
> statement, so use return statements instead of jumps to it and
> drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to pci/hotplug for v4.2, thanks!

> ---
> 
> On top of https://patchwork.kernel.org/patch/6436921/ .
> 
> ---
>  drivers/pci/hotplug/pciehp_core.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/pci/hotplug/pciehp_core.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/pciehp_core.c
> +++ linux-pm/drivers/pci/hotplug/pciehp_core.c
> @@ -256,13 +256,13 @@ static int pciehp_probe(struct pcie_devi
>  		/* Can happen if we run out of bus numbers during probe */
>  		dev_err(&dev->device,
>  			"Hotplug bridge without secondary bus, ignoring\n");
> -		goto err_out_none;
> +		return -ENODEV;
>  	}
>  
>  	ctrl = pcie_init(dev);
>  	if (!ctrl) {
>  		dev_err(&dev->device, "Controller initialization failed\n");
> -		goto err_out_none;
> +		return -ENODEV;
>  	}
>  	set_service_data(dev, ctrl);
>  
> @@ -302,7 +302,6 @@ err_out_free_ctrl_slot:
>  	cleanup_slot(ctrl);
>  err_out_release_ctlr:
>  	pciehp_release_ctrl(ctrl);
> -err_out_none:
>  	return -ENODEV;
>  }
>  
> 
