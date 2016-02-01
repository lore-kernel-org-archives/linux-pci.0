Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722AbcBAVTl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Feb 2016 16:19:41 -0500
Date: Mon, 1 Feb 2016 15:19:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160201211936.GE4861@localhost>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
 <20160120181003.GF13437@red-moon>
 <20160129232538.GH12965@localhost>
 <20160201162838.GB30869@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160201162838.GB30869@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 01, 2016 at 04:28:38PM +0000, Lorenzo Pieralisi wrote:
> On Fri, Jan 29, 2016 at 05:25:38PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 20, 2016 at 06:10:03PM +0000, Lorenzo Pieralisi wrote:
> > 
> > > To do that, we must claim resources on PCI_PROBE_ONLY systems, but
> > > I know for certain Bjorn does not like the idea (I let you trawl
> > > the archives - at least he does not accept the idea of claiming
> > > resources ONLY on PCI_PROBE_ONLY systems, he thinks we should
> > > always claim resources regardless of that flag and fall-back to
> > > reassigning them in case claiming fails. That's perfectly reasonable,
> > > at least on systems with FW initializing PCI). The problem is dealing
> > > with legacy, so switching to resources claiming by default is a tad
> > > complicated, at least for testing (code is easy to implement).
> > 
> > I'd like to think of PCI_PROBE_ONLY basically as "setting
> > IORESOURCE_PCI_FIXED for every BAR", i.e., we can do everything we
> > normally do *except* write to the BAR (of course we have to write to
> > it to size the BAR during enumeration, but we have to restore the
> > original value).
> 
> I am honestly a bit confused about the distinction between
> PCI_PROBE_ONLY and "IORESOURCE_PCI_FIXED for every BAR", the more
> so if I read the resources assignment code, in particular:
> 
> pci_assign_resource()
> 
> in drivers/pci/setup-res.c
> 
> That function assigns the resource but does not update the BAR
> if IORESOURCE_PCI_FIXED is set. I wonder why the resource is
> assigned at all if IORESOURCE_PCI_FIXED is set, probably to
> initialize its parent pointer and set it, still, the value in
> the struct resource may differ from what's in the BAR, I am not sure
> I understand why we are happy with that or I am reading code the
> wrong way (does not this give a view of resource tree disconnected
> from how HW is actually programmed ?)

I'm not happy with that -- it's just one of our many problems.

The assignment code doesn't doesn't really pay attention to
IORESOURCE_PCI_FIXED.  I don't think it pays attention to
PCI_PROBE_ONLY either, except that some arches don't even call the
assignment code if it is set.

Bjorn
