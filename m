Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <518A9114.1040201@wwwdotorg.org>
Date: Wed, 08 May 2013 11:53:24 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jay Agarwal <jagarwal@nvidia.com>
CC: linux@arm.linux.org.uk, thierry.reding@avionic-design.de,
	ldewangan@nvidia.com, bhelgaas@google.com, olof@lixom.net,
	hdoyu@nvidia.com, pgaikwad@nvidia.com, mturquette@linaro.org,
	pdeschrijver@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, jtukkinen@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH 4/4] ARM: tegra: pcie: Enable PCIe controller on Cardhu
References: <1368010660-31465-1-git-send-email-jagarwal@nvidia.com> <1368010660-31465-4-git-send-email-jagarwal@nvidia.com> <518A8596.7070702@wwwdotorg.org>
In-Reply-To: <518A8596.7070702@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/08/2013 11:04 AM, Stephen Warren wrote:
> On 05/08/2013 04:57 AM, Jay Agarwal wrote:
>> - Enable PCIe controller on Cardhu
>> - Only port 2 is connected on this board
>> - Add regulators required for Tegra30
>> - Patch is based on remotes/gitorious_thierryreding_linux/tegra/next
>> - and should be applied on top of this.
> 
>> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> 
>> +	pcie-controller {
>> +		status = "okay";
>> +		pex-clk-supply = <&pex_hvdd_3v3_reg>;
>> +		vdd-supply = <&ldo1_reg>;
>> +		avdd-supply = <&ldo2_reg>;
>> +
>> +		pci@3,0 {
>> +			status = "okay";
>> +		};
>> +	};
...
> According to the Cardhu schematics, the PCIe link to the dock is a
> single lane. Hence, I believe that the Cardhu DT should describe a 411
> port configuration. However, the Cardhu DT doesn't describe any
> particular link configuration, but just inherits the default from
> tegra30.dtsi, which describes a 222 link configuration. I would have
> expected the following in the Cardhu DT:
> 
> 		pci@1,0 {
> 			nvidia,num-lanes = <4>;
> 		};
> 
> 		pci@2,0 {
> 			nvidia,num-lanes = <1>;
> 		};
> 
> 		pci@3,0 {
> 			status = "okay";
> 			nvidia,num-lanes = <1>;
> 		};
> 
> However, if I put that there, no PCIe links are detected at all. Why
> does the driver work with the wrong link configuration, but fail with
> the correct one?

I take this back. Fixing the DT as shown above to represent the correct
4/1/1 configuration does still yield a working system. Please
incorporate this into a future patch revision.

The issue is more that PCIe enumeration is only reliable after a cold
power cycle of the dock (the dock appears to be powered solely by its
power cable and never the battery in Cardhu, and hence isn't affected by
the main tablet PMIC's power on/off state like most of the board is). Is
there some reset signal to the dock that the bootloader or kernel should
be driving to solve this?
