Return-Path: <SRS0=FPnD=5Y=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=FPnD=5Y=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
Date: Tue, 20 Jun 2017 00:00:33 +0200
Message-ID: <4743716.D4sjtRmsBZ@aspire.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1706191415180.1715-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 19, 2017 02:32:57 PM Alan Stern wrote:
> On Mon, 19 Jun 2017, Bjorn Helgaas wrote:
> 
> > > > Have you tested it with system suspend?  That is, if you suspend the
> > > > whole computer, does plugging or unplugging a USB device cause the
> > > > system to wake up?
> > > 
> > > No, the system will not wake up when plugging or unplugging.
> > > Tried several times, nether runtime PM enabled nor runtime PM disabled
> > > will wake up the system under S3, when (un)plugging USB devices.
> > 
> > Alan, I don't know what this test means for the patch
> > (http://marc.info/?l=linux-pci&m=149760607914628&w=2).
> > 
> > pci_target_state() is documented as "return the deepest state from
> > which the device can generate wake events."  For this device, I guess
> > that means D2, and the patch should accomplish that.
> > 
> > I don't know what's supposed to happen to this device when the system
> > is in S3.  I assume that if the system is in S3, most devices are in
> > D3.  If this device is in D3, we won't get PMEs, which I guess is what
> > Kai-Heng is seeing.  Is that the desired behavior?  Or do we want the
> > PMEs enough that we should leave the device in D2 (if that's even
> > possible)?
> 
> It's possible that the test was invalid.  Kai-Heng did not say whether
> /sys/.../power/wakeup was set to "enabled" for both the EHCI controller
> and the USB root hub beneath it, before the test was started.  If
> either of them was set to "disabled" then we would not expect a plug or
> unplug event to wake up the system.
> 
> In any case, the controller should be set to the lowest power setting 
> that is consistent with the desired wakeup behavior.  If wakeup is set 
> to "enabled" then the state should be D2 -- if possible.  That's the 
> theory, anyway.  If the system supports putting devices only into D3 
> during S3 sleep then there's no choice, but if we do have a choice then 
> we should take it.
> 
> BTW, I just noticed that pci_target_state() uses device_may_wakeup() to
> get the desired wakeup behavior.  That is correct for system sleep, but
> it is wrong for runtime PM.  For runtime PM, wakeup should be enabled
> whenever the hardware allows it, so the test should be
> device_can_wakeup().
> 
> This means that pci_target_state() should behave differently depending
> on whether it is called from pci_prepare_to_sleep() or from
> pci_finish_runtime_suspend().  Probably nobody noticed this before 
> because it usually doesn't make any difference.

Right, this is a bug.

Let me cut a fix for it.

Thanks,
Rafael
