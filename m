Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F7C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 11:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF32320856
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jZd+kei3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfDBLuK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:50:10 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3920 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDBLuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 07:50:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca34c700003>; Tue, 02 Apr 2019 04:50:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 04:50:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 02 Apr 2019 04:50:04 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 11:41:28 +0000
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <tiwai@suse.de>, <spujar@nvidia.com>, <skomatineni@nvidia.com>,
        <liviu.dudau@arm.com>, <krzk@kernel.org>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <olof@lixom.net>,
        <maxime.ripard@bootlin.com>, <andy.gross@linaro.org>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <ezequiel@collabora.com>,
        <stefan.wahren@i2se.com>, <marc.w.gonzalez@free.fr>,
        <l.stach@pengutronix.de>, <tpiepho@impinj.com>,
        <hayashi.kunihiko@socionext.com>, <yue.wang@amlogic.com>,
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <20190328131508.GB5518@ulmo>
 <e5a12742-2dfa-e8c8-2a29-24838f4fa939@nvidia.com>
 <20190401150740.GB4874@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c3190fbe-d197-a810-6bd4-d53c6e375bc5@nvidia.com>
Date:   Tue, 2 Apr 2019 17:11:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401150740.GB4874@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554205808; bh=4N3pEV3ihFuChLkatbO2NiqjHen9o9s5cVnP1VlAwsE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jZd+kei34YmGTsxnY8p9y9jJ0wHouSafD/t2URnuUGWRsDvLKCCpSn/AX3QYK3lyc
         Of9mnXTFbF2Hj9cuUkC9i1XB8DLwENTNrwoP6TJQ8CMd+a5UYlY1yNQayOgmd0QCD6
         HvSdeiRTyL2dW63g8eyqjdQuB8jIhbcUcAefdQRkeTB38Z7DElIcQ28YKUOK9U9cux
         j4o2tzP81aTlCQ6/Ff/zyKFQQK5b7KWZmu2yOYJa87KYcuIQ/Z/AC+2qe2DTkDFmfY
         szvEckbIkO7sEOvc67xwnPi7w+tZxd98UIjNzrwQDZENClsyn4iFXoABdobnse6/yO
         Vaf1CpNosojbQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/1/2019 8:37 PM, Thierry Reding wrote:
> On Mon, Apr 01, 2019 at 03:31:54PM +0530, Vidya Sagar wrote:
>> On 3/28/2019 6:45 PM, Thierry Reding wrote:
>>> On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
>>>> Add support for Tegra194 PCIe controllers. These controllers are based
>>>> on Synopsys DesignWare core IP.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>>    .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++++++++++++++++++
>>>>    .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
>>>>    2 files changed, 243 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>>    create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>> new file mode 100644
>>>> index 000000000000..31527283a0cd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>>> @@ -0,0 +1,209 @@
>>>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>>>> +
>>>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>>>> +and thus inherits all the common properties defined in designware-pcie.txt.
>>>> +
>>>> +Required properties:
>>>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>>>> +- device_type: Must be "pci"
>>>> +- reg: A list of physical base address and length for each set of controller
>>>> +  registers. Must contain an entry for each entry in the reg-names property.
>>>> +- reg-names: Must include the following entries:
>>>> +  "appl": Controller's application logic registers
>>>> +  "window1": This is the aperture of controller available under 4GB boundary
>>>> +             (i.e. within 32-bit space). This aperture is typically used for
>>>> +             accessing config space of root port itself and also the connected
>>>> +             endpoints (by appropriately programming internal Address
>>>> +             Translation Unit's (iATU) out bound region) and also to map
>>>> +             prefetchable/non-prefetchable BARs.
>>>> +  "config": As per the definition in designware-pcie.txt
>>>
>>> I see that you set this to a 256 KiB region for all controllers. Since
>>> each function can have up to 4 KiB of extended configuration space, that
>>> means you have space to address:
>>>
>>>       256 KiB = 4 KiB * 8 functions * 8 devices
>>>
>>> Each bus can have up to 32 devices (including the root port) and there
>>> can be 256 busses, so I wonder how this is supposed to work. How does
>>> the mapping work for configuration space? Does the controller allow
>>> moving this 256 KiB window around so that more devices' configuration
>>> space can be accessed?
>> We are not using ECAM here instead only pick 4KB region from this 256 KB region
>> and program iATU (internal Address Translation Unit) of PCIe with the B:D:F of
>> the configuration space that is of interest to be able to view the respective
>> config space in that 4KB space. It is a hardware requirement to reserve 256KB of
>> space (though we use only 4K to access configuration space of any downstream B:D:F)
> 
> Okay, sounds good. I'm wondering if we should maybe note here that
> window1 needs to be a 256 KiB window if that's what the hardware
> requires.
I'll be removing window1 and window2 as they seem to cause unnecessary confusion

> 
>>>> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Address
>>>> +             Translation Unit) registers of the PCIe core are made available
>>>> +             fow SW access.
>>>> +  "dbi": The aperture where root port's own configuration registers are
>>>> +         available
>>>
>>> This is slightly confusing because you already said in the description
>>> of "window1" that it is used to access the configuration space of the
>>> root port itself.
>>>
>>> Is the root port configuration space available via the regular
>>> configuration space registers?
>> Root port configuration space is hidden by default and 'dbi' property tells us
>> where we would like to *view* it. For this, we use a portion of window-1 aperture
>> and use it as 'dbi' base to *view* the config space of root port.
>> Basically Window-1 and window-2 are the umbrella entries (which I added based on
>> suggestion from Stephen Warren <swarren@nvidia.com> ) to give a complete picture of
>> number of apertures available and what they are used for. The windows 1 & 2 as such
>> are not used by the driver directly.
> 
> So I'm not exactly sure I understand how this works. Does the "dbi"
> entry contain a physical address and size of the aperture that we want
> to map into a subregion of "window-1"? Is this part of a region where
> similar subregions exist for all of the controllers? Could the offset
> into such a region be derived from the controller ID?
DBI region is not available for SW immediately after power on. Address where we would
like to see 'dbi' needs to be programmed in one of the APPL registers. Since window1
is one of the apertures (under 4GB boundary) available for each controller (one window1
aperture per controller), we are reserving some portion of window1 to view DBI registers.
Provided 'window1' is available in DT, 'dbi' can be derived run time also. I added it
explicitly to so give more clarity on where it is being reserved (just like how window2
aperture usage is explicitly mentioned through 'ranges'). If the correct approach
is to have only 'window1' and derive 'dbi' in the code, I'll change it to that way.
Please let me know.

> 
>>>> +  "window2": This is the larger (compared to window1) aperture available above
>>>> +             4GB boundary (i.e. in 64-bit space). This is typically used for
>>>> +             mapping prefetchable/non-prefetchable BARs of endpoints
>>>> +- interrupts: A list of interrupt outputs of the controller. Must contain an
>>>> +  entry for each entry in the interrupt-names property.
>>>> +- interrupt-names: Must include the following entries:
>>>> +  "intr": The Tegra interrupt that is asserted for controller interrupts
>>>> +  "msi": The Tegra interrupt that is asserted when an MSI is received
>>>> +- bus-range: Range of bus numbers associated with this controller
>>>> +- #address-cells: Address representation for root ports (must be 3)
>>>> +  - cell 0 specifies the bus and device numbers of the root port:
>>>> +    [23:16]: bus number
>>>> +    [15:11]: device number
>>>> +  - cell 1 denotes the upper 32 address bits and should be 0
>>>> +  - cell 2 contains the lower 32 address bits and is used to translate to the
>>>> +    CPU address space
>>>> +- #size-cells: Size representation for root ports (must be 2)
>>>> +- ranges: Describes the translation of addresses for root ports and standard
>>>> +  PCI regions. The entries must be 7 cells each, where the first three cells
>>>> +  correspond to the address as described for the #address-cells property
>>>> +  above, the fourth and fifth cells are for the physical CPU address to
>>>> +  translate to and the sixth and seventh cells are as described for the
>>>> +  #size-cells property above.
>>>> +  - Entries setup the mapping for the standard I/O, memory and
>>>> +    prefetchable PCI regions. The first cell determines the type of region
>>>> +    that is setup:
>>>> +    - 0x81000000: I/O memory region
>>>> +    - 0x82000000: non-prefetchable memory region
>>>> +    - 0xc2000000: prefetchable memory region
>>>> +  Please refer to the standard PCI bus binding document for a more detailed
>>>> +  explanation.
>>>> +- #interrupt-cells: Size representation for interrupts (must be 1)
>>>> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>>>> +  Please refer to the standard PCI bus binding document for a more detailed
>>>> +  explanation.
>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>> +  See ../clocks/clock-bindings.txt for details.
>>>> +- clock-names: Must include the following entries:
>>>> +  - core_clk
>>>
>>> It's redundant to name a clock _clk. Is this already required by the
>>> standard Designware bindings or is this new?
>> This is a new entry and not a standard Designware binding. I'll remove _clk
>> from the name in the next patch series.
>>
>>>
>>>> +- resets: Must contain an entry for each entry in reset-names.
>>>> +  See ../reset/reset.txt for details.
>>>> +- reset-names: Must include the following entries:
>>>> +  - core_apb_rst
>>>> +  - core_rst
>>>
>>> Same comment as for clock-names.
>> I'll take of it in the next patch series
>>
>>>
>>>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>>>> +- phy-names: Must include an entry for each active lane.
>>>> +  "pcie-p2u-N": where N ranges from 0 to one less than the total number of lanes
>>>
>>> I'd leave away the "pcie-" prefix since the surrounding context already
>>> makes it clear that this is for PCIe.
>> I'll take of it in the next patch series
>>
>>>
>>>> +- Controller dependent register offsets
>>>> +  - nvidia,event-cntr-ctrl: EVENT_COUNTER_CONTROL reg offset
>>>> +      0x168 - FPGA
>>>> +      0x1a8 - C1, C2 and C3
>>>> +      0x1c4 - C4
>>>> +      0x1d8 - C0 and C5
>>>> +  - nvidia,event-cntr-data: EVENT_COUNTER_DATA reg offset
>>>> +      0x16c - FPGA
>>>> +      0x1ac - C1, C2 and C3
>>>> +      0x1c8 - C4
>>>> +      0x1dc - C0 and C5
>>>> +- nvidia,controller-id : Controller specific ID
>>>> +      0x0 - C0
>>>> +      0x1 - C1
>>>> +      0x2 - C2
>>>> +      0x3 - C3
>>>> +      0x4 - C4
>>>> +      0x5 - C5
>>>
>>> It's redundant to have both a controller ID and parameterized register
>>> offsets based on that controller ID. I would recommend keeping the
>>> controller ID and then moving the register offsets to the driver and
>>> decide based on the controller ID.
>> Ok. I'll take of it in the next patch series
>>
>>>
>>>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>>>> +
>>>> +Optional properties:
>>>> +- nvidia,max-speed: limits controllers max speed to this value.
>>>> +    1 - Gen-1 (2.5 GT/s)
>>>> +    2 - Gen-2 (5 GT/s)
>>>> +    3 - Gen-3 (8 GT/s)
>>>> +    4 - Gen-4 (16 GT/s)
>>>> +- nvidia,init-speed: limits controllers init speed to this value.
>>>> +    1 - Gen-1 (2. 5 GT/s)
>>>> +    2 - Gen-2 (5 GT/s)
>>>> +    3 - Gen-3 (8 GT/s)
>>>> +    4 - Gen-4 (16 GT/s)
>>>> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
>>>> +    bit-0 to '1' : disables advertisement of ASPM-L0s
>>>> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
>>>> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
>>>> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
>>>> +    bit-3 to '1' : disables advertisement of ASPM-L1.2
>>>
>>> These seem more like configuration options rather than hardware
>>> description.
>> Yes. Since the platforms like Jetson-Xavier based on T194 are going to go in
>> open market, we are providing these configuration options and hence they are
>> optional
> 
> Under what circumstances would we want to disable certain ASPM states?
> My understanding is that PCI device drivers can already disable
> individual ASPM states if they don't support them, so why would we ever
> want to disable advertisement of certain ASPM states?
Well, this is given to give more flexibility while debugging and given that there is going
to be only one config for different platforms in future, it may be possible to have ASPM
config enabled by default and having this DT option would give more controlled enablement
of ASPM states by controlling the advertisement of ASPM states by root port.
  
> 
>>>> +- nvidia,disable-clock-request : gives a hint to driver that there is no
>>>> +    CLKREQ signal routing on board
> 
> Sounds like this could be useful for designs other than Tegra, so maybe
> remove the "nvidia," prefix? The name also doesn't match the description
> very well. "disable" kind of implies that we want to disable this
> feature despite it being available. However, what we really want to
> express here is that there's no CLKREQ signal on a design at all. So
> perhaps it would be better to invert this and add a property named
> "supports-clock-request" on boards where we have a CLKREQ signal.
Done. I'll add this to pci.txt documentation.

> 
>>>> +- nvidia,update-fc-fixup : needs it to improve perf when a platform is designed
>>>> +    in such a way that it satisfies at least one of the following conditions
>>>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>>>> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>>>> +       a) speed is Gen-2 and MPS is 256B
>>>> +       b) speed is >= Gen-3 with any MPS
>>>
>>> If we know these conditions, can we not determine that the fixup is
>>> needed at runtime?
>> Not really. The programming that should take place based on these flags need to
>> happen before PCIe link up and if we were to find them during run time, we can do
>> that only after the link is up. So, to avoid this chicken and egg situation, these
>> are passed as DT options
> 
> Might be worth explaining what FC is in this context. Also, perhaps
> explain how and why setting this would improve performance. You're also
> not explicit here what the type of the property is. From the context it
> sounds like it's just a boolean, but you may want to spell that out.
Done.

> 
>>>> +- nvidia,cdm-check : Enables CDM checking. For more information, refer Synopsis
>>>> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4
> 
> If this is documented in the DesignWare documentation, why not make this
> a generic property that applies to all DesignWare instantiations? Might
> also be worth giving a one or two sentence description of what this is
> so that people don't have to go look at the databook.
Done.

> 
>>> Why should this be configurable through device tree?
>> This is a hardware feature for safety and can be enabled if required. So, I made it
>> as an optional feature that can be controlled through DT.
>>
>>>
>>>> +- nvidia,enable-power-down : Enables power down of respective controller and
>>>> +    corresponding PLLs if they are not shared by any other entity
>>>
>>> Wouldn't we want this to be the default? Why keep things powered up if
>>> they are not needed?
>> There could be platforms (automotive based), where it is not required to power down
>> controllers and hence needed a flag to control powering down of controllers
> 
> Is it harmful to power down the controllers on such platforms? It
> strikes me as odd to leave something enabled if it isn't needed,
> independent of the platform.
It is not harmful as such. This is just a flexibility. Also, this might be required for
hot-plug feature.
Are you saying that we should have controller getting powered down as default and a flag
to stop that happening? i.e. something like 'nvidia,disable-power-down' ?

> 
>>>> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.
>>>> +- "nvidia,plat-gpios" : Add gpio number that needs to be configured before
>>>> +   system goes for enumeration. There could be platforms where enabling 3.3V and
>>>> +   12V power supplies are done through GPIOs, in which case, list of all such
>>>> +   GPIOs can be specified through this property.
>>>
>>> For power supplies we usually use the regulator bindings. Are there any
>>> other cases where we'd need this?
>> Enabling power supplies is just one example, but there could be platforms where
>> programming of some GPIOs should happen (to configure muxes properly on PCB etc...)
>> before going for enumeration. All such GPIOs can be passed through this DT option.
> 
> As explained in the other subthread, I think it's better to model these
> properly to make sure we have the flexibility that we need. One mux may
> be controlled by a GPIO, another may be connected to I2C.
Done. I'll take care of this in the next patch series.

> 
>>>> +- "nvidia,aspm-cmrt" : Common Mode Restore time for proper operation of ASPM to
>>>> +   be specified in microseconds
>>>> +- "nvidia,aspm-pwr-on-t" : Power On time for proper operation of ASPM to be
>>>> +   specified in microseconds
>>>> +- "nvidia,aspm-l0s-entrance-latency" : ASPM L0s entrance latency to be specified
>>>> +   in microseconds
>>>> +
>>>> +Examples:
>>>> +=========
>>>> +
>>>> +Tegra194:
>>>> +--------
>>>> +
>>>> +SoC DTSI:
>>>> +
>>>> +	pcie@14180000 {
>>>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>>>
>>> It doesn't seem to me like claiming compatibility with "snps,dw-pcie" is
>>> correct. There's a bunch of NVIDIA- or Tegra-specific properties below
>>> and code in the driver. Would this device be able to function if no
>>> driver was binding against the "nvidia,tegra194-pcie" compatible string?
>>> Would it work if you left that out? I don't think so, so we should also
>>> not list it here.
>> It is required for designware specific code to work properly. It is specified
>> by ../designware-pcie.txt file
> 
> That sounds like a bug to me. Why does the driver need that? I mean the
> Tegra instantiation clearly isn't going to work if the driver matches on
> that compatible string, so by definition it is not compatible.
> 
> Rob, was this intentional? Seems like all other users of the DesignWare
> PCIe core use the same scheme, so perhaps I'm missing something?
This is the standard usage procedure across all Designware based implementations.
Probably Rob can give more info on this.

> 
>>>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>>>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>>>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>>>> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>>>> +		reg-names = "appl", "config", "atu_dma";
>>>> +
>>>> +		status = "disabled";
>>>> +
>>>> +		#address-cells = <3>;
>>>> +		#size-cells = <2>;
>>>> +		device_type = "pci";
>>>> +		num-lanes = <8>;
>>>> +		linux,pci-domain = <0>;
>>>> +
>>>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>>>> +		clock-names = "core_clk";
>>>> +
>>>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>>>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>>>> +		reset-names = "core_apb_rst", "core_rst";
>>>> +
>>>> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>>>> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>>>> +		interrupt-names = "intr", "msi";
>>>> +
>>>> +		#interrupt-cells = <1>;
>>>> +		interrupt-map-mask = <0 0 0 0>;
>>>> +		interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
>>>> +
>>>> +		nvidia,bpmp = <&bpmp>;
>>>> +
>>>> +		nvidia,max-speed = <4>;
>>>> +		nvidia,disable-aspm-states = <0xf>;
>>>> +		nvidia,controller-id = <&bpmp 0x0>;
>>>
>>> Why is there a reference to the BPMP in this propert?
>> Ultimately Controller-ID is passed to BPMP-FW and a BPMP handle is required for that
>> which gets derived from this BPMP phandle.
> 
> The binding doesn't say that the nvidia,controller-id is a (phandle, ID)
> pair. Also, you already have the nvidia,bpmp property that contains the
> phandle, although you don't describe that property in the binding above.
> I think you need to either get rid of the nvidia,bpmp property or drop
> the &bpmp phandle from the nvidia,controller-id property.
> 
> My preference is the latter because the controller ID is really
> independent of the BPMP firmware, even if it may be used as part of a
> call to the BPMP firmware.
Done. I'll drop phandle from controller-id property.

> 
>>>> +		nvidia,aux-clk-freq = <0x13>;
>>>> +		nvidia,preset-init = <0x5>;
>>>
>>> aux-clk-freq and preset-init are not defined in the binding above.
>> Ok. I'll take of it in the next patch series
>>
>>>
>>>> +		nvidia,aspm-cmrt = <0x3C>;
>>>> +		nvidia,aspm-pwr-on-t = <0x14>;
>>>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>>>
>>> These should be in decimal notation to make them easier to deal with. I
>>> don't usually read time in hexadecimal.
>> Ok. I'll take of it in the next patch series
>>
>>>
>>>> +
>>>> +		bus-range = <0x0 0xff>;
>>>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000      /* downstream I/O (1MB) */
>>>> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non-prefetchable memory (30MB) */
>>>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>>>> +
>>>> +		nvidia,cfg-link-cap-l1sub = <0x1c4>;
>>>> +		nvidia,cap-pl16g-status = <0x174>;
>>>> +		nvidia,cap-pl16g-cap-off = <0x188>;
>>>> +		nvidia,event-cntr-ctrl = <0x1d8>;
>>>> +		nvidia,event-cntr-data = <0x1dc>;
>>>> +		nvidia,dl-feature-cap = <0x30c>;
>>>
>>> These are not defined in the binding above.
>> Ok. I'll take of it in the next patch series
>>
>>>
>>>> +	};
>>>> +
>>>> +Board DTS:
>>>> +
>>>> +	pcie@14180000 {
>>>> +		status = "okay";
>>>> +
>>>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>>>> +
>>>> +		phys = <&p2u_2>,
>>>> +		       <&p2u_3>,
>>>> +		       <&p2u_4>,
>>>> +		       <&p2u_5>;
>>>> +		phy-names = "pcie-p2u-0", "pcie-p2u-1", "pcie-p2u-2",
>>>> +			    "pcie-p2u-3";
>>>> +	};
>>>> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>>
>>> Might be better to split this into a separate patch.
>> Done.
>>
>>>
>>>> new file mode 100644
>>>> index 000000000000..cc0de8e8e8db
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>>> @@ -0,0 +1,34 @@
>>>> +NVIDIA Tegra194 P2U binding
>>>> +
>>>> +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
>>>> +Speed) each interfacing with 12 and 8 P2U instances respectively.
>>>> +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
>>>> +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
>>>> +lane.
>>>> +
>>>> +Required properties:
>>>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-phy-p2u".
>>>
>>> Isn't the "phy-" implied by "p2u"? The name of the hardware block is
>>> "Tegra194 P2U", so that "phy-" seems gratuitous to me.
>> Done.
>>
>>>
>>>> +- reg: Should be the physical address space and length of respective each P2U
>>>> +       instance.
>>>> +- reg-names: Must include the entry "base".
>>>
>>> "base" is a bad name. Each of these entries will be a "base" of the
>>> given region. The name should specify what region it is the base of.
>> I'll change it to "reg_base"
> 
> Each of these entries will contain a "base" address for "registers" of
> some sort. I'm thinking more along the lines of "ctl" if they are
> control registers for the P2U, or perhaps just "p2u" if there is no
> better name.
Done. I'll go with 'ctl'.

> 
> Thierry
> 
>>>> +Required properties for PHY port node:
>>>> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
>>>> +
>>>> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
>>>> +
>>>> +Example:
>>>> +
>>>> +hsio-p2u {
>>>> +	compatible = "simple-bus";
>>>> +	#address-cells = <2>;
>>>> +	#size-cells = <2>;
>>>> +	ranges;
>>>> +	p2u_0: p2u@03e10000 {
>>>> +		compatible = "nvidia,tegra194-phy-p2u";
>>>> +		reg = <0x0 0x03e10000 0x0 0x00010000>;
>>>> +		reg-names = "base";
>>>> +
>>>> +		#phy-cells = <0>;
>>>> +	};
>>>> +}
>>>> -- 
>>>> 2.7.4
>>

