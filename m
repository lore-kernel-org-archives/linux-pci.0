Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49706 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcFKAAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 20:00:20 -0400
Date: Fri, 10 Jun 2016 19:00:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: host-generic: select IRQ_DOMAIN
Message-ID: <20160611000015.GC16462@localhost>
References: <1463581000-983246-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463581000-983246-1-git-send-email-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 18, 2016 at 04:15:53PM +0200, Arnd Bergmann wrote:
> The generic PCI host controller calls of_irq_parse_and_map_pci
> in its IRQ fixup, but that function is only available when
> CONFIG_IRQ_DOMAIN is set:
> 
> drivers/pci/built-in.o: In function `pci_host_common_probe':
> drivers/pci/host/pci-host-common.c:181: undefined reference to `of_irq_parse_and_map_pci'
> 
> There is no downside in enabling the domains here, so let's
> use a Kconfig select statement to ensure it's always available
> to this driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to pci/host-generic for v4.8, thanks, Arnd.

> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 66329b932e29..64734ba070a2 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -87,6 +87,7 @@ config PCI_HOST_GENERIC
>  	bool "Generic PCI host controller"
>  	depends on (ARM || ARM64) && OF
>  	select PCI_HOST_COMMON
> +	select IRQ_DOMAIN
>  	help
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
