Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:62406 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaJNSeX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 14:34:23 -0400
Received: by mail-ig0-f181.google.com with SMTP id r10so15793328igi.8
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 11:34:22 -0700 (PDT)
Date: Tue, 14 Oct 2014 12:34:19 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 07/18] Delayed cris setup of PCI IRQs to bus scan time
Message-ID: <20141014183419.GG10125@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
 <1412222866-21068-8-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-8-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:35AM +0100, matt@masarand.com wrote:
> From: Matthew Minter <matt@masarand.com>
> 
> PCI IRQs are currently configured to be enabled once at boot in a
> dedicated pass. This means that PCI devices which are hot-plugged after
> boot time will not be given an IRQ, this patch-set fixes this by
> registering the assignment function to be called later in the device
> enable path.
> 
> Signed-off-by: Matthew Minter <matt@masarand.com>
> 
> ---
>  arch/cris/arch-v32/drivers/pci/bios.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index 64a5fb9..d04ecc8 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -80,20 +80,16 @@ int pcibios_enable_resources(struct pci_dev *dev, int mask)
>  	return 0;
>  }
>  
> -int pcibios_enable_irq(struct pci_dev *dev)
> +int pcibios_enable_irq(struct pci_dev *dev, u8 slot, u8 pin)
>  {
>  	dev->irq = EXT_INTR_VECT;
>  	return 0;
>  }
>  
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  {
> -	int err;
> -
> -	if ((err = pcibios_enable_resources(dev, mask)) < 0)
> -		return err;

If I understand correctly, this means we'd now use the default
pcibios_enable_device() from drivers/pci/pci.c, which uses
pci_enable_resources(), instead of cris's pcibios_enable_resources().

That's a good thing that we should do someday, but it's out of scope for
this series because they *are* different, and we need to evaluate whether
it's safe to use the default version instead of the cris version.  Also, I
think this patch leaves the cris pcibios_enable_resources() unused.

> -
> -	if (!dev->msi_enabled)
> -		pcibios_enable_irq(dev);
> +	bridge->swizzle_irq = NULL;
> +	bridge->map_irq = pcibios_enable_irq;
>  	return 0;
>  }
> +
> -- 
> 2.1.0
> 
