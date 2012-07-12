Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:21871
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161307Ab2GLQIL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jul 2012 12:08:11 -0400
Message-ID: <4FFEF65F.7080709@freescale.com>
Date: Thu, 12 Jul 2012 11:07:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH][upstream] PCI: Add PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ
 to enable non MSI/INTx interrupt
References: <1342087342-14748-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342087342-14748-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/12/2012 05:02 AM, Shengzhou Liu wrote:
> On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
> interrupt generated, which are available only in EP mode on those platform.
> In this case, we try to use other interrupt for port service driver to have
> AER, Hot-plug, etc, services to work. (i.e. there is the shared error interrupt
> on platform P1010/P3041/P4080 etc)
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |   10 ++++++++--
>  drivers/pci/quirks.c            |   12 ++++++++++++
>  include/linux/pci.h             |    5 +++++
>  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 75915b3..837ad15 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -212,8 +212,14 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if (!pcie_port_enable_msix(dev, irqs, mask))
>  		return 0;
>  
> -	/* We're not going to use MSI-X, so try MSI and fall back to INTx */
> -	if (!pci_enable_msi(dev) || dev->pin)
> +	/*
> +	 * We're not going to use MSI-X, so try MSI and fall back to INTx.
> +	 * Eventually, if neither MSI/MSI-X nor INTx available, try other
> +	 * interrupt. (On some platforms, root port doesn't support generating
> +	 * MSI/MSI-X/INTx in RC mode)
> +	 */
> +	if (!pci_enable_msi(dev) || dev->pin || ((dev->dev_flags &
> +			PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ) && dev->irq))
>  		irq = dev->irq;

I'd still like to hear someone say what specifically would go wrong if
we just did s/dev->pin/dev->irq/ (and even that much seems to be only
because the code is using a non-standard indicator of an invalid IRQ).
When would dev->irq contain a non-zero value that is not usable?

-Scott

