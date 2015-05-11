Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18732 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbEKUF4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 16:05:56 -0400
From: William Davis <wdavis@nvidia.com>
To: "markh@compro.net" <markh@compro.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Terence Ripperda <TRipperda@nvidia.com>
Subject: RE: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Date: Mon, 11 May 2015 20:05:54 +0000
Message-ID: <b2ae7590ce2c4dd7a8408f739e3aea54@HQMAIL106.nvidia.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <20150508202134.GB26795@l.oracle.com> <554D2099.2030907@compro.net>
In-Reply-To: <554D2099.2030907@compro.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Mark Hounschell [mailto:markh@compro.net]
> Sent: Friday, May 08, 2015 3:46 PM
> To: Konrad Rzeszutek Wilk; William Davis
> Cc: linux-pci@vger.kernel.org; iommu@lists.linux-foundation.org; jglisse@redhat.com; John Hubbard;
> Terence Ripperda
> Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
> 
> On 05/08/2015 04:21 PM, Konrad Rzeszutek Wilk wrote:
> > On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis@nvidia.com wrote:
> >> From: Will Davis <wdavis@nvidia.com>
> >>
> >> Hi,
> >>
> ...
> >>
> >> This solves a long-standing problem with the existing DMA-remapping interfaces,
> >> which require that a struct page be given for the region to be mapped into a
> >> device's IOVA domain. This requirement cannot support peer device BAR ranges,
> >> for which no struct pages exist.
> >>
> ...
> >>
> >> The Intel and nommu versions have been verified on a dual Intel Xeon E5405
> >> workstation.
> 
> PCIe peer2peer is borked on all motherboards I've tried. Only writes are
> possible. Reads are not supported. I suppose if you have a platform with
> only PCI and an IOMMU this would be very useful. Without both read and
> write PCIe peer2peer support, this seems unnecessary.
> 

PCIe peer-to-peer isn't inherently broken or useless itself, even if a lot of its implementations are; I've successfully tested these patches with existing hardware (dual NVIDIA GPUs + an old-ish workstation), and it solves a longstanding problem for us [1], so I disagree with the assessment that this would be unnecessary.

I guess I don't see why the existence of some, or even a lot of, poor implementations suffices as a reason to reject a generic mechanism to support the "good", standardized implementations.

[1] http://stackoverflow.com/questions/19841815/does-the-nvidia-rdma-gpudirect-always-operate-only-physical-addresses-in-physic

Thanks,
Will

--
nvpublic
