Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Feb 2017 16:15:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yinghai Lu <yinghai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170206221502.GA27899@bhelgaas-glaptop.roam.corp.google.com>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206175405.GA15565@bhelgaas-glaptop.roam.corp.google.com>
 <20170206212041.GC679@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206212041.GC679@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 10:20:41PM +0100, Lukas Wunner wrote:
> On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 06, 2017 at 06:54:37AM +0100, Lukas Wunner wrote:
> > > Since commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> > > hotplug ports") we runtime suspend a hotplug port to D3hot when all its
> > > children are runtime suspended or none are present.
> > > 
> > > When runtime suspending the port the PCI core automatically enables PME:
> > >     pci_pm_runtime_suspend()
> > >         pci_finish_runtime_suspend()
> > >             __pci_enable_wake()
> > > 
> > > According to the PCI Express Base Specification, section 6.7.3.4:
> > >    "Note that PME and Hot-Plug Event interrupts (when both are
> > >     implemented) always share the same MSI or MSI-X vector [...]
> > >     If wake generation is required by the associated form factor
> > >     specification, a hot-plug capable Downstream Port must support
> > >     generation of a wakeup event (using the PME mechanism) on hotplug
> > >     events that occur when the system is in a sleep state or the Port
> > >     is in device state D1, D2, or D3Hot."
> > > 
> > > Thus, if the port is runtime suspended even though it is still occupied,
> > > it may immediately be woken by a PME interrupt.
> > 
> > The spec goes on to say that a wakeup event should be generated when
> > all three of these conditions occur:
> > 
> >   - status register for an enabled [hotplug] event transitions from
> >     not set to set
> > 
> >   - Port is in D1, D2, or D3hot,
> > 
> >   - PME_En is set
> > 
> > I think you're saying that if we put a hotplug-capable port that
> > controls an occupied slot into D3hot, the port may immediately
> > generate a wakeup PME.
> > 
> > What is the hotplug event that causes generation of this wakeup event?
> 
> If you had read all e-mails in this thread or looked at the bugzilla
> entry I've created, you wouldn't have to ask this question.

I'm sorry, I don't necessarily have time to sort through all the
emails.  My idea is that the changelog should be a self-contained
justification for the patch.  The bugzilla is for supporting details
and future archaeologists.

> I think it's disappointing that you're asking me to jump through
> various hoops like creating a bugzilla entry, as well as threatening
> to revert my patch, but are unwilling to even look at the bugzilla
> entry or read the entire thread.  It is equally disappointing that
> the reporter of the regression was unwilling or unable to provide
> dmesg output for both machines so that we've got no real idea what
> we're dealing with.

I beg your pardon?  I don't think it's fair to malign Yinghai.  He's
tested at least two machines and at least two patches, and it's only
been two working days since he reported the problem.  He deserves
great thanks for finding this issue early.

If you think a bugzilla is onerous or a revert of a patch that breaks
something is inappropriate, we might have to just disagree.

I'll come back to this later.  I'm still hoping that somebody will do
some experiments with pciehp out of the picture, using setpci to walk
through this manually.  At this point I'm more inclined to suspect a
pciehp issue than a hardware erratum.  If we could reproduce a problem
without pciehp in the picture, that would be much more convincing.

Bjorn
