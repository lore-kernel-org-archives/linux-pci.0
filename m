Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbeGSXfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jul 2018 19:35:32 -0400
Date: Thu, 19 Jul 2018 17:50:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180719225016.GP128988@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1529173804.git.lukas@wunner.de>
 <20180716142053.GA12391@bhelgaas-glaptop.roam.corp.google.com>
 <20180719094315.GA19033@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719094315.GA19033@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 19, 2018 at 11:43:15AM +0200, Lukas Wunner wrote:
> On Mon, Jul 16, 2018 at 09:20:54AM -0500, Bjorn Helgaas wrote:
> > On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> > > Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
> > > on and off synchronously in the IRQ thread, no indirection via a work
> > > queue anymore.
> > > 
> > > When the slot is enabled/disabled by the user via sysfs or an Attention
> > > Button press, a request is sent to the IRQ thread.  The IRQ thread is
> > > thus the sole entity enabling/disabling the slot.
> > > 
> > > The IRQ thread can cope with missed events, e.g. if a card is inserted
> > > and immediately pulled out before the IRQ thread had a chance to react.
> > > It also tolerates an initially unstable link as observed in the wild by
> > > Stefan Roese.
> > > 
> > > Finally, runtime PM support is added.  This was the original motivation
> > > of the series because runtime suspending hotplug ports is needed to power
> > > down Thunderbolt controllers on idle, which saves ~1.5W per controller.
> > > Runtime resuming ports takes tenths of milliseconds during which events
> > > may be missed, this in turn necessitated the event handling rework.
> > > 
> > > I've pushed the series to GitHub to ease reviewing/fetching:
> > > https://github.com/l1k/linux/commits/pciehp_runpm_v2
> > 
> > My current test branch:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/06-16-lukas-pciehp
> > 
> > has this series with these changes:
> > 
> >   - Drop the genirq patch (already merged via tip)
> > 
> >   - Add one blank line (pcie_cleanup_slot())
> > 
> >   - A few trivial changelog updates (mostly to use lkml.kernel.org
> >     links to reduce dependency on 3rd party archives)
> 
> I've reviewed the branch and diffed every commit with the original patch
> and this all LGTM.  I'll try to adhere more closely to the desired style
> in the future, i.e. use kernel.org links and order the Cc: to the bottom.
> 
> 
> > Do you plan any other updates?  The open questions I see are:
> > 
> >   - You mentioned withdrawing "03/32 PCI: pciehp: Fix deadlock on
> >     unplug".  I tried simply dropping that, but that caused a conflict
> >     that I didn't try to resolve.
> 
> Yes, a single patch succeeding it won't apply cleanly if patch 03/32 is
> omitted, namely "06/32 PCI: pciehp: Declare pciehp_unconfigure_device()
> void".  However resolving the conflict is straightforward, I'm including
> a replacement patch below.

I applied the replacement and put everything on pci/hotplug for v4.19.

This is fantastic.  I really appreciate all your work, and especially
your clear, concise changelogs.

> >   - Mika had a few questions/comments that are still dangling.
> 
> I could resolve those with two further replacement patches:
> 
> - "17/32 PCI: pciehp: Enable/disable exclusively from IRQ thread"
>   => Deduplicate code to detect a change in slot occupancy
>      by introducing a small helper.
> 
> - "23/32 PCI: pciehp: Avoid slot access during reset"
>   => Amend commit message to justify usage of rw_semaphore.
> 
> However ISTR that you dislike replacement patches because they're
> more complicated for you to handle.  Would you prefer me to repost
> the full series instead?
> 
> Further open points:
> 
> - Mika suggested adding a few breaks to switch/case statements to avoid
>   unintentional fall-throughs if the code is later extended.  I think
>   it might be good to do that in a separate commit that is applied on
>   top of this series, and at the same time mark all intentional
>   fall-throughs as such for -Wimplicit-fallthrough.
>   BTW, you may see a merge conflict between the pci/06-16-lukas-pciehp
>   and the pci/misc branch because you've already applied Gustavo's patch
>   to the latter and it touches pciehp_ctrl.c.
> 
> - The commit message of "27/32 PCI: pciehp: Support interrupts sent from
>   D3hot" could optionally be extended by your comment that the "Downstream
>   Port" term includes both Root Ports and Switch Downstream Ports.
> 
> - Mika voiced a concern that "32/32 PCI: Whitelist Thunderbolt ports for
>   runtime D3" should probably be constrained to Apple systems, this is
>   pending a reply to the mail I sent yesterday evening.

If you send any of the above updates, I'll gladly update the
pci/hotplug branch.  You can either send replacement patches or
incremental ones that I can fold into existing commits.

Bjorn
