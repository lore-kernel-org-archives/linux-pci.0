Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wj0-f176.google.com ([209.85.210.176]:33422 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759623AbdACQiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 11:38:05 -0500
Received: by mail-wj0-f176.google.com with SMTP id tq7so212138301wjb.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Jan 2017 08:38:05 -0800 (PST)
Received: from [10.82.95.35] (soho87-122.sohonet.co.uk. [193.203.87.122])
        by smtp.gmail.com with ESMTPSA id c133sm90739558wme.12.2017.01.03.07.35.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2017 07:35:14 -0800 (PST)
From: Harry Mallon <hjmallon@gmail.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Diagnosing BAR allocation problems with complex bridge structure
Message-Id: <B56F52C5-7298-4E9D-8AE2-8497527C5D39@gmail.com>
Date: Tue, 3 Jan 2017 15:35:13 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

In this email I am asking for advice on how to diagnose problems in =
assigning memory for PCI-E devices and bridges. I can reproduce my issue =
on the current mainline kernel but I am not currently planning to target =
any fixes for the mainline kernel (unless they prove to be useful =
outside of this machine). I am planning to target the CentOS 3.10.0 =
based kernel. I understand that I am not owed any help/patches etc from =
anyone here, especially not as I am using a non mainline kernel.

I am working on a machine with an odd PCI structure, it has 4 different =
PLX bridges and requires hotplug to work on at least 2 of these. We were =
previously using a kernel based on 3.3 and had to add a few (hacky, =
machine specific) patches to that to make it work correctly. We also use =
"pci=3Drealloc,pcie_bus_safe" in the kernel cmdline. I am currently =
using that kernel as a reference to compare to my development version.

On my current setup some devices don't work, using "lspci -vvv" I can =
see that they are not all receiving the memory allocations that they =
need. They report like one of the two following (it changes depending on =
another PCI-E card being in or out):

05:00.0 VGA compatible controller: NVIDIA Corporation GP102 [TITAN X] =
(rev a1) (prog-if 00 [VGA controller])
        Subsystem: NVIDIA Corporation Device 119a
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- =
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at <ignored> (32-bit, non-prefetchable) =
[disabled]
        Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] =
[size=3D256M]
        Region 3: Memory at f0000000 (64-bit, prefetchable) [disabled] =
[size=3D32M]
        Region 5: I/O ports at 4000 [disabled] [size=3D128]
        Expansion ROM at <ignored> [disabled]

05:00.0 VGA compatible controller: NVIDIA Corporation GK110B [GeForce =
GTX TITAN Black] (rev ff) (prog-if ff)
	!!! Unknown header type 7f

What tools and techniques can anyone recommend for diagnosing this type =
of problem? Is there a way to export all the bridge memory ranges in a =
way that can be visualised (maybe the newer kernel cannot allocate =
enough aligned space)? Is there a way to enable extra PCI debug in the =
kernel? Is there a way to make the kernel panic and=20
report when it fails to assign memory on boot instead of continuing with =
non-functional hardware?

Thanks,
Harry=
