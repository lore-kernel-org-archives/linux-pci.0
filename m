Return-Path: <SRS0=bmI6=2W=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=bmI6=2W=free.fr=slash.tmp@kernel.org>
Subject: Re: Neophyte questions about PCIe
From: Mason <slash.tmp@free.fr>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Message-ID: <e811931b-919f-48a3-8cb8-cacbaf5efd68@free.fr>
Date: Mon, 13 Mar 2017 15:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 10/03/2017 18:49, Mason wrote:

> # /usr/sbin/lspci -v
> 00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00000000-00000fff
>         Memory behind bridge: 04000000-040fffff
>         Prefetchable memory behind bridge: 00000000-000fffff
>         Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Root Port (Slot-), MSI 03
>         Capabilities: [100] Virtual Channel
>         Capabilities: [800] Advanced Error Reporting
>         Kernel driver in use: pcieport
> 
> Still some weirdness here.
> I might be using too old a version: lspci version 3.2.1

Focusing on the unexpected reports of stuff "behind bridge".
The output from pciutils 3.5.4 is mostly identical.
Is this likely to cause issues down the road?

# /usr/sbin/lspci -v
00:00.0 PCI bridge: Sigma Designs, Inc. Device 0024 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 25
        Memory at <ignored> (64-bit, non-prefetchable)
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: 04000000-040fffff [size=1M]
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Capabilities: [50] MSI: Enable+ Count=1/4 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Root Port (Slot-), MSI 03
        Capabilities: [100] Virtual Channel
        Capabilities: [800] Advanced Error Reporting
        Kernel driver in use: pcieport

Regards.
