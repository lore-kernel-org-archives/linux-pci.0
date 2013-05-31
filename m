Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:57606 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3EaWs6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 18:48:58 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so4017842obc.24
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 15:48:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51A920C5.40209@missinglinkelectronics.com>
References: <51A920C5.40209@missinglinkelectronics.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 May 2013 16:48:37 -0600
Message-ID: <CAErSpo7CrajY0__m91yRMi0oo0CjrGdqWPYWxQx+rx5zz4F-qg@mail.gmail.com>
Subject: Re: MSI-X capability display of pciutils
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 4:14 PM, David Epping
<david.epping@missinglinkelectronics.com> wrote:
> Hello,
>
> I am inspecting the MSI-X setup of some PCIe devices and have questions
> about the output of lspci.
>
> It looks something like this:
> Capabilities: [50] MSI-X: Enable+ Count=32 Masked-
>     Vector table: BAR=0 offset=00002000
>     PBA: BAR=0 offset=00003000
>
> As far as I understand the PCI 3.0 specification MSI-X capabilities define a
> 32 bit register for the upper address portion of the MSI target addresses
> (at capability offset 4) and another 32 bit register pointing to the BAR and
> inter-BAR offset for the table of lower address portions of the MSI target
> addresses (at capability offset 8).
> Why are there two lines in the lspci output indicating some BAR and offset?
> What do they mean?

My understanding is that there are three data structures here:
  1) The MSI-X Capability (Figure 6-10) in config space
  2) The "MSI-X Table" (Figure 6-11) in PCI memory space
  3) The "MSI-X PBA" (Pending Bit Array, Figure 6-12) in PCI memory space

The "Vector table" line tells you how to find the "MSI-X Table," and
the "PBA" line tells you how to find the "MSI-X PBA" table.

In MSI (not MSI-X), there is only one MSI target address, and it is in
the MSI capability.

In MSI-X, each MSI-X vector can have its own target address, and those
addresses are not in the capability itself; they are stored in the
memory decoded by a BAR.

In your case, you would read the bus address from BAR 0, and the
vector table should be at offsets 0x2000-0x21ff (32 16-byte entries)
from that address.  The PBA should be at offsets 0x3000-0x30ff (32
8-byte entries).

lspci will show you the BAR values, but it doesn't dump PCI memory
space, so you'd have to use /dev/mem or a tool like
http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c to actually look at the
tables.

Bjorn
