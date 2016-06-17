Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39732 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbcFQVxR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 17:53:17 -0400
Date: Fri, 17 Jun 2016 16:53:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v2 08/13] PCI: Allow runtime PM for Thunderbolt hotplug
 ports on Macs
Message-ID: <20160617215312.GC12254@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
 <47f9e4a9ca09e854d2d01812a4c05b7c6df02259.1463134231.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47f9e4a9ca09e854d2d01812a4c05b7c6df02259.1463134231.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> Thunderbolt controllers have a pin to signal plug events while the
> controller is powered down.  On Macs this pin is wired to the
> southbridge and causes a GPE to be fired.  The OS may then power up the
> controller to probe the newly connected device.  It is thus okay to let
> Thunderbolt hotplug ports go to D3 on Macs.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index f75d4b5..7860ab3 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -224,9 +224,12 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	 * to enumerate devices behind this port properly (the port is
>  	 * powered down preventing all config space accesses to the
>  	 * subordinate devices).  We can't be sure for native PCIe hotplug
> -	 * either so prevent that as well.
> +	 * either so prevent that as well.  However Thunderbolt controllers
> +	 * on Macs are capable of side-band signaling plug events while
> +	 * powered down, so allow them to suspend.
>  	 */
> -	if (!dev->is_hotplug_bridge) {
> +	if (!dev->is_hotplug_bridge ||
> +	    (dev->is_thunderbolt && dmi_match(DMI_SYS_VENDOR, "Apple Inc."))) {

I'd rather have a bit in the pci_dev to control this.  I don't know
how this would be different from the recently-added "bridge_d3" bit.
The bit could be set by a quirk.

It'd be nice if it were a single bit so we don't have to test
is_hotplug_bridge *and* another bit.

>  		/*
>  		 * Keep the port resumed 10ms to make sure things like
>  		 * config space accesses from userspace (lspci) will not
> @@ -243,7 +246,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> -	if (!dev->is_hotplug_bridge) {
> +	if (!dev->is_hotplug_bridge ||
> +	    (dev->is_thunderbolt && dmi_match(DMI_SYS_VENDOR, "Apple Inc."))) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
>  		pm_runtime_dont_use_autosuspend(&dev->dev);
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
