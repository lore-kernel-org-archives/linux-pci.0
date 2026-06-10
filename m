Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1A234994;
	Wed, 10 Jun 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131729; cv=none; b=p4CLZYyGc9qIyhliJ4QcyKN4rEm4End3AK4CoJAIEba1/7m4P4g2v4CaVgwN20BdKNFvJMzMsCyW4mMno/h5tZmlnrKQRQxTvmIXm5c5CFQy02IZBZtSXeTToydaqbZB9a5NRt/Mbl0dSHPm5m3VOEAGmgvj8OUcGfhawRIG9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131729; c=relaxed/simple;
	bh=xxqyStTFs1xIVJtpTZmE5reQoqsQNHtPQnaWCcX/Jnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfXfSP5v37XNReixOcwWIJ1ACiZv+T/x/ljxU+l+k1Mk2m38clH7g3jY9+DtMgwDpR+SMBNHrQo/piOTOTCgKapVuq4l2L+BM1WMlKMreeAZ+s1RpHKod2n/J80iNTWbA6sLSwE3nAtck6QZuB6ledAJGSfRXBH+66/Edc4gpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com; spf=pass smtp.mailfrom=bakke.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakke.com
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 778BD163250;
	Wed, 10 Jun 2026 22:48:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: dag@bakke.com) by omf12.hostedemail.com (Postfix) with ESMTPA id C5F9117;
	Wed, 10 Jun 2026 22:48:41 +0000 (UTC)
Message-ID: <9507bfaa-c14e-49fc-8016-cf65bed9a76d@bakke.com>
Date: Thu, 11 Jun 2026 00:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connecting multiple TB3 eGPUs via USB4 hub?'
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>
References: <f600c4de-955f-4403-9f47-4de1088a9f56@bakke.com>
 <20260608152640.GA35630@bhelgaas> <20260609120826.GN2990@black.igk.intel.com>
Content-Language: en-US, nb-NO
From: Dag B <dag@bakke.com>
In-Reply-To: <20260609120826.GN2990@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 6d9uhp3a6pguk589bkkannr939wwsihc
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C5F9117
X-Session-Marker: 6461674062616B6B652E636F6D
X-Session-ID: U2FsdGVkX18KRobkdWhsr2jBPeJEz1M32Rz0y6oLlaE=
X-HE-Tag: 1781131721-910404
X-HE-Meta: U2FsdGVkX19LNfSze/DmoJR3Ha92sBqnPVFL/eaYurLgV5f74Fa71ys2mkz0JWb8gZJxpD7h9WAbdyD5ZEjh7AmgMVKKc1YW2RjN/o+Dv5CmXLn10pLbDmhNFGg0mK/e5WMPTwEnHNU6/Brm5G61q/8Rb1Y4IFFJNyfmtjpNUEeZEz8XXwdodZgBDiabkIrOh2oZSdDfRXmoL+2apShVLWdH+2YJZFchn2253Ud+OFOVFnvveNyoe4zC11WRQ7ARWI5Q9u/3a+V8nQx2ZisBG7AnR7T8xRsoYlUYJl1u8NCLlhGZNGoKCEF25+RKrq5MZuypaZVuEWD5MW5fqUTmINVrJBo6N7WL2sWLU7WVD6F4VJYTQFls8J132M6OShPFjUaFFFJEtMVJs5Cjrm6E48NdIdnOcg1RzoQ87lVQbHE=


On 6/9/26 14:08, Mika Westerberg wrote:
> Hi,
>
> On Mon, Jun 08, 2026 at 10:26:40AM -0500, Bjorn Helgaas wrote:
>> [+cc linux-usb (Thunderbolt maintainers), Ilpo, Lukas]
>>
>> On Sun, May 24, 2026 at 04:56:56PM +0200, Dag B wrote:
>>> I am attempting to connect two TB3 enclosures to the same USB4 port via a
>>> USB4 hub.
>>>
>>> I cannot figure out of this is in violation of the TB3, TB4 or USB4 spec.
>> I'm not aware of a spec issue here.
Thank you very much Bjorn, slightly more interesting trying to get it to 
work then.
> It should be fine but typically PCIe resources for one tunneled PCIe root
> port may not be enough for multiple GPUs. Therefore I suggest to connect
> them directly to the host USB4 ports without a hub.

That makes perfect sense. Until you run out of physical ports. The 
entire point of this exercise started with trying to connect a 5th 3090 
to my fw13 motherboard. :-D

Hence the USB4 hub. But even with just the hub and two connected GPUs, 
it fails.

For now, I have limited my testing to just the USB4 hub and either one 
or two GPUs.


> Second thing is that you have bunch of PCIe related command line parameters
> that may affect. I suggest removing all of them, and retry. There is hardly
> any reason to add these - the kernel should be able to handle this by
> default.

Mhm. I have stripped the command line parameters for some of my tests. 
It absolutely works with nothing extra for a single GPU. And it 
absolutely did not work without command-line params and with 4 GPUs  
when I started on this adventure. But that was around 6.16-6.17.


>
> Then provide full dmesg along with output of 'sudo lspci -vv' so we can
> look a the resource allocation.

This very quickly becomes a lot of data as I test various things. I put 
a repo with various data up on github.

https://github.com/dagbdagb/usb4_to_tb3_troubleshooting/

If you truly want all this on the mailing list, please let me know.

>
>> Below it looks like you hot-added the hub.  Does it make any
>> difference if everything is connected before boot?

Yes. With both GPUs connected at boot, none of them will work. With just 
one, it works.


>>
>> Please don't filter the dmesg logs you collect.  We can do that if
>> needed.

Noted.

If anything stands out in the kernel logs, let me know. And, of course, 
if logs suggest that this simply isn't possible with the hardware I have 
at hand.

I found this in the logs:

[   38.769878] NVRM: The NVIDIA probe routine was not called for 2 
device(s).
[   38.770543] NVRM: This can occur when another driver was loaded and
                NVRM: obtained ownership of the NVIDIA device(s).

These messages are no longer there after disabling some CONFIG_FB 
options. (and so is my console...)

Makes for no difference in the end, though. 'BAR0 is 0M' (with two GPUs 
connected at boot)


Dag B


>>> .... or, in case it is not:
>>>
>>> Can this work with current USB4/Thunderbolt drivers in Linux? (I am not
>>> worried about bandwidth limitations.)
>>>
>>>
>>> This appears to be too niche to find answers anywhere else. I would be very
>>> grateful for any clarifying answer here, really.
>>>
>>>
>>> Hardware
>>>
>>> - Framework 13 mb with 12th gen Alder Lake (Intel Corporation Alder Lake-P
>>> Thunderbolt 4 NHI)  (4 USB4 ports)
>>>
>>> - Sonnettech Echo 5 hub (Intel Corporation Thunderbolt 4 Bridge [Goshen
>>> Ridge 2020] )
>>>
>>> - Razer Core X (Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016])
>>>
>>> - GPUs are Nvidia RTX 3090. They expose two PCIe devices, the GPU and an
>>> audio device.
>>>
>>>
>>> Using kernel 7.0.10 with gentoo patches.
>>>
>>>
>>> Been playing *a lot* with various permutations of pci-related kernel
>>> options. Current options:
>>>
>>> pci=realloc=on,hpmmiosize=256M,hpiosize=2M,hpmemsize=1G,hpbussize=0x33,pcie_scan_all,big_root_window
>>>
>>>
>>> pcie_port_pm=off
>>>
>>> pcie_aspm.policy=performance
>>>
>>> thunderbolt.clx=0
>>>
>>>
>>>
>>> Booting with 2 eGPUS directly connected to separate USB4 ports.  (pcie
>>> messages only):
>>>
>>> [    0.000000] Command line: root=/dev/nvme0n1p2 pci=realloc=on,hpmmiosize=256M,hpiosize=2M,hpmemsize=1G,hpbussize=0x33,pcie_scan_all,big_root_window
>>> pcie_port_pm=off pcie_aspm.policy=performance thunderbolt.clx=0
>>> [    0.082296] Kernel command line: pci=realloc=on,hpmmiosize=256M,hpiosize=2M,hpmemsize=1G,hpbussize=0x33,pcie_scan_all,big_root_window
>>> \
>>> [    0.082297] Kernel command line: pcie_port_pm=off
>>> pcie_aspm.policy=performance \
>>> [    0.864174] pcieport 0000:00:06.0: PME: Signaling with IRQ 122
>>> [    0.864343] pcieport 0000:00:07.0: PME: Signaling with IRQ 123
>>> [    0.864358] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL-
>>> AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>>> [    0.864661] pcieport 0000:00:07.1: PME: Signaling with IRQ 124
>>> [    0.864677] pcieport 0000:00:07.1: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL-
>>> AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>>> [    0.864900] pcieport 0000:00:07.2: PME: Signaling with IRQ 125
>>> [    0.864914] pcieport 0000:00:07.2: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL-
>>> AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>>> [    0.865139] pcieport 0000:00:07.3: PME: Signaling with IRQ 126
>>> [    0.865153] pcieport 0000:00:07.3: pciehp: Slot #6 AttnBtn- PwrCtrl- MRL-
>>> AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>>> [    0.865376] pcieport 0000:00:1d.0: PME: Signaling with IRQ 127
>>> [    5.127515] pcieport 0000:00:07.3: pciehp: Slot(6): Card present
>>> [    5.134225] pcieport 0000:00:07.0: pciehp: Slot(3): Card present
>>> [    5.263158] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.263178] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.263197] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.263215] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.270527] pcieport 0000:00:07.3: PCI bridge to [bus 7d-a5]
>>> [    5.270529] pcieport 0000:00:07.3:   bridge window [mem
>>> 0x52000000-0x5e1fffff]
>>> [    5.270531] pcieport 0000:00:07.3:   bridge window [mem
>>> 0x6060000000-0x607bffffff 64bit pref]
>>> [    5.270537] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.270537] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.270538] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.270539] pcieport 0000:00:07.3: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.270577] pcieport 0000:00:07.3: PCI bridge to [bus 7d-a5]
>>> [    5.270579] pcieport 0000:00:07.3:   bridge window [mem
>>> 0x52000000-0x5e1fffff]
>>> [    5.270581] pcieport 0000:00:07.3:   bridge window [mem
>>> 0x6060000000-0x607bffffff 64bit pref]
>>> [    5.270703] pcieport 0000:7d:00.0: enabling device (0000 -> 0002)
>>> [    5.287127] pcieport 0000:7e:01.0: enabling device (0000 -> 0002)
>>> [    5.325065] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.325560] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.326061] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.326560] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.340678] pcieport 0000:00:07.0: PCI bridge to [bus 02-2a]
>>> [    5.340680] pcieport 0000:00:07.0:   bridge window [mem
>>> 0x7c000000-0x881fffff]
>>> [    5.340682] pcieport 0000:00:07.0:   bridge window [mem
>>> 0x6000000000-0x601bffffff 64bit pref]
>>> [    5.340688] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.340689] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.340690] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [    5.340690] pcieport 0000:00:07.0: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [    5.340741] pcieport 0000:00:07.0: PCI bridge to [bus 02-2a]
>>> [    5.340744] pcieport 0000:00:07.0:   bridge window [mem
>>> 0x7c000000-0x881fffff]
>>> [    5.340745] pcieport 0000:00:07.0:   bridge window [mem
>>> 0x6000000000-0x601bffffff 64bit pref]
>>> [    5.340866] pcieport 0000:02:00.0: enabling device (0000 -> 0002)
>>> [    5.355410] pcieport 0000:03:01.0: enabling device (0000 -> 0002)
>>>
>>>
>>> Then, connecting the hub with two additional eGPUs to a third USB4 port (all
>>> messages):
>>>
>>> [  596.449718] thunderbolt 0-3: new device found, vendor=0x8 device=0x5f
>>> [  596.449771] thunderbolt 0-3: Sonnet Technologies, Inc. Echo 5 Thunderbolt
>>> 4 Hub
>>> [  596.710380] thunderbolt 0-0:3.1: new retimer found, vendor=0x8087
>>> device=0x15ee
>>> [  596.962295] usb 3-3: new high-speed USB device number 4 using xhci_hcd
>>> [  597.156102] usb 3-3: New USB device found, idVendor=1d5c, idProduct=5801,
>>> bcdDevice= 1.01
>>> [  597.156118] usb 3-3: New USB device strings: Mfr=1, Product=2,
>>> SerialNumber=0
>>> [  597.156130] usb 3-3: Product: USB2.0 Hub
>>> [  597.156138] usb 3-3: Manufacturer: Fresco Logic, Inc.
>>> [  597.157120] hub 3-3:1.0: USB hub found
>>> [  597.157152] hub 3-3:1.0: 6 ports detected
>>> [  597.458933] usb 2-2: new SuperSpeed Plus Gen 2x1 USB device number 4
>>> using xhci_hcd
>>> [  597.472670] usb 2-2: New USB device found, idVendor=8087, idProduct=0b40,
>>> bcdDevice=12.34
>>> [  597.472687] usb 2-2: New USB device strings: Mfr=1, Product=2,
>>> SerialNumber=0
>>> [  597.472700] usb 2-2: Product: USB3.0 Hub
>>> [  597.472711] usb 2-2: Manufacturer: Intel Corporation.
>>> [  597.473459] hub 2-2:1.0: USB hub found
>>> [  597.473587] hub 2-2:1.0: 4 ports detected
>>> [  597.559335] thunderbolt 0-303: new device found, vendor=0x127 device=0x1
>>> [  597.559350] thunderbolt 0-303: Razer Core X
>>> [  597.702310] usb 3-3.5: new full-speed USB device number 5 using xhci_hcd
>>> [  597.801389] usb 3-3.5: New USB device found, idVendor=2a8c,
>>> idProduct=205f, bcdDevice=17.46
>>> [  597.801406] usb 3-3.5: New USB device strings: Mfr=1, Product=2,
>>> SerialNumber=3
>>> [  597.801418] usb 3-3.5: Product: Echo 5 Thunderbolt 4 Hub
>>> [  597.801428] usb 3-3.5: Manufacturer: Sonnet Technologies,Inc.
>>> [  597.801438] usb 3-3.5: SerialNumber: 11AD1D0A510D2E0D381E0B00
>>> [  597.885632] usb 3-3.6: new high-speed USB device number 6 using xhci_hcd
>>> [  597.983768] usb 3-3.6: New USB device found, idVendor=1d5c,
>>> idProduct=5530, bcdDevice= 1.01
>>> [  597.983785] usb 3-3.6: New USB device strings: Mfr=1, Product=2,
>>> SerialNumber=0
>>> [  597.983798] usb 3-3.6: Product: Frescologic VENDOR HID
>>> [  597.983807] usb 3-3.6: Manufacturer: Frescologic
>>> [  597.985769] hid-generic 0003:1D5C:5530.0002: hidraw1: USB HID v1.01
>>> Device [Frescologic Frescologic VENDOR HID] on usb-0000:00:14.0-3.6/input0
>>> [  598.294042] thunderbolt 0-503: new device found, vendor=0x127 device=0x1
>>> [  598.294057] thunderbolt 0-503: Razer Core X
>>> [  598.619985] pcieport 0000:00:07.1: pciehp: Slot(4): Card present
>>> [  598.619999] pcieport 0000:00:07.1: pciehp: Slot(4): Link Up
>>> [  598.745860] pci 0000:2b:00.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Upstream Port
>>> [  598.745987] pci 0000:2b:00.0: PCI bridge to [bus 00]
>>> [  598.746028] pci 0000:2b:00.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.746061] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.746113] pci 0000:2b:00.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.746173] pci 0000:2b:00.0: enabling Extended Tags
>>> [  598.746450] pci 0000:2b:00.0: supports D1 D2
>>> [  598.746471] pci 0000:2b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.747002] pci 0000:2b:00.0: Adding to iommu group 22
>>> [  598.755705] pci 0000:2b:00.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.755945] pci 0000:2c:00.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.756014] pci 0000:2c:00.0: PCI bridge to [bus 00]
>>> [  598.756039] pci 0000:2c:00.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.756059] pci 0000:2c:00.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.756094] pci 0000:2c:00.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.756136] pci 0000:2c:00.0: enabling Extended Tags
>>> [  598.756346] pci 0000:2c:00.0: supports D1 D2
>>> [  598.756359] pci 0000:2c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.756675] pci 0000:2c:00.0: Adding to iommu group 23
>>> [  598.756854] pci 0000:2c:01.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.756925] pci 0000:2c:01.0: PCI bridge to [bus 00]
>>> [  598.756950] pci 0000:2c:01.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.756970] pci 0000:2c:01.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.757863] pci 0000:2c:01.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.758743] pci 0000:2c:01.0: enabling Extended Tags
>>> [  598.759822] pci 0000:2c:01.0: supports D1 D2
>>> [  598.760599] pci 0000:2c:01.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.761582] pci 0000:2c:01.0: Adding to iommu group 24
>>> [  598.762477] pci 0000:2c:02.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.763270] pci 0000:2c:02.0: PCI bridge to [bus 00]
>>> [  598.764010] pci 0000:2c:02.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.764697] pci 0000:2c:02.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.765266] pci 0000:2c:02.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.765832] pci 0000:2c:02.0: enabling Extended Tags
>>> [  598.766513] pci 0000:2c:02.0: supports D1 D2
>>> [  598.767016] pci 0000:2c:02.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.767686] pci 0000:2c:02.0: Adding to iommu group 25
>>> [  598.768272] pci 0000:2c:03.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.768804] pci 0000:2c:03.0: PCI bridge to [bus 00]
>>> [  598.769323] pci 0000:2c:03.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.769815] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.770317] pci 0000:2c:03.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.770816] pci 0000:2c:03.0: enabling Extended Tags
>>> [  598.771451] pci 0000:2c:03.0: supports D1 D2
>>> [  598.771929] pci 0000:2c:03.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.772596] pci 0000:2c:03.0: Adding to iommu group 26
>>> [  598.773173] pci 0000:2c:04.0: [8086:0b26] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.773694] pci 0000:2c:04.0: PCI bridge to [bus 00]
>>> [  598.774196] pci 0000:2c:04.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.774683] pci 0000:2c:04.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.775179] pci 0000:2c:04.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.775687] pci 0000:2c:04.0: enabling Extended Tags
>>> [  598.776319] pci 0000:2c:04.0: supports D1 D2
>>> [  598.776794] pci 0000:2c:04.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.777437] pci 0000:2c:04.0: Adding to iommu group 27
>>> [  598.777985] pci 0000:2b:00.0: PCI bridge to [bus 2c-53]
>>> [  598.778481] pci 0000:2c:00.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.778983] pci 0000:2c:01.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.779463] pci 0000:2c:02.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.779939] pci 0000:2c:03.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.780408] pci 0000:2c:04.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.780987] pci 0000:2c:00.0: PCI bridge to [bus 2d-53]
>>> [  598.781458] pci_bus 0000:2d: busn_res: [bus 2d-53] end is updated to 2d
>>> [  598.782096] pci 0000:2e:00.0: [8086:15da] type 01 class 0x060400 PCIe
>>> Switch Upstream Port
>>> [  598.782628] pci 0000:2e:00.0: PCI bridge to [bus 00]
>>> [  598.783089] pci 0000:2e:00.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.783548] pci 0000:2e:00.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.784020] pci 0000:2e:00.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.784493] pci 0000:2e:00.0: enabling Extended Tags
>>> [  598.785172] pci 0000:2e:00.0: supports D1 D2
>>> [  598.785624] pci 0000:2e:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.786319] pci 0000:2e:00.0: Adding to iommu group 28
>>> [  598.792407] pci 0000:2c:01.0: PCI bridge to [bus 2e-53]
>>> [  598.792880] pci 0000:2e:00.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.793579] pci 0000:2f:01.0: [8086:15da] type 01 class 0x060400 PCIe
>>> Switch Downstream Port
>>> [  598.794094] pci 0000:2f:01.0: PCI bridge to [bus 00]
>>> [  598.794559] pci 0000:2f:01.0:   bridge window [io 0x0000-0x0fff]
>>> [  598.795014] pci 0000:2f:01.0:   bridge window [mem 0x00000000-0x000fffff]
>>> [  598.795485] pci 0000:2f:01.0:   bridge window [mem 0x00000000-0x000fffff
>>> 64bit pref]
>>> [  598.795981] pci 0000:2f:01.0: enabling Extended Tags
>>> [  598.796665] pci 0000:2f:01.0: supports D1 D2
>>> [  598.797111] pci 0000:2f:01.0: PME# supported from D0 D1 D2 D3hot D3cold
>>> [  598.797785] pci 0000:2f:01.0: Adding to iommu group 29
>>> [  598.798344] pci 0000:2e:00.0: PCI bridge to [bus 2f-53]
>>> [  598.798826] pci 0000:2f:01.0: bridge configuration invalid ([bus 00-00]),
>>> reconfiguring
>>> [  598.799576] pci 0000:30:00.0: [10de:2204] type 00 class 0x030000 PCIe
>>> Legacy Endpoint
>>> [  598.800146] pci 0000:30:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
>>> [  598.800598] pci 0000:30:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit
>>> pref]
>>> [  598.801062] pci 0000:30:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit
>>> pref]
>>> [  598.801512] pci 0000:30:00.0: BAR 5 [io  0x0000-0x007f]
>>> [  598.801961] pci 0000:30:00.0: ROM [mem 0x00000000-0x0007ffff pref]
>>> [  598.802697] pci 0000:30:00.0: PME# supported from D0 D3hot
>>> [  598.803421] pci 0000:30:00.0: 8.000 Gb/s available PCIe bandwidth,
>>> limited by 2.5 GT/s PCIe x4 link at 0000:00:07.1 (capable of 252.048 Gb/s
>>> with 16.0 GT/s PCIe x16 link)
>>> [  598.804053] pci 0000:30:00.0: Adding to iommu group 29
>>> [  598.804517] pci 0000:30:00.0: vgaarb: bridge control possible
>>> [  598.804969] pci 0000:30:00.0: vgaarb: VGA device added:
>>> decodes=io+mem,owns=none,locks=none
>>> [  598.805427] i915 0000:00:02.0: vgaarb: VGA decodes changed:
>>> olddecodes=none,decodes=none:owns=io+mem
>>> [  598.806033] pci 0000:30:00.1: [10de:1aef] type 00 class 0x040300 PCIe
>>> Endpoint
>>> [  598.806622] pci 0000:30:00.1: BAR 0 [mem 0x00000000-0x00003fff]
>>> [  598.807434] pci 0000:30:00.1: Adding to iommu group 29
>>> [  598.808118] pci 0000:2f:01.0: PCI bridge to [bus 30-53]
>>> [  598.808614] pci_bus 0000:30: busn_res: [bus 30-53] end is updated to 30
>>> [  598.809107] pci_bus 0000:2f: busn_res: [bus 2f-53] end is updated to 30
>>> [  598.809575] pci_bus 0000:2e: busn_res: [bus 2e-53] end is updated to 53
>>> [  598.810077] pci_bus 0000:54: busn_res: [bus 54-7c] end is updated to 7c
>>> [  598.810714] pci_bus 0000:7d: busn_res: [bus 7d-a5] end is updated to a5
>>> [  598.811226] pci_bus 0000:a6: busn_res: [bus a6] end is updated to a6
>>> [  598.811682] pci_bus 0000:2c: busn_res: [bus 2c-53] end can not be updated
>>> to a6
>>> [  598.812141] pci 0000:2c:00.0: disabling bridge window [mem
>>> 0x00000000-0x000fffff 64bit pref] to [bus 2d] (unused)
>>> [  598.812621] pci 0000:2c:00.0: disabling bridge window [mem
>>> 0x00000000-0x000fffff] to [bus 2d] (unused)
>>> [  598.813082] pci 0000:2c:01.0: bridge window [io  0x1000-0x1fff] to [bus
>>> 2e-53] add_size 1ff000
>>> [  598.813544] pci 0000:2c:01.0: bridge window [mem 0x10000000-0x21ffffff
>>> 64bit pref] to [bus 2e-53] add_size 2e000000 add_align 10000000
>>> [  598.814007] pci 0000:2c:01.0: bridge window [mem 0x01000000-0x020fffff]
>>> to [bus 2e-53] add_size 3ef00000 add_align 1000000
>>> [  598.814474] pci 0000:2b:00.0: bridge window [io  0x1000-0x2fff] to [bus
>>> 2c-53] add_size 1ff000
>>> [  598.814942] pci 0000:2b:00.0: bridge window [mem 0x10000000-0x21ffffff
>>> 64bit pref] to [bus 2c-53] add_size 2e000000 add_align 10000000
>>> [  598.815414] pci 0000:2b:00.0: bridge window [mem 0x01000000-0x020fffff]
>>> to [bus 2c-53] add_size 3ef00000 add_align 1000000
>>> [  598.815908] pcieport 0000:00:07.1: bridge window [io  size 0x200000] to
>>> [bus 2b-53] add_size 1ff000
>>> [  598.816393] pcieport 0000:00:07.1: bridge window [io  size 0x3ff000]:
>>> can't assign; no space
>>> [  598.816870] pcieport 0000:00:07.1: bridge window [io  size 0x3ff000]:
>>> failed to assign
>>> [  598.817346] pcieport 0000:00:07.1: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [  598.817828] pcieport 0000:00:07.1: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [  598.818304] pci 0000:2b:00.0: bridge window [mem size 0x40000000 64bit
>>> pref]: can't assign; no space
>>> [  598.818785] pci 0000:2b:00.0: bridge window [mem size 0x40000000 64bit
>>> pref]: failed to assign
>>> [  598.819281] pci 0000:2b:00.0: bridge window [mem 0x6e000000-0x7a0fffff]:
>>> assigned
>>> [  598.819765] pci 0000:2b:00.0: bridge window [io  size 0x200000]: can't
>>> assign; no space
>>> [  598.820250] pci 0000:2b:00.0: bridge window [io  size 0x200000]: failed
>>> to assign
>>> [  598.820740] pci 0000:2b:00.0: bridge window [mem 0x6e000000-0x7a0fffff]:
>>> releasing
>>> [  598.821235] pci 0000:2b:00.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: assigned
>>> [  598.821727] pci 0000:2b:00.0: bridge window [mem 0x6e000000-0x7a0fffff]:
>>> assigned
>>> [  598.822227] pci 0000:2b:00.0: bridge window [io  size 0x200000]: can't
>>> assign; no space
>>> [  598.822722] pci 0000:2b:00.0: bridge window [io  size 0x200000]: failed
>>> to assign
>>> [  598.823206] pci 0000:2b:00.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: failed to expand by 0x2e000000
>>> [  598.823697] pci 0000:2b:00.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: failed to add optional 2e000000
>>> [  598.824186] pci 0000:2c:01.0: bridge window [mem size 0x40000000 64bit
>>> pref]: can't assign; no space
>>> [  598.824679] pci 0000:2c:01.0: bridge window [mem size 0x40000000 64bit
>>> pref]: failed to assign
>>> [  598.825173] pci 0000:2c:01.0: bridge window [mem 0x6e000000-0x720fffff]:
>>> assigned
>>> [  598.825677] pci 0000:2c:00.0: bridge window [io  size 0x1000]: can't
>>> assign; no space
>>> [  598.826173] pci 0000:2c:00.0: bridge window [io  size 0x1000]: failed to
>>> assign
>>> [  598.826666] pci 0000:2c:01.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.827161] pci 0000:2c:01.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.827652] pci 0000:2c:01.0: bridge window [mem 0x6e000000-0x720fffff]:
>>> releasing
>>> [  598.828140] pci 0000:2c:01.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: assigned
>>> [  598.828630] pci 0000:2c:01.0: bridge window [mem 0x6e000000-0x720fffff]:
>>> assigned
>>> [  598.829132] pci 0000:2c:00.0: bridge window [io  size 0x1000]: can't
>>> assign; no space
>>> [  598.829623] pci 0000:2c:00.0: bridge window [io  size 0x1000]: failed to
>>> assign
>>> [  598.830116] pci 0000:2c:01.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.830606] pci 0000:2c:01.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.831099] pci 0000:2c:01.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: failed to expand by 0x2e000000
>>> [  598.831588] pci 0000:2c:01.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: failed to add optional 2e000000
>>> [  598.832080] pci 0000:2c:00.0: PCI bridge to [bus 2d]
>>> [  598.832605] pci 0000:2e:00.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: assigned
>>> [  598.833106] pci 0000:2e:00.0: bridge window [mem 0x6e000000-0x720fffff]:
>>> assigned
>>> [  598.833599] pci 0000:2e:00.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.834091] pci 0000:2e:00.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.834590] pci 0000:2e:00.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.835088] pci 0000:2e:00.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.835592] pci 0000:2f:01.0: bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]: assigned
>>> [  598.836098] pci 0000:2f:01.0: bridge window [mem 0x6e000000-0x720fffff]:
>>> assigned
>>> [  598.836600] pci 0000:2f:01.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.837097] pci 0000:2f:01.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.837585] pci 0000:2f:01.0: bridge window [io  size 0xab000]: can't
>>> assign; no space
>>> [  598.838073] pci 0000:2f:01.0: bridge window [io  size 0xab000]: failed to
>>> assign
>>> [  598.838559] pci 0000:30:00.0: BAR 1 [mem 0x6020000000-0x602fffffff 64bit
>>> pref]: assigned
>>> [  598.839079] pci 0000:30:00.0: BAR 3 [mem 0x6030000000-0x6031ffffff 64bit
>>> pref]: assigned
>>> [  598.839581] pci 0000:30:00.0: BAR 0 [mem 0x6e000000-0x6effffff]: assigned
>>> [  598.840063] pci 0000:30:00.0: ROM [mem 0x6f000000-0x6f07ffff pref]:
>>> assigned
>>> [  598.840538] pci 0000:30:00.1: BAR 0 [mem 0x6f080000-0x6f083fff]: assigned
>>> [  598.841020] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: can't assign; no
>>> space
>>> [  598.841496] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: failed to assign
>>> [  598.841974] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: can't assign; no
>>> space
>>> [  598.842463] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: failed to assign
>>> [  598.842941] pci 0000:2f:01.0: PCI bridge to [bus 30]
>>> [  598.843429] pci 0000:2f:01.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.843918] pci 0000:2f:01.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.844415] pci 0000:2e:00.0: PCI bridge to [bus 2f-30]
>>> [  598.844901] pci 0000:2e:00.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.845388] pci 0000:2e:00.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.845890] pci 0000:2c:01.0: PCI bridge to [bus 2e-53]
>>> [  598.846369] pci 0000:2c:01.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.846845] pci 0000:2c:01.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.847319] pci 0000:2b:00.0: PCI bridge to [bus 2c-53]
>>> [  598.847789] pci 0000:2b:00.0:   bridge window [mem 0x6e000000-0x7a0fffff]
>>> [  598.848255] pci 0000:2b:00.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.848720] pcieport 0000:00:07.1: PCI bridge to [bus 2b-53]
>>> [  598.849198] pcieport 0000:00:07.1:   bridge window [mem
>>> 0x6e000000-0x7a1fffff]
>>> [  598.849667] pcieport 0000:00:07.1:   bridge window [mem
>>> 0x6020000000-0x603bffffff 64bit pref]
>>> [  598.850136] PCI: No. 2 try to assign unassigned res
>>> [  598.850602] pci 0000:2c:00.0: disabling bridge window [mem
>>> 0x00000000-0x000fffff 64bit pref disabled] to [bus 2d] (unused)
>>> [  598.851083] pci 0000:2c:00.0: disabling bridge window [mem
>>> 0x00000000-0x000fffff disabled] to [bus 2d] (unused)
>>> [  598.851556] pci 0000:2c:01.0: bridge window [io  size 0xab000] to [bus
>>> 2e-53] add_size 155000
>>> [  598.852035] pci 0000:2b:00.0: bridge window [io  size 0x200000] to [bus
>>> 2c-53] add_size 155000
>>> [  598.852530] pcieport 0000:00:07.1: bridge window [io  size 0x200000] to
>>> [bus 2b-53] add_size 155000
>>> [  598.853014] pcieport 0000:00:07.1: bridge window [io  size 0x355000]:
>>> can't assign; no space
>>> [  598.853493] pcieport 0000:00:07.1: bridge window [io  size 0x355000]:
>>> failed to assign
>>> [  598.853971] pcieport 0000:00:07.1: bridge window [io  size 0x200000]:
>>> can't assign; no space
>>> [  598.854448] pcieport 0000:00:07.1: bridge window [io  size 0x200000]:
>>> failed to assign
>>> [  598.854921] pci 0000:2b:00.0: bridge window [io  size 0x355000]: can't
>>> assign; no space
>>> [  598.855401] pci 0000:2b:00.0: bridge window [io  size 0x355000]: failed
>>> to assign
>>> [  598.855896] pci 0000:2b:00.0: bridge window [io  size 0x200000]: can't
>>> assign; no space
>>> [  598.856376] pci 0000:2b:00.0: bridge window [io  size 0x200000]: failed
>>> to assign
>>> [  598.856847] pci 0000:2c:00.0: bridge window [io  size 0x1000]: can't
>>> assign; no space
>>> [  598.857319] pci 0000:2c:00.0: bridge window [io  size 0x1000]: failed to
>>> assign
>>> [  598.857788] pci 0000:2c:01.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.858255] pci 0000:2c:01.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.858722] pci 0000:2c:00.0: bridge window [io  size 0x1000]: can't
>>> assign; no space
>>> [  598.859209] pci 0000:2c:00.0: bridge window [io  size 0x1000]: failed to
>>> assign
>>> [  598.859677] pci 0000:2c:01.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.860143] pci 0000:2c:01.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.860609] pci 0000:2c:00.0: PCI bridge to [bus 2d]
>>> [  598.861088] pci 0000:2e:00.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.861556] pci 0000:2e:00.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.862018] pci 0000:2e:00.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.862501] pci 0000:2e:00.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.862970] pci 0000:2f:01.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.863429] pci 0000:2f:01.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.863891] pci 0000:2f:01.0: bridge window [io  size 0x11c000]: can't
>>> assign; no space
>>> [  598.864349] pci 0000:2f:01.0: bridge window [io  size 0x11c000]: failed
>>> to assign
>>> [  598.864802] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: can't assign; no
>>> space
>>> [  598.865254] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: failed to assign
>>> [  598.865715] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: can't assign; no
>>> space
>>> [  598.866163] pci 0000:30:00.0: BAR 5 [io  size 0x0080]: failed to assign
>>> [  598.866615] pci 0000:2f:01.0: PCI bridge to [bus 30]
>>> [  598.867073] pci 0000:2f:01.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.867528] pci 0000:2f:01.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.867992] pci 0000:2e:00.0: PCI bridge to [bus 2f-30]
>>> [  598.868448] pci 0000:2e:00.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.868907] pci 0000:2e:00.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.869374] pci 0000:2c:01.0: PCI bridge to [bus 2e-53]
>>> [  598.869833] pci 0000:2c:01.0:   bridge window [mem 0x6e000000-0x720fffff]
>>> [  598.870286] pci 0000:2c:01.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.870749] pci 0000:2b:00.0: PCI bridge to [bus 2c-53]
>>> [  598.871209] pci 0000:2b:00.0:   bridge window [mem 0x6e000000-0x7a0fffff]
>>> [  598.871670] pci 0000:2b:00.0:   bridge window [mem
>>> 0x6020000000-0x6031ffffff 64bit pref]
>>> [  598.872132] pcieport 0000:00:07.1: PCI bridge to [bus 2b-53]
>>> [  598.872613] pcieport 0000:00:07.1:   bridge window [mem
>>> 0x6e000000-0x7a1fffff]
>>> [  598.873080] pcieport 0000:00:07.1:   bridge window [mem
>>> 0x6020000000-0x603bffffff 64bit pref]
>>> [  598.873649] pcieport 0000:2b:00.0: enabling device (0000 -> 0002)
>>> [  598.874666] pcieport 0000:2c:01.0: enabling device (0000 -> 0002)
>>> [  598.875244] pcieport 0000:2c:01.0: pciehp: Slot #1 AttnBtn- PwrCtrl- MRL-
>>> AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>>> [  598.876454] pcieport 0000:2c:02.0: pciehp: Hotplug bridge without
>>> secondary bus, ignoring
>>> [  598.877284] pcieport 0000:2c:03.0: pciehp: Hotplug bridge without
>>> secondary bus, ignoring
>>> [  598.878335] pcieport 0000:2e:00.0: enabling device (0000 -> 0002)
>>> [  598.879210] pcieport 0000:2f:01.0: enabling device (0000 -> 0002)
>>> [  598.880224] nvidia 0000:30:00.0: enabling device (0000 -> 0002)
>>> [  598.880833] nvidia 0000:30:00.0: vgaarb: VGA decodes changed:
>>> olddecodes=io+mem,decodes=none:owns=none
>>> [  599.171370] [drm] [nvidia-drm] [GPU ID 0x00003000] Loading driver
>>> [  599.172273] [drm] Initialized nvidia-drm 0.0.0 for 0000:30:00.0 on minor
>>> 3
>>> [  599.172936] pci 0000:30:00.1: extending delay after power-on from D3hot
>>> to 20 msec
>>> [  599.173650] pci 0000:30:00.1: D0 power state depends on 0000:30:00.0
>>> [  683.104898] Loading firmware: nvidia/595.71.05/gsp_ga10x.bin
>>> [  683.634039] Loading firmware: nvidia/595.71.05/gsp_ga10x.bin
>>> [  684.043158] Loading firmware: nvidia/595.71.05/gsp_ga10x.bin
>>>
>>> So, only one of the two hub-connected eGPUs are recognized.
>>>
>>>
>>> pciehp: Hotplug bridge without secondary bus, ignoring <-  This sounds less
>>> promising.
>>>
>>>
>>> lspci (after connecting hub):
>>>
>>> 00:00.0 Host bridge: Intel Corporation 12th Gen Core Processor Host
>>> Bridge/DRAM Registers (rev 02)
>>> 00:02.0 VGA compatible controller: Intel Corporation Alder Lake-P GT2 [Iris
>>> Xe Graphics] (rev 0c)
>>> 00:04.0 Signal processing controller: Intel Corporation Alder Lake
>>> Innovation Platform Framework Processor Participant (rev 02)
>>> 00:06.0 PCI bridge: Intel Corporation 12th Gen Core Processor PCI Express x4
>>> Controller #0 (rev 02)
>>> 00:07.0 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express
>>> Root Port #0 (rev 02)
>>> 00:07.1 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express
>>> Root Port #1 (rev 02)
>>> 00:07.2 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express
>>> Root Port #2 (rev 02)
>>> 00:07.3 PCI bridge: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express
>>> Root Port #3 (rev 02)
>>> 00:08.0 System peripheral: Intel Corporation 12th Gen Core Processor
>>> Gaussian & Neural Accelerator (rev 02)
>>> 00:0a.0 Signal processing controller: Intel Corporation Platform Monitoring
>>> Technology (rev 01)
>>> 00:0d.0 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4 USB
>>> Controller (rev 02)
>>> 00:0d.2 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4 NHI #0
>>> (rev 02)
>>> 00:0d.3 USB controller: Intel Corporation Alder Lake-P Thunderbolt 4 NHI #1
>>> (rev 02)
>>> 00:14.0 USB controller: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host
>>> Controller (rev 01)
>>> 00:14.2 RAM memory: Intel Corporation Alder Lake PCH Shared SRAM (rev 01)
>>> 00:15.0 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO
>>> I2C Controller #0 (rev 01)
>>> 00:15.1 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO
>>> I2C Controller #1 (rev 01)
>>> 00:15.3 Serial bus controller: Intel Corporation Alder Lake PCH Serial IO
>>> I2C Controller #3 (rev 01)
>>> 00:16.0 Communication controller: Intel Corporation Alder Lake PCH HECI
>>> Controller (rev 01)
>>> 00:16.3 Serial controller: Intel Corporation Alder Lake AMT SOL Redirection
>>> (rev 01)
>>> 00:1d.0 PCI bridge: Intel Corporation Alder Lake PCI Express Root Port #9
>>> (rev 01)
>>> 00:1f.0 ISA bridge: Intel Corporation Alder Lake PCH eSPI Controller (rev
>>> 01)
>>> 00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High Definition
>>> Audio Controller (rev 01)
>>> 00:1f.4 SMBus: Intel Corporation Alder Lake PCH-P SMBus Host Controller (rev
>>> 01)
>>> 00:1f.5 Serial bus controller: Intel Corporation Alder Lake-P PCH SPI
>>> Controller (rev 01)
>>> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD
>>> Controller PM9C1a (DRAM-less)
>>> 02:00.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 03:01.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 04:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX
>>> 3090] (rev a1)
>>> 04:00.1 Audio device: NVIDIA Corporation GA102 High Definition Audio
>>> Controller (rev a1)
>>> 2b:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2c:00.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2c:01.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2c:02.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2c:03.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2c:04.0 PCI bridge: Intel Corporation Thunderbolt 4 Bridge [Goshen Ridge
>>> 2020] (rev 03)
>>> 2e:00.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 2f:01.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 30:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX
>>> 3090] (rev a1)
>>> 30:00.1 Audio device: NVIDIA Corporation GA102 High Definition Audio
>>> Controller (rev a1)
>>> 7d:00.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 7e:01.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C step)
>>> [Alpine Ridge 2C 2016] (rev 02)
>>> 7f:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX
>>> 3090 Ti] (rev a1)
>>> 7f:00.1 Audio device: NVIDIA Corporation GA102 High Definition Audio
>>> Controller (rev a1)
>>> a6:00.0 Ethernet controller: Intel Corporation Ethernet Controller I226-V
>>> (rev 04)
>>>
>>>
>>> /proc/iomem after connecting hub
>>>
>>> 00000000-00000fff : Reserved
>>> 00001000-0009efff : System RAM
>>> 0009f000-000fffff : Reserved
>>>    000a0000-000bffff : PCI Bus 0000:00
>>>    000f0000-000fffff : System ROM
>>> 00100000-3727bfff : System RAM
>>> 3727c000-372cafff : Reserved
>>> 372cb000-388b2fff : System RAM
>>> 388b3000-388b3fff : Reserved
>>> 388b4000-3b138fff : System RAM
>>> 3b139000-3ba38fff : Reserved
>>> 3ba39000-3d84efff : System RAM
>>> 3d84f000-40a7efff : Reserved
>>> 40a7f000-43a2efff : ACPI Non-volatile Storage
>>>    43945000-43945fff : USBC000:00
>>> 43a2f000-43afefff : ACPI Tables
>>> 43aff000-43afffff : System RAM
>>> 43b00000-47ffffff : Reserved
>>> 49200000-493fffff : Reserved
>>> 4a000000-503fffff : Reserved
>>>    4c800000-503fffff : Graphics Stolen Memory
>>> 50400000-bfffffff : PCI Bus 0000:00
>>>    50400000-50400fff : 0000:00:1f.5
>>>    50500000-507fffff : PCI Bus 0000:a6
>>>      50500000-505fffff : 0000:a6:00.0
>>>        50500000-505fffff : igc
>>>      50600000-506fffff : 0000:a6:00.0
>>>      50700000-50703fff : 0000:a6:00.0
>>>        50700000-50703fff : igc
>>>    52000000-5e1fffff : PCI Bus 0000:7d
>>>      52000000-5e0fffff : PCI Bus 0000:7e
>>>        52000000-5e0fffff : PCI Bus 0000:7f
>>>          52000000-52ffffff : 0000:7f:00.0
>>>            52000000-52ffffff : nvidia
>>>          53000000-5307ffff : 0000:7f:00.0
>>>          53080000-53083fff : 0000:7f:00.1
>>>    60000000-6c1fffff : PCI Bus 0000:54
>>>    6e000000-7a1fffff : PCI Bus 0000:2b
>>>      6e000000-7a0fffff : PCI Bus 0000:2c
>>>        6e000000-720fffff : PCI Bus 0000:2e
>>>          6e000000-720fffff : PCI Bus 0000:2f
>>>            6e000000-720fffff : PCI Bus 0000:30
>>>              6e000000-6effffff : 0000:30:00.0
>>>                6e000000-6effffff : nvidia
>>>              6f000000-6f07ffff : 0000:30:00.0
>>>              6f080000-6f083fff : 0000:30:00.1
>>>    7a400000-7a4fffff : PCI Bus 0000:01
>>>      7a400000-7a403fff : 0000:01:00.0
>>>        7a400000-7a403fff : nvme
>>>    7a600000-7a60ffff : 0000:00:14.0
>>>      7a600000-7a60ffff : xhci-hcd
>>>    7a611000-7a611fff : 0000:00:16.3
>>>    7c000000-881fffff : PCI Bus 0000:02
>>>      7c000000-880fffff : PCI Bus 0000:03
>>>        7c000000-880fffff : PCI Bus 0000:04
>>>          7c000000-7cffffff : 0000:04:00.0
>>>            7c000000-7cffffff : nvidia
>>>          7d000000-7d07ffff : 0000:04:00.0
>>>          7d080000-7d083fff : 0000:04:00.1
>>> c0000000-cfffffff : PCI ECAM 0000 [bus 00-ff]
>>>    c0000000-cfffffff : PNP0C02:01
>>> fd000000-fd68ffff : PNP0C02:02
>>> fd690000-fd69ffff : INTC1055:00
>>> fd6a0000-fd6affff : INTC1055:00
>>> fd6b0000-fd6cffff : PNP0C02:02
>>> fd6d0000-fd6dffff : INTC1055:00
>>> fd6e0000-fd6effff : INTC1055:00
>>> fd6f0000-fdffffff : PNP0C02:02
>>> fe000000-fe01ffff : PNP0C02:02
>>> fe04c000-fe04ffff : PNP0C02:02
>>> fe050000-fe0affff : PNP0C02:02
>>> fe0d0000-fe0fffff : PNP0C02:02
>>> fe200000-fe7fffff : PNP0C02:02
>>> fec00000-fec003ff : IOAPIC 0
>>> fed00000-fed003ff : HPET 0
>>>    fed00000-fed003ff : PNP0103:00
>>> fed20000-fed7ffff : Reserved
>>>    fed40000-fed44fff : NTC0702:00
>>> fed90000-fed90fff : dmar0
>>> fed91000-fed91fff : dmar1
>>> feda0000-feda0fff : PNP0C02:01
>>> feda1000-feda1fff : PNP0C02:01
>>> fedc0000-fedc7fff : PNP0C02:01
>>> fee00000-feefffff : PNP0C02:01
>>> ff000000-ffffffff : PNP0C02:02
>>> 100000000-10afbfffff : System RAM
>>>    d6a000000-d6b1e52f7 : Kernel code
>>>    d6b200000-d6b7a0fff : Kernel rodata
>>>    d6b800000-d6bac0cff : Kernel data
>>>    d6c247000-d6c30ffff : Kernel bss
>>> 10afc00000-10afffffff : RAM buffer
>>> 4000000000-7fffffffff : PCI Bus 0000:00
>>>    4000000000-400fffffff : 0000:00:02.0
>>>    4010000000-4016ffffff : 0000:00:02.0
>>>    4017000000-4017000fff : 0000:00:15.0
>>>      4017000000-40170001ff : lpss_dev
>>>        4017000000-40170001ff : i2c_designware.0 lpss_dev
>>>      4017000200-40170002ff : lpss_priv
>>>      4017000800-4017000fff : idma64.0
>>>    4017001000-4017001fff : 0000:00:15.1
>>>      4017001000-40170011ff : lpss_dev
>>>        4017001000-40170011ff : i2c_designware.1 lpss_dev
>>>      4017001200-40170012ff : lpss_priv
>>>      4017001800-4017001fff : idma64.1
>>>    4017002000-4017002fff : 0000:00:15.3
>>>      4017002000-40170021ff : lpss_dev
>>>        4017002000-40170021ff : i2c_designware.2 lpss_dev
>>>      4017002200-40170022ff : lpss_priv
>>>      4017002800-4017002fff : idma64.2
>>>    4020000000-40ffffffff : 0000:00:02.0
>>>    6000000000-601bffffff : PCI Bus 0000:02
>>>      6000000000-6011ffffff : PCI Bus 0000:03
>>>        6000000000-6011ffffff : PCI Bus 0000:04
>>>          6000000000-600fffffff : 0000:04:00.0
>>>          6010000000-6011ffffff : 0000:04:00.0
>>>    6020000000-603bffffff : PCI Bus 0000:2b
>>>      6020000000-6031ffffff : PCI Bus 0000:2c
>>>        6020000000-6031ffffff : PCI Bus 0000:2e
>>>          6020000000-6031ffffff : PCI Bus 0000:2f
>>>            6020000000-6031ffffff : PCI Bus 0000:30
>>>              6020000000-602fffffff : 0000:30:00.0
>>>              6030000000-6031ffffff : 0000:30:00.0
>>>    6040000000-605bffffff : PCI Bus 0000:54
>>>    605c000000-605cffffff : 0000:00:02.0
>>>    605d000000-605d0fffff : 0000:00:1f.3
>>>    605d100000-605d13ffff : 0000:00:0d.3
>>>      605d100000-605d13ffff : thunderbolt
>>>    605d140000-605d17ffff : 0000:00:0d.2
>>>      605d140000-605d17ffff : thunderbolt
>>>    605d180000-605d19ffff : 0000:00:04.0
>>>      605d180000-605d19ffff : proc_thermal
>>>    605d1a0000-605d1affff : 0000:00:0d.0
>>>      605d1a0000-605d1affff : xhci-hcd
>>>    605d1b0000-605d1b7fff : 0000:00:0a.0
>>>    605d1b8000-605d1bbfff : 0000:00:1f.3
>>>    605d1bc000-605d1bffff : 0000:00:14.2
>>>    605d1c0000-605d1c00ff : 0000:00:1f.4
>>>      605d1c0000-605d1c00ff : i801_smbus
>>>    605d1c1000-605d1c1fff : 0000:00:16.0
>>>      605d1c1000-605d1c1fff : mei_me
>>>    605d1c5000-605d1c5fff : 0000:00:14.2
>>>    605d1c6000-605d1c6fff : 0000:00:0d.3
>>>    605d1c7000-605d1c7fff : 0000:00:0d.2
>>>    605d1c8000-605d1c8fff : 0000:00:08.0
>>>    6060000000-607bffffff : PCI Bus 0000:7d
>>>      6060000000-6071ffffff : PCI Bus 0000:7e
>>>        6060000000-6071ffffff : PCI Bus 0000:7f
>>>          6060000000-606fffffff : 0000:7f:00.0
>>>          6070000000-6071ffffff : 0000:7f:00.0
>>>
>>>
