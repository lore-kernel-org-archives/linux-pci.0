Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A550BC43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60389218D8
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546641359;
	bh=eLFx5QsO2PNppJ6lUJMQmQuIs2Dj1CrYe2EsOqMxe2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uOtrpVOzoNsq8hti4qeI4rH9yFJBj1Ssd9A91YIEjlAGXsrotCh/i0Byq6Xdh7VAq
	 gc1TvP9C8wM6bJes9iOtHS2aimohs5zv3/myDpz+M1IqIUZbPxcYfCSZfIw7gdPtCf
	 qxW9J4UwQ/qtZ7lw6aq58Yw95We8Y0MCl5L/8GXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfADWf6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfADWf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 17:35:58 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBD021872;
        Fri,  4 Jan 2019 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546641357;
        bh=eLFx5QsO2PNppJ6lUJMQmQuIs2Dj1CrYe2EsOqMxe2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzV0gi+iQKIxYUK/HMd1lq4DF/tCcVtbCHdiJEq1Fw+ovpTISAmmhrokB8xKF+Gz+
         8CKjBKv8R+OZcIqSA5VhfBanhZXrd6D45nKp2Lk+QbFN5SoY6tSw43si3LBMxP+MzV
         UVt5fhI+kKW7t2g2e2jex4ge8LDErOiEfWlgVLn4=
Date:   Fri, 4 Jan 2019 16:35:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 3/4] PCI/MSI: Handle vector reduce and retry
Message-ID: <20190104223531.GA223506@google.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-4-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 03, 2019 at 03:50:32PM -0700, Keith Busch wrote:
> The struct irq_affinity nr_sets forced the driver to handle reducing the
> vector count on allocation failures because the set distribution counts
> are driver specific. The change to this API requires very different usage
> than before, and introduced new error corner cases that weren't being
> handled. It is also less efficient since the driver doesn't actually
> know what a proper vector count it should use since it only sees the
> error code and can only reduce by one instead of going straight to a
> possible vector count like PCI is able to do.
> 
> Provide a driver specific callback for managed irq set creation so that
> PCI can take a min and max vectors as before to handle the reduce and
> retry logic.
> 
> The usage is not particularly obvious for this new feature, so append
> documentation for driver usage.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/PCI/MSI-HOWTO.txt | 36 +++++++++++++++++++++++++++++++++++-
>  drivers/pci/msi.c               | 20 ++++++--------------
>  include/linux/interrupt.h       |  5 +++++
>  3 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
> index 618e13d5e276..391b1f369138 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.txt
> @@ -98,7 +98,41 @@ The flags argument is used to specify which type of interrupt can be used
>  by the device and the driver (PCI_IRQ_LEGACY, PCI_IRQ_MSI, PCI_IRQ_MSIX).
>  A convenient short-hand (PCI_IRQ_ALL_TYPES) is also available to ask for
>  any possible kind of interrupt.  If the PCI_IRQ_AFFINITY flag is set,
> -pci_alloc_irq_vectors() will spread the interrupts around the available CPUs.
> +pci_alloc_irq_vectors() will spread the interrupts around the available
> +CPUs. Vector affinities allocated under the PCI_IRQ_AFFINITY flag are
> +managed by the kernel, and are not tunable from user space like other
> +vectors.
> +
> +When your driver requires a more complex vector affinity configuration
> +than a default spread of all vectors, the driver may use the following
> +function:
> +
> +  int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +				   unsigned int max_vecs, unsigned int flags,
> +				   const struct irq_affinity *affd);
> +
> +The 'struct irq_affinity *affd' allows a driver to specify additional
> +characteristics for how a driver wants the vector management to occur. The
> +'pre_vectors' and 'post_vectors' fields define how many vectors the driver
> +wants to not participate in kernel managed affinities, and whether those
> +special vectors are at the beginning or the end of the vector space.

How are the pre_vectors and post_vectors handled?  Do they get
assigned to random CPUs?  Current CPU?  Are their assignments tunable
from user space?

> +It may also be the case that a driver wants multiple sets of fully
> +affinitized vectors. For example, a single PCI function may provide
> +different high performance services that want full CPU affinity for each
> +service independent of other services. In this case, the driver may use
> +the struct irq_affinity's 'nr_sets' field to specify how many groups of
> +vectors need to be spread across all the CPUs, and fill in the 'sets'
> +array to say how many vectors the driver wants in each set.

I think the issue here is IRQ vectors, and "services" and whether
they're high performance are unnecessary concepts.

What does irq_affinity.sets point to?  I guess it's a table of
integers where the table size is the number of sets and each entry is
the number of vectors in the set?

So we'd have something like this:

  pre_vectors     # vectors [0..pre_vectors) (pre_vectors >= 0)
  set 0           # vectors [pre_vectors..pre_vectors+set0) (set0 >= 1)
  set 1           # vectors [pre_vectors+set0..pre_vectors+set0+set1) (set1 >= 1)
  ...
  post_vectors    # vectors [pre_vectors+set0..pre_vectors+set0+set1+setN+post_vectors)

where the vectors in set0 are spread across all CPUs, those in set1
are independently spread across all CPUs, etc?

I would guess there may be device-specific restrictions on the mapping
of of these vectors to sets, so the PCI core probably can't assume the
sets can be of arbitrary size, contiguous, etc.

> +When using multiple affinity 'sets', the error handling for vector
> +reduction and retry becomes more complicated since the PCI core
> +doesn't know how to redistribute the vector count across the sets. In
> +order to provide this error handling, the driver must also provide the
> +'recalc_sets()' callback and set the 'priv' data needed for the driver
> +specific vector distribution. The driver's callback is responsible to
> +ensure the sum of the vector counts across its sets matches the new
> +vector count that PCI can allocate.
>  
>  To get the Linux IRQ numbers passed to request_irq() and free_irq() and the
>  vectors, use the following function:
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a1c8a09efa5..b93ac49be18d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msi_enabled))
>  		return -EINVAL;
>  
> @@ -1061,6 +1054,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  				return -ENOSPC;
>  		}
>  
> +		if (nvec != maxvec && affd && affd->recalc_sets)
> +			affd->recalc_sets((struct irq_affinity *)affd, nvec);
> +
>  		rc = msi_capability_init(dev, nvec, affd);
>  		if (rc == 0)
>  			return nvec;
> @@ -1093,13 +1089,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> @@ -1110,6 +1099,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  				return -ENOSPC;
>  		}
>  
> +		if (nvec != maxvec && affd && affd->recalc_sets)
> +			affd->recalc_sets((struct irq_affinity *)affd, nvec);
> +
>  		rc = __pci_enable_msix(dev, entries, nvec, affd);
>  		if (rc == 0)
>  			return nvec;
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index c672f34235e7..01c06829ff43 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -249,12 +249,17 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
>   * @sets:		Number of affinitized sets
> + * @recalc_sets:	Recalculate sets if the previously requested allocation
> + *			failed
> + * @priv:		Driver private data
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
>  	int	nr_sets;
>  	int	*sets;
> +	void	(*recalc_sets)(struct irq_affinity *, unsigned int);
> +	void	*priv;
>  };
>  
>  /**
> -- 
> 2.14.4
> 
