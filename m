Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56312 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbcFNUWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 16:22:33 -0400
Date: Tue, 14 Jun 2016 15:22:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160614202228.GA8449@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
 <CAMxnaaU_3z6BSmSnYfi4ee=aTKm3aPyUaXds=G29wdp8O0m5Cw@mail.gmail.com>
 <20160614163703.GA31488@localhost>
 <CAMxnaaUQC0kyoBK1ri_AYEi=Dc_aiuiMp=kx1mFaZpsw9-D-eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaUQC0kyoBK1ri_AYEi=Dc_aiuiMp=kx1mFaZpsw9-D-eA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 09:14:27PM +0200, Andreas Noever wrote:
> On Tue, Jun 14, 2016 at 6:37 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > [+cc linux-kernel]
> >
> > On Sat, May 21, 2016 at 11:48:42AM +0200, Andreas Noever wrote:
> >>
> >> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> >>
> >> Tested on MacBookPro10,1
> >>
> >> On Fri, May 13, 2016 at 1:15 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >> > This series powers Thunderbolt controllers on Macs down when nothing is
> >> > plugged in, saving 1.7 W on machines with a Light Ridge controller and
> >> > reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.
> >> >
> >> > Briefly, a custom ACPI method provided by Apple is used to cut power to
> >> > the controller.  A GPE is enabled while the controller is powered down
> >> > which side-band signals a plug event, whereupon power is reinstated using
> >> > the ACPI method.  Note that even though this mechanism is ACPI-based,
> >> > it does not use _PSx methods and is thus entirely nonstandard.
> >
> > I think the current arrangement was that Andreas would ack Thunderbolt
> > patches and I would merge them via the PCI tree.  That makes some sense
> > because Thunderbolt and PCIe are related, but the more I think about
> > it, the less I'm happy with it.
> >
> > This series is a good example.  I'm sure it's good work and
> > worthwhile.  But I can't really say anything about the content of it
> > because most of it is Thunderbolt-specific and there's no public spec.
> > It seems like this is basically a collection of reverse-engineered
> > quirks that happen to work with the current state of Linux PM on
> > certain Macs.  We don't know what might change on future Macs.  We
> > don't know what might break when we make changes to Linux PM.
> >
> > I can't test this series, nor do I want to.  I can't test most of the
> > patches I merge, but I can at least read the spec and see whether the
> > patches make sense.  What I would *like* is to have public Thunderbolt
> > specs and a kernel developer's guide so we know what to expect from
> > the hardware and the firmware and we can write code that should work
> > not just on current Macs, but also on non-Macs and future Macs.
> >
> > I don't think the current situation is really maintainable, and I'm
> > not comfortable merging code that I can't maintain.
> Most of the code is contained within the thunderbolt driver. I think
> there is quite some precedence for reverse engineered drivers without
> specs being part of the kernel. My understanding was that, since I am
> listed in MAINTAINERS, I am responsible for the driver. Now our
> changes often need improvements to the pci core, which is why I think
> merging through your tree is a good idea (without transferring
> responsibility). The changes to the drivers/pci should be supported by
> the PCI-spec and make sense without knowing about thunderbolt (but it
> might be the case that thunderbolt is the only user of these
> features).
> 
> Specifically for this series we want to:
>  - whitelist thunderbolt bridges for PM. Detecting those bridges is
> non-standard but I think this is acceptable, since this
> blacklist/whitelist is basically a quirk.
>  - Load our portdrv on tb bridges. PCI just sees another portdriver
> and all the reverse engineered magic lives inside the driver.
>  - Forward more PM callbacks to portdrivers (not tb specific)
>  - hotplug D3cold fixes: resume around board_added/remove_board,
> ignore interrupts in d3cold (not tb specific and probably a general
> bugfix)
>  - Make pci not fail if bridges have been put into D3cold by some
> external mechanism.
> 
> So maybe you could review the pci changes as a solution to the problem
> "we want to load a custom portdriver which can put bridges into d3cold
> in a device specific way". We certainly to not expect you to take
> responsibility for the thunderbolt driver.

That's a fine solution as far as I'm personally concerned.  I think
it's poor for Linux overall, because I think it's fragile, and it's
disappointing that a technology as important as Thunderbolt is so
poorly supported by the promulgators.  But if you're willing to work
in that environment, that's great.

You maintain the thunderbolt code and merge changes, and I'll review
the pieces that touch drivers/pci.  I do have a couple comments on
those pieces, but I don't think they'll be major.

I just want to get out of the business of merging drivers/thunderbolt
code that I can't maintain.

Bjorn
