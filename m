Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:42588
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752091Ab3JHRJb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 13:09:31 -0400
Message-ID: <1381252156.7979.247.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Bhushan Bharat-R65777 <R65777@freescale.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"galak@kernel.crashing.org" <galak@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"agraf@suse.de" <agraf@suse.de>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Date: Tue, 8 Oct 2013 12:09:16 -0500
In-Reply-To: <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
	 <20130924235812.GD9302@google.com>
	 <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
	 <CAErSpo742BOxzxRaFQn+UnsNday4_8LM6+3G6=cfp9DHecPxDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-08 at 10:47 -0600, Bjorn Helgaas wrote:
> On Thu, Oct 3, 2013 at 11:19 PM, Bhushan Bharat-R65777
> <R65777@freescale.com> wrote:
> 
> >> I don't know enough about VFIO to understand why these new interfaces are
> >> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce.c and
> >> vfio_iommu_type1.c but I don't know if they're comparable to the Freescale PAMU.
> >> Do other VFIO IOMMU implementations support MSI?  If so, do they handle the
> >> problem of mapping the MSI regions in a different way?
> >
> > PAMU is an aperture type of IOMMU while other are paging type, So they are completely different from what PAMU is and handle that differently.
> 
> This is not an explanation or a justification for adding new
> interfaces.  I still have no idea what an "aperture type IOMMU" is,
> other than that it is "different."  But I see that Alex is working on
> this issue with you in a different thread, so I'm sure you guys will
> sort it out.

PAMU is a very constrained IOMMU that cannot do arbitrary page mappings.
Due to these constraints, we cannot map the MSI I/O page at its normal
address while also mapping RAM at the address we want.  The address we
can map it at depends on the addresses of other mappings, so it can't be
hidden in the IOMMU driver -- the user needs to be in control.

Another difference is that (if I understand correctly) PCs handle MSIs
specially, via interrupt remapping, rather than being translated as a
normal memory access through the IOMMU.

-Scott



