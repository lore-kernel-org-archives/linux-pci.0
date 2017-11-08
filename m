Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1549 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbdKHIpK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2017 03:45:10 -0500
Subject: Re: [PATCH V2 3/4] PCI: tegra: Apply sw fixups to support ASPM-L1
 Sub-States
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
        <yinghai@kernel.org>, <david.daney@cavium.com>,
        <Julia.Lawall@lip6.fr>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1509423769-10522-1-git-send-email-vidyas@nvidia.com>
 <1509423769-10522-4-git-send-email-vidyas@nvidia.com>
 <20171107225007.GA22847@bhelgaas-glaptop.roam.corp.google.com>
From: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ef7d193c-c114-d0c6-e450-c00ae3ab2d51@nvidia.com>
Date: Wed, 8 Nov 2017 14:15:05 +0530
MIME-Version: 1.0
In-Reply-To: <20171107225007.GA22847@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wednesday 08 November 2017 04:20 AM, Bjorn Helgaas wrote:
> Hi Vidya,
>
> On Tue, Oct 31, 2017 at 09:52:48AM +0530, Vidya Sagar wrote:
>> Programs T_cmrt (Commmon Mode Restore Time) and T_pwr_on (Power On)
>> values to get them reflected in ASPM-L1 Sub-States capability registers
>> Also adjusts internal counter values according to 19.2 MHz clk_m value
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * no change in this patch
>>
>>   drivers/pci/host/pci-tegra.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index e1526cc5d381..08da67a82a2d 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/of_pci.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-aspm.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/reset.h>
>> @@ -191,6 +192,27 @@
>>   #define RP_PRIV_XP_DL	0x494
>>   #define  RP_PRIV_XP_DL_GEN2_UPD_FC_TSHOLD	(0x1ff << 1)
>>   
>> +#define RP_L1_PM_SUBSTATES_CTL				0xC00
>> +#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK		(0xFF << 8)
>> +#define RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT		8
>> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK		(0x3 << 16)
>> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT		16
>> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK		(0x1F << 19)
>> +#define RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT		19
>> +#define RP_L1_PM_SUBSTATES_CTL_HIDE_CAP			(0x1 << 24)
>> +
>> +#define RP_L1_PM_SUBSTATES_1_CTL			0xC04
>> +#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK	0x1FFF
>> +#define RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY		0x26
>> +
>> +#define RP_L1_PM_SUBSTATES_2_CTL			0xC08
>> +#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK	0x1FFF
>> +#define RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY		0x4D
>> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK	(0xFF << 13)
>> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND		(0x13 << 13)
>> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK	(0xF << 21)
>> +#define RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP	(0x2 << 21)
>> +
>>   #define RP_RX_HDR_LIMIT	0xe00
>>   #define  RP_RX_HDR_LIMIT_PW_MASK	(0xff << 8)
>>   #define  RP_RX_HDR_LIMIT_PW		(0x0e << 8)
>> @@ -331,6 +353,7 @@ struct tegra_pcie_soc {
>>   	bool program_deskew_time;
>>   	bool updateFC_threshold;
>>   	bool has_aspm_l1;
>> +	bool has_aspm_l1ss;
>>   };
>>   
>>   static inline struct tegra_msi *to_tegra_msi(struct msi_controller *chip)
>> @@ -423,6 +446,12 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
>>   	return readl(pcie->pads + offset);
>>   }
>>   
>> +u32 pcie_aspm_get_ltr_l_1_2_threshold(void)
>> +{
>> +	/* LTR L1.2 Threshold = 55us for all ports */
>> +	return ((0x37 << 16) | (0x02 << 29));
> I know you've already worked through this, but let me think out loud
> to try to figure this out myself.
>
> ASPM defines Link power states L0, L0s, and L1.  L1 PM Substates
> extend that by adding L1.1 and L1.2.  L1.2 presumably uses less power
> and has a longer exit delay than L1.1 [sec 5.5].
>
> Ports that support L1.2 must support Latency Tolerance Reporting (LTR)
> [sec 6.18].  When LTR is enabled, a device periodically sends LTR
> messages.
>
> When ASPM puts a Link into L1, it chooses either L1.1 or L1.2 based on
> LTR_L1.2_THRESHOLD and recent LTR messages.  If there's no LTR
> information it looks like LTR_L1.2_THRESHOLD doesn't matter and it
> always chooses L1.2 [sec 5.5.1].
>
> I don't see anything that writes PCI_EXP_DEVCTL2_LTR_EN, so I don't
> think Linux ever enables LTR.  Some BIOSes apparently enable it
> (Google for "LTR enabled").
I think this needs to be done in aspm.c file. i.e. whenever sub-system 
enables L1.2, it should enable
LTR_EN also.
>
> 1) It seems like the LTR_L1.2_THRESHOLD value should be computed based
>     on the latency requirements of downstream devices.  How did you
>     come up with 55us?
This is given by Tegra hardware folks.
>
> 2) The spec requires [sec 5.5.4] that LTR_L1.2_THRESHOLD at both ends
>     of a Link be the same, but as far as I can see, there's no
>     requirement that it be the same across the whole system, so this
>     interface doesn't seem like quite the right approach.
Agree that this patch would make 55us applicable to entire system
>
> 3) We must support kernels with multiple host bridge drivers compiled
>     in, and the weak/strong symbol approach doesn't support using the
>     correct version, e.g., if we merge this patch, every system
>     containing the tegra driver would use this function, even if the
>     hardware had a different host bridge.  Also, if another driver
>     implemented its own version, we'd have duplicate symbols.
Yes. Agree with this too.
How about using quirks framework for this?
Rajat / Thierry / Bjorn, any thoughts on this?
>
>>   /*
>>    * The configuration space mapping on Tegra is somewhat similar to the ECAM
>>    * defined by PCIe. However it deviates a bit in how the 4 bits for extended
>> @@ -2262,6 +2291,37 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>>   		value |= RP_VEND_XP_UPDATE_FC_THRESHOLD_T210;
>>   		writel(value, port->base + RP_VEND_XP);
>>   	}
>> +
>> +	if (soc->has_aspm_l1ss) {
>> +		/* Set Common Mode Restore Time to 30us */
>> +		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
>> +		value &= ~RP_L1_PM_SUBSTATES_CTL_CM_RTIME_MASK;
>> +		value |= (0x1E << RP_L1_PM_SUBSTATES_CTL_CM_RTIME_SHIFT);
>> +		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
>> +
>> +		/* set T_Power_On to 70us */
>> +		value = readl(port->base + RP_L1_PM_SUBSTATES_CTL);
>> +		value &= ~(RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_MASK |
>> +			RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_MASK);
>> +		value |= (1 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_SCL_SHIFT) |
>> +			(7 << RP_L1_PM_SUBSTATES_CTL_T_PWRN_VAL_SHIFT);
>> +		writel(value, port->base + RP_L1_PM_SUBSTATES_CTL);
>> +
>> +		/* Following is based on clk_m being 19.2 MHz */
>> +		value = readl(port->base + RP_L1_PM_SUBSTATES_1_CTL);
>> +		value &= ~RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY_MASK;
>> +		value |= RP_L1_PM_SUBSTATES_1_CTL_PWR_OFF_DLY;
>> +		writel(value, port->base + RP_L1_PM_SUBSTATES_1_CTL);
>> +
>> +		value = readl(port->base + RP_L1_PM_SUBSTATES_2_CTL);
>> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY_MASK;
>> +		value |= RP_L1_PM_SUBSTATES_2_CTL_T_L1_2_DLY;
>> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_MASK;
>> +		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND;
>> +		value &= ~RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP_MASK;
>> +		value |= RP_L1_PM_SUBSTATES_2_CTL_MICROSECOND_COMP;
>> +		writel(value, port->base + RP_L1_PM_SUBSTATES_2_CTL);
>> +	}
>>   }
>>   /*
>>    * FIXME: If there are no PCIe cards attached, then calling this function
>> @@ -2403,6 +2463,7 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>>   	.program_deskew_time = false,
>>   	.updateFC_threshold = false,
>>   	.has_aspm_l1 = false,
>> +	.has_aspm_l1ss = false,
>>   };
>>   
>>   static const struct tegra_pcie_soc tegra30_pcie = {
>> @@ -2425,6 +2486,7 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>>   	.program_deskew_time = false,
>>   	.updateFC_threshold = false,
>>   	.has_aspm_l1 = true,
>> +	.has_aspm_l1ss = false,
>>   };
>>   
>>   static const struct tegra_pcie_soc tegra124_pcie = {
>> @@ -2446,6 +2508,7 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>>   	.program_deskew_time = false,
>>   	.updateFC_threshold = false,
>>   	.has_aspm_l1 = true,
>> +	.has_aspm_l1ss = false,
>>   };
>>   
>>   static const struct tegra_pcie_soc tegra210_pcie = {
>> @@ -2475,6 +2538,7 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>>   	.program_deskew_time = true,
>>   	.updateFC_threshold = true,
>>   	.has_aspm_l1 = true,
>> +	.has_aspm_l1ss = true,
>>   };
>>   
>>   static const struct tegra_pcie_soc tegra186_pcie = {
>> @@ -2497,6 +2561,7 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>>   	.program_deskew_time = false,
>>   	.updateFC_threshold = false,
>>   	.has_aspm_l1 = true,
>> +	.has_aspm_l1ss = true,
>>   };
>>   
>>   static const struct of_device_id tegra_pcie_of_match[] = {
>> -- 
>> 2.7.4
>>
