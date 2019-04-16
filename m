Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D100BC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C9721741
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U7x185+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfDPRsT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:48:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19865 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPRsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 13:48:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb6154b0001>; Tue, 16 Apr 2019 10:47:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 10:48:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 10:48:15 -0700
Received: from [10.25.74.19] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 17:48:09 +0000
Subject: Re: [PATCH V2 12/16] arm64: tegra: Add P2U and PCIe controller nodes
 to Tegra194 DT
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
 <1554407683-31580-13-git-send-email-vidyas@nvidia.com>
 <20190415151552.GI29254@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <223774ba-8416-82d6-6091-a64f0740d8af@nvidia.com>
Date:   Tue, 16 Apr 2019 23:18:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415151552.GI29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555436875; bh=Pdqajbj99LbvWz0xV0nqki++zHOSXXWIMw0sVQKCmCY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=U7x185+tTSdQnm9E1BYM56+c98EJD11csu8mUPO6krG10wQ4OTnOyWVEzNIQ5INQt
         PHURILv7lJ/W3wL5zIRDS7PTvZqn76+pw7mhy699uDetc01AANddWmZ64X7F2mybBO
         c5FwFjgD389aBNBGLa/jajskZPuj3KH9v+TiP9SRoyh55p4XirjHp1c7Ap2lD1wIXT
         ANUl9vhBLDNRSGtWiUHXfvdiz3dP5O663fOKhAS4uXa6S7+KWZBPwRjAe41jAobrZC
         06sjOeX6z8eHbtM6j1m32XYFnfG5ZRDtKtKbk8lXKsaSmdHU33Wi/8+8AA04l4rx5/
         Px17xM8wb/eXA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/2019 8:45 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:39AM +0530, Vidya Sagar wrote:
>> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
>> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
>> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
>> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v1]:
>> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nodes
>> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to 'nvidia,tegra194-p2u'
>> * Changed reg-name from 'base' to 'ctl'
>> * Updated all PCIe nodes according to the changes made to DT documentation file
>>
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 449 +++++++++++++++++++++++++++++++
>>   1 file changed, 449 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index c77ca211fa8f..5b62136d97a5 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -884,6 +884,166 @@
>>   				nvidia,interface = <3>;
>>   			};
>>   		};
>> +
>> +		p2u_0: p2u@03e10000 {			/* HSIO-Lane-0 */
>> +			compatible = "nvidia,tegra194-p2u";
>> +			reg = <0x03e10000 0x10000>;
>> +			reg-names = "ctl";
>> +
>> +			#phy-cells = <0>;
>> +		};
>> +
> [...]
>> +		p2u_12: p2u@03eb0000 {			/* NVHS-Lane-0 */
>> +			compatible = "nvidia,tegra194-p2u";
>> +			reg = <0x03eb0000 0x10000>;
>> +			reg-names = "ctl";
>> +
>> +			#phy-cells = <0>;
>> +		};
> [...]
> 
> Do we perhaps want to include the type of P2U in the label? That would
> make it more obvious which ones to list in the PCIe controller nodes'
> phys properties. Something like:
> 
> 		p2u_hsio_0: p2u@3e10000 {
> 			...
> 		};
> 
> 		...
> 
> 		p2u_nvhs_0: p2u@3eb0000 {
> 			...
> 		};
> 
> ? Also, make sure to drop the leading 0 from unit-addresses. Recent
> versions of DTC have checks for that in place and will warn about it in
> recent Linux builds.
Done.

> 
> [...]
>> @@ -1054,4 +1214,293 @@
>>   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>   		interrupt-parent = <&gic>;
>>   	};
>> +
>> +	pcie@14180000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
>> +		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
> 
> Didn't you remove some of these from the bindings?
I've removed some but what we see here are still present in bindings.

> 
> Thierry
> 
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x1B 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +	};
>> +
>> +	pcie@14100000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
>> +		reset-names = "core_apb", "core";
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
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <1>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +	};
>> +
>> +	pcie@14120000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
>> +		reset-names = "core_apb", "core";
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
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <2>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x32100000 0x0 0x32100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +	};
>> +
>> +	pcie@14140000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
>> +		reg = <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
>> +		reset-names = "core_apb", "core";
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
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <3>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x34100000 0x0 0x34100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000  /* prefetchable memory (768MB) */
>> +			  0x82000000 0x0 0x40000000 0x12 0xB0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
>> +	};
>> +
>> +	pcie@14160000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
>> +		reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
>> +		clock-names = "core";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
>> +		reset-names = "core_apb", "core";
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
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <4>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x36100000 0x0 0x36100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x17 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +	};
>> +
>> +	pcie@141a0000 {
>> +		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
>> +		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
>> +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
>> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
>> +		       0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
>> +		reg-names = "appl", "config", "atu_dma", "dbi";
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
>> +		clock-names = "core", "core_m";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
>> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>> +		reset-names = "core_apb", "core";
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
>> +		supports-clkreq;
>> +		nvidia,disable-aspm-states = <0xf>;
>> +		nvidia,controller-id = <5>;
>> +		nvidia,aspm-cmrt-us = <60>;
>> +		nvidia,aspm-pwr-on-t-us = <20>;
>> +		nvidia,aspm-l0s-entrance-latency-us = <3>;
>> +
>> +		bus-range = <0x0 0xff>;
>> +		ranges = <0x81000000 0x0 0x3a100000 0x0 0x3a100000 0x0 0x00100000    /* downstream I/O (1MB) */
>> +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000  /* prefetchable memory (13GB) */
>> +			  0x82000000 0x0 0x40000000 0x1f 0x40000000 0x0 0xC0000000>; /* non-prefetchable memory (3GB) */
>> +	};
>>   };
>> -- 
>> 2.7.4
>>

