Return-Path: <SRS0=q+5X=Y2=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=q+5X=Y2=rock-chips.com=shawn.lin@kernel.org>
Subject: Re: [PATCH v2] PCI: rockchip: Add quirk to disable RC's ASPM L0s
To: Bjorn Helgaas <helgaas@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <1481543487-33152-1-git-send-email-shawn.lin@rock-chips.com>
 <20170111182822.GC14532@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Wenrui Li <wenrui.li@rock-chips.com>, Brian Norris
 <briannorris@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 devicetree@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e6968068-ba74-5073-e4ca-9eb81a7c1f47@rock-chips.com>
Date: Thu, 12 Jan 2017 09:44:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170111182822.GC14532@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 2017/1/12 2:28, Bjorn Helgaas wrote:
> On Mon, Dec 12, 2016 at 07:51:27PM +0800, Shawn Lin wrote:
>> Rockchip's RC outputs 100MHz reference clock but there are
>> two methods for PHY to generate it.
>>
>> (1)One of them is to use system PLL to generate 100MHz clock and
>> the PHY will relock it and filter signal noise then outputs the
>> reference clock.
>>
>> (2)Another way is to share Soc's 24MHZ crystal oscillator with
>> PHY and force PHY's DLL to generate 100MHz internally.
>>
>> When using case(2), the exit from L0s doesn't work fine occasionally
>> due to the broken design of RC receiver's logical circuit. So even if
>> we use extended-synch, it still fails for PHY to relock the bits from
>> FTS sometimes. This will hang the system.
>>
>> Maybe we could argue that why not use case(1) to avoid it? The reason
>> is that as we could see the reference clock is derived from system PLL
>> and the path from it to PHY isn't so clean which means there are some
>> noise introduced by power-domain and other buses can't be filterd out
>> by PHY and we could see noise from the frequency spectrum by
>> oscilloscope. This makes the TX compatibility test a little difficult
>> to pass the spec. So case(1) and case(2) are both used indeed now. If
>> using case(2), we should disable RC's L0s support, and that is why we
>> need this property to indicate this quirk.
>>
>> Also after checking quirk.c, I noticed there is already a quirk for
>> disabling L0s unconditionally, quirk_disable_aspm_l0s. But obviously we
>> shouldn't do that as mentioned above that case(1) could still works fine
>> with L0s.
>>
>> Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - drop the quirk prefix
>>
>>  Documentation/devicetree/bindings/pci/rockchip-pcie.txt | 2 ++
>>  drivers/pci/host/pcie-rockchip.c                        | 9 +++++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> index 71aeda1..1453a73 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> @@ -43,6 +43,8 @@ Required properties:
>>  - interrupt-map-mask and interrupt-map: standard PCI properties
>>
>>  Optional Property:
>> +- aspm-no-l0s: RC won't support ASPM L0s. This property is needed if
>> +	using 24MHz OSC for RC's PHY.
>>  - ep-gpios: contain the entry for pre-reset gpio
>>  - num-lanes: number of lanes to use
>>  - vpcie3v3-supply: The phandle to the 3.3v regulator to use for PCIe.
>> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
>> index f2dca7b..35988fc 100644
>> --- a/drivers/pci/host/pcie-rockchip.c
>> +++ b/drivers/pci/host/pcie-rockchip.c
>> @@ -140,6 +140,8 @@
>>  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
>>  #define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
>>  #define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
>> +#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
>> +#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
>>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
>>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>> @@ -653,6 +655,13 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>>  	status &= ~PCIE_RC_CONFIG_THP_CAP_NEXT_MASK;
>>  	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_THP_CAP);
>>
>> +	/* Clear L0s from RC's link cap */
>> +	if (of_property_read_bool(dev->of_node, "apsm-no-l0s")) {
>
> Did you test this?  This string ("apsm-no-l0s") doesn't match the
> "aspm-no-l0s" documented above.  The current tree doesn't contain either
> string in any DTS.
>

oops, mea culpa. I think I wrote this and tested it on the kernel4.4
chromeOS tree. There were some non-upstream patches there so I slightly
amend it when rebasing on your next branch, I guess I made the mistake
then.

I will fix this.

>> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
>> +		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
>> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
>> +	}
>> +
>>  	rockchip_pcie_write(rockchip, 0x0, PCIE_RC_BAR_CONF);
>>
>>  	rockchip_pcie_write(rockchip,
>> --
>> 1.9.1
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin
