Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35812 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751977AbdFLOSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2017 10:18:53 -0400
Date: Mon, 12 Jun 2017 10:18:52 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>
cc: gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
In-Reply-To: <CAAd53p6S9NPBD=qGP419mhBgSgn-s1dc=adued8Y+Y0=GDsHKg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1706121010010.2092-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Let's get some help from people who understand PCI well.

Here's the general problem: Kai-Heng has a PCI-based USB host 
controller that advertises wakeup capability from D3, but it doesn't 
assert PME# from D3 when it should.  For "lspci -vv" output, see

	http://marc.info/?l=linux-usb&m=149570231732519&w=2

On Mon, 12 Jun 2017, Kai-Heng Feng wrote:

> On Mon, Jun 12, 2017 at 3:04 PM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Fri, Jun 9, 2017 at 10:43 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> On Fri, 9 Jun 2017, Kai-Heng Feng wrote:
> >>
> >> Is this really the right solution?  Maybe it would be better to allow
> >> the controller to go into D3 provided no wakeup signal is needed.  You
> >> could do:
> >>
> >>                 device_set_wakeup_capable(&pdev->dev, 0);
> >
> > This doesn't work.
> > After applying this function, still nothing happens when devices get plugged in.
> > IIUC this function disable the wakeup function, but what I want to do
> > here is to have PME signal works even when runtime PM is enabled.

This may indicate a bug in either the PCI or USB stacks (or both!).  If 
a driver requires wakeup capability from runtime suspend but the device 
does not provide it, the PCI core should not allow the device to go 
into runtime suspend.  Or is that the driver's responsibility?

> > I also saw some legacy PCI PM stuff, so I also tried:
> > device_set_wakeup_capable(&pdev->dev, 1);
> > ...doesn't work either.
> >
> >>
> >> Another alternative is to put the controller into D2 instead of D3, but
> >> (1) I don't know how to do that, and (2) we don't know if wakeup
> >> signalling works any better in D2 than it does in D3.
> >
> > I'll try if D2 works.
> 
> Put the device into D2 instead of D3 can make the wakeup signaling
> work, i.e. USB devices can be correctly detected after plugged into
> EHCI port.
> 
> Do you think this alternative an acceptable workaround?

Yes, it is.  The difficulty is that I don't know how to tell the PCI 
core that the device should go in D2 during runtime suspend instead of 
D3.  Some sort of quirk may be needed -- perhaps Bjorn can help.

Alan Stern
