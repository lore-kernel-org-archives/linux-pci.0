Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44789 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbcEKTgu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 May 2016 15:36:50 -0400
Date: Wed, 11 May 2016 14:36:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/4] PCI: No need to set d3cold_allowed to PCIe ports
Message-ID: <20160511193645.GB28812@localhost>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461919919-120102-2-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461919919-120102-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 11:51:56AM +0300, Mika Westerberg wrote:
> The Linux PCI core skips PCI bridges and PCIe ports when system is
> suspended. The PCI core checks return value of pci_has_subordinate() in
> pci_pm_suspend_noirq() to skip all devices where it is non-zero (which
> means PCI bridges and PCIe ports).

This patch looks fine to me.

But I wonder whether it's correct for pci_pm_suspend_noirq() (and the
other PM functions) to use pci_has_subordinate() as opposed to
pci_is_bridge().

pci_is_bridge() is true for all bridge devices (plain old PCI-PCI
bridges, PCIe ports, CardBus bridges, etc.)

pci_has_subordinate() is true only if the bridge has a struct pci_bus
allocated for its secondary bus.  This is probably the case for all or
almost all bridges, but it's conceivable that if we don't have enough
bus number space for the secondary bus, we might not allocate that
struct pci_bus.

What do you PM guys think?  I don't know what you would want to do
with a bridge that didn't have any reachable devices below it.

> Since PCIe ports are never suspended in the first place, there is no need
> to set d3cold_allowed for them.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index be35da2e105e..6c6bb03392ea 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -134,11 +134,6 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		return status;
>  
>  	pci_save_state(dev);
> -	/*
> -	 * D3cold may not work properly on some PCIe port, so disable
> -	 * it by default.
> -	 */
> -	dev->d3cold_allowed = false;
>  	return 0;
>  }
>  
> -- 
> 2.8.0.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
