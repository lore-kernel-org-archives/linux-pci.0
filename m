Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:51805 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025AbbA3NvS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 08:51:18 -0500
Received: by mail-qa0-f52.google.com with SMTP id x12so19875278qac.11
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2015 05:51:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-92321-41252@https.bugzilla.kernel.org/>
References: <bug-92321-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 30 Jan 2015 07:50:57 -0600
Message-ID: <CAErSpo6Hw2GhtbmjBdTiLnvW_4vZPno9cpCXk+wTTAviB6F7vg@mail.gmail.com>
Subject: Re: [Bug 92321] New: Mapping CompactPCI device through sysfs-pci driver
To: Georgiy <jediknight.93@mail.ru>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci for visibility]

Hi Georgiy,

Thanks a lot for your problem report.  A few questions below ...

On Fri, Jan 30, 2015 at 2:52 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=92321
>
>             Bug ID: 92321
>            Summary: Mapping CompactPCI device through sysfs-pci driver
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.16.0-4-586
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: jediknight.93@mail.ru
>         Regression: No
>
> So, the problem can be described as follows:
>
> 1. We got 11 completely equal PCI devices, connected through two CompactPCI
> buses, 6 on one, and 5 on the other.
>
> 2. We are trying to access the resources of the devices through the sysfs
> filesystem, example: /sys/class/pci_bus/0000:04/device/0000:04:0d.0/resource1.
> First 4 devices allow read/write access to their resources without problems,
> but:
>
> 3.The 5th and 6th devices of both buses don't work: all files exist, but all
> read operations return a bunch of FFs, regardless of the written values, so I
> can't really say if the write was successful or not. When one of the first 4 is
> physically removed, 5th device starts working as usual, same goes for 6 on the
> bus with 6 devices. It looks like it can only work with 4 devices per bus, not
> more. It should be noted that CompactPCI allows using 7 PCI devices on the bus
> at once, according to the specification.

This sounds like the reads aren't reaching the device or the device
isn't responding.  In that case, the host bridge typically fabricates
data of FFs to satisfy the read.

> 4. It can't really be a hardware problem, because Windows driver(developed long
> ago by someone we don't have access to) does it just fine.
>
> lspci:
> 03:0b.0 Multimedia controller: Device 6472:8001 (rev 01)
> 03:0c.0 Multimedia controller: Device 6472:8001 (rev 01)
> 03:0d.0 Multimedia controller: Device 6472:8001 (rev 01)
> 03:0e.0 Multimedia controller: Device 6472:8001 (rev 01)
> 03:0f.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:09.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:0a.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:0b.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:0c.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:0d.0 Multimedia controller: Device 6472:8001 (rev 01)
> 04:0f.0 Multimedia controller: Device 6472:8001 (rev 01)
>
> lspci -vv(equal output for all devices, aside from position on the bus, IRQ
> number, and memory addresses):
>
> 04:0f.0 Multimedia controller: Device 6472:8001 (rev 01)
> Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr Stepping-
> SERR- FastB2B- DisINTx-
> Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx+
> Interrupt: pin A routed to IRQ 11
> Region 0: I/O ports at d800 [size=128]
> Region 1: Memory at febfe800 (32-bit, non-prefetchable) [size=128]
>
> Don't know if I really need show you the code, because it is as simple as it is
> possible - file is opened, then mmaped, then the resulting pointer is used to
> write and read into that file. Basically, it's this:
>
> fd = open ( (device_ + "resource" + std::to_string (i)).c_str(), O_RDWR);
> ptr = (u_int32_t*) mmap (NULL, 0x7f, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
> 0);
>
> All paths are valid, that's what was checked first. dmesg output contains no
> errors nor warnings for the corresponding problem.

Can you please attach a complete dmesg log and complete "lspci -vv"
output to the bugzilla?  That will help figure out whether there's a
bridge configuration problem on the path leading to the devices.

Bjorn
