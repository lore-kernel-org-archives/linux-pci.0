Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36189 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbHJQvU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 12:51:20 -0400
Received: by ioeg141 with SMTP id g141so175452506ioe.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 09:51:20 -0700 (PDT)
Date: Mon, 10 Aug 2015 11:51:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Davis <wdavis@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v4 10/12] pci: add pci_find_common_upstream_dev()
Message-ID: <20150810165116.GA32452@google.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
 <1437601197-6481-11-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437601197-6481-11-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 22, 2015 at 04:39:55PM -0500, Will Davis wrote:
> Adds an interface to find the first device which is upstream of both
> devices.
> 
> Signed-off-by: Will Davis <wdavis@nvidia.com>
> ---
>  drivers/pci/search.c | 25 +++++++++++++++++++++++++
>  include/linux/pci.h  |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a20ce7d..cbd8163 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -384,3 +384,28 @@ int pci_dev_present(const struct pci_device_id *ids)
>  	return 0;
>  }
>  EXPORT_SYMBOL(pci_dev_present);
> +
> +/**
> + * pci_find_common_upstream_dev - Returns the first common upstream device
> + * @from: the PCI device to search for a common upstream device from
> + * @to: the PCI device to search for a common upstream device to
> + *
> + * Walks up the bus hierarchy from the @from device, looking for the first bus
> + * which the @to device is downstream of. Returns %NULL if the devices do not
> + * share any upstream devices.

This interface looks like it should be symmetric: you should get the same
answer regardless of which device is "from" and which is "to".  I would
rename the arguments to something more neutral to reflect that.

> + */
> +struct pci_dev *pci_find_common_upstream_dev(struct pci_dev *from,
> +					     struct pci_dev *to)
> +{
> +	struct pci_dev *pdev = from;
> +
> +	while (pdev != NULL) {
> +		if ((to->bus->number >= pdev->bus->busn_res.start) &&
> +		    (to->bus->number <= pdev->bus->busn_res.end))
> +			return pdev;
> +		pdev = pdev->bus->self;

I think you want "pdev = pci_upstream_bridge(pdev)" here; otherwise you'll
exit the loop early if "from" is a VF on a virtual bus.

> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(pci_find_common_upstream_dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d58063e..8262b9e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -860,6 +860,8 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  }
>  struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
>  int pci_dev_present(const struct pci_device_id *ids);
> +struct pci_dev *pci_find_common_upstream_dev(struct pci_dev *from,
> +					     struct pci_dev *to);
>  
>  int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
>  			     int where, u8 *val);
> -- 
> 2.4.6
> 
