Return-Path: <SRS0=eCDn=PJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124CEC43387
	for <linux-pci@archiver.kernel.org>; Tue,  1 Jan 2019 05:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AF3208E3
	for <linux-pci@archiver.kernel.org>; Tue,  1 Jan 2019 05:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfAAFZM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 00:25:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfAAFZL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 00:25:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71E9286679;
        Tue,  1 Jan 2019 05:25:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0277526363;
        Tue,  1 Jan 2019 05:25:03 +0000 (UTC)
Date:   Tue, 1 Jan 2019 13:24:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20190101052458.GA17588@ming.t460p>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231220059.GI159477@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 01 Jan 2019 05:25:11 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 31, 2018 at 04:00:59PM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 29, 2018 at 11:26:48AM +0800, Ming Lei wrote:
> > The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
> > if leass than @min_vecs interrupt vectors are available for @dev.
> 
> s/leass/fewer/
> 
> > However, this way may be changed by falling back to
> > __pci_enable_msi_range(), for example, if the device isn't capable of
> > MSI, __pci_enable_msi_range() will return -EINVAL, and finally it is
> > returned to users of pci_alloc_irq_vectors_affinity() even though
> > there are quite MSIX vectors available. This way violates the interface.
> 
> I *think* the above means:
> 
>   If a device supports MSI-X but not MSI and a caller requests
>   @min_vecs that can't be satisfied by MSI-X, we previously returned
>   -EINVAL (from the failed attempt to enable MSI), not -ENOSPC.
> 
> and I agree that this doesn't match the documented API.

OK, will use the above comment log.

> 
> > Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> > vectors and allocate vectors again in case that -ENOSPC is returned, such
> > as NVMe, so we need to respect the current interface and give preference to
> > -ENOSPC.
> 
> I thought the whole point of the (min_vecs, max_vecs) tuple was to
> avoid this sort of "reduce and try again" iteration in the callers.

As Keith replied, in case of NVMe, we have to keep min_vecs same with
max_vecs.

> 
> > Cc: Jens Axboe <axboe@fb.com>,
> > Cc: Keith Busch <keith.busch@intel.com>,
> > Cc: linux-pci@vger.kernel.org,
> > Cc: Bjorn Helgaas <bhelgaas@google.com>,
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/pci/msi.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 7a1c8a09efa5..91b4f03fee91 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  				   const struct irq_affinity *affd)
> >  {
> >  	static const struct irq_affinity msi_default_affd;
> > -	int vecs = -ENOSPC;
> > +	int msix_vecs = -ENOSPC;
> > +	int msi_vecs = -ENOSPC;
> >  
> >  	if (flags & PCI_IRQ_AFFINITY) {
> >  		if (!affd)
> > @@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  	}
> >  
> >  	if (flags & PCI_IRQ_MSIX) {
> > -		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> > -				affd);
> > -		if (vecs > 0)
> > -			return vecs;
> > +		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> > +						    max_vecs, affd);
> > +		if (msix_vecs > 0)
> > +			return msix_vecs;
> >  	}
> >  
> >  	if (flags & PCI_IRQ_MSI) {
> > -		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> > -		if (vecs > 0)
> > -			return vecs;
> > +		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
> > +						  affd);
> > +		if (msi_vecs > 0)
> > +			return msi_vecs;
> >  	}
> >  
> >  	/* use legacy irq if allowed */
> > @@ -1199,7 +1201,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  		}
> >  	}
> >  
> > -	return vecs;
> > +	return msix_vecs == -ENOSPC ? msix_vecs : msi_vecs;
> 
> If you know you want to return -ENOSPC, just return that, not a
> variable that happens to contain it, i.e.,
> 
>   if (msix_vecs == -ENOSPC)
>     return -ENOSPC;
>   return msi_vecs;

OK.

Thanks,
Ming
