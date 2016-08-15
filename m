Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54142 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842AbcHORYc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 13:24:32 -0400
Date: Mon, 15 Aug 2016 12:24:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kallol Biswas <kallol@nucleodyne.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Fwd: PCIe root port programming
Message-ID: <20160815172427.GA9790@localhost>
References: <CAH=XD5_kqkw=f1g_M69eUHsSDhry32s5VQJXC-_iVa+LZ+vUDA@mail.gmail.com>
 <CAH=XD58J+Yf-Rdz_bAJ-e9rU4ipu9opieFd0BuHeYAdX0nmrzg@mail.gmail.com>
 <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAH=XD59zixa7yoV7v0MUWAq-2ESCFmQZaSS89boJUYTy9wfgdw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kallol,

Sorry I didn't respond to this earlier; I was on vacation for most of
last week.

On Fri, Aug 12, 2016 at 02:14:59PM -0700, Kallol Biswas wrote:
>    I am trying to debug an issue that the PCIe memory
> transactions are not routed through a host bridge.
> 
> The config transactions work fine. The primary, secondary and
> subordinate bus numbers look fine for the PCIe tree under the host
> bridge. The memory windows are programmed fine.
> 
> Can someone point me to the code that programs the chipset/root port
> registers those direct processor transactions to a specific host
> bridge?

It looks like you have an x86 system with ACPI.  In that case, we use
the ACPI pci_root.c host bridge driver.  The chipset configuration for
routing processor memory transactions to host bridges is done by the
firmware, and the kernel doesn't touch it.  There should be
information in the chipset spec about how to do this, but there's no
code in Linux itself that does it.

> Cat of /proc/mem is copied below.
> 
> /root/physmem -p c8100000 -s 4 -r
> Operation:read to Addr: 0xc8100000 Value: 0
> ffffffff ffffffff ffffffff ffffffff
> 
> The PCIe analyzer sitting between host bridge (0:3.0 and 02:00.0) and
> external switches/devices does not capture any mem transactions.
> However, config transactions are visible in the trace.

00:03.0 is not a host bridge; it's a Root Port, which logically
connects two PCI buses.  A host bridge logically connects a processor
bus to a PCI bus.

> root@xlink-target:~# cat /proc/iomem
> 00000000-00000fff : reserved
> 00001000-0009abff : System RAM
> 0009ac00-0009ffff : reserved
> 000c0000-000c7fff : Video ROM
> 000c8000-000c8fff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-78f36fff : System RAM
>   01000000-01828f14 : Kernel code
>   01828f15-01f3fb3f : Kernel data
>   020bb000-021fdfff : Kernel bss
>   30000000-37ffffff : Crash kernel
> 78f37000-79839fff : reserved
>   79116018-79116018 : APEI ERST
>   7911601c-79116021 : APEI ERST
>   79116028-79116039 : APEI ERST
>   79116040-7911604c : APEI ERST
>   79116050-7911804f : APEI ERST
> 7983a000-79d4afff : ACPI Non-volatile Storage
> 79d4b000-8fffffff : reserved
>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> c6000000-c70fffff : PCI Bus 0000:2f
>   c6000000-c70fffff : PCI Bus 0000:30
>     c6000000-c6ffffff : 0000:30:00.0
>     c7000000-c701ffff : 0000:30:00.0
> c7100000-c71fffff : PCI Bus 0000:31
>   c7100000-c711ffff : 0000:31:00.1
>     c7100000-c711ffff : igb
>   c7120000-c713ffff : 0000:31:00.0
>     c7120000-c713ffff : igb
>   c7140000-c7143fff : 0000:31:00.1
>     c7140000-c7143fff : igb
>   c7144000-c7147fff : 0000:31:00.0
>     c7144000-c7147fff : igb
> c7300000-c730ffff : 0000:00:14.0
>   c7300000-c730ffff : xhci-hcd
> c7310000-c73107ff : 0000:00:1f.2
>   c7310000-c73107ff : ahci
> c7311000-c73113ff : 0000:00:1d.0
>   c7311000-c73113ff : ehci_hcd
> c7312000-c73123ff : 0000:00:1a.0
>   c7312000-c73123ff : ehci_hcd
> c7314000-c731400f : 0000:00:16.1
> c7315000-c731500f : 0000:00:16.0
> c7316000-c73167ff : 0000:00:11.4
>   c7316000-c73167ff : ahci
> c7317000-c7317fff : 0000:00:05.4
> c7ffc000-c7ffcfff : dmar1
> c8000000-c8000000 : <BAD>
> c8000001-c8000001 : <BAD>
> c8000002-c8000002 : <BAD>
> c8000003-c8000003 : <BAD>

Interesting, what are these from?

> c8100000-c91fffff : PCI Bus 0000:02
>   c8100000-c90fffff : PCI Bus 0000:03
>     c8100000-c90fffff : PCI Bus 0000:04
>       c8100000-c82fffff : PCI Bus 0000:05
>         c8100000-c81fffff : PCI Bus 0000:06
>           c8100000-c8100fff : 0000:06:00.0

You're trying to read the 06:00.0 BAR at 0xc8100000.  The windows
above look fine, but the top-level host bridge window is missing.

The c8100000-c91fffff window is a window through the 00:03.0 Root
Port, which connects bus 00 to bus 02.  The 00:03.0 bridge forwards
memory transactions in the c8100000-c91fffff range from its primary
bus (bus 00) to its secondary bus (bus 02).

But we don't know how those transactions get to bus 00 in the first
place.  The host bridge is the connection between the processor and
bus 00, and it should have a window that encloses c8100000-c91fffff.

Your dmesg log should have information about this bridge, e.g.,
something like this:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0xc8100000-0xc9ffffff window]

and there should be a line in /proc/iomem something like this:

  c8100000-c9ffffff : PCI Bus 0000:00

Bjorn
