Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61856 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685AbcBIQcT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2016 11:32:19 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	David Daney <ddaney@caviumnetworks.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	David Daney <ddaney.cavm@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 3/3] pci, pci-thunder-ecam: Add driver for ThunderX-pass1 on-chip devices
Date: Tue, 09 Feb 2016 17:31:26 +0100
Message-ID: <4260938.2z2RNjENMM@wuerfel>
In-Reply-To: <20160209162628.GA20171@localhost>
References: <1454715675-17512-1-git-send-email-ddaney.cavm@gmail.com> <12842339.z2KnaZPlyO@wuerfel> <20160209162628.GA20171@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 February 2016 10:26:28 Bjorn Helgaas wrote:
> On Tue, Feb 09, 2016 at 10:25:33AM +0100, Arnd Bergmann wrote:
> > On Monday 08 February 2016 17:24:30 Bjorn Helgaas wrote:
> > > > >
> > > > >I assume your system conforms to expectations like these; I'm just
> > > > >pointing them out because you mentioned buses with multiple devices on
> > > > >them, which is definitely something one doesn't expect in PCIe.
> > > > 
> > > > The topology we have is currently working with the kernel's core PCI
> > > > code.  I don't really want to get into discussing what the
> > > > definition of PCIe is.  We have multiple devices (more than 32) on a
> > > > single bus, and they have PCI Express and ARI Capabilities.  Is that
> > > > PCIe?  I don't know.
> > > 
> > > I don't need to know the details of your topology.  As long as it
> > > conforms to the PCIe spec, it should be fine.  If it *doesn't* conform
> > > to the spec, but things currently seem to work, that's less fine,
> > > because a future Linux change is liable to break something for you.
> > > 
> > > I was a little concerned about your statement that "there are multiple
> > > devices residing on each bus, so from that point of view it cannot be
> > > PCIe."  That made it sound like you're doing something outside the
> > > spec.  If you're just using regular multi-function devices or ARI,
> > > then I don't see any issue (or any reason to say it can't be PCIe).
> > 
> > It doesn't conform to the PCIe port spec, because there are no external
> > ports but just integrated devices in the host bridge. 
> 
> Is there a spec section you have in mind?  Based on sec 1.3.1, I don't
> think there's a requirement to have PCI Express Ports (is that what
> you mean by "external ports"?)

No, I was just assuming that ports are specified in their own document,
which would not be followed here if there are none. There is nothing in
here that leads me to believe that the hardware is actually noncompliant
with any relevant standard.

> Root Complex Integrated Endpoints (sec 1.3.2.3) are clearly supported
> and they would not be behind a Root Port.  If you're using those, I
> hope they're correctly identified via the PCIe capability Device/Port
> Type (sec 7.8.2) because we rely on that type to figure out whether
> the link-related registers are implemented.
> 
> The spec does include rules related to peer-to-peer transactions, MPS,
> ASPM, error reporting, etc., and Linux relies on those, so I think it
> would be important to get those right.

David can probably explain more if the registers are compliant with
those parts of the spec.

	Arnd
