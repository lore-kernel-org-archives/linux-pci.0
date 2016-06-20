Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36206 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbcFTTFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 15:05:38 -0400
Date: Mon, 20 Jun 2016 14:05:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: export devm_request_pci_bus_resources to modules
Message-ID: <20160620190533.GB15674@localhost>
References: <20160620154604.2280100-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620154604.2280100-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 20, 2016 at 05:45:41PM +0200, Arnd Bergmann wrote:
> Host drivers can be loadable modules, so we might run into this
> build error with the new interface:
> 
> ERROR: devm_request_pci_bus_resources [drivers/pci/host/pcie-iproc.ko] undefined!
> 
> This adds an EXPORT_SYMBOL_GPL() line.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Folded in, thanks, Arnd!

> ---
>  drivers/pci/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 4c42a1013e3b..32efe8f5d5e9 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -132,6 +132,7 @@ int devm_request_pci_bus_resources(struct device *dev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
>  
>  static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
>  #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> -- 
> 2.9.0
> 
