Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11620 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbEGQKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 12:10:22 -0400
From: William Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"John Hubbard" <jhubbard@nvidia.com>,
	"jglisse@redhat.com" <jglisse@redhat.com>
Subject: RE: [PATCH 2/6] DMA-API: Introduce dma_(un)map_resource
Date: Thu, 7 May 2015 16:10:21 +0000
Message-ID: <9b2e409d18174a80bd255349d798aac8@HQMAIL106.nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <1430505138-2877-3-git-send-email-wdavis@nvidia.com>
 <20150507150950.GK24643@google.com>
In-Reply-To: <20150507150950.GK24643@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, May 7, 2015 10:10 AM
> To: William Davis
> Cc: joro@8bytes.org; iommu@lists.linux-foundation.org; linux-
> pci@vger.kernel.org; Terence Ripperda; John Hubbard; jglisse@redhat.com
> Subject: Re: [PATCH 2/6] DMA-API: Introduce dma_(un)map_resource
> 
> On Fri, May 01, 2015 at 01:32:14PM -0500, wdavis@nvidia.com wrote:
> > From: Will Davis <wdavis@nvidia.com>
> >
> > Add functions to DMA-map and -unmap a resource for a given device.
> > This will allow devices to DMA-map a peer device's resource (for
> > example, another device's BAR region on PCI) to enable peer-to-peer
> transactions.
> >
> > Signed-off-by: Will Davis <wdavis@nvidia.com>
> > Reviewed-by: Terence Ripperda <tripperda@nvidia.com>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  include/asm-generic/dma-mapping-broken.h |  9 +++++++++
> > include/asm-generic/dma-mapping-common.h | 34
> ++++++++++++++++++++++++++++++++
> >  include/linux/dma-mapping.h              |  7 +++++++
> 
> You should document these new interfaces in Documentation/DMA-API-*
> 

Will do.

Thanks,
Will

--
nvpublic
