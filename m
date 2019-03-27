Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41322C4360F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0597B208E4
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 10:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oNhtMDlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbfC0Kxi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:53:38 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8712 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0Kxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 06:53:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b562a0001>; Wed, 27 Mar 2019 03:53:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 03:53:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Mar 2019 03:53:36 -0700
Received: from [10.24.47.154] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 10:53:23 +0000
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
To:     Jon Hunter <jonathanh@nvidia.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <kishon@ti.com>,
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
        <shawn.lin@rock-chips.com>, <xiaowei.bao@nxp.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
 <b8a7db52-0bc6-2d9d-dd50-7b041f2bf56d@nvidia.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <43f1a198-fc1f-91ec-0fbb-6aff4d35eeb2@nvidia.com>
Date:   Wed, 27 Mar 2019 16:23:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b8a7db52-0bc6-2d9d-dd50-7b041f2bf56d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553684011; bh=oqciHL8sB6iHSD7RDKxAcC79ZowKrMqdjfD2j9KBmZA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=oNhtMDlKsHSfk2KYbHWJ04IAbUcvpV0xK/fCDwhGFF4zq8vxcrgO0m7lFJGiwe5+F
         QElhjeGQXBvleG59vte3WpwFKv76GWotrlOilemwjxHC3LpiAmWguxoCOnPFxmcRib
         At+/SOn87s1AyhgqwYqaKLH076XmZvyBKtrGzBDLhbBVzOnokRjAGEIgdBKYqpngIB
         bxfbLUB5tZP0zAkahYcFAUQ8OIoFHgGyH9Ear8uYUq9HNkq+w5S5PHfuXLjQTGcbx3
         0fQkreMdpwhFvWesAjULsO3A0HHWMLV+u6dP4BBi9PZr56r70MWwTivKCwiWuFlhLq
         1zy6Q/a6Yp2Ug==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/27/2019 3:40 PM, Jon Hunter wrote:
> 
> On 26/03/2019 15:13, Vidya Sagar wrote:
>> Add support for Tegra194 PCIe controllers. These controllers are based
>> on Synopsys DesignWare core IP.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++++++++++++++++++
>>   .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
>>   2 files changed, 243 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>>   create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> new file mode 100644
>> index 000000000000..31527283a0cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>> @@ -0,0 +1,209 @@
>> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>> +- device_type: Must be "pci"
>> +- reg: A list of physical base address and length for each set of controller
>> +  registers. Must contain an entry for each entry in the reg-names property.
>> +- reg-names: Must include the following entries:
>> +  "appl": Controller's application logic registers
>> +  "window1": This is the aperture of controller available under 4GB boundary
>> +             (i.e. within 32-bit space). This aperture is typically used for
>> +             accessing config space of root port itself and also the connected
>> +             endpoints (by appropriately programming internal Address
>> +             Translation Unit's (iATU) out bound region) and also to map
>> +             prefetchable/non-prefetchable BARs.
>> +  "config": As per the definition in designware-pcie.txt
>> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Address
>> +             Translation Unit) registers of the PCIe core are made available
>> +             fow SW access.
>> +  "dbi": The aperture where root port's own configuration registers are
>> +         available
>> +  "window2": This is the larger (compared to window1) aperture available above
>> +             4GB boundary (i.e. in 64-bit space). This is typically used for
>> +             mapping prefetchable/non-prefetchable BARs of endpoints
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
>> +  - core_clk
>> +- resets: Must contain an entry for each entry in reset-names.
>> +  See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - core_apb_rst
>> +  - core_rst
>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
>> +- phy-names: Must include an entry for each active lane.
>> +  "pcie-p2u-N": where N ranges from 0 to one less than the total number of lanes
>> +- Controller dependent register offsets
>> +  - nvidia,event-cntr-ctrl: EVENT_COUNTER_CONTROL reg offset
>> +      0x168 - FPGA
>> +      0x1a8 - C1, C2 and C3
>> +      0x1c4 - C4
>> +      0x1d8 - C0 and C5
>> +  - nvidia,event-cntr-data: EVENT_COUNTER_DATA reg offset
>> +      0x16c - FPGA
>> +      0x1ac - C1, C2 and C3
>> +      0x1c8 - C4
>> +      0x1dc - C0 and C5
>> +- nvidia,controller-id : Controller specific ID
>> +      0x0 - C0
>> +      0x1 - C1
>> +      0x2 - C2
>> +      0x3 - C3
>> +      0x4 - C4
>> +      0x5 - C5
>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> 
> I don't see any power-domains listed here. We should have these for T194
> right?
Thanks for catching this.
Yes. PCIe uses power-domains and I'll add that in the future patch.

> 
> Cheers
> Jon
> 

