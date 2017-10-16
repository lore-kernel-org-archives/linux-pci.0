Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755874AbdJPWGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Oct 2017 18:06:34 -0400
Date: Mon, 16 Oct 2017 17:06:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>
Subject: Re: PCIe error reporting
Message-ID: <20171016220631.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD008D9F2@AcuExch.aculab.com>
 <20171010211035.GY25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0090E73@AcuExch.aculab.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00911C9@AcuExch.aculab.com>
 <20171011132525.GF25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009155B@AcuExch.aculab.com>
 <20171011172113.GJ25517@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0097D9F@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0097D9F@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 02:23:22PM +0000, David Laight wrote:
> From: Bjorn Helgaas
> > On Wed, Oct 11, 2017 at 04:00:04PM +0000, David Laight wrote:
> > > From: Bjorn Helgaas

> > It would be interesting to know what Windows does about AER on that
> > platform.  I would expect Windows to respect the platform's wishes as
> > expressed by _OSC, so if Windows does AER recovery, there might be a
> > problem in the way Linux uses _OSC.
> 
> I've booted server 2012, difficult to say whether AER gets logged.
> There are some recent WHEA logs - but not from when I was generating
> errors.  The event viewer doesn't decode the data that might say
> what is being reported.

I don't know how to tell what Windows is doing with respect to AER.

> I've 'bodged' the Linux kernel to think that the BIOS gave it control
> of AER (set OSC_PCI_EXPRESS_AER_CONTROL into *mask and
> root->osc_control_set in acpi_pci_osc_control_set()).
> I think this is the earliest place the info is saved.
> This is enough to the 'pcieport ... AER enabled with IRQ nn' messages
> (It is sharing the interrupt with PME).
> 
> I've made sure my card is beneath one of the cpu bridges (the companion
> chip host bridges don't support AER).
> I've also bodged the driver to ioremap() an area larger than one of the
> BARs so I can generated PCIe read and write TLP that are outside the
> BAR ranges.
> Reads set CESta: NonFatalError.
> Writes set UESTA: UnsepReq and save the TLP header.
> No interrupts to aerdrv are generated.
> I can clear the status bits using setpci.
> Should I expect these errors to raise interrupts?

I think that depends on the Root Error Command register.
