Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Wed, 24 Aug 2016 13:33:20 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160824173320.GD13337@localhost.localdomain>
References: <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
 <20160823200232.GB3725@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823200232.GB3725@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 03:02:32PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 23, 2016 at 01:10:18PM -0400, Keith Busch wrote:
> > Yes, that's fairly accurate on how this works with other storage
> > transports. While md doesn't directly affect LED states, 'ledmon'
> > subscribes to md events and executes an appropriate LED control method
> > specific to that transport.
> 
> This is a tangent, but is there some reason for putting ledmon in the
> middle of this scheme?  It seems like the important pieces (md and LED
> control) are intimately related and both in the kernel, so why the
> trip through userland?  ledmon sounds like a glorified special-case
> /dev/mem, with similar security and stability issues.  Plus it must
> have to associate a storage device with a PCIe port, grub through its
> config space to find the Slot Control register, deal with possible
> hotplug, etc.  It all sounds icky.

DM knows to report status on groups and members, but as far as I know,
there's no in-kernel API for setting storage status LEDs. If we want to
put it in the kernel, I think it'd be a longer term project, but could
be interesting to try if this is a desirable feature.

There's more than one way to set status (SGPIO, SES, IPMI), and
'ledmon' already knows how to figure out which method to use for many
storage devices. We will just need to teach it whatever method we expose
for PCIe attached drives.

The direct SlotCtl config write method had no new kernel dependencies,
so seemed desirable, but you raised a good point that it potentially
breaks the slot control command sequence.
