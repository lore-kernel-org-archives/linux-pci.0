Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934665AbbI2P6S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Sep 2015 11:58:18 -0400
Date: Tue, 29 Sep 2015 11:58:10 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
cc: Andreas Hartmann <andihartmann@freenet.de>,
	iommu@lists.linux-foundation.org, Leo Duran <leo.duran@amd.com>,
	Christoph Hellwig <hch@lst.de>,
	device-mapper development <dm-devel@redhat.com>,
	Milan Broz <mbroz@redhat.com>, Jens Axboe <axboe@fb.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [dm-devel] AMD-Vi IO_PAGE_FAULTs and ata3.00: failed command:
 READ FPDMA QUEUED errors since Linux 4.0
In-Reply-To: <20150929152100.GL3036@8bytes.org>
Message-ID: <alpine.LRH.2.02.1509291143170.24174@file01.intranet.prod.int.rdu2.redhat.com>
References: <55B7BEA2.30205@01019freenet.de> <20150728175054.GB24782@redhat.com> <55B7D054.4070308@maya.org> <20150728192908.GA25264@redhat.com> <55BCD5A7.2080708@maya.org> <55BE1D5E.6020709@maya.org> <alpine.LRH.2.02.1508021347480.17729@file01.intranet.prod.int.rdu2.redhat.com>
 <55FE5740.2060701@maya.org> <20150929152100.GL3036@8bytes.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tue, 29 Sep 2015, Joerg Roedel wrote:

> On Sun, Sep 20, 2015 at 08:50:40AM +0200, Andreas Hartmann wrote:
> > > I would submit this bug to maintainers of AMD-Vi. They understand the 
> > > hardware, so they should tell why do large I/O requests result in 
> > > IO_PAGE_FAULTs.
> > > 
> > > It is probably bug either in AMD-Vi driver or in hardware.
> > 
> > Until now, I didn't hear anything from the maintainers of AMD-Vi.
> 
> What do you mean by this? I've been commenting on this issue in the
> past and I thought we agreed that this is no issue of the IOMMU driver.
> 
> It it were, bisection should lead to a commit that breaks it, but there
> are no commits between v3.18 and v3.19 in the AMD IOMMU driver touching
> the DMA-API path.
> 
> 	Joerg

I don't know why are you so certain that the bug in not in AMD-Vi IOMMU.

There was a patch (34b48db66e08ca1c1bc07cf305d672ac940268dc) that 
increased default block request size. That patch triggers AMD-Vi page 
faults. The bug may be in ATA driver, in ATA controller on in AMD-Vi 
driver or hardware. I didn't see anything in that thread that proves that 
the bug in not in AMD-Vi IOMMU.

The bug probably existed even before kernel 3.19, but it was masked by the 
fact that I/O request size was artifically capped. Bisecting probably 
won't find it, as it may have existed since ever.

Mikulas
