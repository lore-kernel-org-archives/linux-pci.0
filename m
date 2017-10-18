Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbdJRREc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Oct 2017 13:04:32 -0400
Date: Wed, 18 Oct 2017 12:04:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Martin Mares <mj@ucw.cz>
Subject: Re: lspci reports 'stale' BAR info after a card reset
Message-ID: <20171018170429.GA6332@bhelgaas-glaptop.roam.corp.google.com>
References: <063D6719AE5E284EB5DD2968C1650D6DD009AD46@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD009AD46@AcuExch.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin]

On Wed, Oct 18, 2017 at 01:23:53PM +0000, David Laight wrote:
> I'm doing some experiments that generate errors on a PCIe link.
> (I'd like to get AER reporting things - but that is a different
> problem.)
> 
> If I force 'link down' (by shorting the TX lines with a screwdriver!)
> the card side resets everything to do with the PCIe links including
> all of config space - particularly the BARs.
> 
> The kernel doesn't know this has happened, so the bridge is left
> configured and the device driver (hopefully) doesn't crash the
> kernel when it gets 0xffffffff back from reads!
> 
> If I then run 'lspci -vx' I get:
> 09:00.0 Class 0004: Device 12d9:001e (rev 01) (prog-if 02)
>         Subsystem: Device 12d9:0001
>         Flags: fast devsel, IRQ 16, NUMA node 0
>         [virtual] Memory at fa200000 (32-bit, non-prefetchable) [size=1M]
>         [virtual] Memory at fa100000 (32-bit, non-prefetchable) [size=1M]
>         [virtual] Memory at fa300000 (32-bit, non-prefetchable) [size=8K]
>         ...
> 00: d9 12 1e 00 00 00 10 00 01 02 04 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 12 01 00
> 30: 00 00 00 00 50 00 00 00 00 00 00 00 00 01 00 00
> 
> Note that the hexdump shows the BARs as all zero, but the text shows the
> values that the kernel thinks are being used.
> This doesn't make it obvious that something has gone badly wrong.
> 
> AFAICT most of the info lspci outputs comes from decoding config space.
> I suspect it is getting the BAR info from the kernel (linux 4.14.0-rc4 ish)
> in order to print the size.
> It would be better if it reported the inconsistency.

I agree, it does seem odd that the hexdump reflects the hardware but
the text does not.  I don't know whether that's intentional; maybe
Martin does.

My guess is that the hexdump reads the config space directly because
the kernel doesn't cache most of that data directly.

The BAR info in the text is likely coming via sysfs from the kernel's
pci_dev structures, because it shows the kernel's view (not the actual
values in the BAR, which may be different if the host bridge
translates between CPU addresses and PCI bus addresses).

The kernel doesn't change its pci_dev->resource[] values until it
reconfigures the device, and it apparently hasn't figured out that it
needs to do this.

Bjorn
