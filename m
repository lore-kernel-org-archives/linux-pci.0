Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Wed, 15 Jun 2016 20:40:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160615184050.GA983@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <CAMxnaaU_3z6BSmSnYfi4ee=aTKm3aPyUaXds=G29wdp8O0m5Cw@mail.gmail.com>
 <20160614163703.GA31488@localhost>
 <CAMxnaaUQC0kyoBK1ri_AYEi=Dc_aiuiMp=kx1mFaZpsw9-D-eA@mail.gmail.com>
 <20160614202228.GA8449@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160614202228.GA8449@localhost>
List-ID: <linux-pci.vger.kernel.org>

[+cc Linus, Greg KH]

On Tue, Jun 14, 2016 at 03:22:28PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2016 at 09:14:27PM +0200, Andreas Noever wrote:
> > On Tue, Jun 14, 2016 at 6:37 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, May 21, 2016 at 11:48:42AM +0200, Andreas Noever wrote:
> > > > On Fri, May 13, 2016 at 1:15 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > > > This series powers Thunderbolt controllers on Macs down when
> > > > > nothing is plugged in, saving 1.7 W on machines with a Light Ridge
> > > > > controller and reportedly 4 W on Cactus Ridge 4C and Falcon Ridge
> > > > > 4C.
> > > > >
> > > > > Briefly, a custom ACPI method provided by Apple is used to cut
> > > > > power to the controller.  A GPE is enabled while the controller
> > > > > is powered down which side-band signals a plug event, whereupon
> > > > > power is reinstated using the ACPI method.  Note that even though
> > > > > this mechanism is ACPI-based, it does not use _PSx methods and is
> > > > > thus entirely nonstandard.
> > > >
> > > > Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> > > > Tested on MacBookPro10,1
> > >
> > > I think the current arrangement was that Andreas would ack Thunderbolt
> > > patches and I would merge them via the PCI tree.  That makes some sense
> > > because Thunderbolt and PCIe are related, but the more I think about
> > > it, the less I'm happy with it.
> > >
> > > This series is a good example.  I'm sure it's good work and
> > > worthwhile.  But I can't really say anything about the content of it
> > > because most of it is Thunderbolt-specific and there's no public spec.
> > > It seems like this is basically a collection of reverse-engineered
> > > quirks that happen to work with the current state of Linux PM on
> > > certain Macs.  We don't know what might change on future Macs.  We
> > > don't know what might break when we make changes to Linux PM.
> > >
> > > I can't test this series, nor do I want to.  I can't test most of the
> > > patches I merge, but I can at least read the spec and see whether the
> > > patches make sense.  What I would *like* is to have public Thunderbolt
> > > specs and a kernel developer's guide so we know what to expect from
> > > the hardware and the firmware and we can write code that should work
> > > not just on current Macs, but also on non-Macs and future Macs.
> > >
> > > I don't think the current situation is really maintainable, and I'm
> > > not comfortable merging code that I can't maintain.
> >
> > Most of the code is contained within the thunderbolt driver. I think
> > there is quite some precedence for reverse engineered drivers without
> > specs being part of the kernel. My understanding was that, since I am
> > listed in MAINTAINERS, I am responsible for the driver. Now our
> > changes often need improvements to the pci core, which is why I think
> > merging through your tree is a good idea (without transferring
> > responsibility). The changes to the drivers/pci should be supported by
> > the PCI-spec and make sense without knowing about thunderbolt (but it
> > might be the case that thunderbolt is the only user of these
> > features). [...]
> > 
> > So maybe you could review the pci changes as a solution to the problem
> > "we want to load a custom portdriver which can put bridges into d3cold
> > in a device specific way". We certainly to not expect you to take
> > responsibility for the thunderbolt driver.
> 
> That's a fine solution as far as I'm personally concerned.  I think
> it's poor for Linux overall, because I think it's fragile, and it's
> disappointing that a technology as important as Thunderbolt is so
> poorly supported by the promulgators.  But if you're willing to work
> in that environment, that's great.
> 
> You maintain the thunderbolt code and merge changes, and I'll review
> the pieces that touch drivers/pci.  I do have a couple comments on
> those pieces, but I don't think they'll be major.
> 
> I just want to get out of the business of merging drivers/thunderbolt
> code that I can't maintain.

So how should changes to drivers/thunderbolt/ be merged in the future?

Andreas could probably send pulls directly to Linus, but I'm not sure
what the requirements are. I believe Linus wants signed tags. The trust
path from Linus to me is 4 hops and I've signed Andreas' key today,
yielding a 5 hop trust path:
http://pgp.cs.uu.nl/mk_path.cgi?FROM=0x79BE3E4300411886&TO=0x2AAF22EB
http://pgp.surfnet.nl:11371/pks/lookup?op=vindex&search=0xB1FCD9A3

Is there an upper limit on the acceptable length of the trust path?
Does the key have to be signed by another maintainer?

I guess the alternative would be that Greg KH picks up the patches,
as he did with the initial version of the Thunderbolt driver back in
2014. I'm not sure if that makes sense as I assume he has numerous
other things on his plate. (Which is not to belittle your own or
Linus' workload.)

Most subsystems seem to practice a four-eyes principle, i.e. a
Reviewed-by should be provided by someone else if author and committer
are the same person. I'll be glad to provide that for Andreas' own
patches such as 2ffa9a5d76a7, or help otherwise if I can.


As concerns this particular series, 10 of the 13 patches, i.e. the
majority, concern the PCI core, 1 concerns the PM core and only 2
concern the Thunderbolt driver. Since the PCI core is generally seeing
a lot more activity than the Thunderbolt driver, the probability of
merge conflicts is much higher if this series is merged through a
different tree than yours. It seems to be common practice to just
accept an Acked-by from other subsystem maintainers as a green light
to merge without looking closer at those patches.


I agree with your assessment that the lack of public documentation on
Thunderbolt is deplorable. However the PCIe spec does define what a
PCIe switch is and how it functions, and Thunderbolt is precisely that.
I.e. it documents a portion of Thunderbolt without ever saying so
explicitly.

You cite the lack of a public spec as a reason for unmaintainability,
yet your subsystem contains code to support Thunderbolt on non-Macs,
in the form of acpiphp. Was the maintainability argument ever mounted
against acpiphp? Intel engineers with access to the spec contributed
the changes for acpiphp to make Thunderbolt work on non-Macs. Is their
code more maintainable than reverse-engineered code?

Best regards,

Lukas
