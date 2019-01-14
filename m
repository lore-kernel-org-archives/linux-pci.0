Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5848BC43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BD720659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547508223;
	bh=EoY1rmjd/3x1i4yq5mZn/iUOqC5nzyn0WH42TMBgnco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DHJCYnlom2XgoGqJaULwsYjaIbt/c+RXSEKcN6xcY8EoEaqdtrxgJF+iz0t5ZRLT8
	 iU+iWiWB9CwvFcgoTVmqG47sSBv9g5lRO/9cSvxtVpx8ck7BWNsds5vDkC0UIlFqwD
	 EkPElSBWlu7QlnSgOJkbBos3sqDYnknKqGFnDzCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfANXXm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfANXXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 18:23:42 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29364205C9;
        Mon, 14 Jan 2019 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547508221;
        bh=EoY1rmjd/3x1i4yq5mZn/iUOqC5nzyn0WH42TMBgnco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2BwpIwYUH9qq3bTZ5YmNn/VGYbd9ZeSdDGI2mejBoDlGl9SHjW3cewkWowGkJmds
         dt0R9q/tUuq5JVF87WDJtRVB4eC8gYEGgltLRiD5dnI7MlzlR6hEKohoGNT3eayKYV
         LXOMT/ORRc3UPQJ+YIzucpKiNr9f3EhFEy0XLYJ4=
Date:   Mon, 14 Jan 2019 17:23:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-pci@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190114232338.GE33971@google.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103013106.26452-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 09:31:06AM +0800, Ming Lei wrote:
> The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
> if fewer than @min_vecs interrupt vectors are available for @dev.
> 
> However, if a device supports MSI-X but not MSI and a caller requests
> @min_vecs that can't be satisfied by MSI-X, we previously returned
> -EINVAL (from the failed attempt to enable MSI), not -ENOSPC.
> 
> Users of pci_alloc_irq_vectors_affinity() may try to reduce irq vectors
> and allocate vectors again in case that -ENOSPC is returned, such as NVMe,
> so we need to respect the current interface and give preference to -ENOSPC.
> 
> Especially the min/max vecs doesn't work correctly when using the
> irq_affinity nr_sets because rebalancing the set counts is driver specific.
> To get around that, drivers using nr_sets have to set min and max to the same
> value and handle the "reduce and try again".
> 
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: linux-nvme@lists.infradead.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Applied to pci/msi for v5.1, thanks!

If this is something that should be in v5.0, let me know and include the
justification, e.g., something we already merged for v5.0 or regression
info, etc, and a Fixes: line, and I'll move it to for-linus.

> ---
>  drivers/pci/msi.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a1c8a09efa5..4c0b47867258 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   const struct irq_affinity *affd)
>  {
>  	static const struct irq_affinity msi_default_affd;
> -	int vecs = -ENOSPC;
> +	int msix_vecs = -ENOSPC;
> +	int msi_vecs = -ENOSPC;
>  
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
> @@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	}
>  
>  	if (flags & PCI_IRQ_MSIX) {
> -		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> -				affd);
> -		if (vecs > 0)
> -			return vecs;
> +		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> +						    max_vecs, affd);
> +		if (msix_vecs > 0)
> +			return msix_vecs;
>  	}
>  
>  	if (flags & PCI_IRQ_MSI) {
> -		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> -		if (vecs > 0)
> -			return vecs;
> +		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
> +						  affd);
> +		if (msi_vecs > 0)
> +			return msi_vecs;
>  	}
>  
>  	/* use legacy irq if allowed */
> @@ -1199,7 +1201,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	return vecs;
> +	if (msix_vecs == -ENOSPC)
> +		return -ENOSPC;
> +	return msi_vecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>  
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
