Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757269AbdJKNZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Oct 2017 09:25:29 -0400
Date: Wed, 11 Oct 2017 08:25:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: Re: PCIe error reporting
Message-ID: <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 12:50:04PM +0000, David Laight wrote:
> From: David Laight
> > Sent: 11 October 2017 11:04
> ...
> > > > On that system (XEON E5-2600) dmesg contains (retyped):
> > > >   acpi: PNP0A08:00: _OSC: platform does not support [AER]
> > >
> > > Per the PCI Firmware spec r3.0, sec 4.5.1, on ACPI platforms, the OS
> > > is supposed to use _OSC to ask the firmware for permission before
> > > using AER.  In this case, the firmware declined to grant us
> > > permission, so we're not supposed to do anything at all with AER.
> > 
> > I read that as 'BIOS knows nothing about AER' rather than 'BIOS
> > refused to hand over control' - but I could be wrong.
> > 
> > I'm not sure where to look to see if the actual hardware does.
> > I'm guessing that Intel Haswell-E should.
> 
> I've four Haswell root port bridges with the AER block at offset 148.
> None of them have anything in the three 'root error registers'.
> 
> So the firmware/bios can't be using the registers - which means the
> OS could use them.

The current Linux behavior is based on the spec I cited above, which
says

  If any bits in the Control Field are returned cleared (masked to
  zero) by the _OSC control method, the respective feature is
  designated unsupported by the platform and must not be enabled by
  the operating system. Some of these features may be controlled by
  platform firmware prior to operating system boot or during runtime
  for a legacy operating system, while others may be
  disabled/inoperative until native operating system support is
  available.

If Linux is handling _OSC correctly (always a question, since it's
quite complicated), it sounds like your platform is telling Linux not
to enable AER.

You could experimentally make Linux enable AER anyway, but it's hard
for me to see how we could do that safely in general.

The short answer probably is "complain to your platform vendor".

Bjorn
