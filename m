Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A0C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A371220815
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 02:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfADCqA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfADCp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 21:45:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78391C04FFFF;
        Fri,  4 Jan 2019 02:45:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51CB9600C3;
        Fri,  4 Jan 2019 02:45:51 +0000 (UTC)
Date:   Fri, 4 Jan 2019 10:45:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 3/4] PCI/MSI: Handle vector reduce and retry
Message-ID: <20190104024546.GD31330@ming.t460p>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103225033.11249-4-keith.busch@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 04 Jan 2019 02:45:59 +0000 (UTC)
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
> +
> +It may also be the case that a driver wants multiple sets of fully
> +affinitized vectors. For example, a single PCI function may provide
> +different high performance services that want full CPU affinity for each
> +service independent of other services. In this case, the driver may use
> +the struct irq_affinity's 'nr_sets' field to specify how many groups of
> +vectors need to be spread across all the CPUs, and fill in the 'sets'
> +array to say how many vectors the driver wants in each set.
> +
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

->recalc_sets() should have been done after msi_capability_init() makes at least
'minvec' is available.

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

->recalc_sets() should have been done after __pci_enable_msix() makes at least
'minvec' is available.

Thanks,
Ming
