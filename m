Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759601AbdACSHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 13:07:23 -0500
Date: Tue, 3 Jan 2017 12:07:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harry Mallon <hjmallon@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Diagnosing BAR allocation problems with complex bridge structure
Message-ID: <20170103180718.GA25398@bhelgaas-glaptop.roam.corp.google.com>
References: <B56F52C5-7298-4E9D-8AE2-8497527C5D39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B56F52C5-7298-4E9D-8AE2-8497527C5D39@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Harry,

On Tue, Jan 03, 2017 at 03:35:13PM +0000, Harry Mallon wrote:
> Hi,
> 
> In this email I am asking for advice on how to diagnose problems in assigning memory for PCI-E devices and bridges. I can reproduce my issue on the current mainline kernel but I am not currently planning to target any fixes for the mainline kernel (unless they prove to be useful outside of this machine). I am planning to target the CentOS 3.10.0 based kernel. I understand that I am not owed any help/patches etc from anyone here, especially not as I am using a non mainline kernel.
> 
> I am working on a machine with an odd PCI structure, it has 4 different PLX bridges and requires hotplug to work on at least 2 of these. We were previously using a kernel based on 3.3 and had to add a few (hacky, machine specific) patches to that to make it work correctly. We also use "pci=realloc,pcie_bus_safe" in the kernel cmdline. I am currently using that kernel as a reference to compare to my development version.
> 
> On my current setup some devices don't work, using "lspci -vvv" I can see that they are not all receiving the memory allocations that they need. They report like one of the two following (it changes depending on another PCI-E card being in or out):
> 
> 05:00.0 VGA compatible controller: NVIDIA Corporation GP102 [TITAN X] (rev a1) (prog-if 00 [VGA controller])
>         Subsystem: NVIDIA Corporation Device 119a
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 11
>         Region 0: Memory at <ignored> (32-bit, non-prefetchable) [disabled]
>         Region 1: Memory at e0000000 (64-bit, prefetchable) [disabled] [size=256M]
>         Region 3: Memory at f0000000 (64-bit, prefetchable) [disabled] [size=32M]
>         Region 5: I/O ports at 4000 [disabled] [size=128]
>         Expansion ROM at <ignored> [disabled]
> 
> 05:00.0 VGA compatible controller: NVIDIA Corporation GK110B [GeForce GTX TITAN Black] (rev ff) (prog-if ff)
> 	!!! Unknown header type 7f
> 
> What tools and techniques can anyone recommend for diagnosing this type of problem? Is there a way to export all the bridge memory ranges in a way that can be visualised (maybe the newer kernel cannot allocate enough aligned space)? Is there a way to enable extra PCI debug in the kernel? Is there a way to make the kernel panic and 
> report when it fails to assign memory on boot instead of continuing with non-functional hardware?

A complete dmesg log from a current kernel and complete "lspci -vv"
output is the best place to start.  The goal is that all your devices
should work without requiring any machine-specific patches or
command-line parameters.  Our resource allocation code is not really
very robust, so unusual topologies don't always work out of the box.

You can open a bug report at https://bugzilla.kernel.org in the
drivers/PCI area, attach the dmesg and lspci output, and respond with
the URL here.

Bjorn
