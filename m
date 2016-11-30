Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:36624 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbcK3SGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Nov 2016 13:06:49 -0500
Subject: Re: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
To: Thierry Reding <thierry.reding@gmail.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-10-thierry.reding@gmail.com>
 <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
 <20161130174840.GB20246@ulmo.ba.sec>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <13197e02-a83a-c9d8-13fa-7b21f664a12c@kapsi.fi>
Date: Wed, 30 Nov 2016 20:06:45 +0200
MIME-Version: 1.0
In-Reply-To: <20161130174840.GB20246@ulmo.ba.sec>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/30/2016 07:48 PM, Thierry Reding wrote:
> On Mon, Nov 28, 2016 at 06:54:44PM +0200, Mikko Perttunen wrote:
>> Testing this series with a Jetson TX1 + r8168e PCI-E card, it /almost/
>> works.. Relevant parts of bootlog:
>>
>> [    1.876191] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configuration
>> [    1.884200] tegra-pcie 1003000.pcie-controller: probing port 0, using 4
>> lanes
>> [    1.893368] tegra-pcie 1003000.pcie-controller: Slot present pin change,
>> signature: 00000008
>> [    1.948049] tegra-pcie 1003000.pcie-controller: probing port 1, using 1
>> lanes
>> [    1.957209] tegra-pcie 1003000.pcie-controller: Slot present pin change,
>> signature: 00000000
>> [    2.367748] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
>> [    2.778307] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
>> [    3.188888] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
>> [    3.197344] tegra-pcie 1003000.pcie-controller: link 1 down, ignoring
>> [    3.203931] tegra-pcie 1003000.pcie-controller: PCI host bridge to bus
>> 0000:00
>> [    3.211160] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> [    3.217343] pci_bus 0000:00: root bus resource [mem
>> 0x13000000-0x1fffffff]
>> [    3.224218] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3fffffff
>> pref]
>> [    3.231525] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    3.237380] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]),
>> reconfiguring
>> [    3.254499] pci 0000:00:01.0: BAR 14: assigned [mem
>> 0x13000000-0x130fffff]
>> [    3.261389] pci 0000:00:01.0: BAR 15: assigned [mem 0x20000000-0x200fffff
>> 64bit pref]
>> [    3.269220] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
>> [    3.275412] pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20003fff
>> 64bit pref]
>> [    3.283172] pci 0000:01:00.0: BAR 2: assigned [mem 0x13000000-0x13000fff
>> 64bit]
>> [    3.290498] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>> [    3.296596] pci 0000:00:01.0: PCI bridge to [bus 01]
>> [    3.301568] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
>> [    3.307666] pci 0000:00:01.0:   bridge window [mem 0x13000000-0x130fffff]
>> [    3.314454] pci 0000:00:01.0:   bridge window [mem 0x20000000-0x200fffff
>> 64bit pref]
>> [    3.322213] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host
>> bridge
>> [    3.329257] pcieport 0000:00:01.0: enabling device (0000 -> 0003)
>> [    3.335572] pcieport 0000:00:01.0: Signaling PME through PCIe PME
>> interrupt
>> [    3.342537] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>> [    3.349256] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
>> [    3.354858] r8169 0000:01:00.0: enabling device (0000 -> 0003)
>> [    3.361460] r8169 0000:01:00.0 eth0: RTL8168e/8111e at
>> 0xffff000008eae000, 98:de:d0:04:25:14, XID 0c200000 IRQ 348
>> [    3.371812] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes,
>> tx checksumming: ko]
>>
>> then
>>
>> [    3.706240] tegra-mc 70019000.memory-controller: afiw: write
>> @0x000000007a484000: EMEM address decode error (EMEM decode error)
>> [    3.717747] r8169 0000:01:00.0 eth0: link down
>
> Hmm... that's very odd. It seems like for some reason the PCIe
> controller wants to access memory that's below the DRAM. Do you happen
> to have the SMMU enabled for PCIe? Can you try adding some debug prints
> to the networking driver to find out where this address is coming from?

SMMU is disabled; I'll try adding debug prints. The behavior certainly 
looks pretty strange.

>
>> The card is alive though, the transfer LED is blinking according to incoming
>> traffic, I assume; we can also see that the driver is able to access the hw
>> to some extent. The kernel version is 4.9rc7 with just this series on top.
>> The same board/card also works in U-boot.
>
> I've tested this on a recent linux-next, so perhaps that's something
> else to try out. I wouldn't expect v4.9-rc7 to have any issues with a
> PCI network driver, but who knows.

I did test earlier with -next too but with some random set of patches 
and config options, but I agree that it's not likely to be the reason. I 
had some IP stack (UDPv6 warnings IIRC?) and lockdep issues or somesuch 
with recent -next's so I switched to rc7.

>
> Thanks,
> Thierry
>

Thanks,
Mikko.
