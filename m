Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38700 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529AbbIUWKt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 18:10:49 -0400
Received: by igxx6 with SMTP id x6so67567796igx.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2015 15:10:48 -0700 (PDT)
Date: Mon, 21 Sep 2015 17:10:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Ulrich Obergfell <uobergfe@redhat.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7] pci: quirk to skip msi disable on shutdown
Message-ID: <20150921221043.GR25767@google.com>
References: <1441553385-3810-1-git-send-email-mst@redhat.com>
 <20150921182147.GC27964@google.com>
 <20150921223622-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150921223622-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 10:42:13PM +0300, Michael S. Tsirkin wrote:
> On Mon, Sep 21, 2015 at 01:21:47PM -0500, Bjorn Helgaas wrote:
> > On Sun, Sep 06, 2015 at 06:32:35PM +0300, Michael S. Tsirkin wrote:
> > > On some hypervisors, virtio devices tend to generate spurious interrupts
> > > when switching between MSI and non-MSI mode.  Normally, either MSI or
> > > non-MSI is used and all is well, but during shutdown, linux disables MSI
> > > which then causes an "irq %d: nobody cared" message, with irq being
> > > subsequently disabled.
> > 
> > My understanding is:
> > 
> >   Linux disables MSI/MSI-X during device shutdown.  If the device
> >   signals an interrupt after that, it may use INTx.
> > 
> > This INTx interrupt is not necessarily spurious.  Using INTx to signal an
> > interrupt that occurs when MSI is disabled seems like reasonable behavior
> > for any PCI device.
> > And it doesn't seem related to switching between MSI and non-MSI mode.
> > Yes, the INTx happens *after* disabling MSI, but it is not at all
> > *because* we disabled MSI.  So I wouldn't say "they generate spurious
> > interrupts when switching between MSI and non-MSI."
> > 
> > Why doesn't virtio-pci just register an INTx handler in addition to an MSI
> > handler?
> 
> The handler causes an expensive exit to the hypervisor,
> and the INTx lines are shared with other devices.

Do we care?  Is this a performance path?  I thought we were in a kexec
shutdown path.

> Seems silly to slow them down just so we can do something
> that triggers the device bug.  The bus master is disabled by that time,
> if linux can just desist from touching MSI enable device won't
> send either INTx (because MSI is on) or MSI
> (because bus master is on) and all will be well.

It would also be silly to put special-purpose code in the PCI core
if there's a reasonable way to handle this in a driver.

Can you describe exactly what the device bug is?  Apparently you're
saying that if we shut down MSI, it triggers the bug?  And I guess
you're talking about a virtio device as implemented in qemu or other
hypervisors?

If we leave MSI enabled (as your patch does), then the device has MSI
enabled and Bus Master disabled.  I can see these possibilities:

  1) the device never recognizes an interrupt condition
  2) the device sets the pending bit but doesn't issue the MSI write,
     so the OS doesn't see the interrupt unless it polls for it
  3) the device signals MSI and we still have an MSI handler
     registered, so we silently handle it
  4) the device signals INTx

You seem to suggest that if we leave MSI enabled (as your patch does),
we're in case 1.  But I doubt that disabling MSI causes the device to
interrupt.

Case 2 seems more likely to me: the device recognized an interrupt
condition, e.g., an event occurred, and the OS simply doesn't see the
interrupt because the device can't issue the MSI message.

Case 3 does seem like it would be a device bug, because the device
shouldn't do an MSI write when Bus Master is disabled.  I don't see
this case mentioned explicitly in the PCI spec, but PCIe r3.0 spec sec
7.5.1.1 does make it clear that disabling Bus Master also disables MSI
messages.

I don't know whether case 4 would be legal or not.  But apparently it
doesn't happen with the virtio device anyway, so it's not really a
concern here.

Bjorn
