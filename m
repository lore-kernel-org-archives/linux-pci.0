Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9033 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbcK2GZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2016 01:25:37 -0500
Subject: Re: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
To: Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-10-thierry.reding@gmail.com>
 <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
CC: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <b1d4404a-375a-0787-0ef8-f4e81710663c@nvidia.com>
Date: Tue, 29 Nov 2016 11:55:19 +0530
MIME-Version: 1.0
In-Reply-To: <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've also tried with OCZ SSD and things are working fine.

Boot log...

[    1.770836] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configuration
[    1.796262] tegra-pcie 1003000.pcie-controller: probing port 0, using 
4 lanes
[    1.809456] tegra-pcie 1003000.pcie-controller: Slot present pin 
change, signature: 00000008
[    1.828019] tegra-pcie 1003000.pcie-controller: probing port 1, using 
1 lanes
[    1.835179] tegra-pcie 1003000.pcie-controller: Slot present pin 
change, signature: 00000000
[    2.254574] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    2.665182] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    3.075772] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    3.084231] tegra-pcie 1003000.pcie-controller: link 1 down, ignoring
[    3.090863] tegra-pcie 1003000.pcie-controller: PCI host bridge to 
bus 0000:00
[    3.098138] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
[    3.104340] pci_bus 0000:00: root bus resource [mem 
0x13000000-0x1fffffff]
[    3.111232] pci_bus 0000:00: root bus resource [mem 
0x20000000-0x3fffffff pref]
[    3.118566] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.124490] pci 0000:00:01.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.144765] pci 0000:00:01.0: BAR 14: assigned [mem 
0x13000000-0x130fffff]
[    3.151670] pci 0000:01:00.0: BAR 2: assigned [mem 
0x13000000-0x1303ffff 64bit]
[    3.159013] pci 0000:01:00.0: BAR 0: assigned [mem 
0x13040000-0x1305ffff 64bit]
[    3.166338] pci 0000:01:00.0: BAR 6: assigned [mem 
0x13060000-0x1306ffff pref]
[    3.173559] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.178530] pci 0000:00:01.0:   bridge window [mem 0x13000000-0x130fffff]
[    3.185338] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host 
bridge
[    3.192384] pcieport 0000:00:01.0: enabling device (0000 -> 0002)
[    3.198747] pcieport 0000:00:01.0: Signaling PME through PCIe PME 
interrupt
[    3.205763] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    3.212491] mvsas 0000:01:00.0: mvsas: driver version 0.8.16
[    3.218182] mvsas 0000:01:00.0: enabling device (0000 -> 0002)
[    3.229007] mvsas 0000:01:00.0: mvsas: PCI-E x4, Bandwidth Usage: 2.5 
Gbps
[   10.184674] scsi host0: mvsas
[   10.368296] ata1.00: ATA-8: OCZ-REVODRIVE3 X2, 2.25, max UDMA/133
[   10.374400] ata1.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   10.388296] ata1.00: configured for UDMA/133
[   10.411571] scsi 0:0:0:0: Direct-Access     ATA OCZ-REVODRIVE3 X 2.25 
PQ: 0 ANSI: 5
[   10.441215] sd 0:0:0:0: [sda] 117231408 512-byte logical blocks: 
(60.0 GB/55.9 GiB)
[   10.620169] ata2.00: ATA-8: OCZ-REVODRIVE3 X2, 2.25, max UDMA/133
[   10.626283] ata2.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   10.640171] ata2.00: configured for UDMA/133
[   10.644714] sd 0:0:0:0: [sda] Write Protect is off
[   10.649597] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.661798] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.670963] scsi 0:0:1:0: Direct-Access     ATA OCZ-REVODRIVE3 X 2.25 
PQ: 0 ANSI: 5
[   10.701173] sd 0:0:1:0: [sdb] 117231408 512-byte logical blocks: 
(60.0 GB/55.9 GiB)
[   10.879961] ata3.00: ATA-8: OCZ-REVODRIVE3 X2, 2.25, max UDMA/133
[   10.886076] ata3.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   10.899961] ata3.00: configured for UDMA/133
[   10.904486] sd 0:0:1:0: [sdb] Write Protect is off
[   10.909367] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   10.920861]  sdb: sdb1
[   10.924375] sd 0:0:1:0: [sdb] Attached SCSI disk
[   10.933242] scsi 0:0:2:0: Direct-Access     ATA OCZ-REVODRIVE3 X 2.25 
PQ: 0 ANSI: 5
[   10.965166] sd 0:0:2:0: [sdc] 117231408 512-byte logical blocks: 
(60.0 GB/55.9 GiB)
[   11.143890] ata4.00: ATA-8: OCZ-REVODRIVE3 X2, 2.25, max UDMA/133
[   11.150002] ata4.00: 117231408 sectors, multi 16: LBA48 NCQ (depth 31/32)
[   11.163892] ata4.00: configured for UDMA/133
[   11.168424] sd 0:0:2:0: [sdc] Write Protect is off
[   11.173306] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   11.184751]  sdc: sdc1
[   11.188243] sd 0:0:2:0: [sdc] Attached SCSI disk
[   11.197107] scsi 0:0:3:0: Direct-Access     ATA OCZ-REVODRIVE3 X 2.25 
PQ: 0 ANSI: 5
[   11.229166] sd 0:0:3:0: [sdd] 117231408 512-byte logical blocks: 
(60.0 GB/55.9 GiB)
[   11.238220] 70090000.usb supply dvdd-pex-pll not found, using dummy 
regulator
[   11.245777] sd 0:0:3:0: [sdd] Write Protect is off
[   11.245848] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   11.251511]  sdd: sdd1
[   11.252354] sd 0:0:3:0: [sdd] Attached SCSI disk

Thanks,

Vidya Sagar


On Monday 28 November 2016 10:24 PM, Mikko Perttunen wrote:
> Testing this series with a Jetson TX1 + r8168e PCI-E card, it /almost/ 
> works.. Relevant parts of bootlog:
>
> [    1.876191] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configuration
> [    1.884200] tegra-pcie 1003000.pcie-controller: probing port 0, 
> using 4 lanes
> [    1.893368] tegra-pcie 1003000.pcie-controller: Slot present pin 
> change, signature: 00000008
> [    1.948049] tegra-pcie 1003000.pcie-controller: probing port 1, 
> using 1 lanes
> [    1.957209] tegra-pcie 1003000.pcie-controller: Slot present pin 
> change, signature: 00000000
> [    2.367748] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    2.778307] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    3.188888] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    3.197344] tegra-pcie 1003000.pcie-controller: link 1 down, ignoring
> [    3.203931] tegra-pcie 1003000.pcie-controller: PCI host bridge to 
> bus 0000:00
> [    3.211160] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
> [    3.217343] pci_bus 0000:00: root bus resource [mem 
> 0x13000000-0x1fffffff]
> [    3.224218] pci_bus 0000:00: root bus resource [mem 
> 0x20000000-0x3fffffff pref]
> [    3.231525] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    3.237380] pci 0000:00:01.0: bridge configuration invalid ([bus 
> 00-00]), reconfiguring
> [    3.254499] pci 0000:00:01.0: BAR 14: assigned [mem 
> 0x13000000-0x130fffff]
> [    3.261389] pci 0000:00:01.0: BAR 15: assigned [mem 
> 0x20000000-0x200fffff 64bit pref]
> [    3.269220] pci 0000:00:01.0: BAR 13: assigned [io 0x1000-0x1fff]
> [    3.275412] pci 0000:01:00.0: BAR 4: assigned [mem 
> 0x20000000-0x20003fff 64bit pref]
> [    3.283172] pci 0000:01:00.0: BAR 2: assigned [mem 
> 0x13000000-0x13000fff 64bit]
> [    3.290498] pci 0000:01:00.0: BAR 0: assigned [io 0x1000-0x10ff]
> [    3.296596] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    3.301568] pci 0000:00:01.0:   bridge window [io 0x1000-0x1fff]
> [    3.307666] pci 0000:00:01.0:   bridge window [mem 
> 0x13000000-0x130fffff]
> [    3.314454] pci 0000:00:01.0:   bridge window [mem 
> 0x20000000-0x200fffff 64bit pref]
> [    3.322213] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate 
> host bridge
> [    3.329257] pcieport 0000:00:01.0: enabling device (0000 -> 0003)
> [    3.335572] pcieport 0000:00:01.0: Signaling PME through PCIe PME 
> interrupt
> [    3.342537] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    3.349256] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.354858] r8169 0000:01:00.0: enabling device (0000 -> 0003)
> [    3.361460] r8169 0000:01:00.0 eth0: RTL8168e/8111e at 
> 0xffff000008eae000, 98:de:d0:04:25:14, XID 0c200000 IRQ 348
> [    3.371812] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 
> bytes, tx checksumming: ko]
>
> then
>
> [    3.706240] tegra-mc 70019000.memory-controller: afiw: write 
> @0x000000007a484000: EMEM address decode error (EMEM decode error)
> [    3.717747] r8169 0000:01:00.0 eth0: link down
>
> The card is alive though, the transfer LED is blinking according to 
> incoming traffic, I assume; we can also see that the driver is able to 
> access the hw to some extent. The kernel version is 4.9rc7 with just 
> this series on top. The same board/card also works in U-boot.
>
> - Mikko
>
> On 11/25/2016 12:57 PM, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Enable the x4 PCIe and M.2 Key E slots on Jetson TX1. The Key E slot is
>> currently untested due to lack of hardware.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 26 
>> ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts 
>> b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> index 983775e637a4..4c1ea7a08d43 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
>> @@ -7,6 +7,32 @@
>>      model = "NVIDIA Jetson TX1 Developer Kit";
>>      compatible = "nvidia,p2371-2180", "nvidia,tegra210";
>>
>> +    pcie-controller@01003000 {
>> +        status = "okay";
>> +
>> +        avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
>> +        hvddio-pex-supply = <&vdd_1v8>;
>> +        dvddio-pex-supply = <&vdd_pex_1v05>;
>> +        dvdd-pex-pll-supply = <&vdd_pex_1v05>;
>> +        hvdd-pex-pll-e-supply = <&vdd_1v8>;
>> +        vddio-pex-ctl-supply = <&vdd_1v8>;
>> +
>> +        pci@1,0 {
>> +            phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
>> + <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
>> + <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
>> + <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
>> +            phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
>> +            status = "okay";
>> +        };
>> +
>> +        pci@2,0 {
>> +            phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
>> +            phy-names = "pcie-0";
>> +            status = "okay";
>> +        };
>> +    };
>> +
>>      host1x@50000000 {
>>          dsi@54300000 {
>>              status = "okay";
>>

