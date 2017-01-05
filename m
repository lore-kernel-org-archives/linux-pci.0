Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52598 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970139AbdAECY1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 21:24:27 -0500
Subject: Re: [PATCH V2 5/5] ARM: dts: exynos5440: support the phy-pcie node for
 pcie
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <76739931-33f0-a457-fae1-7ea11ea0cfea@samsung.com>
Date: Thu, 05 Jan 2017 11:24:24 +0900
MIME-version: 1.0
In-reply-to: <20170104175822.5zedyszx2phiehuv@kozik-lap>
Content-type: text/plain; charset=utf-8
References: <20170104123435.30740-1-jh80.chung@samsung.com>
 <CGME20170104123436epcas1p10b52f24e7d6c00edb44e4331a1870e4d@epcas1p1.samsung.com>
 <20170104123435.30740-6-jh80.chung@samsung.com>
 <20170104175822.5zedyszx2phiehuv@kozik-lap>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/05/2017 02:58 AM, Krzysztof Kozlowski wrote:
> On Wed, Jan 04, 2017 at 09:34:35PM +0900, Jaehoon Chung wrote:
>> Add phy-pcie node for using Exynos5440 pcie.
>> And use the reg-names as "elbi" and "config".
> 
> 'and' is only for joining in compound sentences, don't start with it.

Got it.

> 
>> Because the getting configuratioin space address from ranges is old way.
> 
> Spell-check please.

Will do.

> 
>> It also is helpful to distinguish more clearly.
> 
> Distinguish what? Please work on the commit msg, I am not picking 

Will update the commit-msg.

>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog on V2:
>> - Removes the child-node
>> - Fixes the typo
>> - Removes the unnecessary comments
>>
>>  arch/arm/boot/dts/exynos5440.dtsi | 34 ++++++++++++++++++++++------------
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
>> index 2a2e570..feb074d 100644
>> --- a/arch/arm/boot/dts/exynos5440.dtsi
>> +++ b/arch/arm/boot/dts/exynos5440.dtsi
>> @@ -290,11 +290,22 @@
>>  		clock-names = "usbhost";
>>  	};
>>  
>> +	pcie_phy0: pcie-phy@270000 {
>> +		#phy-cells = <0>;
>> +		compatible = "samsung,exynos5440-pcie-phy";
>> +		reg = <0x270000 0x1000>, <0x271000 0x40>;
>> +	};
>> +
>> +	pcie_phy1: pcie-phy@272000 {
>> +		#phy-cells = <0>;
>> +		compatible = "samsung,exynos5440-pcie-phy";
>> +		reg = <0x272000 0x1000>, <0x271040 0x40>;
>> +	};
>> +
>>  	pcie_0: pcie@290000 {
>>  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
>> -		reg = <0x290000 0x1000
>> -			0x270000 0x1000
>> -			0x271000 0x40>;
>> +		reg = <0x290000 0x1000>, <0x40000000 0x1000>;
>> +		reg-names = "elbi", "config";
>>  		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
>>  			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
>>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -303,9 +314,9 @@
>>  		#address-cells = <3>;
>>  		#size-cells = <2>;
>>  		device_type = "pci";
>> -		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
>> -			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
>> -			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
>> +		phys = <&pcie_phy0>;
>> +		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000
>> +			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>;
> 
> I think the comments were useful. You can leave them.

Ok. will keep.

> 
>>  		#interrupt-cells = <1>;
>>  		interrupt-map-mask = <0 0 0 0>;
>>  		interrupt-map = <0x0 0 &gic 53>;
>> @@ -315,9 +326,8 @@
>>  
>>  	pcie_1: pcie@2a0000 {
>>  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
>> -		reg = <0x2a0000 0x1000
>> -			0x272000 0x1000
>> -			0x271040 0x40>;
>> +		reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
>> +		reg-names = "elbi", "config";
>>  		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
>>  			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
>>  			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -326,9 +336,9 @@
>>  		#address-cells = <3>;
>>  		#size-cells = <2>;
>>  		device_type = "pci";
>> -		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
>> -			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
>> -			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
>> +		phys = <&pcie_phy1>;
>> +		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000
>> +			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>;
> 
> I think the comments were useful. You can leave them.
> 
> This looks like depending on the changes in the driver, so I will need a
> tag or stable branch from PCIe maintainers.

Right..

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Krzysztof
> 
> 
> 

