Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34528 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbHCP2M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 11:28:12 -0400
Received: by oigu133 with SMTP id u133so29183023oig.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 08:28:11 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 3 Aug 2015 08:28:11 -0700
Message-ID: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
Subject: Failure to HotPlug if devices not present at boot - no memory space
From: Barry Grussling <barry@grussling.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am having some issues with PCIe hotplug on Linux.  Bottom
line is if PCIe endpoints are present and enabled on boot,
things work fine.  I can disable/enable endpoints and rescan
the PCI chain great and everything is found and loaded.

If PCIe endpoints are not present on boot and instead
are added later, I get "no space" and "failed to assign"
when I try to rescan the PCIe bus.

Booting with pci=realloc=on seems to have no effect.

I have verified I have CONFIG_PCI_REALLOC_ENABLE_AUTO=y
and CONFIG_PCI_IOV=y in my config.

The root complex is an ARM Cortex A9 SoC.  There is
a PLX PEX 8619 16-lane PCIe switch chip hooked up to
the root complex of the SoC.

Here is the enumeration from a device when all the PCIe
endpoints are present and enabled when the SoC boots:
pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xc7dfffff]
pci 0000:01:00.0: BAR 8: assigned [mem 0xc0000000-0xc7bfffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xc7c00000-0xc7c1ffff]
pci 0000:01:00.1: BAR 0: assigned [mem 0xc7c20000-0xc7c3ffff]
pci 0000:02:00.0: BAR 8: assigned [mem 0xc0000000-0xc27fffff]
pci 0000:02:02.0: BAR 8: assigned [mem 0xc2800000-0xc4ffffff]
pci 0000:02:0f.0: BAR 8: assigned [mem 0xc5000000-0xc77fffff]
pci 0000:02:03.0: BAR 8: assigned [mem 0xc7800000-0xc78fffff]
pci 0000:02:0b.0: BAR 8: assigned [mem 0xc7900000-0xc79fffff]
pci 0000:02:0d.0: BAR 8: assigned [mem 0xc7a00000-0xc7afffff]
pci 0000:03:00.0: BAR 1: assigned [mem 0xc0000000-0xc0ffffff]
pci 0000:03:00.0: BAR 2: assigned [mem 0xc1000000-0xc1ffffff]
pci 0000:03:00.0: BAR 0: assigned [mem 0xc2000000-0xc20fffff]
pci 0000:03:00.0: BAR 3: assigned [mem 0xc2100000-0xc21003ff]
pci 0000:03:00.0: BAR 4: assigned [mem 0xc2100400-0xc21007ff]
pci 0000:03:00.0: BAR 5: assigned [mem 0xc2100800-0xc2100bff]
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc27fffff]
pci 0000:04:00.0: BAR 1: assigned [mem 0xc3000000-0xc3ffffff]
pci 0000:04:00.0: BAR 2: assigned [mem 0xc4000000-0xc4ffffff]
pci 0000:04:00.0: BAR 0: assigned [mem 0xc2800000-0xc28fffff]
pci 0000:04:00.0: BAR 3: assigned [mem 0xc2900000-0xc29003ff]
pci 0000:04:00.0: BAR 4: assigned [mem 0xc2900400-0xc29007ff]
pci 0000:04:00.0: BAR 5: assigned [mem 0xc2900800-0xc2900bff]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:02.0:   bridge window [mem 0xc2800000-0xc4ffffff]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [mem 0xc7800000-0xc78fffff]
pci 0000:02:0b.0: PCI bridge to [bus 06]
pci 0000:02:0b.0:   bridge window [mem 0xc7900000-0xc79fffff]
pci 0000:02:0d.0: PCI bridge to [bus 07]
pci 0000:02:0d.0:   bridge window [mem 0xc7a00000-0xc7afffff]
pci 0000:08:00.0: BAR 1: assigned [mem 0xc5000000-0xc5ffffff]
pci 0000:08:00.0: BAR 2: assigned [mem 0xc6000000-0xc6ffffff]
pci 0000:08:00.0: BAR 0: assigned [mem 0xc7000000-0xc70fffff]
pci 0000:08:00.0: BAR 3: assigned [mem 0xc7100000-0xc71003ff]
pci 0000:08:00.0: BAR 4: assigned [mem 0xc7100400-0xc71007ff]
pci 0000:08:00.0: BAR 5: assigned [mem 0xc7100800-0xc7100bff]
pci 0000:02:0f.0: PCI bridge to [bus 08]
pci 0000:02:0f.0:   bridge window [mem 0xc5000000-0xc77fffff]
pci 0000:01:00.0: PCI bridge to [bus 02-08]
pci 0000:01:00.0:   bridge window [mem 0xc0000000-0xc7bfffff]
pci 0000:00:00.0: PCI bridge to [bus 01-08]
pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc7dfffff]
pci 0000:00:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:01:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:03:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:02:02.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:04:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:02:03.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0b.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0d.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0f.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:08:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:01:00.1: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  256

In this case I can request a driver removal, power off the device,
power it back on, rescan the bus, and I get:
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [mem 0xc7800000-0xc78fffff]
pci 0000:02:0b.0: PCI bridge to [bus 06]
pci 0000:02:0b.0:   bridge window [mem 0xc7900000-0xc79fffff]
pci 0000:02:0d.0: PCI bridge to [bus 07]
pci 0000:02:0d.0:   bridge window [mem 0xc7a00000-0xc7afffff]
pci 0000:08:00.0: BAR 1: assigned [mem 0xc5000000-0xc5ffffff]
pci 0000:08:00.0: BAR 2: assigned [mem 0xc6000000-0xc6ffffff]
pci 0000:08:00.0: BAR 0: assigned [mem 0xc7000000-0xc70fffff]
pci 0000:08:00.0: BAR 3: assigned [mem 0xc7100000-0xc71003ff]
pci 0000:08:00.0: BAR 4: assigned [mem 0xc7100400-0xc71007ff]
pci 0000:08:00.0: BAR 5: assigned [mem 0xc7100800-0xc7100bff]
TestDrv 0000:08:00.0: Driver Loaded Successfully

Here is the boot enumeration when one endpoint (00:08:00.0) is
not present at SoC boot time:
pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xc59fffff]
pci 0000:01:00.0: BAR 8: assigned [mem 0xc0000000-0xc57fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xc5800000-0xc581ffff]
pci 0000:01:00.1: BAR 0: assigned [mem 0xc5820000-0xc583ffff]
pci 0000:02:00.0: BAR 8: assigned [mem 0xc0000000-0xc27fffff]
pci 0000:02:02.0: BAR 8: assigned [mem 0xc2800000-0xc4ffffff]
pci 0000:02:03.0: BAR 8: assigned [mem 0xc5000000-0xc50fffff]
pci 0000:02:0b.0: BAR 8: assigned [mem 0xc5100000-0xc51fffff]
pci 0000:02:0d.0: BAR 8: assigned [mem 0xc5200000-0xc52fffff]
pci 0000:02:0f.0: BAR 8: assigned [mem 0xc5300000-0xc53fffff]
pci 0000:03:00.0: BAR 1: assigned [mem 0xc0000000-0xc0ffffff]
pci 0000:03:00.0: BAR 2: assigned [mem 0xc1000000-0xc1ffffff]
pci 0000:03:00.0: BAR 0: assigned [mem 0xc2000000-0xc20fffff]
pci 0000:03:00.0: BAR 3: assigned [mem 0xc2100000-0xc21003ff]
pci 0000:03:00.0: BAR 4: assigned [mem 0xc2100400-0xc21007ff]
pci 0000:03:00.0: BAR 5: assigned [mem 0xc2100800-0xc2100bff]
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:02:00.0:   bridge window [mem 0xc0000000-0xc27fffff]
pci 0000:04:00.0: BAR 1: assigned [mem 0xc3000000-0xc3ffffff]
pci 0000:04:00.0: BAR 2: assigned [mem 0xc4000000-0xc4ffffff]
pci 0000:04:00.0: BAR 0: assigned [mem 0xc2800000-0xc28fffff]
pci 0000:04:00.0: BAR 3: assigned [mem 0xc2900000-0xc29003ff]
pci 0000:04:00.0: BAR 4: assigned [mem 0xc2900400-0xc29007ff]
pci 0000:04:00.0: BAR 5: assigned [mem 0xc2900800-0xc2900bff]
pci 0000:02:02.0: PCI bridge to [bus 04]
pci 0000:02:02.0:   bridge window [mem 0xc2800000-0xc4ffffff]
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [mem 0xc5000000-0xc50fffff]
pci 0000:02:0b.0: PCI bridge to [bus 06]
pci 0000:02:0b.0:   bridge window [mem 0xc5100000-0xc51fffff]
pci 0000:02:0d.0: PCI bridge to [bus 07]
pci 0000:02:0d.0:   bridge window [mem 0xc5200000-0xc52fffff]
pci 0000:02:0f.0: PCI bridge to [bus 08]
pci 0000:02:0f.0:   bridge window [mem 0xc5300000-0xc53fffff]
pci 0000:01:00.0: PCI bridge to [bus 02-08]
pci 0000:01:00.0:   bridge window [mem 0xc0000000-0xc57fffff]
pci 0000:00:00.0: PCI bridge to [bus 01-08]
pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xc59fffff]
pci 0000:00:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:01:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:00.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:03:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:02:02.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:04:00.0: Max Payload Size set to  256/ 256 (was  128), Max Read Rq  256
pci 0000:02:03.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0b.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0d.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:02:0f.0: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  128
pci 0000:01:00.1: Max Payload Size set to  256/ 512 (was  128), Max Read Rq  256

If I then apply power to the endpoint at (00:08:00.0) and
attempt to scan the bus I get:
pci 0000:02:03.0: PCI bridge to [bus 05]
pci 0000:02:03.0:   bridge window [mem 0xc5000000-0xc50fffff]
pci 0000:02:0b.0: PCI bridge to [bus 06]
pci 0000:02:0b.0:   bridge window [mem 0xc5100000-0xc51fffff]
pci 0000:02:0d.0: PCI bridge to [bus 07]
pci 0000:02:0d.0:   bridge window [mem 0xc5200000-0xc52fffff]
pci 0000:08:00.0: BAR 1: no space for [mem size 0x01000000]
pci 0000:08:00.0: BAR 1: failed to assign [mem size 0x01000000]
pci 0000:08:00.0: BAR 2: no space for [mem size 0x01000000]
pci 0000:08:00.0: BAR 2: failed to assign [mem size 0x01000000]
pci 0000:08:00.0: BAR 0: assigned [mem 0xc5300000-0xc53fffff]
pci 0000:08:00.0: BAR 3: no space for [mem size 0x00000400]
pci 0000:08:00.0: BAR 3: failed to assign [mem size 0x00000400]
pci 0000:08:00.0: BAR 4: no space for [mem size 0x00000400]
pci 0000:08:00.0: BAR 4: failed to assign [mem size 0x00000400]
pci 0000:08:00.0: BAR 5: no space for [mem size 0x00000400]
pci 0000:08:00.0: BAR 5: failed to assign [mem size 0x00000400]
TestDrv 0000:08:00.0: Unable to Map Bar 2!

Note the working system allocates 0xc0000000 to 0xc7dfffff to
the PCI subsystem but the failing boot only allocates 0xc0000000
to 0xc59fffff.

My Google-Fu turned up some posts about pci=realloc being needed.
I have booted this unit with and without that kernel parameter
and I can't see any difference (the diff output of my
commands is the same).  I am currently booting the unit
with "pci=realloc=on,pcie_bus_perf".

I did some reading in the kernel-parameters.txt and tried
booting with "pci=realloc=on,pcie_bus_perf,hpmemsize=256M"
hoping that would allow for a large PCI space but it
didn't seem to have any effect.

The kernel on the device is currently 3.17.  In an effort
to see if this was fixed in a future kernel I cherry-picked
all the changes to drivers/pci/bus.c up to and including
3a9ad0b PCI: Add pci_bus_addr_t

but that resulted in no difference.

I am rappidly crashing into the end of my PCI Express on Linux
knowledge.  Any help or guidance would be greatly appreciated.

Thanks,

Barry
