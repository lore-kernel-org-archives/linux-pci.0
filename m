Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56918 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbbFYL1O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jun 2015 07:27:14 -0400
Date: Thu, 25 Jun 2015 12:27:33 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150625112733.GA9733@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com>
 <20150602145510.GE23650@red-moon>
 <1435099588.3996.14.camel@kernel.crashing.org>
 <CAErSpo6AziA5GXEi6AizW2WP6oLVMd1p57pWunDNBQeVXxp1nw@mail.gmail.com>
 <1435101283.3996.17.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435101283.3996.17.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 24, 2015 at 12:14:43AM +0100, Benjamin Herrenschmidt wrote:
> On Tue, 2015-06-23 at 18:02 -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 23, 2015 at 5:46 PM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > On Tue, 2015-06-02 at 15:55 +0100, Lorenzo Pieralisi wrote:
> > >> While at it, do you think it is reasonable to also claim the bridge
> > >> windows (resources) in the respective pci_read_bridge_* calls ?
> > >
> > > No, don't claim in read. There's a clear distinction between gathering
> > > resources and claiming them, and we need to keep that.
> > >
> > > Some fixups might happen in between the two for example.
> > 
> > Are there any existing fixups like that?  Concrete examples would help
> > figure out the best way forward.
> 
> Not off the top of my mind, it's been a long time since I wrote the
> resource claiming stuff in arch/powerpc but it does make me nervous. We
> collect resources when probing and we claim in the survey, those have
> been historically very distinct steps.

Yes, that makes me nervous too, that's why I posted my patch as an
RFC/RFT, I think there is little debate in moving
pci_read_bridge_bases() to core PCI, claiming the resources is a
different question though, and I can't have the overall picture
since it _seems_ arch specific (I know Bjorn does not agree with
this though - it might be due to platform specific quirks) even if
it should not.

> > Most arches call pci_read_bridge_bases() from pcibios_fixup_bus().  I
> > think that's a poor place to do it because it's code that normally
> > doesn't have to be arch-specific.  Resource claiming is also usually
> > done from arch code, and it shouldn't be arch-specific either.
> 
> Claiming as in putting in the resource tree etc... is different from
> actually reading the values from the HW and is traditionally done much
> later, no ?
> 
> > If we move both the read and claim into generic code, then we might
> > need to make sure there's a fixup phase in between or something.
> 
> Well, then there's a more general argument to be made as to whether we
> want the claiming to be "merged" as part of the probing/reading I
> suppose...

On PROBE_ONLY systems (that are the systems I really wanted to cover
by claiming as soon as pci_read_bridge_bases() is executed) I think
we all agree that merging the claiming/reading is sane (but I also
think that Bjorn is not happy with that :), I mean it should not
be PROBE_ONLY dependent).

> Then there's also the case where everything gets fully reassigned, like
> powernv, where the "read" phase is really only about sizing device
> BARs...

Exactly, there claiming right after reading should not be a problem
either. How do you want me to proceed ? Should I make bridge resources
claiming in PCI core PROBE_ONLY ? Or move it to ARM specific hooks ?

I will certainly move pci_read_bridge_bases() to core code since this
changes nothing to current behaviour and must be consolidated
regardless.

Thoughts appreciated.

Thanks,
Lorenzo
