Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36506 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352AbaKMQvI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 11:51:08 -0500
Received: by mail-pd0-f172.google.com with SMTP id r10so14871388pdi.31
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 08:51:08 -0800 (PST)
Date: Thu, 13 Nov 2014 09:51:04 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Kishon Vijay Abraham I' <kishon@ti.com>
Subject: Re: [PATCH] PCI: dra7xx: Add __init annotation to
 dra7xx_add_pcie_port()
Message-ID: <20141113165104.GE5064@google.com>
References: <001e01cff983$c76f0ed0$564d2c70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001e01cff983$c76f0ed0$564d2c70$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 06, 2014 at 02:37:39PM +0900, Jingoo Han wrote:
> Add __init annotation to dra7xx_add_pcie_port(), because
> the dra7xx_add_pcie_port() is called only by dra7xx_pcie_probe()
> that was already marked as __init. Also, this patch fixes
> section mismatch warning.
> 
> WARNING: drivers/pci/host/built-in.o(.text.unlikely+0xcc): Section mismatch in reference from the function dra7xx_add_pcie_port() to
> the function .init.text:dw_pcie_host_init()
> The function dra7xx_add_pcie_port() references
> the function __init dw_pcie_host_init().
> This is often because dra7xx_add_pcie_port lacks a __init
> annotation or the annotation of dw_pcie_host_init is wrong.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/host-dra7xx for v3.19, thanks!

Kishon, let me know if there's any issue with this.  It looks like a pretty
obvious fix.

> ---
> This patch is based on the submitted patch "[PATCH V2] PCI:
> dra7xx: Add dra7xx prefix before add_pcie_port".
> 
>  drivers/pci/host/pci-dra7xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 5b4a644..8c69697 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -270,8 +270,8 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> -				struct platform_device *pdev)
> +static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
> +				       struct platform_device *pdev)
>  {
>  	int ret;
>  	struct pcie_port *pp;
> -- 
> 1.7.9.5
> 
> 
