Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59287 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcELHfA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 May 2016 03:35:00 -0400
Date: Thu, 12 May 2016 09:34:56 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] NVMe: Only release requested regions
Message-ID: <20160512073456.GD25134@c203.arch.suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
 <20160512070352.GB20802@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20160512070352.GB20802@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 12:03:52AM -0700, Christoph Hellwig wrote:
> >  static void nvme_dev_unmap(struct nvme_dev *dev)
> >  {
> > +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> > +	int bars;
> > +
> >  	if (dev->bar)
> >  		iounmap(dev->bar);
> > -	pci_release_regions(to_pci_dev(dev->dev));
> > +
> > +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
> > +	pci_release_selected_regions(pdev, bars);
> 
> This looks fine, but I really hate this API.
> 
> Can someone add these two nice helpers to pci.h:

Well I could send a patch, but then this is your code...

> 
> static inline int
> pci_request_mem_regions(struct pci_dev *pdev, const char *name)
> {
> 	return pci_request_selected_regions(pdev,
> 			pci_select_bars(pdev, IORESOURCE_MEM), name);
> }
> 
> static inline void
> pci_release_mem_regions(struct pci_dev *pdev)
> {
> 	return pci_release_selected_regions(pdev,
> 			pci_select_bars(pdev, IORESOURCE_MEM));
> }
> 
> But for now this should do it:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
