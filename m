Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:32789 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbCTXW1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 19:22:27 -0400
Received: by iecvj10 with SMTP id vj10so1169810iec.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 16:22:26 -0700 (PDT)
Date: Fri, 20 Mar 2015 18:22:23 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux@arm.linux.org.uk, linux-kernel@codethink.co.uk,
	Linux ARM Kernel list <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI List <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ARM: add PCI hotplug support
Message-ID: <20150320232223.GP26935@google.com>
References: <1426594952-1456-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426594952-1456-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 17, 2015 at 12:22:32PM +0000, Ben Dooks wrote:
> Hotplug on PCIe should work with ARM, however the necessary
> PCIe hotplug is not availale as the menu items for PCI hotplug

"available"

> have not been included.
> 
> Add the include of PCI hotplug support to the ARM main Kconfig
> so that it can be selected.
> 
> The only issue that was found during this is that the PCI code
> did not assign interrupts properly to newly probed devices. This
> will need to be fixed for any interrupt capable devices.

Yep, this is a known PCI problem, at least if you're referring to
the fact that pci_fixup_irqs() only happens for devices present at
boot-time.  I would love for somebody to fix that generically.

I would also like to squash together the PCI, PCIe, and PCI hotplug Kconfig
options so arches would only have to include drivers/pci/Kconfig.

> This has been tested on a Marvell 88F6281 with a TI XIO3130
> PCIe bridge (with hotplug enabled) and fixes for IRQ assignment
> added.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I assume this will be handled via an ARM tree, but if you want it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> --
> CC: Linux ARM Kernel list <linux-arm-kernel@lists.infradead.org>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Linux PCI List <linux-pci@vger.kernel.org>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9f1f09a..4574ab4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1302,6 +1302,7 @@ config PCI_HOST_ITE8152
>  	select DMABOUNCE
>  
>  source "drivers/pci/Kconfig"
> +source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/pcie/Kconfig"
>  
>  source "drivers/pcmcia/Kconfig"
> -- 
> 2.1.4
> 
