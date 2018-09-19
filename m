Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbeITAju (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 20:39:50 -0400
Date: Wed, 19 Sep 2018 13:00:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v4 6/6] PCI: Expose reset type to users of
 pci_reset_bus()
Message-ID: <20180919130033.5f65b1c8@t450s.home>
In-Reply-To: <20180919163037.13497-7-okaya@kernel.org>
References: <20180919163037.13497-1-okaya@kernel.org>
        <20180919163037.13497-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 19 Sep 2018 16:30:37 +0000
Sinan Kaya <okaya@kernel.org> wrote:

> Looking to have more control between the users of the API vs. what the API
> can do internally. The new reset_type tells the PCI core about the bounds
> of the request.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/pci/pci.c           | 18 +++++++++++++++---
>  drivers/vfio/pci/vfio_pci.c |  6 ++++--
>  include/linux/pci.h         |  2 +-
>  3 files changed, 20 insertions(+), 6 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b4f14419bd51..f11d29f32119 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5232,13 +5232,25 @@ static int __pci_reset_bus(struct pci_bus *bus)
>  /**
>   * pci_reset_bus - Try to reset a PCI bus
>   * @pdev: top level PCI device to reset via slot/bus
> + * @reset_type: resets to try
>   *
>   * Same as above except return -EAGAIN if the bus cannot be locked
>   */
> -int pci_reset_bus(struct pci_dev *pdev)
> +int pci_reset_bus(struct pci_dev *pdev, u32 reset_type)
>  {
> -	return (!pci_probe_reset_slot(pdev->slot)) ?
> -	    __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> +	if (reset_type & PCI_RESET_LINK) {
> +		return (!pci_probe_reset_slot(pdev->slot)) ?
> +				__pci_reset_slot(pdev->slot) :
> +				__pci_reset_bus(pdev->bus);
> +	}
> +
> +	if (reset_type & PCI_RESET_BUS)
> +		return __pci_reset_bus(pdev->bus);
> +
> +	if (reset_type & PCI_RESET_SLOT)
> +		return __pci_reset_slot(pdev->slot);
> +
> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(pci_reset_bus);
>  
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index fe7ada997c51..0e80c72b1eaa 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1015,7 +1015,8 @@ static long vfio_pci_ioctl(void *device_data,
>  						    &info, slot);
>  		if (!ret)
>  			/* User has access, do the reset */
> -			ret = pci_reset_bus(vdev->pdev);
> +			ret = pci_reset_bus(vdev->pdev,
> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
>  
>  hot_reset_release:
>  		for (i--; i >= 0; i--)
> @@ -1390,7 +1391,8 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
>  	}
>  
>  	if (needs_reset)
> -		ret = pci_reset_bus(vdev->pdev);
> +		ret = pci_reset_bus(vdev->pdev,
> +				slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
>  
>  put_devs:
>  	for (i = 0; i < devs.cur_index; i++) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 4fdddcb85066..85f48e156753 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1128,7 +1128,7 @@ int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
>  int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
>  int pci_probe_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
> -int pci_reset_bus(struct pci_dev *dev);
> +int pci_reset_bus(struct pci_dev *dev, u32 reset_type);
>  void pci_reset_secondary_bus(struct pci_dev *dev);
>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
