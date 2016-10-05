Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcJESyI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Oct 2016 14:54:08 -0400
Date: Wed, 5 Oct 2016 13:54:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pierre de Villemereuil <flyos@mailoo.org>,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
Message-ID: <20161005185401.GA30607@localhost>
References: <57F4B9C5.60600@linux.intel.com>
 <Pine.LNX.4.44L0.1610051030310.1880-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1610051030310.1880-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Lukas]

On Wed, Oct 05, 2016 at 10:45:22AM -0400, Alan Stern wrote:
> [Adding Bjorn and linux-pci to the CC: list]
> 
> In short, Pierre's USB host controller doesn't send wakeup signals from
> runtime suspend, because the firmware limits the runtime-suspend state
> to D0 and the controller can't issue PME# from the D0 state.  In this
> situation we would prefer to avoid suspending the controller at all,
> rather than have it go into runtime suspend and then stop working.
> 
> On Wed, 5 Oct 2016, Mathias Nyman wrote:
> 
> > On 04.10.2016 17:11, Alan Stern wrote:
> > > On Tue, 4 Oct 2016, Mathias Nyman wrote:
> > >
> > >> On 03.10.2016 23:54, Pierre de Villemereuil wrote:
> > >>> Hi Mathias,
> > >>>
> > >>> Just to know: does that mean the firmware from Asus is faulty in here? Do you
> > >>> think I should contact Asus about this?
> > >>>
> > >>
> > >> Probably, _S0W, _DSM  and XFLT code for xHCI are useless in that ACPI DSDT firmware version.
> > >>
> > >> But we still want the driver to handle cases like this.
> > >> Just wrote the patch.
> > >> Adding Alan Stern to CC for PM sanity feedback on it:
> > >>
> > >> ---
> > >>
> > >> Author: Mathias Nyman <mathias.nyman@linux.intel.com>
> > >> Date:   Tue Oct 4 13:07:59 2016 +0300
> > >>
> > >>       xhci: Prevent a non-responsive xhci suspend state.
> > >>
> > >>       ACPI may limit the lowest possible runtime suspend PCI D-state to D0.
> > >>       If xHC is not capable of generating PME# events in D0 we end
> > >>       up with a non-responsive runtime suspended host without PME# capability
> > >>       and with interrupts disabled, unable to detect or wake up when a
> > >>       new usb device is connected.
> > >>
> > >>       This was triggered on a ASUS TP301UA machine.
> > >>
> > >>       Reported-by: Pierre de Villemereuil <flyos@mailoo.org>
> > >>       Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > >>
> > >> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > >> index d7b0f97..08b021c 100644
> > >> --- a/drivers/usb/host/xhci-pci.c
> > >> +++ b/drivers/usb/host/xhci-pci.c
> > >> @@ -396,6 +396,11 @@ static int xhci_pci_suspend(struct usb_hcd *hcd, bool do_wakeup)
> > >>           if (xhci->quirks & XHCI_SSIC_PORT_UNUSED)
> > >>                   xhci_ssic_port_unused_quirk(hcd, true);
> > >>
> > >> +       /* Prevent a non-responsive PCI D0 state without PME# wake capability */
> > >> +       if (pci_choose_state(pdev, PMSG_AUTO_SUSPEND) == PCI_D0)
> > >> +               if (!pci_pme_capable(pdev, PCI_D0))
> > >> +                       return -EBUSY;
> > >> +
> > >>           ret = xhci_suspend(xhci, do_wakeup);
> > >>           if (ret && (xhci->quirks & XHCI_SSIC_PORT_UNUSED))
> > >>                   xhci_ssic_port_unused_quirk(hcd, false);
> > >
> > > I've got three comments about this proposal.
> > >
> > > First, this logic should not apply during system suspend, only during
> > > runtime suspend.  You don't want to abort putting a laptop to sleep
> > > just because the xHCI controller can't generate wakeup signals.
> > 
> > Yes, I assume it would be ok change usb core to pass down something like
> > pm_message_t to suspend_common() so that we could do this.
> > hcd_pci_runetime_suspend()  -> suspend_common()  -> hcd->driver->pci_suspend()
> > 
> > Assuming this workaround should stay in xhci-pci.c
> 
> If necessary, it could be moved into hcd_pci_runtime_suspend().  But I 
> would prefer to put it in the PCI core.
> 
> > > Second, this really has nothing to do with the D0 state.  The same
> > > logic should apply to whatever state is chosen for runtime suspend: If
> > > the controller can't generate PME# wakeup signals in that state then
> > > the suspend should be aborted.
> > 
> > PCI code actually does this for us, it will walk down the D-states until
> > it finds one that support PME#, but stop at D0 end return D0 even if D0
> > does not support PME#.
> 
> That sounds like a bug.  Or rather, accepting D0 as the target state
> when it doesn't support PME# is the bug.
> 
> > Unfortunately that is done in a static function in pci/pci.c.
> > 
> > static pci_power_t pci_target_state(struct pci_dev *dev)
> > {
> >          pci_power_t target_state = PCI_D3hot;
> > 
> > 	if (platform_pci_power_manageable(dev)) {
> >                  /*
> >                   * Call the platform to choose the target state of the device
> >                   * and enable wake-up from this state if supported.
> >                   */
> >                  pci_power_t state = platform_pci_choose_state(dev);
> > 
> > 	        switch (state) {
> > 	        case PCI_POWER_ERROR:
> >                  case PCI_UNKNOWN:
> >                          break;
> >                  case PCI_D1:
> >                  case PCI_D2:
> >                          if (pci_no_d1d2(dev))
> > 	                        break;
> >                  default:
> > 	                target_state = state;
> >                  }
> >          } else if (!dev->pm_cap) {
> >                  target_state = PCI_D0;
> >          } else if (device_may_wakeup(&dev->dev)) {
> >                  /*
> >                   * Find the deepest state from which the device can generate
> >                   * wake-up events, make it the target state and enable device
> >                   * to generate PME#.
> >                   */
> >                  if (dev->pme_support) {
> >                          while (target_state
> >                                && !(dev->pme_support & (1 << target_state)))
> >                                  target_state--;
> >                  }
> >          }
> > 
> >          return target_state;
> > }
> > 
> > The best I can do from xhci is call pci_choose_state() which will call
> > platform_pci_choose_state(), but won't do the PME# checking and
> > D-state decrement to D0 .
> > 
> > If pci_choose_state() returns D0 from a runtime suspend callback
> > (and yes, should make sure its runtime suspend, not system suspend)
> > I can pretty much assume pci_target_state will do the same.
> > 
> > >
> > > Third, the same reasoning applies to every PCI device that relies on
> > > PME#, not just to xHCI controllers.  Therefore the new code should be
> > > added to drivers/pci/pci-driver.c:pci_pm_runtime_suspend(), not to
> > > xhci-pci.c.
> > 
> > Yes, that would be the preferred solution.
> > I was not sure we can do that. pci-driver.c pci_pm_runtime_suspend() will call
> > pci_finish_runtime_suspend()
> >    pci_target_state()        // returns D0,
> >    pci_set_power_state()    // to D0, which is the state we probably are already in.
> > 
> > So it won't really do much. The device PCI device is disabled in usb hcd suspend
> > hcd-pci.c:
> > suspend_common()
> >    ...
> >    pci_disable_device(pci_dev)
> > 
> > Should we anyway disable runtime PM in PCI if the PCI device has wakeup enabled
> > and the target state is D0 without PME# support?
> 
> First, the device_may_wakeup() test applies only to suspend suspend, 
> not to runtime suspend.  The current PM design assumes that wakeup will 
> always be enabled during runtime suspend (if the device supports it).
> 
> Second, there is a potential problem because some PCI devices have
> other platform-based mechanisms for sending wakeup signals, instead of
> using PME#.  Such devices probably don't support standard PCI wakeup at
> all.  (A good example is the UHCI controllers on Intel's old chipsets.)
> We don't want to prevent them from going into runtime suspend.
> 
> Now, maybe this isn't an issue -- I don't know enough about the details
> of how the PCI core handles runtime suspend and how it coordinates with
> the platform code.
> 
> Hopefully Bjorn can fill in the missing details.
> 
> Alan Stern
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
