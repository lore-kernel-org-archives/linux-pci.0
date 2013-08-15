Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]:19638 "EHLO
	usmailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3HOAcz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 20:32:55 -0400
Date: Wed, 14 Aug 2013 21:32:49 -0300
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-edac@vger.kernel.org
Subject: Re: PCI devices w/ multiple drivers at once? (sb_edac vs i2c-imc)
Message-id: <20130814213249.3c568da8@concha.lan>
In-reply-to: <CAErSpo6Gp34O=L1ASPRLLBxwQShn6SN5EfXjDT+G7XAg3qbL-g@mail.gmail.com>
References: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
 <CAErSpo6Gp34O=L1ASPRLLBxwQShn6SN5EfXjDT+G7XAg3qbL-g@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Em Wed, 14 Aug 2013 16:04:06 -0600
Bjorn Helgaas <bhelgaas@google.com> escreveu:

> On Wed, Aug 14, 2013 at 3:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > I'm working on a driver for the Sandy Bridge iMC SMBUS controller.  It
> > (mostly) lives on pci device 15, function 0.  So my driver registers
> > as an ordinary PCI driver for that device (8086.3ca8).
> >
> > The problem is that sb_edac also registers for 8086.3ca8.  This means
> > that the drivers conflict.  The sb_edac driver is actually driving
> > functionality that's split between eleven (!) different pci devices,
> > none of which overlaps the stuff I'm driving.
> >
> > What's the Right Way (tm) to handle this?  Should I just modify
> > sb_edac to pick a different one of the 11 devices to probe?  Is there
> > some standard way to handle this in the PCI code?

The sb-edac driver needs to see lots of different devices in order to
work, as the memory controller registers are on different PCI IDs.

So, there's not much that can be done there, I'm afraid.

Btw, we almost added a code there to also access the SMBUS, in order to
enumerate the memories. We ended by not adding, because we were afraid
or risking to race with BIOS. A race while access an I2C EEPROM memory
can be very bad, as a read operation might be understood as write, thus
destroying the DIMM configuration.

> 
> Nope, there's no standard way to do this.
> 
> The single driver that claims a device is presumed to own all the
> device's resources, including its config space, BARs, interrupts, etc.
>  If two drivers need access to the same device, they need to
> coordinate between themselves somehow.
> 
> Bjorn

Regards,
Mauro
