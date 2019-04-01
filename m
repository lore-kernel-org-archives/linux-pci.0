Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C37FC43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 12:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3418220883
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 12:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Buags0p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfDAMhw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:37:52 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15205 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 08:37:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca206120000>; Mon, 01 Apr 2019 05:37:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 05:37:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Apr 2019 05:37:47 -0700
Received: from [192.168.1.18] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 12:37:36 +0000
Subject: Re: [PATCH 06/10] arm64: tegra: Add P2U and PCIe controller nodes to
 Tegra194 DT
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
 <1553613207-3988-7-git-send-email-vidyas@nvidia.com>
 <20190328165905.GB31762@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <c5074b21-5425-6f21-4e17-a0117f91711d@nvidia.com>
Date:   Mon, 1 Apr 2019 18:07:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328165905.GB31762@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554122258; bh=zDy/hVQ7fkey1yo1JpVfQbGzBModYR0iGCoDFeQ10Rw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Buags0p9rzw/TZz2n3ixMekmGoyLnlaf79nNWHDh+8x2MWGK7iopaDtPLVW9zaEHi
         LWYq86Sf9yz13orRBPHb+i2NuJGVe9OJuIUjNiUeNp7DDszz33b9Htse9xNvZSH+kG
         fJeeIFgoG95uwQJG4ydnVd5gvgbIiiYItwqEPTEj1KxmIUEOe96/ob2MhZQu/5eRKf
         Em5foI3I9JypldSOzyhkoSXSIOoIqwf6OnBKcPvAXS6PwDeZORoHsgXVT8/isrw6zw
         23oS0Jbotyqg7j8YfThlsBD0YDxG/LaAfvUEFwqMRg/SE/yxg9GdC9szd1FzbqwDju
         UF4xG/+o29rFQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/28/2019 10:29 PM, Thierry Reding wrote:
> On Tue, Mar 26, 2019 at 08:43:23PM +0530, Vidya Sagar wrote:
>> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
>> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
>> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
>> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 473 +++++++++++++++++++++++++++++++
>>   1 file changed, 473 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index c77ca211fa8f..266a3058fa66 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -1054,4 +1054,477 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent = <&gic>;
>>   	};
>> +
>> +	hsio-p2u {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> 
> It doesn't look to me like there's really a bus here. Perhaps just leave
> out that top-level hsio-p2u node? If you only want to somehow organize
> these, perhaps a better way would be to add a comment.
Yes. 'hsio-p2u' and 'nvhs-p2u' are not real buses as such. I'll drop both
hsio-p2u and nvhs-p2u nodes and give comments to indicate which P2U brick
a particular P2U block falls in.

> 
> Or: the address map lists something called PIPE2UPHY_XBAR at addresses
> 0x03e00000-0x03e0ffff. Perhaps that really ought to be the "bus" in this
> case?
Not really. That is different.

> 
> Also, please leave a blank linke between the properties and the nodes
> for readability.
> 
>> +		p2u_0: p2u@03e10000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e10000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_1: p2u@03e20000 {
> 
> Please leave blank lines between nodes for readability.
Done.

> 
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e20000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_2: p2u@03e30000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e30000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_3: p2u@03e40000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e40000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_4: p2u@03e50000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e50000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_5: p2u@03e60000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e60000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_6: p2u@03e70000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e70000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_7: p2u@03e80000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e80000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_8: p2u@03e90000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03e90000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_9: p2u@03ea0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03ea0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_10: p2u@03f30000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03f30000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_11: p2u@03f40000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03f40000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +	};
>> +
>> +	nvhs-p2u {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +		p2u_12: p2u@03eb0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03eb0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_13: p2u@03ec0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03ec0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_14: p2u@03ed0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03ed0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_15: p2u@03ee0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03ee0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_16: p2u@03ef0000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03ef0000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_17: p2u@03f00000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03f00000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_18: p2u@03f10000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03f10000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +		p2u_19: p2u@03f20000 {
>> +			compatible = "nvidia,tegra194-phy-p2u";
>> +			reg = <0x0 0x03f20000 0x0 0x00010000>;
>> +			reg-names = "base";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +	};
> 
> It's not clear to me why NVHS PHYs are listed as a separate bus. Also,
> these really should be sorted by unit-address. If that means that HSIO
> and NVHS PHYs are mixed, so be it. We can use comments to highlight
> which PHYs are of which type. Or perhaps we really should be using
> different compatible strings for them?
I listed NVHS P2Us separately just to distinguish them from HSIO P2Us.
As part of addressing your above comment, I'm going to remove 'hsio-p2u'
and 'nvhs-p2u' nodes and list all P2Us as per their unit address order.

> 
> Same comments on the below as for the bindings earlier.
> 
> Thierry
> 
>> +
>> +	pcie@14180000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x38000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x38080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x18 0x00000000 0x4 0x00000000>; /* window2 (16G)              */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <8>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <0>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
>> +		clock-names = "core_clk";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
>> +		reset-names = "core_apb_rst", "core_rst";
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
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x0>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1d8>;
>> +		nvidia,event-cntr-data = <0x1dc>;
>> +	};
>> +
>> +	pcie@14100000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x30000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x30080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x12 0x00000000 0x0 0x40000000>; /* window2 (1G)               */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <1>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <1>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
>> +		clock-names = "core_clk";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
>> +		reset-names = "core_apb_rst", "core_rst";
>> +
>> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 45 0x04>;
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x1>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1a8>;
>> +		nvidia,event-cntr-data = <0x1ac>;
>> +	};
>> +
>> +	pcie@14120000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x32000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x32080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x12 0x40000000 0x0 0x40000000>; /* window2 (1G)               */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <1>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <2>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
>> +		clock-names = "core_clk";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
>> +		reset-names = "core_apb_rst", "core_rst";
>> +
>> +		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 47 0x04>;
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x2>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1a8>;
>> +		nvidia,event-cntr-data = <0x1ac>;
>> +	};
>> +
>> +	pcie@14140000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x34000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x34080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x12 0x80000000 0x0 0x40000000>; /* window2 (1G)               */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <1>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <3>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
>> +		clock-names = "core_clk";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
>> +		reset-names = "core_apb_rst", "core_rst";
>> +
>> +		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 49 0x04>;
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x3>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0xB0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1a8>;
>> +		nvidia,event-cntr-data = <0x1ac>;
>> +	};
>> +
>> +	pcie@14160000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
>> +		reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x36000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x36080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x14 0x00000000 0x4 0x00000000>; /* window2 (16G)              */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <4>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <4>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
>> +		clock-names = "core_clk";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
>> +		reset-names = "core_apb_rst", "core_rst";
>> +
>> +		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 51 0x04>;
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x4>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1c4>;
>> +		nvidia,event-cntr-data = <0x1c8>;
>> +	};
>> +
>> +	pcie@141a0000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x3a000000 0x0 0x02000000   /* window1 (32M)              */
>> +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
>> +		       0x1c 0x00000000 0x4 0x00000000>; /* window2 (16G)              */
>> +		reg-names = "appl", "window1", "config", "atu_dma", "dbi", "window2";
>> +
>> +		status = "disabled";
>> +
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		num-lanes = <8>;
>> +		num-viewport = <8>;
>> +		linux,pci-domain = <5>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
>> +			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
>> +		clock-names = "core_clk", "core_clk_m";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +		reset-names = "core_apb_rst", "core_rst";
>> +
>> +		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
>> +			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
>> +		interrupt-names = "intr", "msi";
>> +
>> +		nvidia,bpmp = <&bpmp>;
>> +
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0 0 0 0>;
>> +		interrupt-map = <0 0 0 0 &gic 0 53 0x04>;
>> +
>> +		nvidia,max-speed = <4>;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <&bpmp 0x5>;
>> +		nvidia,aspm-cmrt = <0x3C>;
>> +		nvidia,aspm-pwr-on-t = <0x14>;
>> +		nvidia,aspm-l0s-entrance-latency = <0x3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +
>> +		nvidia,event-cntr-ctrl = <0x1d8>;
>> +		nvidia,event-cntr-data = <0x1dc>;
>> +	};
>>   };
>> -- 
>> 2.7.4
>>

