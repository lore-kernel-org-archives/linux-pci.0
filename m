Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:56167 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcK1Qyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Nov 2016 11:54:51 -0500
Subject: Re: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
To: Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-10-thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
Date: Mon, 28 Nov 2016 18:54:44 +0200
MIME-Version: 1.0
In-Reply-To: <20161125105718.3866-10-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Testing this series with a Jetson TX1 + r8168e PCI-E card, it /almost/ 
works.. Relevant parts of bootlog:

[    1.876191] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configuration
[    1.884200] tegra-pcie 1003000.pcie-controller: probing port 0, using 
4 lanes
[    1.893368] tegra-pcie 1003000.pcie-controller: Slot present pin 
change, signature: 00000008
[    1.948049] tegra-pcie 1003000.pcie-controller: probing port 1, using 
1 lanes
[    1.957209] tegra-pcie 1003000.pcie-controller: Slot present pin 
change, signature: 00000000
[    2.367748] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    2.778307] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    3.188888] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
[    3.197344] tegra-pcie 1003000.pcie-controller: link 1 down, ignoring
[    3.203931] tegra-pcie 1003000.pcie-controller: PCI host bridge to 
bus 0000:00
[    3.211160] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    3.217343] pci_bus 0000:00: root bus resource [mem 
0x13000000-0x1fffffff]
[    3.224218] pci_bus 0000:00: root bus resource [mem 
0x20000000-0x3fffffff pref]
[    3.231525] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.237380] pci 0000:00:01.0: bridge configuration invalid ([bus 
00-00]), reconfiguring
[    3.254499] pci 0000:00:01.0: BAR 14: assigned [mem 
0x13000000-0x130fffff]
[    3.261389] pci 0000:00:01.0: BAR 15: assigned [mem 
0x20000000-0x200fffff 64bit pref]
[    3.269220] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    3.275412] pci 0000:01:00.0: BAR 4: assigned [mem 
0x20000000-0x20003fff 64bit pref]
[    3.283172] pci 0000:01:00.0: BAR 2: assigned [mem 
0x13000000-0x13000fff 64bit]
[    3.290498] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[    3.296596] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.301568] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
[    3.307666] pci 0000:00:01.0:   bridge window [mem 0x13000000-0x130fffff]
[    3.314454] pci 0000:00:01.0:   bridge window [mem 
0x20000000-0x200fffff 64bit pref]
[    3.322213] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host 
bridge
[    3.329257] pcieport 0000:00:01.0: enabling device (0000 -> 0003)
[    3.335572] pcieport 0000:00:01.0: Signaling PME through PCIe PME 
interrupt
[    3.342537] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    3.349256] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    3.354858] r8169 0000:01:00.0: enabling device (0000 -> 0003)
[    3.361460] r8169 0000:01:00.0 eth0: RTL8168e/8111e at 
0xffff000008eae000, 98:de:d0:04:25:14, XID 0c200000 IRQ 348
[    3.371812] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 
bytes, tx checksumming: ko]

then

[    3.706240] tegra-mc 70019000.memory-controller: afiw: write 
@0x000000007a484000: EMEM address decode error (EMEM decode error)
[    3.717747] r8169 0000:01:00.0 eth0: link down

The card is alive though, the transfer LED is blinking according to 
incoming traffic, I assume; we can also see that the driver is able to 
access the hw to some extent. The kernel version is 4.9rc7 with just 
this series on top. The same board/card also works in U-boot.

- Mikko

On 11/25/2016 12:57 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Enable the x4 PCIe and M.2 Key E slots on Jetson TX1. The Key E slot is
> currently untested due to lack of hardware.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> index 983775e637a4..4c1ea7a08d43 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
> @@ -7,6 +7,32 @@
>  	model = "NVIDIA Jetson TX1 Developer Kit";
>  	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
>
> +	pcie-controller@01003000 {
> +		status = "okay";
> +
> +		avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
> +		hvddio-pex-supply = <&vdd_1v8>;
> +		dvddio-pex-supply = <&vdd_pex_1v05>;
> +		dvdd-pex-pll-supply = <&vdd_pex_1v05>;
> +		hvdd-pex-pll-e-supply = <&vdd_1v8>;
> +		vddio-pex-ctl-supply = <&vdd_1v8>;
> +
> +		pci@1,0 {
> +			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
> +			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
> +			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
> +			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
> +			phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
> +			status = "okay";
> +		};
> +
> +		pci@2,0 {
> +			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> +			phy-names = "pcie-0";
> +			status = "okay";
> +		};
> +	};
> +
>  	host1x@50000000 {
>  		dsi@54300000 {
>  			status = "okay";
>
