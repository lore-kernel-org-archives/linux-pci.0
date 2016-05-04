Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54740 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbcEDWBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 May 2016 18:01:52 -0400
Date: Wed, 4 May 2016 17:01:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Use cached copy of PCI_EXP_SLTCAP_HPC bit
Message-ID: <20160504220145.GC3117@localhost>
References: <a1c9caeb4124f89fbf7cde171642ca3f511081b5.1462366514.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a1c9caeb4124f89fbf7cde171642ca3f511081b5.1462366514.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 04, 2016 at 03:05:57PM +0200, Lukas Wunner wrote:
> We cache the PCI_EXP_SLTCAP_HPC bit in pci_dev->is_hotplug_bridge on
> device probe, so there's no need to read it again on allocation of
> port service devices.
> 
> No functional change intended.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v4.7, thanks, Lukas!

> ---
>  drivers/pci/pcie/portdrv_core.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 050069f..af7796d 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -254,7 +254,6 @@ static void cleanup_service_irqs(struct pci_dev *dev)
>  static int get_port_device_capability(struct pci_dev *dev)
>  {
>  	int services = 0;
> -	u32 reg32;
>  	int cap_mask = 0;
>  
>  	if (pcie_ports_disabled)
> @@ -269,19 +268,15 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		pcie_port_platform_notify(dev, &cap_mask);
>  
>  	/* Hot-Plug Capable */
> -	if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
> -	    pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT) {
> -		pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
> -		if (reg32 & PCI_EXP_SLTCAP_HPC) {
> -			services |= PCIE_PORT_SERVICE_HP;
> -			/*
> -			 * Disable hot-plug interrupts in case they have been
> -			 * enabled by the BIOS and the hot-plug service driver
> -			 * is not loaded.
> -			 */
> -			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> -		}
> +	if ((cap_mask & PCIE_PORT_SERVICE_HP)
> +	    && dev->is_hotplug_bridge) {
> +		services |= PCIE_PORT_SERVICE_HP;
> +		/*
> +		 * Disable hot-plug interrupts in case they have been enabled
> +		 * by the BIOS and the hot-plug service driver is not loaded.
> +		 */
> +		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
>  	}
>  	/* AER capable */
>  	if ((cap_mask & PCIE_PORT_SERVICE_AER)
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
