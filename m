Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:47655 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941516AbcKQRQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2016 12:16:11 -0500
Date: Thu, 17 Nov 2016 14:40:42 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Remove service driver load/unload messages
Message-ID: <20161117134042.GA11658@wunner.de>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161116221310.15842.25671.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161116221310.15842.25671.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 16, 2016 at 04:13:10PM -0600, Bjorn Helgaas wrote:
> Remove the "service driver %s loaded" and unloaded messages.  I don't think
> these add any useful information.

I think those particular ones have a value to some extent because
they communicate for which of the port's capabilities a driver is
available and loaded.  For ports below a hotplug port they also
comunicate the steps to unbind the ports from their drivers when
the device is unplugged.

E.g. when I plug in the Apple Thunderbolt Ethernet adapter I get this
because a new hotplug port appears below the hotplug port of the host
controller:
[  141.926865] pciehp 0000:0a:00.0:pcie204: service driver pciehp loaded

On unplug I get this:
[  202.497548] pciehp 0000:0a:00.0:pcie204: unloading service driver pciehp

Thanks,

Lukas

> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e9270b4..9698289 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -499,7 +499,6 @@ static int pcie_port_probe_service(struct device *dev)
>  	if (status)
>  		return status;
>  
> -	dev_printk(KERN_DEBUG, dev, "service driver %s loaded\n", driver->name);
>  	get_device(dev);
>  	return 0;
>  }
> @@ -524,8 +523,6 @@ static int pcie_port_remove_service(struct device *dev)
>  	pciedev = to_pcie_device(dev);
>  	driver = to_service_driver(dev->driver);
>  	if (driver && driver->remove) {
> -		dev_printk(KERN_DEBUG, dev, "unloading service driver %s\n",
> -			driver->name);
>  		driver->remove(pciedev);
>  		put_device(dev);
>  	}
> 
