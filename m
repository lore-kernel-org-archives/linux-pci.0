Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33125 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdEOVAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 17:00:38 -0400
Received: by mail-pg0-f45.google.com with SMTP id u187so65622925pgb.0
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 14:00:37 -0700 (PDT)
Date: Mon, 15 May 2017 14:00:34 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] pci: Disable master abort while waiting for an FLR to
 complete
Message-ID: <20170515210033.GA58785@google.com>
References: <20170512181107.13853.34680.stgit@localhost.localdomain>
 <20170515163623.GA15237@google.com>
 <CAKgT0UfNBhHSK9yvt7rZFMb+aZ9OF-Y7O4H8Axsr4NF99w9phQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgT0UfNBhHSK9yvt7rZFMb+aZ9OF-Y7O4H8Axsr4NF99w9phQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 12:48:30PM -0700, Alexander Duyck wrote:
> On Mon, May 15, 2017 at 9:36 AM, Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, May 12, 2017 at 11:13:57AM -0700, Alexander Duyck wrote:
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 7904d02ffdb9..acbdbabeaa0e 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -3758,14 +3758,31 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
> >>   */
> >>  static void pci_flr_wait(struct pci_dev *dev)
> >>  {
> >> +     struct pci_dev *bridge = dev->bus->self;
> >>       int i = 0;
> >> +     u16 bctl;
> >>       u32 id;
> >>
> >> +     /*
> >> +      * Disable MasterAbortMode while we are waiting to avoid reporting
> >> +      * bus errors for reading the command register on a device that is
> >> +      * not ready (in some architectures)
> >
> > I assume it's intentional to only do this *after* you've started the
> > reset (but before you start polling)?
> 
> Yes. The general idea is that the only thing that should be accessing
> the device is us. So this way we can catch any other code that might
> be broken such as a device driver that is leaving a thread active that
> is accessing the device before a reset.

I figured as much (and that makes sense). Thus, this patch is
independent of the report I made in the first place -- that somehow MSI
interrupts can still be delivered from my EP while we're in the midst of
FLR.

> >> +      */
> >> +     if (bridge) {
> >> +             pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &bctl);
> >> +             pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
> >> +                                   bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
> >> +     }
> >> +
> >>       do {
> >>               msleep(100);
> >>               pci_read_config_dword(dev, PCI_COMMAND, &id);
> >
> > IIUC, the patch works fine, in that I no longer get an abort from the
> > RC.
> 
> So did you actually test this patch or are you just speculating it
> should work? I'm just not sure what you mean by "IIUC" in this context
> here, were you referring to how the patch fixes the issue or how the
> testing should work for verifying it fixed the issue?

I did test it, but due to the below issue (the timeout loop doesn't
actually work for me, and then we still abort / panic when the device
doesn't respond later) it's hard to tell whether this is very effective.

The precise reason why I use "IIUC": even with this patch, my system can
crash with asynchronous aborts (ARM64 SError) just after FLR. I *think*
that means the above pci_read_config_dword() is no longer causing an
abort, but it's hard to tell for sure what exactly caused the abort at
all when looking at asynchronous errors (I can add extra delays, prints,
etc., to get a pretty good idea, but that isn't exactly precise, and
it's time consuming). I *suspect* that I'm now just crashing due to
pci_dev_restore().

> >>       } while (i++ < 10 && id == ~0);
> >
> > BTW, the RK3399 host controller doesn't actually return all 1's on
> > aborted transactions. So this loop doesn't really work for it at all.
> >
> > I take it that this (seemingly widely used) pattern all derives from the
> > PCI spec, which notes:
> >
> >   "The host bus bridge, in PC compatible systems, must return all 1's on
> >   a read transaction and discard data on a write transaction when
> >   terminated with Master-Abort."
> >
> > RK3399 is far from a "PC compatible system", but I don't know if that's
> > a real excuse here...
> 
> So if it doesn't return all 1's does it return all 0's? I'm just
> curious what is returned?

All 0's.

> >>
> >> +     /* restore bridge state */
> >> +     if (bridge)
> >> +             pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bctl);
> >> +
> >>       if (id == ~0)
> >>               dev_warn(&dev->dev, "Failed to return from FLR\n");
> >
> > And there's no actual error code returned here; so since several of the
> > error cases I can trigger on my hardware seem to never actually recover
> > (no longer how long I wait and/or poll), it seems like we should
> > propagate the error upward. Right now, we still unconditionally continue
> > with the pci_dev_restore(), even though that's doomed to abort too...
> 
> If you take a look we ignore the return value anyway and call the
> restore function in pci_reset_function().

Right, that's what I was referring to.

> I think the general idea is
> we should still have a device here after attempting to perform the
> reset.

That assumption doesn't always seem to hold true here.

> It may be that performing an FLR isn't the right choice for this
> hardware. Do you know if it functions correctly and actually completes
> the reset correctly? I know in the case of some of the Intel Ethernet
> silicon we were advertising support for it but found an issue that was
> causing the Ethernet PHY to go offline as a result of performing the
> FLR.

I don't know exactly the cause for why this Wifi card aborts vs. when it
resets properly. A high percentage of the time, this card seems to reset
properly, but I am able to trigger certain cases (due to a buggy Wifi
driver; what's new?) that seem to get the entire card into a bad state
such that it no longer reset properly.

I can pursue the source of such driver bugs, but if I know anything
about this vendor, there's never going to be an acceptably-close-to-100%
certainty that there won't be such bugs again.

> Do you know what it was that was kicking off the need to perform
> the reset in the first place?

It's now baked into the mwifiex Wifi driver. It always has had a
fallback such that if the Wifi FW stops responding for whatever reason
[1], we can automatically unload the netdev / reset the device / reload
the netdev. This was supported for SDIO previously, but was added to the
PCIe driver in commit 4c5dae59d2e9 ("mwifiex: add PCIe function level
reset support") and extended to work automatically via this
not-yet-merged patch:

https://patchwork.kernel.org/patch/9706855/
[PATCH v3 2/2] mwifiex: pcie: add card_reset() support

> Also you may consider possibly adding a
> quirk if the FLR is kicking your device completely out of the system.
> There was recently a PCI flag added to indicate a device doesn't
> support FLR. You might try adding your own version of the quirk for
> this device to see if maybe pushing it to use a different sort of
> reset might be more useful.

I'm not sure if another sort of reset is available, nor if it would work
better. I'll investigate though.

Also, I'm told this same Wifi card works fine on other PCIe systems
(e.g., Intel-based laptops) without trouble, including over 1000s of FLR
cycles. (But I only trust such testing as far as I can throw the tester
though -- I don't think they're testing as many corner cases as I am.)

> > So there may be several implementation bugs with RK3399. I don't know
> > how much can be fixed on Rockchip's side, vs. how much can be
> > accomodated in the PCI core.
> >
> > Brian
> 
> This is the kind of thing we have PCIe quirks for if nothing else.
> Odds are we should be able to work around it, it is just a matter of
> knowing what all the quirks are.

Maybe your imagination for "quirks" isn't creative enough :)

Brian

[1] Hint: there are a boundless number of reasons for such FW failures.
