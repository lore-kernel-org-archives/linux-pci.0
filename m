Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C2C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B0221741
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 15:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FROUadir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDPPdq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:33:46 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6342 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPPdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 11:33:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb5f5d50000>; Tue, 16 Apr 2019 08:33:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 08:33:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 08:33:44 -0700
Received: from [10.24.45.163] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 15:33:39 +0000
Subject: Re: [PATCH V2 10/16] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-11-git-send-email-vidyas@nvidia.com>
 <20190415150819.GG29254@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <94b4cf4f-8cdd-da29-6661-68ae318b58a3@nvidia.com>
Date:   Tue, 16 Apr 2019 21:03:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415150819.GG29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555428821; bh=RUjBf2nT3aUBUaOQpBt8d/wB4t6UX+/ZlztWHbxa1wA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FROUadirmsCZLl48g8/xulRPIkoOvwm3M+e2uXFedZO4Id8Rec3VR3vXrF7bF1t+e
         Ro2az6Na6zHbYxxTUKFcpyqF7WCEqqmpgeAznOAP/F/Z8Bn0S5ok67usZ8s8ptEMk5
         AiiLz0oUf+Ljb3P4VkjPLbNOSAvkoFE/ArZNyj3VeOwhUVYhS3WniBV/AQvlnQManF
         J11Yk4T0XCyle6zU+P/VCXaVa3N6Zia97k+I0Vo9IZRIxImHCL4kxR515cStqfjGfN
         BC0hK/+CcuSHfrDB6gCgnEK/XuGJN2bPxc+iV4m2Ra7WEheVrCGtvTLITvkBXUz/Rt
         okzoceh/C+vJg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/2019 8:38 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:37AM +0530, Vidya Sagar wrote:
>> Add support for Tegra194 PCIe controllers. These controllers are based
>> on Synopsys DesignWare core IP.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v1]:
>> * Added documentation for 'power-domains' property
>> * Removed 'window1' and 'window2' properties
>> * Removed '_clk' and '_rst' from clock and reset names
>> * Dropped 'pcie' from phy-names
>> * Added entry for BPMP-FW handle
>> * Removed offsets for some of the registers and added them in code and would be pickedup based on
>>    controller ID
>> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an optional
>> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with inverted operation
>> * Added more documentation for 'nvidia,update-fc-fixup' property
>> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
>> * Added '-us' to all properties that represent time in microseconds
>> * Moved P2U documentation to a separate file
>>
>>   .../bindings/pci/nvidia,tegra194-pcie.txt          | 181 +++++++++++++++++++++
>>   1 file changed, 181 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> new file mode 100644
>> index 000000000000..71aa01b6ccf3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -0,0 +1,181 @@
>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>> +- device_type: Must be "pci"
>> +- power-domains: A phandle to the node that controls power to the respective
>> +  PCIe controller and a specifier name for the PCIe controller. Following are
>> +  the specifiers for the different PCIe controllers
>> +  - Controller-0 - TEGRA194_POWER_DOMAIN_PCIEX8B
>> +  - Controller-1 - TEGRA194_POWER_DOMAIN_PCIEX1A
>> +  - Controller-2 - TEGRA194_POWER_DOMAIN_PCIEX1A
>> +  - Controller-3 - TEGRA194_POWER_DOMAIN_PCIEX1A
>> +  - Controller-4 - TEGRA194_POWER_DOMAIN_PCIEX4A
>> +  - Controller-5 - TEGRA194_POWER_DOMAIN_PCIEX8A
> 
> I'm not sure if I missed it, but is there an include file that contains
> definitions for these symbolic names? Might be worth referring to such
> an include from this document.
These are macros for power domains of different PCIe controller. I'll give
the path of header where these macros are defined.

> 
> Also, why do we have two different ways of specifying the controllers?
> Why are they called Controller-* in one place and PCIEX* in another? Can
> we just pick one and stick with it?
Since I've been using C0, C1, C2...Etc, I'll stick to it this format and PCIEX*
is part of macro name and is used only here.

> 
>> +- reg: A list of physical base address and length for each set of controller
>> +  registers. Must contain an entry for each entry in the reg-names property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "config": As per the definition in designware-pcie.txt
>> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             fow SW access.
>> +  "dbi": The aperture where root port's own configuration registers are
>> +         available
>> +- interrupts: A list of interrupt outputs of the controller. Must contain an
>> +  entry for each entry in the interrupt-names property.
>> +- interrupt-names: Must include the following entries:
>> +  "intr": The Tegra interrupt that is asserted for controller interrupts
>> +  "msi": The Tegra interrupt that is asserted when an MSI is received
>> +- bus-range: Range of bus numbers associated with this controller
>> +- #address-cells: Address representation for root ports (must be 3)
>> +  - cell 0 specifies the bus and device numbers of the root port:
>> +    [23:16]: bus number
>> +    [15:11]: device number
>> +  - cell 1 denotes the upper 32 address bits and should be 0
>> +  - cell 2 contains the lower 32 address bits and is used to translate to the
>> +    CPU address space
>> +- #size-cells: Size representation for root ports (must be 2)
>> +- ranges: Describes the translation of addresses for root ports and standard
>> +  PCI regions. The entries must be 7 cells each, where the first three cells
>> +  correspond to the address as described for the #address-cells property
>> +  above, the fourth and fifth cells are for the physical CPU address to
>> +  translate to and the sixth and seventh cells are as described for the
>> +  #size-cells property above.
>> +  - Entries setup the mapping for the standard I/O, memory and
>> +    prefetchable PCI regions. The first cell determines the type of region
>> +    that is setup:
>> +    - 0x81000000: I/O memory region
>> +    - 0x82000000: non-prefetchable memory region
>> +    - 0xc2000000: prefetchable memory region
>> +  Please refer to the standard PCI bus binding document for a more detailed
>> +  explanation.
>> +- #interrupt-cells: Size representation for interrupts (must be 1)
>> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
>> +  Please refer to the standard PCI bus binding document for a more detailed
>> +  explanation.
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +  See ../clocks/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - core
>> +- resets: Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - core_apb
>> +  - core
>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> +- phy-names: Must include an entry for each active lane.
>> +  "p2u-N": where N ranges from 0 to one less than the total number of lanes
>> +- nvidia,bpmp: Must contain a phandle to BPMP controller node.
>> +- nvidia,controller-id : Controller specific ID
>> +      0 - C0
>> +      1 - C1
>> +      2 - C2
>> +      3 - C3
>> +      4 - C4
>> +      5 - C5
> 
> Again, here you use a different name to refer to the controllers than
> before, although it's fairly obvious that these correspond to the
> earlier Controller-*. But best to pick one and stick with it.
> 
> Also, the list for the power-domains property has description - value,
> whereas you have value - description here. Since eventually the device
> tree bindings will be converted to YAML, perhaps stick with:
> 
>      value: description
> 
> To help with a subsequent conversion.
Done.

> 
>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>> +
>> +Optional properties:
>> +- max-link-speed: Limits controllers max speed to this value. For more info,
>> +    please refer to Documentation/devicetree/bindings/pci/pci.txt file.
>> +- nvidia,init-speed: Limits controllers init speed to this value.
>> +    1 - Gen-1 (2. 5 GT/s)
>> +    2 - Gen-2 (5 GT/s)
>> +    3 - Gen-3 (8 GT/s)
>> +    4 - Gen-4 (16 GT/s)
> 
> Please provide a description for when to use this and what the effects
> are. "Limits controller's init speed" doesn't say anything about whether
> the speed can be increased later, or whether it will always stay at this
> speed. Also, does it actually mean "set" the initial speed, or would the
> controller also be able to start out at a lower speed than the one given
> by "nvidia,init-speed"? "Limits" would suggest the latter, but best to
> clarify.
Ok. I'll provide more details in V3 patch series.

> 
>> +- nvidia,disable-aspm-states : Controls advertisement of ASPM states
>> +    bit-0 to '1' : Disables advertisement of ASPM-L0s
>> +    bit-1 to '1' : Disables advertisement of ASPM-L1. This also disables
>> +                   advertisement of ASPM-L1.1 and ASPM-L1.2
>> +    bit-2 to '1' : Disables advertisement of ASPM-L1.1
>> +    bit-3 to '1' : Disables advertisement of ASPM-L1.2
>> +- supports-clkreq : Refer to Documentation/devicetree/bindings/pci/pci.txt
>> +- nvidia,update-fc-fixup : This is a boolean property and needs to be present to
>> +    improve perf when a platform is designed in such a way that it satisfies at
>> +    least one of the following conditions thereby enabling root port to
>> +    exchange optimum number of FC (Flow Control) credits with downstream devices
>> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>> +       a) speed is Gen-2 and MPS is 256B
>> +       b) speed is >= Gen-3 with any MPS
>> +- nvidia,cdm-check : Enables CDM checking. For more information, refer Synopsis
>> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4
>> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.
> 
> If it's a GPIO number it should have a -gpio or -gpios suffix. I think
> -gpios is preferred. Since the parent of the property is already a PEX
> controller, perhaps omit the pex- prefix and just call this:
> 
>      "nvidia,wake-gpios"
> 
> ?Fine. I'll change it to 'nvidia,wake-gpios'.

> 
> Thierry
> 
>> +- "nvidia,aspm-cmrt-us" : Common Mode Restore time for proper operation of ASPM
>> +   to be specified in microseconds
>> +- "nvidia,aspm-pwr-on-t-us" : Power On time for proper operation of ASPM to be
>> +   specified in microseconds
>> +- "nvidia,aspm-l0s-entrance-latency-us" : ASPM L0s entrance latency to be
>> +   specified in microseconds
>> +
>> +Examples:
>> +=========
>> +
>> +Tegra194:
>> +--------
>> +
>> +SoC DTSI:
>> +
>> +	pcie@14180000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
>> +		reg-names = "appl", "config", "atu_dma";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <8>;
>> +		linux,pci-domain = <0>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +		reset-names = "core_apb", "core";
>> +
>> +		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 72 0x04>;
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <0>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000      /* downstream I/O (1MB) */
>> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non-prefetchable memory (30MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
>> +	};
>> +
>> +Board DTS:
>> +
>> +	pcie@14180000 {
>> +		status = "okay";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_2>,
>> +		       <&p2u_3>,
>> +		       <&p2u_4>,
>> +		       <&p2u_5>;
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
>> +	};
>> -- 
>> 2.7.4
>>

