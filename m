Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbeHIVJk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 17:09:40 -0400
Date: Thu, 9 Aug 2018 13:43:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eric Pilmore <epilmore@gigaio.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
Subject: Re: IOAT DMA w/IOMMU
Message-ID: <20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David, Logan, Alex, iommu list]

On Thu, Aug 09, 2018 at 11:14:13AM -0700, Eric Pilmore wrote:
> Didn't get any response on the IRC channel so trying here.
> 
> Was wondering if anybody here has used IOAT DMA engines with an
> IOMMU turned on (Xeon based system)? My specific question is really
> whether it is possible to DMA (w/IOAT) to a PCI BAR address as the
> destination without having to map that address to the IOVA space of
> the DMA engine first (assuming the IOMMU is on)?

So is this a peer-to-peer DMA scenario?  You mention DMA, which would
be a transaction initiated by a PCI device, to a PCI BAR address, so
it doesn't sound like system memory is involved.

I copied some folks who know a lot more about this than I do.

> I am encountering issues where I see PTE Errors reported from DMAR
> in this scenario, but I do not if I use a different DMA engine
> that's sitting downstream off the PCI tree. I'm wondering if the
> IOAT DMA failure is some artifact of these engines sitting behind
> the Host Bridge.
> 
> Thanks in advance!
> Eric
