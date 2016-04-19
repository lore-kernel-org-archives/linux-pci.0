Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35960 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcDSWds (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 18:33:48 -0400
Received: by mail-ig0-f182.google.com with SMTP id f1so113132004igr.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 15:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dad5ef4a3ace4c2e8a73dafc24df6c7f@XCGVAG27.northgrum.com>
References: <dad5ef4a3ace4c2e8a73dafc24df6c7f@XCGVAG27.northgrum.com>
Date: Tue, 19 Apr 2016 15:33:47 -0700
Message-ID: <CAH=XD59xbiXxLTZd-__j2oLfWLR4S=wQ3kb0cjTpfH6oDFXszw@mail.gmail.com>
Subject: Re: PCI Hot Plug: OS can not program BARs for new devices
From: Kallol Biswas <kallol@nucleodyne.com>
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

How can I force Linux kernel to allocate some window anyway for the
bridges? With pcie=hpmemsize=256M once or twice hot plug worked on
port 9 (see messages below).

When hotplug works the bridge PCI resources are programmed differently.

Looks like that there is no other alternative than read the kernel
code and figure out what is happening.

When hotplug works:

pciehp 0000:09:09.0:pcie24: Hotplug Controller:
pciehp 0000:09:09.0:pcie24:   Seg/Bus/Dev/Func/IRQ : 0000:09:09.0 IRQ 79
pciehp 0000:09:09.0:pcie24:   Vendor ID            : 0x10b5
pciehp 0000:09:09.0:pcie24:   Device ID            : 0x9797
pciehp 0000:09:09.0:pcie24:   Subsystem ID         : 0x1003
pciehp 0000:09:09.0:pcie24:   Subsystem Vendor ID  : 0x10b5
pciehp 0000:09:09.0:pcie24:   PCIe Cap offset      : 0x68
pciehp 0000:09:09.0:pcie24:   PCI resource [13]     : [io  0xe000-0xefff]
pciehp 0000:09:09.0:pcie24:   PCI resource [14]     : [mem
0xfb000000-0xfb0fffff]
pciehp 0000:09:09.0:pcie24:   PCI resource [15]     : [mem
0xfbe00000-0xfbefffff 64bit pref]
pciehp 0000:09:09.0:pcie24: Slot Capabilities      : 0x004a0cff
pciehp 0000:09:09.0:pcie24:   Physical Slot Number : 9
pciehp 0000:09:09.0:pcie24:   Attention Button     : yes
pciehp 0000:09:09.0:pcie24:   Power Controller     : yes
pciehp 0000:09:09.0:pcie24:   MRL Sensor           : yes
pciehp 0000:09:09.0:pcie24:   Attention Indicator  : yes
pciehp 0000:09:09.0:pcie24:   Power Indicator      : yes
pciehp 0000:09:09.0:pcie24:   Hot-Plug Surprise    : yes
pciehp 0000:09:09.0:pcie24:   EMI Present          : yes
pciehp 0000:09:09.0:pcie24:   Command Completed    : yes
pciehp_readw : reg 0x1a value 0x50 ret 0x0
pciehp 0000:09:09.0:pcie24: Slot Status            : 0x0050


When hotplug does not work:

pciehp_readl : reg 0x14 value 0x4a0cff ret 0x0
pciehp 0000:09:09.0:pcie24: Hotplug Controller:
pciehp 0000:09:09.0:pcie24:   Seg/Bus/Dev/Func/IRQ : 0000:09:09.0 IRQ 79
pciehp 0000:09:09.0:pcie24:   Vendor ID            : 0x10b5
pciehp 0000:09:09.0:pcie24:   Device ID            : 0x9797
pciehp 0000:09:09.0:pcie24:   Subsystem ID         : 0x1003
pciehp 0000:09:09.0:pcie24:   Subsystem Vendor ID  : 0x10b5
pciehp 0000:09:09.0:pcie24:   PCIe Cap offset      : 0x68
pciehp 0000:09:09.0:pcie24:   PCI resource [13]     : [io  0x2000-0x2fff]
pciehp 0000:09:09.0:pcie24:   PCI resource [15]     : [mem
0x90200000-0x903fffff 64bit pref]
pciehp 0000:09:09.0:pcie24: Slot Capabilities      : 0x004a0cff
pciehp 0000:09:09.0:pcie24:   Physical Slot Number : 9
pciehp 0000:09:09.0:pcie24:   Attention Button     : yes
pciehp 0000:09:09.0:pcie24:   Power Controller     : yes
pciehp 0000:09:09.0:pcie24:   MRL Sensor           : yes
pciehp 0000:09:09.0:pcie24:   Attention Indicator  : yes
pciehp 0000:09:09.0:pcie24:   Power Indicator      : yes
pciehp 0000:09:09.0:pcie24:   Hot-Plug Surprise    : yes
pciehp 0000:09:09.0:pcie24:   EMI Present          : yes
pciehp 0000:09:09.0:pcie24:   Command Completed    : yes
pciehp_readw : reg 0x1a value 0x10 ret 0x0
pciehp 0000:09:09.0:pcie24: Slot Status            : 0x0010
pciehp_readw : reg 0x18 value 0x140 ret 0x0

On Tue, Apr 19, 2016 at 2:04 PM, Tang, Jason (ES) <Jason.Tang2@ngc.com> wrote:
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> owner@vger.kernel.org] On Behalf Of Kallol Biswas
>> Sent: Tuesday, April 19, 2016 16:39
>> To: linux-pci@vger.kernel.org
>> Subject: PCI Hot Plug: OS can not program BARs for new devices
>>
>> I have a been testing PCIe Hot Plug feature on a Supericro X10DRL
>> motherboard running 2.6.38.1 kernel.
>>
>> If an endpoint is already present at boot time on a hot plug capable
>> PCIe slot then I can remove and add the endpoint with the help of a
>> Quarch device. OS allocates resources properly and after hot unplug
>> and plug, the device is functional.
>>
>> If the endpoint is not present at boot time (turned off with the
>> Quarch) then put back (turn on with Quarch) the OS can not program BAR
>> registers.
> <snip>
>> Is there a workaround for this? Note, there are other devices on
>> downstream PCIe ports, so remove and rescan is not an option.
>
> I had proposed a solution to this, involving statically enumerating bus numbers and BAR resources. See http://www.spinics.net/lists/linux-pci/msg44721.html
> Using hpmemsize was not sufficient for my case, because I needed to "hot add" a bridge.
>
