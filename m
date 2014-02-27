Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55653 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaB0OIy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 09:08:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-kernel@lists.linaro.org
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] pci: OF: Fix the conversion of IO ranges into IO resources.
Date: Thu, 27 Feb 2014 15:08:44 +0100
Message-ID: <7049275.SxVd47MEQ4@wuerfel>
In-Reply-To: <20140227135616.GK1692@e106497-lin.cambridge.arm.com>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <CAPcvp5EqcKEWoH_--azp+sMykmEWtY5whHG=c9t3sZVXZyAPUg@mail.gmail.com> <20140227135616.GK1692@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014 13:56:16 Liviu Dudau wrote:
> On Thu, Feb 27, 2014 at 01:22:19PM +0000, Andrew Murray wrote:
> > On 27 February 2014 13:06, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > >
> > > +/**
> > > + * of_pci_range_to_resource - Create a resource from an of_pci_range
> > > + * @range:     the PCI range that describes the resource
> > > + * @np:                device node where the range belongs to
> > > + * @res:       pointer to a valid resource that will be updated to
> > > + *              reflect the values contained in the range.
> > > + * Note that if the range is an IO range, the resource will be converted
> > > + * using pci_address_to_pio() which can fail if it is called to early or
> > > + * if the range cannot be matched to any host bridge IO space.
> > > + */
> > > +void of_pci_range_to_resource(struct of_pci_range *range,
> > > +       struct device_node *np, struct resource *res)
> > > +{
> > > +       res->flags = range->flags;
> > > +       if (res->flags & IORESOURCE_IO) {
> > > +               unsigned long port;
> > > +               port = pci_address_to_pio(range->pci_addr);
> > 
> > Is this likely to break existing users of of_pci_range_to_resource?
> 
> I've tested the change with a tegra2 based device (trimslice) and I've
> got a functional board.

Did you have any devices using I/O ports though? They are fairly rare
these days.

> > I have no idea if I/O previously worked for mips, but this patch seems
> > to change that behavior. It may be a similar story for microblaze and
> > powerpc.
> 
> Both microblaze and powerpc share an identical implementation and it is
> expecting that the physical address passed as parameter fits between
> io_base_phys and io_base_phys + pcibios_io_size(hose). So yes, the
> correct way is to use cpu_addr and fix the weak implementation? But we
> don't have enough information for the weak implementation to work, as
> we don't know where the physical IO base start (we are just about to
> find out from DT).

I think using pci_address_to_pio() at that point is just wrong
in either way. Before the host is fully registered, you can't actually
look up the port number -- you are only trying to assign one at this time.

The implementation that Will wrote for ARM would work here: find the
next available virtual I/O range, call pci_ioremap_io on range->pci_addr
and then return the virtual address. Unfortunately that code is not
architecture independent at this time, and we will first have to come
up with something that can be made to work for powerpc, microblaze,
mips and arm.

	Arnd
