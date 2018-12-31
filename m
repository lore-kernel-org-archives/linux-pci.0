Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B74C43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD75B21783
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546293662;
	bh=DfKXBotlMsGMKpqY2oZ3mKfC7uXI7DkTTexz5WHoZYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Id5VQe/iIRk0iKl85o0Joc+q9TH0tHFaVjdNoGOTAWBC38SRmc89m+JcqBp3jQODu
	 fnuGoGwZumUETAiIceaSKwTFms3S89TN2CdWYCO0XdJpQDEUGN8m/+cFCwNrbiCFEM
	 Ey7yJS6IVrF+v5G50e4nJgwHeURtlfh7Sb4hrTwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeLaWBC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbeLaWBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 17:01:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C175B21019;
        Mon, 31 Dec 2018 22:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546293661;
        bh=DfKXBotlMsGMKpqY2oZ3mKfC7uXI7DkTTexz5WHoZYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8No7RKMPPQttkmTKS/hlUNhsJH6x/X3SX8LSWHT3RCinNRsP2CTi2frlGu6lxkmE
         b6tICR3JJsIlr1IXuZkFfj5MVabyX8VcBsM1P1V3qCVOZ8T5VYGFS/kbC0eb8K8uxo
         UZJz8OuIsHlMrBAJKiOnYyNS6f6NRkhNj4GRiu9A=
Date:   Mon, 31 Dec 2018 16:00:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20181231220059.GI159477@google.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229032650.27256-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 29, 2018 at 11:26:48AM +0800, Ming Lei wrote:
> The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
> if leass than @min_vecs interrupt vectors are available for @dev.

s/leass/fewer/

> However, this way may be changed by falling back to
> __pci_enable_msi_range(), for example, if the device isn't capable of
> MSI, __pci_enable_msi_range() will return -EINVAL, and finally it is
> returned to users of pci_alloc_irq_vectors_affinity() even though
> there are quite MSIX vectors available. This way violates the interface.

I *think* the above means:

  If a device supports MSI-X but not MSI and a caller requests
  @min_vecs that can't be satisfied by MSI-X, we previously returned
  -EINVAL (from the failed attempt to enable MSI), not -ENOSPC.

and I agree that this doesn't match the documented API.

> Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> vectors and allocate vectors again in case that -ENOSPC is returned, such
> as NVMe, so we need to respect the current interface and give preference to
> -ENOSPC.

I thought the whole point of the (min_vecs, max_vecs) tuple was to
avoid this sort of "reduce and try again" iteration in the callers.

> Cc: Jens Axboe <axboe@fb.com>,
> Cc: Keith Busch <keith.busch@intel.com>,
> Cc: linux-pci@vger.kernel.org,
> Cc: Bjorn Helgaas <bhelgaas@google.com>,
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/pci/msi.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a1c8a09efa5..91b4f03fee91 100644
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
> @@ -1199,7 +1201,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	return vecs;
> +	return msix_vecs == -ENOSPC ? msix_vecs : msi_vecs;

If you know you want to return -ENOSPC, just return that, not a
variable that happens to contain it, i.e.,

  if (msix_vecs == -ENOSPC)
    return -ENOSPC;
  return msi_vecs;

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
