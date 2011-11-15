Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:37013 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125Ab1KOANC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2011 19:13:02 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <dwg@au1.ibm.com>;
	Tue, 15 Nov 2011 00:11:32 +1000
Date: Tue, 15 Nov 2011 11:00:50 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	joerg.roedel@amd.com, agraf@suse.de, benve@cisco.com,
	aafabbri@cisco.com, B08248@freescale.com, B07421@freescale.com,
	avi@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
Message-ID: <20111115000050.GA4882@truffala.fritz.box>
References: <20111103195452.21259.93021.stgit@bling.home>
 <20111111175118.GA6946@phenom.dumpdata.com>
 <1321049456.2682.220.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321049456.2682.220.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 03:10:56PM -0700, Alex Williamson wrote:
> Thanks Konrad!  Comments inline.
> On Fri, 2011-11-11 at 12:51 -0500, Konrad Rzeszutek Wilk wrote:
> > On Thu, Nov 03, 2011 at 02:12:24PM -0600, Alex Williamson wrote:
[snip]
> > > +The GET_NUM_REGIONS ioctl tells us how many regions the device supports:
> > > +
> > > +#define VFIO_DEVICE_GET_NUM_REGIONS     _IOR(';', 109, int)
> > 
> > Don't want __u32?
> 
> It could be, not sure if it buys us anything maybe even restricts us.
> We likely don't need 2^32 regions (famous last words?), so we could
> later define <0 to something?

As a rule, it's best to use explicit fixed width types for all ioctl()
arguments, to avoid compat hell for 32-bit userland on 64-bit kernel
setups.

[snip]
> > > +Again, zero count entries are allowed (vfio-pci uses a static interrupt
> > > +type to index mapping).
> > 
> > I am not really sure what that means.
> 
> This is so PCI can expose:
> 
> enum {
>         VFIO_PCI_INTX_IRQ_INDEX,
>         VFIO_PCI_MSI_IRQ_INDEX,
>         VFIO_PCI_MSIX_IRQ_INDEX,
>         VFIO_PCI_NUM_IRQS
> };
> 
> So like regions it always exposes 3 IRQ indexes where count=0 if the
> device doesn't actually support that type of interrupt.  I just want to
> spell out that bus drivers have this kind of flexibility.

I knew what you were aiming for, so I could see what you meant here,
but I don't think the doco is very clearly expressed at all.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

