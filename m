Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:2743
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752235Ab2GPPrh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2012 11:47:37 -0400
Message-ID: <50043790.6090605@freescale.com>
Date: Mon, 16 Jul 2012 10:47:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2 v2] PCI: Add PCI_DEV_FLAGS_USE_NON_MSI_INTX_IRQ to
 enable non MSI/INTx interrupt
References: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1342409487-28256-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/15/2012 10:31 PM, Shengzhou Liu wrote:
> On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
> interrupt generated, which are available only in EP mode on those platform.
> In this case, we try to use other interrupt for port service driver to have
> AER, Hot-plug, etc, services to work.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2: separated platform-specific part to arch/powerpc/sysdev.
> 
>  drivers/pci/pcie/portdrv_core.c |   10 ++++++++--
>  drivers/pci/quirks.c            |    9 +++++++++
>  include/linux/pci.h             |    5 +++++
>  3 files changed, 22 insertions(+), 2 deletions(-)
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

I didn't see a response on the question about what would happen if we
did this unconditionally (i.e. just s/dev->pin/dev->irq/ in the original
code).  We should avoid introducing flags like this unless there's a
good reason.

Maybe submit a patch that does it unconditionally, and see if that draws
a complaint.

-Scott

