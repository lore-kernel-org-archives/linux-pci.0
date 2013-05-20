Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33587 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756487Ab3ETXmX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 May 2013 19:42:23 -0400
Message-ID: <1369093321.6387.24.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/PCI: Use PCI_UNKNOWN for unknown power state
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Date: Tue, 21 May 2013 09:42:01 +1000
In-Reply-To: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
References: <20130520231909.32416.81752.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-05-20 at 17:19 -0600, Bjorn Helgaas wrote:
> Previously we initialized dev->current_state to 4 (PCI_D3cold), but I think
> we wanted PCI_UNKNOWN (5) here based on the comment and the fact that the
> generic version of this code, pci_setup_device(), uses PCI_UNKNOWN.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Ack. Do you send to Linus or should I ?

Thanks.

Cheers,
Ben.

>  arch/powerpc/kernel/pci_of_scan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 2a67e9b..d2d407d 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -165,7 +165,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
>  	pr_debug("    class: 0x%x\n", dev->class);
>  	pr_debug("    revision: 0x%x\n", dev->revision);
>  
> -	dev->current_state = 4;		/* unknown power state */
> +	dev->current_state = PCI_UNKNOWN;	/* unknown power state */
>  	dev->error_state = pci_channel_io_normal;
>  	dev->dma_mask = 0xffffffff;
>  


