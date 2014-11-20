Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:64521 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaKTXLi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Nov 2014 18:11:38 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so3837360iec.30
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2014 15:11:38 -0800 (PST)
Date: Thu, 20 Nov 2014 16:11:35 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix device node for virtual bus
Message-ID: <20141120231135.GE7987@google.com>
References: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415760163-12517-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 12, 2014 at 01:42:43PM +1100, Gavin Shan wrote:
> pci_set_bus_of_node() sets virtual PCI bus's device node to PHB's
> device node wrongly. The patch fixes the issue.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to pci/misc for v3.19, thanks!

Thanks for explaining this to me.  It seems obvious now that I look at the
code.

> ---
>  drivers/pci/of.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index f092993..7b2256b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -31,9 +31,9 @@ void pci_release_of_node(struct pci_dev *dev)
>  
>  void pci_set_bus_of_node(struct pci_bus *bus)
>  {
> -	if (bus->self == NULL)
> +	if (pci_is_root_bus(bus))
>  		bus->dev.of_node = pcibios_get_phb_of_node(bus);
> -	else
> +	else if (bus->self)
>  		bus->dev.of_node = of_node_get(bus->self->dev.of_node);
>  }
>  
> -- 
> 1.8.3.2
> 
