Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3DWUMs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Apr 2013 16:12:48 -0400
Message-ID: <1366747958.2918.651.camel@bling.home>
Subject: Re: [PATCH v4 21/22] vfio-pci: Use PCI_MSIX_TABLE_BIR, not
 PCI_MSIX_FLAGS_BIRMASK
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 14:12:38 -0600
In-Reply-To: <20130422231235.32621.48799.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
	 <20130422231235.32621.48799.stgit@bhelgaas-glaptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 17:12 -0600, Bjorn Helgaas wrote:
> PCI_MSIX_FLAGS_BIRMASK is mis-named because the BIR mask is in the
> Table Offset register, not the flags ("Message Control" per spec)
> register.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 8189cb6..10626e8 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -78,8 +78,8 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		pci_read_config_word(pdev, msix_pos + PCI_MSIX_FLAGS, &flags);
>  		pci_read_config_dword(pdev, msix_pos + PCI_MSIX_TABLE, &table);
>  
> -		vdev->msix_bar = table & PCI_MSIX_FLAGS_BIRMASK;
> -		vdev->msix_offset = table & ~PCI_MSIX_FLAGS_BIRMASK;
> +		vdev->msix_bar = table & PCI_MSIX_TABLE_BIR;
> +		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
>  		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
>  	} else
>  		vdev->msix_bar = 0xFF;
> 

Acked-by: Alex Williamson <alex.williamson@redhat.com>

