Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36204 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbbJERwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 13:52:04 -0400
Date: Mon, 5 Oct 2015 12:52:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank de Jong <frapex@xs4all.nl>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: missing PCI ID refs
Message-ID: <20151005175159.GA18545@localhost>
References: <56117FFE.6020304@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56117FFE.6020304@xs4all.nl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-ide]

On Sun, Oct 04, 2015 at 09:37:34PM +0200, Frank de Jong wrote:
> Hi,
> 
> Somewhere between kernel v3.15 and v3.18 several PCI ID refs went missing.
> By accident, I presume. Kernel v3.14 is fine.
> 
> This might just be the tip of iceberg, so to speak, as more PCI ID
> refs are probably missing.
> 
> In v3.14:
> - "0000:03:00.0" was shown as "pata_pdc2027x" (PCI ID: 105a:4d68)
> - "0000:00:1f.2" was shown as "ahci" (PCI ID: 8086:1c02)
> - "0000:06:00.0" was shown as "ahci" (PCI ID: 1b21:0612)
> 
>  # snippet from /proc/interrupts
>            CPU0       CPU1
>   0:         15          0   IO-APIC-edge      timer
>   1:         31          0   IO-APIC-edge      i8042
>   4:      39043          0   IO-APIC-edge      serial
>   5:          1          0   IO-APIC-edge      parport0
>   8:        111          0   IO-APIC-edge      rtc0
>   9:          3          0   IO-APIC-fasteoi   acpi
>  12:        144          0   IO-APIC-edge      i8042
>  16:         99          0   IO-APIC  16-fasteoi   ehci_hcd:usb1
>  18:       5173          0   IO-APIC  18-fasteoi   0000:03:00.0
>  19:    2871417          0   IO-APIC  19-fasteoi   eth0
>  23:         33          0   IO-APIC  23-fasteoi   ehci_hcd:usb4
>  24:        759          0   PCI-MSI-edge      0000:00:1f.2
>  25:      16582          0   PCI-MSI-edge      0000:06:00.0

I think the names shown in /proc/interrupts are supplied by the driver
when it calls request_irq(), so I don't think this is a PCI problem.

It might be a driver problem, but I think it's more likely an
intentional change, either this one or something similar: 4f37b504768c
("libata: Use dev_name() for request_irq() to distinguish devices")

>  26:      29172          0   PCI-MSI-edge      eth1
>  27:        502          0   PCI-MSI-edge      snd_hda_intel
>  28:          0          0   PCI-MSI-edge      xhci_hcd
>  29:          0          0   PCI-MSI-edge      xhci_hcd
>  30:          0          0   PCI-MSI-edge      xhci_hcd
>  31:         17          0   PCI-MSI-edge      i915
> 
> # snippet from lspci
> 00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series
> Chipset Family SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
>         Subsystem: Micro-Star International Co., Ltd. Device 7732
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 24
>         I/O ports at f0b0 [size=8]
>         I/O ports at f0a0 [size=4]
>         I/O ports at f090 [size=8]
>         I/O ports at f080 [size=4]
>         I/O ports at f060 [size=32]
>         Memory at f7f05000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [70] Power Management version 3
>         Capabilities: [a8] SATA HBA v1.0
>         Capabilities: [b0] PCI Advanced Features
>         Kernel driver in use: ahci
> 
> 03:00.0 Mass storage controller: Promise Technology, Inc. PDC20268
> [Ultra100 TX2] (rev 02) (prog-if 85)
>         Subsystem: Promise Technology, Inc. Ultra100 TX2
>         Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 18
>         I/O ports at e0c0 [size=8]
>         I/O ports at e0b0 [size=4]
>         I/O ports at e0a0 [size=8]
>         I/O ports at e090 [size=4]
>         I/O ports at e080 [size=16]
>         Memory at f7e24000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at f7e20000 [disabled] [size=16K]
>         Capabilities: [60] Power Management version 1
>         Kernel driver in use: pata_pdc2027x
> 
> 06:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA
> Controller (rev 01) (prog-if 01 [AHCI 1.0])
>         Subsystem: Micro-Star International Co., Ltd. Device 7732
>         Flags: bus master, fast devsel, latency 0, IRQ 25
>         I/O ports at c050 [size=8]
>         I/O ports at c040 [size=4]
>         I/O ports at c030 [size=8]
>         I/O ports at c020 [size=4]
>         I/O ports at c000 [size=32]
>         Memory at f7c00000 (32-bit, non-prefetchable) [size=512]
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Legacy Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel
>         Kernel driver in use: ahci
> 
> Kind regards,
> Frank de Jong
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
