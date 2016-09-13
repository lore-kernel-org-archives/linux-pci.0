Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752333AbcIMVCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 17:02:36 -0400
Date: Tue, 13 Sep 2016 16:02:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: Fix bridge_d3 update on device removal
Message-ID: <20160913210231.GG4138@localhost>
References: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9bc855a01d0f29cc8425cf50dce9812062309cfb.1473135221.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 06:20:46AM +0200, Lukas Wunner wrote:
> Starting with v4.8, we allow a PCIe port to runtime suspend to D3hot if
> the port itself and its children satisfy a number of conditions.  Once a
> child is removed, we recheck those conditions in case the removed device
> was blocking the port from suspending.
> 
> The rechecking needs to happen *after* the device has been removed from
> the bus it resides on.  Otherwise when walking the port's subordinate
> bus in pci_bridge_d3_update(), the device being removed would
> erroneously still be taken into account.
> 
> However the device is removed from the bus_list in pci_destroy_dev() and
> we currently recheck *before* that.  Fix it.
> 
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

9d26d3a8f1b0 appeared in v4.8-rc1, so I assume this fix should be merged
before v4.8, right?

I applied it to for-linus with Mika's reviewed-by and Rafael's acked-by on
that assumption.

> ---
>  drivers/pci/remove.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index d1ef7ac..f9357e0 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -40,6 +40,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	list_del(&dev->bus_list);
>  	up_write(&pci_bus_sem);
>  
> +	pci_bridge_d3_device_removed(dev);
>  	pci_free_resources(dev);
>  	put_device(&dev->dev);
>  }
> @@ -96,8 +97,6 @@ static void pci_remove_bus_device(struct pci_dev *dev)
>  		dev->subordinate = NULL;
>  	}
>  
> -	pci_bridge_d3_device_removed(dev);
> -
>  	pci_destroy_dev(dev);
>  }
>  
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
