Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1931 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab3DWUN7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Apr 2013 16:13:59 -0400
Message-ID: <1366748035.2918.652.camel@bling.home>
Subject: Re: [PATCH v4 22/22] vfio-pci: Use cached MSI/MSI-X capabilities
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 14:13:55 -0600
In-Reply-To: <20130422231242.32621.38158.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
	 <20130422231242.32621.38158.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 17:12 -0600, Bjorn Helgaas wrote:
> We now cache the MSI/MSI-X capability offsets in the struct pci_dev,
> so no need to find the capabilities again.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 10626e8..05afe88 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -70,7 +70,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  	}
>  
> -	msix_pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
> +	msix_pos = pdev->msix_cap;
>  	if (msix_pos) {
>  		u16 flags;
>  		u32 table;
> @@ -183,7 +183,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  		u8 pos;
>  		u16 flags;
>  
> -		pos = pci_find_capability(vdev->pdev, PCI_CAP_ID_MSI);
> +		pos = vdev->pdev->msi_cap;
>  		if (pos) {
>  			pci_read_config_word(vdev->pdev,
>  					     pos + PCI_MSI_FLAGS, &flags);
> @@ -194,7 +194,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  		u8 pos;
>  		u16 flags;
>  
> -		pos = pci_find_capability(vdev->pdev, PCI_CAP_ID_MSIX);
> +		pos = vdev->pdev->msix_cap;
>  		if (pos) {
>  			pci_read_config_word(vdev->pdev,
>  					     pos + PCI_MSIX_FLAGS, &flags);
> 

Acked-by: Alex Williamson <alex.williamson@redhat.com>

