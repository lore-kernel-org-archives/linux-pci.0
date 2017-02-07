Return-Path: <SRS0=UJwY=ZU=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=UJwY=ZU=wunner.de=lukas@kernel.org>
Date: Tue, 7 Feb 2017 07:26:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Don't enable PME on runtime suspend
Message-ID: <20170207062659.GC791@wunner.de>
References: <d1ae979d256631e7c189694a6d3e1a518abf3fc8.1486359844.git.lukas@wunner.de>
 <20170206175405.GA15565@bhelgaas-glaptop.roam.corp.google.com>
 <20170206212041.GC679@wunner.de>
 <1518967.ikNpzX2uft@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518967.ikNpzX2uft@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 10:52:12PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 06, 2017 10:20:41 PM Lukas Wunner wrote:
> > On Mon, Feb 06, 2017 at 11:54:05AM -0600, Bjorn Helgaas wrote:
> > > On Mon, Feb 06, 2017 at 06:54:37AM +0100, Lukas Wunner wrote:
> > > > Since commit 68db9bc81436 ("PCI: pciehp: Add runtime PM support for PCIe
> > > > hotplug ports") we runtime suspend a hotplug port to D3hot when all its
> > > > children are runtime suspended or none are present.
> > > > 
> > > > When runtime suspending the port the PCI core automatically enables PME:
> > > >     pci_pm_runtime_suspend()
> > > >         pci_finish_runtime_suspend()
> > > >             __pci_enable_wake()
> > > > 
> > > > According to the PCI Express Base Specification, section 6.7.3.4:
> > > >    "Note that PME and Hot-Plug Event interrupts (when both are
> > > >     implemented) always share the same MSI or MSI-X vector [...]
> > > >     If wake generation is required by the associated form factor
> > > >     specification, a hot-plug capable Downstream Port must support
> > > >     generation of a wakeup event (using the PME mechanism) on hotplug
> > > >     events that occur when the system is in a sleep state or the Port
> > > >     is in device state D1, D2, or D3Hot."
> > > > 
> > > > Thus, if the port is runtime suspended even though it is still occupied,
> > > > it may immediately be woken by a PME interrupt.
> > > 
> > > The spec goes on to say that a wakeup event should be generated when
> > > all three of these conditions occur:
> > > 
> > >   - status register for an enabled [hotplug] event transitions from
> > >     not set to set
> > > 
> > >   - Port is in D1, D2, or D3hot,
> > > 
> > >   - PME_En is set
> > > 
> > > I think you're saying that if we put a hotplug-capable port that
> > > controls an occupied slot into D3hot, the port may immediately
> > > generate a wakeup PME.
> > > 
> > > What is the hotplug event that causes generation of this wakeup event?
> > 
> > If you had read all e-mails in this thread or looked at the bugzilla
> > entry I've created, you wouldn't have to ask this question.
> > 
> > I think it's disappointing that you're asking me to jump through
> > various hoops like creating a bugzilla entry, as well as threatening
> > to revert my patch, but are unwilling to even look at the bugzilla
> > entry or read the entire thread.  It is equally disappointing that
> > the reporter of the regression was unwilling or unable to provide
> > dmesg output for both machines so that we've got no real idea what
> > we're dealing with.
> > 
> > It's a Link Up event.
> > 
> > Which doesn't make sense of course because per the spec PME is only
> > supposed to be signaled when the Link Status *changes* from 0 to 1,
> 
> BTW, where exactly did you find this bit in the spec?

PCIe Base Spec, section 6.7.3.4:

"For form factors that support wake generation, a wakeup event must be
 generated if all three of the following conditions occur:

 * The status register for an enabled event transitions from not set to set
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * The Port is in device state D1, D2, or D3Hot, and
 * The PME_En bit in the Port's Power Management Control/Status register is
   set"


My point was that the Link Status shouldn't arbitrarily change from 0 to 1
after powering off the slot.

Best regards,

Lukas
