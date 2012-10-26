Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5062BA8B.7090503@peak-system.com>
References: <5062BA8B.7090503@peak-system.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 26 Oct 2012 02:29:33 -0600
Message-ID: <CAErSpo7vk6d1RCWQPFL9PqqwbH5u+F=uyPywCM_3sAVF3RW34g@mail.gmail.com>
Subject: Re: Info about ACPI/PCI vs ISA
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-acpi@vger.kernel.org, support@peak-system.com,
	Robert Hancock <hancockrwd@gmail.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 26, 2012 at 2:19 AM, Stephane Grosjean
<s.grosjean@peak-system.com> wrote:

> I'm working on an issue with one of our PCI adapters.
> This PCI adapter is a standard and well proven board, for many years:
>
> $ lspci -v
> ...
> 04:08.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
> controller (rev 02)
>     Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
>     Flags: medium devsel, IRQ 11
>     Memory at f0410000 (32-bit, non-prefetchable) [size=64K]
>     Memory at f0400000 (32-bit, non-prefetchable) [size=64K]
>     Kernel driver in use: pcan
>
> The running system is:
>
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.1.9-1.4-desktop (geeko@buildhost) (gcc
> version 4.6.2 (SUSE Linux) ) #1 SMP PREEMPT Fri Jan 27 08:55:10 UTC 2012
> (efb5ff4)
> ...
> [    0.000000] Kernel command line:
> root=/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000015-part2
> resume=/dev/disk/by-id/ata-SPCC_Solid_State_DiskB28_00000000000000000015-part1
> splash=silent quiet vga=0x31b
> ...
> [    0.471267] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 10 *11 12 14
> 15)
> [    0.471323] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 10 11 12 14
> 15) *7
> [    0.471378] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 10 11 12 14
> 15) *7
> [    0.471434] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *10 11 12 14
> 15)
> [    0.471487] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 10 11 12 14
> 15) *0, disabled.
> [    0.471541] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 10 11 12 14
> 15) *0, disabled.
> [    0.471594] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 *10 11 12 14
> 15)
> [    0.471647] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 10 *11 12 14
> 15)
>
> We don't succeed to send and receive data to/from this card and we suspect
> an IRQ related issue. For example, loading our (good old) "pcan" driver
> leads to the below logs:
>
> ...
> [    6.186877] pci 0000:00:1e.0: can't derive routing for PCI INT A
> [    6.186878] pcan 0000:04:08.0: PCI INT A: no GSI - using ISA IRQ 11

Where's the source for the "pcan" driver?  I see the pcan_usb driver
in the tree, but that looks like something different from what you're
looking at here.

Does the device work under any version of Linux?  If so, please
collect the complete dmesg log from the newest working version, and
the same log from the broken version.

Does this adapter work in some systems but not others?  Under Windows
but not under Linux?  You refer to the "good old" driver, so I infer
that it works *somewhere* and I'm trying to figure out what's
different about the case where it doesn't work.

> My questions are:
>
> - why does the system not succeed to "derive" routing for INTA? And why us?

The derivation is based on ACPI _PRT tables.  Regrettably, we don't
dump the _PRT contents in dmesg, so we'd need an acpidump to look
further into that.

Bjorn
