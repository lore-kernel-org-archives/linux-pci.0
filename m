Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52702 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab2GQUzx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 16:55:53 -0400
Received: by lbbgm6 with SMTP id gm6so1136608lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 13:55:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120717214656.20a84ff1@stein>
References: <FC57104DF444434A9D1D8A7B4EBB29231353B632@HC-EXCHANGE.nt-fsrvr.o2micro.com>
 <CAErSpo5tpn0o3NTZy3VCvhU4H7+vWCSdMVmgaexqY8VY_4h=yw@mail.gmail.com> <20120717214656.20a84ff1@stein>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Jul 2012 14:55:31 -0600
Message-ID: <CAErSpo49SMAbGJTSzzdoiAxgEm6DpxqXxOhk6CWUqtMW9WkcRg@mail.gmail.com>
Subject: Re: [Bug 43247] O2 micro SD/MMC+1394 controller: 1394 device can't
 work (Register access failure)
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>,
	linux-pci@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Jennifer and the other reporters of the issue most certainly all used
> modular kernels, i.e. got the drivers loaded by udev.
>
> module_init() doesn't matter, but
>   - .probe(),
>   - .resume()
> do.  So as you say, if the drivers were statically linked, then at least
> .probe() would be performed serially, one PCI device after another,
> right?  But AFAIK .resume() would still be performed in parallel by a
> pool of kernel threads in current kernels.

OK, I see.  When both drivers are loaded near the same time via udev,
the firewire driver doesn't work correctly.  I don't know of anything
that serializes driver registration from dynamically loaded modules.

I wouldn't bother with the resume issue until after the load-time
issue is resolved because suspend/resume makes things harder to debug.
 You might be able to try loading/unloading the modules in a loop to
reproduce the issue in a single boot.

> From what I can tell, there is no driver bug but an unfortunate interaction
> between parts of a combo controller which in theory should functionally be
> totally unrelated.

That's plausible.  But I can't think of anything useful the PCI core
can do here.  If you can identify a hardware issue in the device, it's
possible you could write a quirk to work around it.  But after the
driver has called pci_enable_device() (the last point at which quirks
are applied), the PCI core is pretty much out of the picture.

Maybe something could be added to one or both drivers to look for
these devices and try deal with them?  I'm afraid I don't have any
good ideas here.
