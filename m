Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53812 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758150AbbJVS4v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 14:56:51 -0400
Date: Thu, 22 Oct 2015 13:56:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Ben Shelton <benjamin.h.shelton@intel.com>,
	linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] PCI: Remove unnecessary re-read of SR-IOV offset/stride
 registers
Message-ID: <20151022185647.GF21237@localhost>
References: <20151016211628.31492.86258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151016211628.31492.86258.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 16, 2015 at 04:16:28PM -0500, Bjorn Helgaas wrote:
> Previously, we read PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE from the
> SR-IOV capability in pci_iov_set_numvfs() after changing PCI_SRIOV_NUM_VF,
> and we read them again in sriov_enable().  But sriov_init() always calls
> pci_iov_set_numvfs() before a successful return, and it caches the offset
> and stride values, so there's no need to read the capability again in
> sriov_enable().
> 
> Remove the PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE config reads from
> sriov_enable() and use the cached values from the pci_sriov structure.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I haven't seen any objections, so I applied this to pci/virtualization for
v4.4.

> ---
>  drivers/pci/iov.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 0202ab0..9b52ad4 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -230,7 +230,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	int rc;
>  	int i, j;
>  	int nres;
> -	u16 offset, stride, initial;
> +	u16 initial;
>  	struct resource *res;
>  	struct pci_dev *pdev;
>  	struct pci_sriov *iov = dev->sriov;
> @@ -253,9 +253,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
>  		return -EINVAL;
>  
> -	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &offset);
> -	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &stride);
> -	if (!offset || (nr_virtfn > 1 && !stride))
> +	if (!iov->offset || (nr_virtfn > 1 && !iov->stride))
>  		return -EIO;
>  
>  	nres = 0;
> @@ -270,9 +268,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  		return -ENOMEM;
>  	}
>  
> -	iov->offset = offset;
> -	iov->stride = stride;
> -
>  	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
>  	if (bus > dev->bus->busn_res.end) {
>  		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
