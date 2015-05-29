Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:33653 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbbE2IYv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 May 2015 04:24:51 -0400
Date: Fri, 29 May 2015 10:24:44 +0200
From: "joro@8bytes.org" <joro@8bytes.org>
To: Mark Hounschell <markh@compro.net>
Cc: William Davis <wdavis@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Terence Ripperda <TRipperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
Message-ID: <20150529082444.GB13130@8bytes.org>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
 <1431973504-5903-5-git-send-email-wdavis@nvidia.com>
 <20150519234300.GA31666@google.com>
 <555C79E5.9040507@compro.net>
 <ea891abe867444d193742030348a6ad1@HQMAIL106.nvidia.com>
 <555CDD6F.40304@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555CDD6F.40304@compro.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 20, 2015 at 03:15:59PM -0400, Mark Hounschell wrote:
> On 05/20/2015 01:30 PM, William Davis wrote:
> >In an IOMMU environment, the DMA ops would be one of the IOMMU
> >implementations, so these APIs would create a mapping for the peer device
> >resource, even if it's on the same bus. Would a transaction targeting that
> >mapping be forwarded upstream until it hits an IOMMU, which would then send
> >the translated request back downstream? Or is my understanding of this
> >configuration incorrect?
> >
> 
> It's my understanding of the IOMMU that is lacking here. I have no
> idea if that is actually what would happen. Does it?

On the x86 side at least the IOMMU drivers enable ACS when available,
forcing all perr-to-peer DMA between PCIe devices to go through the
IOMMU. This only works when the peers are in different iommu groups,
though.


	Joerg

