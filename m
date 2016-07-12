Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbcGLMKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 08:10:34 -0400
Date: Tue, 12 Jul 2016 14:15:32 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160712121531.GA26969@agordeev.lab.eng.brq.redhat.com>
References: <1468151866-7776-1-git-send-email-hch@lst.de>
 <1468151866-7776-6-git-send-email-hch@lst.de>
 <20160711205110.GA23915@dhcp-27-118.brq.redhat.com>
 <20160712091754.GC4845@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160712091754.GC4845@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 11:17:54AM +0200, Christoph Hellwig wrote:
> > > +		dev->irq_affinity = NULL;
> > > +
> > > +		if (rc < 0)
> > >  			return rc;
> > > +		if (rc < minvec)
> > 
> > 		else if (rc < minvec)
> 
> No need for the else - the previous line is a return (I've dropped
> the removed lines above so that it's clearly visible).  And we already
> handle the rc == 0 case a few lines above.

There is no bug here definitely, but (a) (if my memory serves me well)
there are archs whose branch prediction benefits from -else parts in
conditionals and (b) the code style you're updating was consistent
wrt branching and your change makes it inconsistent even within one
function.
