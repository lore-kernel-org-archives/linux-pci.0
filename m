Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Jun 2015 17:55:35 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
Message-ID: <20150603165535.GB11928@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com>
 <20150602145510.GE23650@red-moon>
 <556DE1B9.6020100@roeck-us.net>
 <20150603103235.GC27917@red-moon>
 <556F1958.5050003@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <556F1958.5050003@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 03, 2015 at 04:12:24PM +0100, Guenter Roeck wrote:

[...]

> >> After looking into this some more, I think the wrinkle may be that
> >> pci_read_bridge_bases() and thus pci_read_bridge_io() isn't called
> >> on probe-only systems (if PCI_PROBE_ONLY is set). A secondary
> >
> > That's what we would like to change :)
> >
> > https://lkml.org/lkml/2015/5/21/359
> 
> Yes, that should help. I had a brief look last night and concluded
> that this would require changes all over the place, which your patch
> pretty much confirms. Glad that you are tackling it - changes all over
> the place spell trouble and would probably require more time than I have
> available to spend on the problem.

Eh, trouble did not even start because we have just tested it on ARM/ARM64
systems (that's all I can do no sign of testing on any other arch), so I do
not expect it will be merged quickly, it will take me time to get all the
required acks.

I should be able to send a v2 beginning of next week.

> >> problem is that pci_read_bridge_io() does not enable a resource
> >> if it is explicitly disabled (base > limit), but the subsequent call
> >> to pci_bridge_check_ranges() unconditionally enables it.
> >>
> >> Not really sure how to address this; my current code checks IO support
> >> in both pci_read_bridge_io() and pci_bridge_check_ranges(). And since
> >> pci_read_bridge_io() is not always called, I don't see how it might
> >> be possible to get rid of pci_bridge_check_ranges(), or even the check
> >> for IO support in pci_bridge_check_ranges().
> >>
> >>> While at it, do you think it is reasonable to also claim the bridge
> >>> windows (resources) in the respective pci_read_bridge_* calls ?
> >>>
> >>> Is there a reason why we don't/can't do it ? I noticed that on
> >>> PROBE_ONLY systems on ARM/ARM64 at the moment we do not claim
> >>> the bridge apertures and this is not correct, see below:
> >>>
> >>> [5.980127] pcieport 0000:00:02.1: can't enable device: BAR 8
> >>> [mem 0xbff00000 - 0xbfffffff] not claimed
> >>> [5.988056] pcieport: probe of 0000:00:02.1 failed with error -22
> >>>
> >> Is this when trying my patches or with the current upstream code ?
> >
> > It is upstream code with a couple of ARM64 related patches not yet
> > merged. Still, it shows an issue that must be tackled.
> >
> > It is not caused by your patches but it can be solved by them.
> > On PROBE_ONLY systems, all resources must be claimed (since they
> > are not reassigned, hence not claimed by the code that reassigns them),
> > otherwise we can't enable a device resources (ie pcibios_enable_device
> > calls pci_enable_resources that fails, since resources are not claimed).
> >
> > That's why we are suggesting claiming the bridge apertures as soon
> > as they are read from the base registers, even on PROBE_ONLY systems.
> >
> > I think that's the only approach Bjorn would accept, otherwise
> > we will have to fiddle with PROBE_ONLY on ARM64, and either avoid calling
> > pci_enable_resources or avoid checking if a resource is claimed in
> > pci_enable_resources, neither solution seems sane to me.
> >
> 
> Looks like I'll need one of those arm64 systems at some point ;-).
> 
> Where is your patch in respect to acceptance ? Would it make sense to
> merge it into my code and base my patch(es) on it, or do you expect
> major changes which would make that difficult ?

I have a tweak to v1, I will post v2 next week and copy you in.
Acceptance, I think it received review only from ARM guys/platforms
so we are still far from merging it.

Thanks,
Lorenzo
