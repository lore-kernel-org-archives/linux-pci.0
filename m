Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755204AbcIMQmL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Sep 2016 12:42:11 -0400
Date: Tue, 13 Sep 2016 11:42:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        cov@codeaurora.org, alex.williamson@redhat.com,
        vikrams@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: save and restore device state during bus reset
Message-ID: <20160913164205.GD4138@localhost>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 07:00:00PM -0400, Sinan Kaya wrote:
> A secondary bus reset causes settings to be lost by all downstream
> devices on the tree. The code is currently saving and restoring device
> states only when called from the VFIO path via pci_probe_reset_bus
> and pci_reset_bus functions.
> 
> Moving the save and restore into pci_reset_bridge_secondary_bus
> so that all users of the API have the same behavior.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aab9d51..b209378 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3860,19 +3860,6 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	pci_reset_secondary_bus(dev);
>  }
>  
> -/**
> - * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
> - * @dev: Bridge device
> - *
> - * Use the bridge control register to assert reset on the secondary bus.
> - * Devices on the secondary bus are left in power-on state.
> - */
> -void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
> -{
> -	pcibios_reset_secondary_bus(dev);
> -}
> -EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
> -
>  static int pci_parent_bus_reset(struct pci_dev *dev, int probe)
>  {
>  	struct pci_dev *pdev;
> @@ -4362,6 +4349,21 @@ static void pci_slot_restore(struct pci_slot *slot)
>  	}
>  }
>  
> +/**
> + * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
> + * @dev: Bridge device
> + *
> + * Use the bridge control register to assert reset on the secondary bus.
> + * Devices on the secondary bus are left in power-on state.

This comment is no longer correct (you don't leave the devices in
power-on state).

> + */
> +void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
> +{
> +	pci_bus_save_and_disable(dev->bus);

"dev" is a bridge, and dev->bus is the bus on the *primary* side of
the bridge, so I think this saves and disables the bridge itself.
Don't you want dev->subordinate here instead?

> +	pcibios_reset_secondary_bus(dev);
> +	pci_bus_restore(dev->bus);
> +}
> +EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
> +
>  static int pci_slot_reset(struct pci_slot *slot, int probe)
>  {
>  	int rc;
> @@ -4504,12 +4506,8 @@ int pci_reset_bus(struct pci_bus *bus)
>  	if (rc)
>  		return rc;
>  
> -	pci_bus_save_and_disable(bus);
> -
>  	rc = pci_bus_reset(bus, 0);
>  
> -	pci_bus_restore(bus);
> -
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bus);
> @@ -4528,8 +4526,6 @@ int pci_try_reset_bus(struct pci_bus *bus)
>  	if (rc)
>  		return rc;
>  
> -	pci_bus_save_and_disable(bus);
> -
>  	if (pci_bus_trylock(bus)) {
>  		might_sleep();
>  		pci_reset_bridge_secondary_bus(bus->self);
> @@ -4537,8 +4533,6 @@ int pci_try_reset_bus(struct pci_bus *bus)
>  	} else
>  		rc = -EAGAIN;
>  
> -	pci_bus_restore(bus);
> -
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(pci_try_reset_bus);
> -- 
> 1.9.1
> 
