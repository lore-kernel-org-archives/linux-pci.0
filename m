Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab3GXVJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jul 2013 17:09:56 -0400
Message-ID: <51F0429F.3060904@redhat.com>
Date: Wed, 24 Jul 2013 17:09:51 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop> <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
In-Reply-To: <20130723180821.19616.52936.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2013 02:08 PM, Bjorn Helgaas wrote:
> Convert pciehp to be builtin only, with no module option.
>
> Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>

Acked-by: Donald Dutile <ddutile@redhat.com>

> ---
>   drivers/pci/pcie/Kconfig |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..3b94cfc 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>   # Include service Kconfig here
>   #
>   config HOTPLUG_PCI_PCIE
> -	tristate "PCI Express Hotplug driver"
> +	bool "PCI Express Hotplug driver"
>   	depends on HOTPLUG_PCI&&  PCIEPORTBUS
>   	help
>   	  Say Y here if you have a motherboard that supports PCI Express Native
>   	  Hotplug
>
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called pciehp.
> -
>   	  When in doubt, say N.
>
>   source "drivers/pci/pcie/aer/Kconfig"
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

