Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752489AbdFMR2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Jun 2017 13:28:51 -0400
Date: Tue, 13 Jun 2017 12:28:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI
 controller
Message-ID: <20170613172849.GA7012@bhelgaas-glaptop.roam.corp.google.com>
References: <CAAd53p6S9NPBD=qGP419mhBgSgn-s1dc=adued8Y+Y0=GDsHKg@mail.gmail.com>
 <Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org>
 <CAAd53p580X5_G6a05aAueHVxEoy5hpQrs6s2gtJA+gPEf2PqLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAd53p580X5_G6a05aAueHVxEoy5hpQrs6s2gtJA+gPEf2PqLg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm]

On Tue, Jun 13, 2017 at 12:21:15PM +0800, Kai-Heng Feng wrote:
> On Mon, Jun 12, 2017 at 10:18 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Let's get some help from people who understand PCI well.
> >
> > Here's the general problem: Kai-Heng has a PCI-based USB host
> > controller that advertises wakeup capability from D3, but it doesn't
> > assert PME# from D3 when it should.  For "lspci -vv" output, see
> >
> >         http://marc.info/?l=linux-usb&m=149570231732519&w=2
> >
> > On Mon, 12 Jun 2017, Kai-Heng Feng wrote:
> >
> >> On Mon, Jun 12, 2017 at 3:04 PM, Kai-Heng Feng
> >> <kai.heng.feng@canonical.com> wrote:
> >> > On Fri, Jun 9, 2017 at 10:43 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> >> On Fri, 9 Jun 2017, Kai-Heng Feng wrote:
> >> >>
> >> >> Is this really the right solution?  Maybe it would be better to allow
> >> >> the controller to go into D3 provided no wakeup signal is needed.  You
> >> >> could do:
> >> >>
> >> >>                 device_set_wakeup_capable(&pdev->dev, 0);
> >> >
> >> > This doesn't work.
> >> > After applying this function, still nothing happens when devices get plugged in.
> >> > IIUC this function disable the wakeup function, but what I want to do
> >> > here is to have PME signal works even when runtime PM is enabled.
> >
> > This may indicate a bug in either the PCI or USB stacks (or both!).  If
> > a driver requires wakeup capability from runtime suspend but the device
> > does not provide it, the PCI core should not allow the device to go
> > into runtime suspend.  Or is that the driver's responsibility?
> >
> >> > I also saw some legacy PCI PM stuff, so I also tried:
> >> > device_set_wakeup_capable(&pdev->dev, 1);
> >> > ...doesn't work either.
> >> >
> >> >>
> >> >> Another alternative is to put the controller into D2 instead of D3, but
> >> >> (1) I don't know how to do that, and (2) we don't know if wakeup
> >> >> signalling works any better in D2 than it does in D3.
> >> >
> >> > I'll try if D2 works.
> >>
> >> Put the device into D2 instead of D3 can make the wakeup signaling
> >> work, i.e. USB devices can be correctly detected after plugged into
> >> EHCI port.
> >>
> >> Do you think this alternative an acceptable workaround?
> >
> > Yes, it is.  The difficulty is that I don't know how to tell the PCI
> > core that the device should go in D2 during runtime suspend instead of
> > D3.  Some sort of quirk may be needed -- perhaps Bjorn can help.
> >
> 
> FWIW, this is the diff I used to make the controller transits to D2
> instead of D3:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 563901cd9c06..36663688404a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -922,6 +922,9 @@ int pci_set_power_state(struct pci_dev *dev,
> pci_power_t state)
>         if (dev->current_state == state)
>                 return 0;
> 
> +       if (state > PCI_D2 && (dev->dev_flags & PCI_DEV_FLAGS_MAX_D2))
> +               state = PCI_D2;
> +
>         __pci_start_power_transition(dev, state);
> 
>         /* This device is quirked not to be put into D3, so
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 93326974ff4b..a2c1fe62974a 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -181,6 +181,8 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
>                 if (pdev->device == 0x7808) {
>                         ehci->use_dummy_qh = 1;
>                         ehci_info(ehci, "applying AMD
> SB700/SB800/Hudson-2/3 EHCI dummy qh workaround\n");
> +
> +                       pdev->dev_flags |= PCI_DEV_FLAGS_MAX_D2;
>                 }
>                 break;
>         case PCI_VENDOR_ID_VIA:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8039f9f0ca05..6f86f2aa8548 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -188,6 +188,7 @@ enum pci_dev_flags {
>          * the direct_complete optimization.
>          */
>         PCI_DEV_FLAGS_NEEDS_RESUME = (__force pci_dev_flags_t) (1 << 11),
> +       PCI_DEV_FLAGS_MAX_D2 = (__force pci_dev_flags_t) (1 << 12),
>  };
> 
>  enum pci_irq_reroute_variant {

The lspci output [1] shows:

  00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller (rev 39) (prog-if 20 [EHCI])
    Capabilities: [c0] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
      Bridge: PM- B3+

The device claims it can assert PME# from D3hot.  If it can't, that
sounds like a hardware defect that should be addressed with a quirk.
Ideally we would also have a pointer to the AMD hardware erratum.

Is the following path involved here?

  pci_finish_runtime_suspend
    target_state = pci_target_state()
      if (device_may_wakup())
	if (dev->pme_support)
	  ...
    pci_set_power_state(..., target_state)

If so, I would naively expect that a quirk could clear the
PCI_PM_CAP_PME_D3 and PCI_PM_CAP_PME_D3cold bits in dev->pme_support,
and pci_target_state() would then avoid selecting D3 or D3cold.  But
I'm not an expert in power management.

Bjorn

[1] http://marc.info/?l=linux-usb&m=149570231732519&w=2
