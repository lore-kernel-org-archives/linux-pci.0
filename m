Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53769C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126EB2084C
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P3NFcLsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDBJRf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:17:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12933 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfDBJRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2019 05:17:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca3287d0000>; Tue, 02 Apr 2019 02:16:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 02:16:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 02:16:42 -0700
Received: from [10.24.47.153] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 09:16:30 +0000
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     <bhelgaas@google.com>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>, <tiwai@suse.de>, <spujar@nvidia.com>,
        <skomatineni@nvidia.com>, <liviu.dudau@arm.com>, <krzk@kernel.org>,
        <heiko@sntech.de>, <horms+renesas@verge.net.au>, <olof@lixom.net>,
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
 <5ca06149.1c69fb81.720fd.79e1@mx.google.com>
 <5ef50168-2476-1088-7156-8a4488d7a2e1@nvidia.com>
 <20190401143138.GA4874@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <67f9b726-c075-0291-7777-8f10ecc9e29d@nvidia.com>
Date:   Tue, 2 Apr 2019 14:46:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401143138.GA4874@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554196606; bh=qpB2HpWh9Rh9N17jpHX8wd0qoQBh0ZVFbnm2lss8LTA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=P3NFcLspu7AcAO18Y9lgs4CgJZ+P57rRdNYMuan+esqp7vB/N6manFQEWtHfHacyj
         K34l6D1t8v26bN1ZshrxS5zFGIo7KXAxe5tI0JXhkkU88AUwVp6M5ot8dkQr8lShZk
         ZDJHhGI8efEAF8fcv9y/Ja5/HtDw12MxqS5X9Utnsmimmh2mI5y0Dm73aND22b9lz2
         FAuZMg4xovpM+GLj0q9bitLRc0DWQ2B2emllXpXIhO+tHyhFJEMujPK5iMadryowqJ
         68ae9/hWU5l5aGOBu8RzDIvCYLa1acayQ9S9CYfgYDjbWsM5TWBMiPbo95ksrJ4TsD
         lKBR5rAjaA6PA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/1/2019 8:01 PM, Thierry Reding wrote:
> On Mon, Apr 01, 2019 at 04:48:42PM +0530, Vidya Sagar wrote:
>> On 3/31/2019 12:12 PM, Rob Herring wrote:
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
>>>
>>> This is usually represented in 'ranges' for BARs.
>> I added window1 and window2 as the umbrella apertures that each PCIe controller has
>> and gave a description of how each aperture *can* be used. This is an overview and as
>> such these two entries are not directly used by the driver.
>> 'ranges' property gives us the information as to how exactly are window1 and window2
>> apertures used.
>> Thierry Reding also gave few comments about these entries. If this is confusing,
>> I'm ok to remove them as well. Please let me know.
> 
> If all you want to do is document how these are used, it may be better
> to enhance the device tree bindings for the ranges property if it does
> not describe this fully enough yet, or add comments in the DT nodes to
> clarify.
It looks like having window1 and window2 is causing confusion here. I'll remove
them in my next patch.

> 
>>>> +  "config": As per the definition in designware-pcie.txt
>>>> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Address
>>>> +             Translation Unit) registers of the PCIe core are made available
>>>> +             fow SW access.
>>>> +  "dbi": The aperture where root port's own configuration registers are
>>>> +         available
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
>>>> +- resets: Must contain an entry for each entry in reset-names.
>>>> +  See ../reset/reset.txt for details.
>>>> +- reset-names: Must include the following entries:
>>>> +  - core_apb_rst
>>>> +  - core_rst
>>>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>>>> +- phy-names: Must include an entry for each active lane.
>>>> +  "pcie-p2u-N": where N ranges from 0 to one less than the total number of lanes
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
>>>
>>> Don't we have standard speed properties?
>> Not that I'm aware of. If you come across any, please do let me know and
>> I'll change these.
> 
> See Documentation/devicetree/bindings/pci/pci.txt, max-link-speed.
> There's a standard of_pci_get_max_link_speed() property that reads it
> from device tree.
Thanks for the pointer. I'll switch to this in the next patch.

> 
>>> Why do we need 2 values?
>> max-speed configures the controller to advertise the speed mentioned through
>> this flag, whereas, init-speed gets the link up at this speed and software
>> can further take the link speed to a different speed by retraining the link.
>> This is to give flexibility to developers depending on the platform.
> 
> This seems to me like overcomplicating things. Couldn't we do something
> like start in the slowest mode by default and then upgrade if endpoints
> support higher speeds?
> 
> I'm assuming that the maximum speed is already fixed by the IP hardware
> instantiation, so why would we want to limit it additionally? Similarly,
> what's the use-case for setting the initial link speed to something
> other than the lowest speed?
You are right that maximum speed supported by hardware is fixed and through
max-link-speed DT option, flexibility is given to limit it to the desired speed
for a controller on a given platform. As mentioned in the documentation for max-link-speed,
this is a strategy to avoid unnecessary operation for unsupported link speed.
There is no real use-case as such even for setting the initial link speed, but it is
there to give flexibility (for any debugging) to get the link up at a certain speed
and then take it to a higher speed at a later point of time. Please note that, hardware
as such already has the capability to take the link to maximum speed agreed by both
upstream and downstream ports. 'nvidia,init-speed' is only to give more flexibility
while debugging. I'm OK to remove it if this is not adding much value here.

> 
>>>> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
>>>> +    bit-0 to '1' : disables advertisement of ASPM-L0s
>>>> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
>>>> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
>>>> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
>>>> +    bit-3 to '1' : disables advertisement of ASPM-L1.2
>>>
>>> Seems like these too should be common.
>> This flag controls the advertisement of different ASPM states by root port.
>> Again, I'm not aware of any common method for this.
> 
> rockchip-pcie-host.txt documents an "aspm-no-l0s" property that prevents
> the root complex from advertising L0s. Sounds like maybe following a
> similar scheme would be best for consistency. I think we'll also want
> these to be non-NVIDIA specific, so drop the "nvidia," prefix and maybe
> document them in pci.txt so that they can be more broadly used.
Since we have ASPM-L0s, L1, L1.1 and L1.2 states, I prefer to have just one entry
with different bit positions indicating which particular state should not be
advertised by root port. Do you see any particular advantage to have 4 different options?
If having one options is fine, I'll remove "nvidia," and document it in pci.txt.

> 
>>>> +- nvidia,disable-clock-request : gives a hint to driver that there is no
>>>> +    CLKREQ signal routing on board
>>>> +- nvidia,update-fc-fixup : needs it to improve perf when a platform is designed
>>>> +    in such a way that it satisfies at least one of the following conditions
>>>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>>>> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>>>
>>> What is Cx?
>> Cx is the Controller with its ID.
>>
>>>
>>>> +       a) speed is Gen-2 and MPS is 256B
>>>> +       b) speed is >= Gen-3 with any MPS
>>>> +- nvidia,cdm-check : Enables CDM checking. For more information, refer Synopsis
>>>> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4
>>>> +- nvidia,enable-power-down : Enables power down of respective controller and
>>>> +    corresponding PLLs if they are not shared by any other entity
>>>> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.
>>>> +- "nvidia,plat-gpios" : Add gpio number that needs to be configured before
>>>> +   system goes for enumeration. There could be platforms where enabling 3.3V and
>>>> +   12V power supplies are done through GPIOs, in which case, list of all such
>>>> +   GPIOs can be specified through this property.
>>>
>>> These should be split out to their specific function.
>> Enabling Power rails is just an example and depending on the platform, there could be
>> some on-board muxes which are controlled through GPIOs and all such platform specific
>> configuration can be handled through this flag.
> 
> Doing this via a "generic" GPIO binding is bound to break at some point.
> What if at some point one of those muxes needs additional power, perhaps
> controlled through an I2C regulator? Or if the mux requires multiple
> GPIOs for the correct configuration? How do you allow the mux to be
> reconfigured to one of the other options?
> 
> If all you have is a generic GPIO consumer of GPIOs there's not enough
> context for the driver to do anything with these GPIOs other than
> perhaps setting them to a specific value at probe time. In that case you
> could achieve the same thing using a gpio-hog.
> 
> I think we need to identify what the various uses for these can be and
> then find the right bindings (or come up with new ones) to properly
> describe the actual hardware. Otherwise we're going to paint ourselves
> into a corner.
> 
> Are there any use-cases besides regulators and muxes? For regulators we
> already have fixed and GPIO regulators, and for muxes there are a number
> of bindings defined in Documentation/devicetree/bindings/mux.
We don't have any other use cases apart from regulator and muxes and I agree with
your comment that we should use regulator/mux frameworks than this generic GPIO
configuration. I'll make changes for this in the next patch series.

> 
> Thierry
> 

