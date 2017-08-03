Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdHCVw5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 17:52:57 -0400
Date: Thu, 3 Aug 2017 16:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 1/2] vmd: Reserve IRQ pre-vector for better affinity
Message-ID: <20170803215254.GH20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1500593634-4558-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500593634-4558-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 20, 2017 at 07:33:53PM -0400, Keith Busch wrote:
> The driver has a special purpose for the vmd device's first, so this
> one shouldn't be considered for irq affinity.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Applied both to pci/host-vmd for v4.14, thanks!

> ---
>  drivers/pci/host/vmd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index e27ad2a..8cddf30 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -662,6 +662,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int i, err;
>  
> +	/*
> +	 * The first vector is reserved for special use, so start affinity at
> +	 * the second vector
> +	 */
> +	struct irq_affinity affd = {
> +		.pre_vectors = 1,
> +	};
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> @@ -687,8 +695,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> -					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
> +	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
> +					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> -- 
> 2.5.5
> 
