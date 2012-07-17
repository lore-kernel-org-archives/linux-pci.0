Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:20443
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755960Ab2GQRlo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 13:41:44 -0400
Message-ID: <5005A3D2.5060504@freescale.com>
Date: Tue, 17 Jul 2012 12:41:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] PCI: use dev->irq instead of dev->pin to enable non MSI/INTx
 interrupt
References: <1342492551-13766-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342492551-13766-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2012 09:35 PM, Shengzhou Liu wrote:
> On some platforms, root port has neither MSI/MSI-X nor INTx interrupt
> generated in RC mode. In this case, we have to use other interrupt(i.e.
> system shared interrupt) for port service irq to have AER, Hot-plug, etc,
> services to work.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 75915b3..a855254 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -212,8 +212,13 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if (!pcie_port_enable_msix(dev, irqs, mask))
>  		return 0;
>  
> -	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
> -	if (!pci_enable_msi(dev) || dev->pin)
> +	/*
> +	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
> +	 * If neither MSI/MSI-X nor INTx available, try other interrupt. (On
> +	 * some platforms, root port doesn't support generating MSI/MSI-X/INTx
> +	 * in RC mode)
> +	 */
> +	if (!pci_enable_msi(dev) || dev->irq)
>  		irq = dev->irq;

What about the other usage of dev->pin a few lines up?

-Scott

