Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:36367 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757721Ab3GWVQA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jul 2013 17:16:00 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
Date: Tue, 23 Jul 2013 23:26:03 +0200
Message-ID: <1858488.HKVVs8OCFA@vostro.rjw.lan>
In-Reply-To: <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop> <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 23, 2013 12:08:21 PM Bjorn Helgaas wrote:
> Convert pciehp to be builtin only, with no module option.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pcie/Kconfig |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..3b94cfc 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>  # Include service Kconfig here
>  #
>  config HOTPLUG_PCI_PCIE
> -	tristate "PCI Express Hotplug driver"
> +	bool "PCI Express Hotplug driver"
>  	depends on HOTPLUG_PCI && PCIEPORTBUS
>  	help
>  	  Say Y here if you have a motherboard that supports PCI Express Native
>  	  Hotplug
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called pciehp.
> -
>  	  When in doubt, say N.
>  
>  source "drivers/pci/pcie/aer/Kconfig"
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
