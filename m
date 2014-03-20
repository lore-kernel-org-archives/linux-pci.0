Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:57239 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbaCTQmf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 12:42:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-sh@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben-linux@fluff.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms+renesas@verge.net.au>
Subject: Re: DMABOUNCE in pci-rcar
Date: Thu, 20 Mar 2014 17:41:49 +0100
Message-ID: <4884083.IuNl44Y6XD@wuerfel>
In-Reply-To: <532B137B.7010900@codethink.co.uk>
References: <201402241200.21944.arnd@arndb.de> <5527822.QYtFYiIpiW@wuerfel> <532B137B.7010900@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 20 March 2014 17:12:43 Ben Dooks wrote:
> On 20/03/14 17:09, Arnd Bergmann wrote:
> > On Thursday 20 March 2014 16:04:36 Ben Dooks wrote:

> >> As a note, if we now boot a Lager with DT on 3.14-rc3 series the USB
> >> controllers no longer work with full 2GiB RAM enabled in the device
> >> tree.
> >
> > Did it work before these patches got applied initially?
> 
> It did, but I cannot remember if we where limiting DRAM to 1GiB
> or not.

I would assume you did, or you happened to never actually use
memory higher than that for DMA during tests.

> >> Could we work around this by having 1GiB of memory defined in the
> >> 32bit memory and then add the rest of the 3GiB from the >32bit
> >> area via LPAE? Will the kernel ever try to allocate DMA memory from
> >> anything >32bit?
> >
> > You can solve the case for dma_alloc_coherent() this way, or by
> > setting the mask correctly. It won't help you for dma_map_* though,
> > which still requires someone to add support for swiotlb or using
> > an IOMMU if present.
> 
> We do not have an IOMMU present at the moment. Not sure how
> to go about setting a mask on a pci-probed device.

Ah, right. The mask is a problem because PCI devices assume that
they can do DMA to any 32-bit masked address without calling
dma_set_mask. Your trick to describe the system memory at a different
physical alias would solve this part. Another option might be to
add a quirk in the OHCI/EHCI drivers, if you are able to detect
this special case from the PCI IDs. Whether we can allow the PCI host
controller to just set a mask is an open question. If we decide to go
that route, you should be able to do it using the add_bus() callback
in the host controller driver. However, it would be a departure from
the normal way of doing PCI DMA, and I can't foresee what the implications
would be.

	Arnd
