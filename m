Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dub004-omc4s6.hotmail.com ([157.55.2.81]:55835 "EHLO
	DUB004-OMC4S6.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaIDPDJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 11:03:09 -0400
Message-ID: <DUB130-DS10845119A34A53DA8A6430DBC50@phx.gbl>
From: "Robert" <RJSmith92@live.com>
To: <linux-pci@vger.kernel.org>
Subject: PCIe root bridge and memory ranges.
Date: Thu, 4 Sep 2014 15:57:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello All,

I am having trouble understanding what memory ranges go through the PCIe 
root bridge on a Haswell CPU (what I have in my system) and similarly on 
other modern CPUs. From what I can gather from sources online (including 
many datasheets) is that the PCIE root complex contains a PCI host bridge, 
which produces 1 PCI root bridge (ACPI\PNP0A08). This root bridge then 
forwards certain memory ranges onto the PCI/PCIe bus.

First of all if I take something like PAM registers, when something is 
written to this address the PAM register forwards it to DMI (if set to do so 
E.G. 0xD0000), so this transaction never goes through the PCI root bridge? 
What's confusing is if I look at the DSDT ACPI table and look at the 
ACPI\PNP0A08 device, it says that the PAM registers ranges go through it. I 
guess this is just for an OS purpose as it doesn’t need to know what exact 
ranges go through the root bridge? I'm not entirely sure on that and if 
anyone could clarify it would be appreciated.

As well as the PAM register ranges for the root bridge it also has the PCIe 
device memory range, which in my case is 0xC0000000 – 0xFEAFFFFF, now does 
that mean that anything above that range isn't going through the PCI root 
bridge, or is it just like that so an OS doesn't try map a device in that 
region. If I look at the Haswell datasheet it has small regions in that area 
between things like APIC and BIOS that reach the DMI.

It seems as if the PCI root bridge is using some sort of subtractive 
decoding that picks up whatever isn't sent to DRAM etc. and to make it easy 
for an OS the BIOS gives it a block of address space.

Finally, I was on a forum related to external GPUs, and some Windows users 
didn’t have enough space to map the device below 4GB. To resolve this they 
manually edited the DSDT table and added another entry above the 4GB 
barrier, now Windows mapped the GPU in the 64bit space. Now I presume 
changing the entry in the DSDT table didn't make any difference to how the 
hardware was set up, it just told the OS that the root bridge will in fact 
pick up this address range and therefore it knew it could map it there.

So am I write in thinking the ranges in the ACPI table are for the OSs 
purpose, and don't actually have to accurately represent what the hardware 
does.

..and does anyone know what ranges do actually go through a single PCIe root 
bridge on a modern system?

If anyone could help it would be greatly appreciated :)

Kind Regards,
Robert 

