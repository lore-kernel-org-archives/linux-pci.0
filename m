Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753913AbdCWR3d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Mar 2017 13:29:33 -0400
Date: Thu, 23 Mar 2017 12:29:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Message-ID: <20170323172928.GA23612@bhelgaas-glaptop.roam.corp.google.com>
References: <20170301233158.1035-1-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301233158.1035-1-himanshu.madhani@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 01, 2017 at 03:31:58PM -0800, Himanshu Madhani wrote:
> From: Michael Hernandez <michael.hernandez@cavium.com>
> 
> min_vecs is the minimum amount of vectors needed to operate in MSI-X mode
> which may just include the vectors that don't need affinity.
> 
> Disabling affinity settings causes the qla2xxx driver scsi_add_host
> to fail when blk_mq is enabled as the blk_mq_pci_map_queues expects
> affinity masks on each vector.
> 
> v2 --> v3
> o fixed code as per review comments.
> 
> v1 --> v2
> 
> o Moved the check from pci_alloc_irq_vectors_affinity() to
>   __pci_enable_{msi|msix}_range()
> 
> Fixes: dfef358 ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
> Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/msi.c |   25 ++++++++++++++++++-------
>  1 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7f73bac..46c0cdd 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1091,6 +1091,15 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  
>  	for (;;) {
>  		if (affd) {
> +			/*
> +			 * If there aren't any vectors left after applying the
> +			 * pre/post vectors don't bother with assigning
> +			 * affinity.
> +			 */
> +			if (affd->pre_vectors + affd->post_vectors == nvec)
> +				affd = NULL;
> +		}

I don't really like this because affd->pre_vectors and
affd->post_vectors are not PCI MSI concepts.  I think they really
belong in irq/affinity.c, e.g., maybe this could be checked in
irq_create_affinity_masks().

If that could be done, we wouldn't have to duplicate the checks here
for both MSI and MSI-X.

I raised a similar question earlier:
http://lkml.kernel.org/r/20170202173659.GD21267@bhelgaas-glaptop.roam.corp.google.com

> +		if (affd) {
>  			nvec = irq_calc_affinity_vectors(nvec, affd);
>  			if (nvec < minvec)
>  				return -ENOSPC;
> @@ -1138,6 +1147,15 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  
>  	for (;;) {
>  		if (affd) {
> +			/*
> +			 * If there aren't any vectors left after applying the
> +			 * pre/post vectors don't bother with assigning
> +			 * affinity.
> +			 */
> +			if (affd->pre_vectors + affd->post_vectors == nvec)
> +				affd = NULL;
> +		}
> +		if (affd) {
>  			nvec = irq_calc_affinity_vectors(nvec, affd);
>  			if (nvec < minvec)
>  				return -ENOSPC;
> @@ -1209,13 +1227,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  
>  		if (affd->pre_vectors + affd->post_vectors > min_vecs)
>  			return -EINVAL;
> -
> -		/*
> -		 * If there aren't any vectors left after applying the pre/post
> -		 * vectors don't bother with assigning affinity.
> -		 */
> -		if (affd->pre_vectors + affd->post_vectors == min_vecs)
> -			affd = NULL;
>  	} else {
>  		if (WARN_ON(affd))
>  			affd = NULL;
> -- 
> 1.7.1
> 
