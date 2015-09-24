Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39143 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbbIXVgq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 17:36:46 -0400
Date: Thu, 24 Sep 2015 16:36:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Davis <wdavis@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 10/22] PCI: Add pci_resource_to_peer()
Message-ID: <20150924213643.GG10481@localhost>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
 <1442337067-22964-11-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442337067-22964-11-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 12:10:55PM -0500, Will Davis wrote:
> Add helper to convert a struct resource to a peer DMA address.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> ---
>  include/linux/pci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db0cb51..2a9deff 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1508,6 +1508,22 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
>  }
>  #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
>  
> +#ifdef CONFIG_HAS_DMA_P2P
> +static inline bool pci_resource_to_peer(struct pci_dev *dev,

I'm not really a fan of functions that return bool unless the
function name is obviously a predicate.  So in this case, I'd
return 0 or a negative errno.

> +					struct pci_dev *peer,
> +					struct resource *res,
> +					dma_peer_addr_t *peer_addr) {
> +	if (pci_peer_traffic_supported(dev, peer)) {
> +		struct pci_bus_region region;
> +
> +		pcibios_resource_to_bus(dev->bus, &region, res);
> +		*peer_addr = region.start;
> +		return true;
> +	}
> +
> +	return false;

It's trivial, but I'd structure it like this, which is sort of the
typical "return errors early" pattern, and reduces indentation of the
mainline path:

  if (!pci_peer_traffic_supported(dev, peer))
    return -EINVAL;

  pcibios_resource_to_bus(dev->bus, &region, res);
  *peer_addr = region.start;
  return 0;

> +}
> +#endif /* CONFIG_HAS_DMA_P2P */
>  
>  /*
>   *  The world is not perfect and supplies us with broken PCI devices.
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
