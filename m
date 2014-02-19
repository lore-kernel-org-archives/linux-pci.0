Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47332 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398AbaBSLHw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2014 06:07:52 -0500
Date: Wed, 19 Feb 2014 11:07:19 +0000
From: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140219110718.GD28173@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <1392726043-31088-4-git-send-email-will.deacon@arm.com>
 <2340480.VAU4NNbBD8@wuerfel>
 <20140218191023.GG2010@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140218191023.GG2010@mudshark.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 07:10:23PM +0000, Will Deacon wrote:
> On Tue, Feb 18, 2014 at 01:46:44PM +0000, Arnd Bergmann wrote:
> > On Tuesday 18 February 2014 12:20:43 Will Deacon wrote:
> > > +	/* Register our I/O and Memory resources */
> > > +	res_valid = 0;
> > > +	list_for_each_entry(win, &pci->host.windows, list) {
> > > +		struct resource *parent;
> > > +
> > > +		if (resource_type(win->res) == IORESOURCE_IO) {
> > > +			parent = &ioport_resource;
> > > +			err = pci_ioremap_io(win->offset, win->res->start);
> > 
> > and consequently pass the pci_addr rather than the offset here. How about
> > moving the pci_ioremap_io() call into gen_pci_alloc_io_offset()?

I've probably just confused myself, but passing the pci_addr to
pci_ioremap_io doesn't make sense to me. My understanding is that:

  cpu = bus + offset

In the case of I/O, the offset is really:

  offset = (PCI_IO_VIRT_BASE - bus) + window

where window is determined by the simple allocator I wrote.

Now, the __io macro takes care of PCI_IO_VIRT_BASE so we don't actually care
about that when adding the PCI I/O resources, instead we'll just pass:

  offset = window - bus

and then pci_ioremap_io will just want the window offset, since that's added
directly on to PCI_IO_VIRT_BASE for the ioremap_page_range.

If I call pci_ioremap_io(range->pci_addr, ...) then I'm going to trip a BUG_ON
unless the pci_addr is within IO_SPACE_LIMIT.

Will
