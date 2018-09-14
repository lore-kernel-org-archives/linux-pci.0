Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIODtx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 23:49:53 -0400
Date: Fri, 14 Sep 2018 16:33:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2 6/6] PCI: Expose reset type to users of
 pci_reset_bus()
Message-ID: <20180914163321.2abba9fa@t450s.home>
In-Reply-To: <20180914211808.2564-7-okaya@kernel.org>
References: <20180914211808.2564-1-okaya@kernel.org>
        <20180914211808.2564-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 14 Sep 2018 21:18:08 +0000
Sinan Kaya <okaya@kernel.org> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index fe7ada997c51..754f08286bb1 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1015,7 +1015,7 @@ static long vfio_pci_ioctl(void *device_data,
>  						    &info, slot);
>  		if (!ret)
>  			/* User has access, do the reset */
> -			ret = pci_reset_bus(vdev->pdev);
> +			ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);

This should have switched back the control we had prior to 811c5cb37df4
with something like:

	ret = pci_reset_bus(vdev->pdev,
			slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);

>  
>  hot_reset_release:
>  		for (i--; i >= 0; i--)
> @@ -1390,7 +1390,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
>  	}
>  
>  	if (needs_reset)
> -		ret = pci_reset_bus(vdev->pdev);
> +		ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);

Same here.  Thanks,

Alex
