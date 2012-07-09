Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:29070
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751890Ab2GIQjK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2012 12:39:10 -0400
Message-ID: <4FFB0927.7080406@freescale.com>
Date: Mon, 9 Jul 2012 11:39:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] PCI: Add pcie_irq=other to enable non MSI/INTx interrupt
 for port service driver
References: <1341830970-12779-1-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1341830970-12779-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/09/2012 05:49 AM, Shengzhou Liu wrote:
> On some platforms, in RC mode, root port has neither MSI/MSI-X nor INTx
> interrupt generated, which are available only in EP mode on those platform.
> In this case, we try to use other interrupt if supported (i.e. there is the
> shared error interrupt on platform P1010, P3041, P4080, etc) to have AER,
> Hot-plug, etc, services to work.
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
>  Documentation/kernel-parameters.txt |    4 ++++
>  drivers/pci/pcie/portdrv_core.c     |   19 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index a92c5eb..af97c81 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2218,6 +2218,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_irq=	[PCIE] Native PCIe root port interrupt options:
> +		other	Try to use other interrupt when root port has
> +			neither MSI/MSI-X nor INTx support.

Why does the user need to specify this?  Shouldn't this be a matter of
communication between kernel internals?

> @@ -216,6 +227,14 @@ static int init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	if (!pci_enable_msi(dev) || dev->pin)
>  		irq = dev->irq;
>  
> +	/*
> +	 * On some platforms, root port has neither MSI/MSI-X nor INTx
> +	 * interrupt support in RC mode, so try to use other interrupt(i.e.
> +	 * shared interrupt if supported).
> +	 */
> +	else if (port_other_interrupt_enabled && dev->irq)
> +		irq = dev->irq;

Is there any reason to not use dev->irq if it is non-zero?

-Scott

