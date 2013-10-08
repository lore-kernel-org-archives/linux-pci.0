Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:58759
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492Ab3JHXfd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 19:35:33 -0400
Message-ID: <1381275325.7979.320.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
From: Scott Wood <scottwood@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Bharat Bhushan <r65777@freescale.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Bharat Bhushan <Bharat.Bhushan@freescale.com>
Date: Tue, 8 Oct 2013 18:35:25 -0500
In-Reply-To: <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
	 <1381273037.7979.298.camel@snotra.buserror.net>
	 <CAErSpo7+7SHVcOJkHkW5cjb6pN+bqYeRdPBA=MVX0RLz=-pP6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-08 at 17:25 -0600, Bjorn Helgaas wrote:
> >> -     u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
> >> +     dma_addr_t msiir; /* MSIIR Address in CCSR */
> >
> > Are you sure dma_addr_t is right here, versus phys_addr_t?  It implies
> > that it's the output of the DMA API, but I don't think the DMA API is
> > used in the MSI driver.  Perhaps it should be, but we still want the raw
> > physical address to pass on to VFIO.
> 
> I don't know what "msiir" is used for, but if it's an address you
> program into a PCI device, then it's a dma_addr_t even if you didn't
> get it from the DMA API.  Maybe "bus_addr_t" would have been a more
> suggestive name than "dma_addr_t".  That said, I have no idea how this
> relates to VFIO.

It's a bit awkward because it gets used both as something to program
into a PCI device (and it's probably a bug that the DMA API doesn't get
used), and also (if I understand the current plans correctly) as a
physical address to give to VFIO to be a destination address in an IOMMU
mapping.  So I think the value we keep here should be a phys_addr_t (it
comes straight from the MMIO address in the device tree), which gets
trivially turned into a dma_addr_t by the non-VFIO code path because
there's currently no translation there.

-Scott



