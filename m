Return-Path: <SRS0=Doyg=5T=rowland.harvard.edu=stern+5952b05e@kernel.org>
Return-Path: <SRS0=Doyg=5T=rowland.harvard.edu=stern+5952b05e@kernel.org>
Date: Wed, 14 Jun 2017 14:55:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
    Bjorn Helgaas <bhelgaas@google.com>,  <gregkh@linuxfoundation.org>,
    USB list <linux-usb@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
    LKML <linux-kernel@vger.kernel.org>,
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
     <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
In-Reply-To: <20170613172849.GA7012@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <Pine.LNX.4.44L0.1706141449190.1889-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Tue, 13 Jun 2017, Bjorn Helgaas wrote:

> [+cc Rafael, linux-pm]
> 
> On Tue, Jun 13, 2017 at 12:21:15PM +0800, Kai-Heng Feng wrote:
> > On Mon, Jun 12, 2017 at 10:18 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Let's get some help from people who understand PCI well.
> > >
> > > Here's the general problem: Kai-Heng has a PCI-based USB host
> > > controller that advertises wakeup capability from D3, but it doesn't
> > > assert PME# from D3 when it should.  For "lspci -vv" output, see
> > >
> > >         http://marc.info/?l=linux-usb&m=149570231732519&w=2
> > >
> > > On Mon, 12 Jun 2017, Kai-Heng Feng wrote:
> > >
> > >> On Mon, Jun 12, 2017 at 3:04 PM, Kai-Heng Feng
> > >> <kai.heng.feng@canonical.com> wrote:
> > >> > On Fri, Jun 9, 2017 at 10:43 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >> >> On Fri, 9 Jun 2017, Kai-Heng Feng wrote:
> > >> >>
> > >> >> Is this really the right solution?  Maybe it would be better to allow
> > >> >> the controller to go into D3 provided no wakeup signal is needed.  You
> > >> >> could do:
> > >> >>
> > >> >>                 device_set_wakeup_capable(&pdev->dev, 0);
> > >> >
> > >> > This doesn't work.
> > >> > After applying this function, still nothing happens when devices get plugged in.
> > >> > IIUC this function disable the wakeup function, but what I want to do
> > >> > here is to have PME signal works even when runtime PM is enabled.
> > >
> > > This may indicate a bug in either the PCI or USB stacks (or both!).  If
> > > a driver requires wakeup capability from runtime suspend but the device
> > > does not provide it, the PCI core should not allow the device to go
> > > into runtime suspend.  Or is that the driver's responsibility?
> > >
> > >> > I also saw some legacy PCI PM stuff, so I also tried:
> > >> > device_set_wakeup_capable(&pdev->dev, 1);
> > >> > ...doesn't work either.
> > >> >
> > >> >>
> > >> >> Another alternative is to put the controller into D2 instead of D3, but
> > >> >> (1) I don't know how to do that, and (2) we don't know if wakeup
> > >> >> signalling works any better in D2 than it does in D3.
> > >> >
> > >> > I'll try if D2 works.
> > >>
> > >> Put the device into D2 instead of D3 can make the wakeup signaling
> > >> work, i.e. USB devices can be correctly detected after plugged into
> > >> EHCI port.
> > >>
> > >> Do you think this alternative an acceptable workaround?
> > >
> > > Yes, it is.  The difficulty is that I don't know how to tell the PCI
> > > core that the device should go in D2 during runtime suspend instead of
> > > D3.  Some sort of quirk may be needed -- perhaps Bjorn can help.

> The lspci output [1] shows:
> 
>   00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 39) (prog-if 20 [EHCI])
>     Capabilities: [c0] Power Management version 2
>       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>       Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
>       Bridge: PM- B3+
> 
> The device claims it can assert PME# from D3hot.  If it can't, that
> sounds like a hardware defect that should be addressed with a quirk.
> Ideally we would also have a pointer to the AMD hardware erratum.
> 
> Is the following path involved here?
> 
>   pci_finish_runtime_suspend
>     target_state = pci_target_state()
>       if (device_may_wakup())
> 	if (dev->pme_support)
> 	  ...
>     pci_set_power_state(..., target_state)
> 
> If so, I would naively expect that a quirk could clear the
> PCI_PM_CAP_PME_D3 and PCI_PM_CAP_PME_D3cold bits in dev->pme_support,
> and pci_target_state() would then avoid selecting D3 or D3cold.  But
> I'm not an expert in power management.

That's a good idea.  However, we should apply the quirk only when it is 
needed.  Which means we need to know the numeric values for the PCI 
IDs.  Also, this will help searching for published errata.

Kai-Heng, what does "lspci -nvs 00:12.0" show?

Alan Stern
