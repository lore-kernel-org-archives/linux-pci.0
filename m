Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45233 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdBFRdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 12:33:01 -0500
Date: Mon, 6 Feb 2017 09:33:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv5 2/5] pci: Add device disconnected state
Message-ID: <20170206173300.GC25762@infradead.org>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486144555-5526-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 12:55:52PM -0500, Keith Busch wrote:
> This patch adds a new state to pci_dev to be set when it is unexpectedly
> disconnected. The pci driver tear down functions can observe this new
> device state so they may skip operations that will fail.
> 
> The pciehp and pcie-dpc drivers are aware when the link is down, so
> these set the flag when their handlers detect the device is disconnected.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/hotplug/pciehp_pci.c |  5 +++++
>  drivers/pci/pci.h                | 14 ++++++++++++++
>  drivers/pci/pcie/pcie-dpc.c      |  4 ++++
>  include/linux/pci.h              |  2 ++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
> index 9e69403..9b2f41d 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -109,6 +109,11 @@ int pciehp_unconfigure_device(struct slot *p_slot)
>  				break;
>  			}
>  		}
> +		if (!presence) {
> +			pci_dev_set_disconnected(dev, NULL);
> +			if (pci_has_subordinate(dev))
> +				pci_walk_bus(dev->subordinate, pci_dev_set_disconnected, NULL);

overlong line here.

> +static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
> +{
> +	set_bit(PCI_DEV_DISCONNECTED, &dev->priv_flags);
> +	return 0;
> +}

Return void here?

> +			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected, NULL);

Antother too long line.

Except for these nitpicks this patch looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
