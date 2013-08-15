Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:39764 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758419Ab3HOAlY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 20:41:24 -0400
Received: by mail-vb0-f50.google.com with SMTP id x14so125282vbb.9
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 17:41:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130814213249.3c568da8@concha.lan>
References: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
 <CAErSpo6Gp34O=L1ASPRLLBxwQShn6SN5EfXjDT+G7XAg3qbL-g@mail.gmail.com> <20130814213249.3c568da8@concha.lan>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Aug 2013 17:41:03 -0700
Message-ID: <CALCETrVYKuRcRgKEroCVbvkqfHjOtAA1Rwn6b4uas19BXogkpA@mail.gmail.com>
Subject: Re: PCI devices w/ multiple drivers at once? (sb_edac vs i2c-imc)
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-edac@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 5:32 PM, Mauro Carvalho Chehab
<m.chehab@samsung.com> wrote:
>
> Em Wed, 14 Aug 2013 16:04:06 -0600
> Bjorn Helgaas <bhelgaas@google.com> escreveu:
>
> > On Wed, Aug 14, 2013 at 3:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > > I'm working on a driver for the Sandy Bridge iMC SMBUS controller.  It
> > > (mostly) lives on pci device 15, function 0.  So my driver registers
> > > as an ordinary PCI driver for that device (8086.3ca8).
> > >
> > > The problem is that sb_edac also registers for 8086.3ca8.  This means
> > > that the drivers conflict.  The sb_edac driver is actually driving
> > > functionality that's split between eleven (!) different pci devices,
> > > none of which overlaps the stuff I'm driving.
> > >
> > > What's the Right Way (tm) to handle this?  Should I just modify
> > > sb_edac to pick a different one of the 11 devices to probe?  Is there
> > > some standard way to handle this in the PCI code?
>
> The sb-edac driver needs to see lots of different devices in order to
> work, as the memory controller registers are on different PCI IDs.
>
> So, there's not much that can be done there, I'm afraid.

Would you be okay with changing the PCI ID that the sb_edac driver
binds to?  That is, let it claim any of the other mess of devices it
talks to.

Alternatively, I could shove the whole thing into the edac-sbridge module.

>
>
> Btw, we almost added a code there to also access the SMBUS, in order to
> enumerate the memories. We ended by not adding, because we were afraid
> or risking to race with BIOS. A race while access an I2C EEPROM memory
> can be very bad, as a read operation might be understood as write, thus
> destroying the DIMM configuration.

The controller is, indeed, amazingly racy.  But I have access to
(NDAed) reference code for this, and I need it for NVDIMM support,
which is a real thing that AFAICT Intel's trying to support, so this
stuff is really supposed to work.  (The reference code performs
undocumented incantations that I can't (yet?) talk about.)

Is there any way to get sb_edac to expose, for each DIMM, the physical
address range that the DIMM maps to (or at least the range that
contains all the interleaved bits of it).  That would give me a nice
sanity check to validate that the firmware isn't lying about the
NVDIMM aperture.

(Don't use my old i2c_imc submission as a valid sample -- it blows up
terribly when closed-loop thermal throttling is on.)

--Andy
