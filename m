Return-Path: <SRS0=fUOp=KM=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=fUOp=KM=h08.hostsharing.net=foo00@kernel.org>
Date: Sat, 28 Jul 2018 07:44:41 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org,
	Mayurkumar Patel <mayurkumar.patel@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180728054441.GA7501@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
 <20180719094315.GA19033@wunner.de>
 <20180719225016.GP128988@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719225016.GP128988@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 19, 2018 at 05:50:16PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 19, 2018 at 11:43:15AM +0200, Lukas Wunner wrote:
> > On Mon, Jul 16, 2018 at 09:20:54AM -0500, Bjorn Helgaas wrote:
> > >   - Mika had a few questions/comments that are still dangling.
> > 
> > I could resolve those with two further replacement patches:
> > 
> > - "17/32 PCI: pciehp: Enable/disable exclusively from IRQ thread"
> >   => Deduplicate code to detect a change in slot occupancy
> >      by introducing a small helper.
> > 
> > - "23/32 PCI: pciehp: Avoid slot access during reset"
> >   => Amend commit message to justify usage of rw_semaphore.
> > 
> > Further open points:
> > 
> > - Mika suggested adding a few breaks to switch/case statements to avoid
> >   unintentional fall-throughs if the code is later extended.  I think
> >   it might be good to do that in a separate commit that is applied on
> >   top of this series, and at the same time mark all intentional
> >   fall-throughs as such for -Wimplicit-fallthrough.
> >   BTW, you may see a merge conflict between the pci/06-16-lukas-pciehp
> >   and the pci/misc branch because you've already applied Gustavo's patch
> >   to the latter and it touches pciehp_ctrl.c.
> > 
> > - The commit message of "27/32 PCI: pciehp: Support interrupts sent from
> >   D3hot" could optionally be extended by your comment that the "Downstream
> >   Port" term includes both Root Ports and Switch Downstream Ports.
> 
> If you send any of the above updates, I'll gladly update the
> pci/hotplug branch.  You can either send replacement patches or
> incremental ones that I can fold into existing commits.

Bjorn, Mika, everyone, please excuse the delay.

I've just posted 4 patches to linux-pci@ to address all the above-listed
review comments that are still outstanding:

* 2 replacement patches for existing commits on Bjorn's pci/hotplug branch:
    PCI: pciehp: Avoid slot access during reset
    PCI: pciehp: Support interrupts sent from D3hot
  No code changes, only the commit messages have been updated.
  Specifics are below the three dash separator in each patch.

* 2 patches that are intended to be applied on top of the branch:
    PCI: pciehp: Avoid implicit fallthroughs in switch statements
    PCI: pciehp: Deduplicate presence check on probe & resume

With this approach I hope to minimize the work for Bjorn by avoiding
any rebase conflicts.

Thanks!

Lukas
