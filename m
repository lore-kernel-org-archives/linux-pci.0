Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35623 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233Ab3DRQgG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2013 12:36:06 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so2945856oag.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2013 09:36:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130418152747.GA19258@arm.com>
References: <20130418152747.GA19258@arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Apr 2013 10:35:45 -0600
Message-ID: <CAErSpo5PnUC4h2Eg7BPUOvUUPQmpUPwZGO89PVJu4qw5ysGX6A@mail.gmail.com>
Subject: Re: I/O and multiple PCI buses
To: Andrew Murray <andrew.murray@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 18, 2013 at 9:27 AM, Andrew Murray <andrew.murray@arm.com> wrote:
> I'm trying to understand PCI I/O addressing in the kernel... (again)
>
> I understand that ideally you want to give PCI bus addresses to PCI devices in
> the range of 0K to 64K. This seems to be achieved in pcibios_init_resources in
> arm's kernel/bios32.c implementation.
>
> What happens if you want to add another root bus? In this implementation the
> start address of the io_res is now 64K and as sys->io_offset is set to 0 the
> bus addresses under this second root bus will be 64K-128K - which I assume may
> break some things.
>
> Am I correct that for ARM there are no implementations where subsequent root
> buses allocate I/O starting from 0?
>
> And to allow subsequent busses to use I/O starting from 0, you'd have to set
> sys->io_offset to 64K*nr and adapt functions such as pci_iomap to use the
> offset?
>
> Are there any other archiectures that do give I/O ranges starting from 0 in
> subsequent root busses? Or am I missing something here?

I don't know the details about ARM, but there are ia64 systems with
many host bridges, and often they're set up so the I/O port addresses
on the PCI bus are always between 0-64K, e.g.,

pci_root HWP0002:00: host bridge window [io  0x0000-0x0fff]
pci_root HWP0002:01: host bridge window [io  0x1000-0x1fff]
pci_root HWP0002:02: host bridge window [io  0x2000-0x3fff]
pci_root HWP0002:03: host bridge window [io  0x4000-0x5fff]
pci_root HWP0002:04: host bridge window [io  0x6000-0x7fff]
pci_root HWP0002:05: host bridge window [io  0x8000-0x9fff]
pci_root HWP0002:06: host bridge window [io  0xa000-0xbfff]
pci_root HWP0002:07: host bridge window [io  0xc000-0xdfff]
pci_root HWP0002:08: host bridge window [io  0xe000-0xffff]
pci_root HWP0002:09: host bridge window [io  0x1000000-0x1000fff] (PCI
address [0x0-0xfff])
pci_root HWP0002:0a: host bridge window [io  0x1001000-0x1001fff] (PCI
address [0x1000-0x1fff])
pci_root HWP0002:0b: host bridge window [io  0x1002000-0x1003fff] (PCI
address [0x2000-0x3fff])
pci_root HWP0002:0c: host bridge window [io  0x1004000-0x1005fff] (PCI
address [0x4000-0x5fff])
pci_root HWP0002:0d: host bridge window [io  0x1006000-0x1007fff] (PCI
address [0x6000-0x7fff])
pci_root HWP0002:0e: host bridge window [io  0x1008000-0x1009fff] (PCI
address [0x8000-0x9fff])
pci_root HWP0002:0f: host bridge window [io  0x100a000-0x100bfff] (PCI
address [0xa000-0xbfff])
pci_root HWP0002:10: host bridge window [io  0x100c000-0x100dfff] (PCI
address [0xc000-0xdfff])
pci_root HWP0002:11: host bridge window [io  0x100e000-0x100ffff] (PCI
address [0xe000-0xffff])

In this case, host bridges HWP0002:00 - HWP0002:08 all share one 64K
I/O port space, and HWP0002:09 - HWP0002:11 share a separate one.
There's no requirement that they share any space -- each host bridge
*could* have its own 64K I/O port space, but we just use the
configuration done by the firmware.

Note that for HWP0002:00 and HWP0002:09, for example, the addresses on
PCI are the same (0x0-0xfff), but the CPU addresses in the struct
resource are different.  The CPU addresses are what drivers see, and
what they pass to inb(), etc., and it's possible there are drivers
that assume these port addresses fit in a u16, and those drivers would
break.  But as far as the hardware PCI device is concerned, it should
be fine because it sees only bus addresses in the 0-64K range.

There's some gunk in arch/ia64/include/asm/io.h to make
"inb(0x1000000)" work and generate a bus access to I/O port 0 on the
correct root bus.

Bjorn
