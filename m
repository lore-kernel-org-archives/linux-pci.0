Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10710 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbEKTtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 15:49:22 -0400
From: William Davis <wdavis@nvidia.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: "joro@8bytes.org" <joro@8bytes.org>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Terence Ripperda <TRipperda@nvidia.com>
Subject: RE: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Date: Mon, 11 May 2015 19:49:20 +0000
Message-ID: <2fb918c2fb734b4189a5ab2a25d98de8@HQMAIL106.nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <20150508202134.GB26795@l.oracle.com>
In-Reply-To: <20150508202134.GB26795@l.oracle.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Friday, May 08, 2015 3:22 PM
> To: William Davis
> Cc: joro@8bytes.org; jglisse@redhat.com; linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org;
> John Hubbard; Terence Ripperda
> Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
> 
> ...
> >
> > The Intel and nommu versions have been verified on a dual Intel Xeon E5405
> > workstation. I'm in the process of obtaining hardware to test the AMD version
> > as well. Please review.
> 
> Does it work if you boot with 'iommu=soft swiotlb=force' which will mandate
> an strict usage of the DMA API?
> 

This patch series doesn't yet add a SWIOTLB implementation, and so the dma_map_resource() call would return 0 to indicate the path is not implemented (see patch 2/6). So no, the new interfaces would not work with that configuration, but they're also not expected to at this point.

Thanks,
Will
--
nvpublic
