Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48077 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbcL0W5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 17:57:45 -0500
Subject: Re: [RFC PATCH 3/6] ARM64: dts: exynos5433: add the pcie_phy node for
 PCIe
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <43872be0-191e-2b6d-adcc-3ce0b88b44c7@samsung.com>
Date: Wed, 28 Dec 2016 07:57:30 +0900
MIME-version: 1.0
In-reply-to: <20161227161134.ds67t5byucphwkjg@kozik-lap>
Content-type: text/plain; charset=utf-8
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas5p451b1352d6c8c5205a69246c2994b9506@epcas5p4.samsung.com>
 <20161226052029.10552-4-jh80.chung@samsung.com>
 <20161227161134.ds67t5byucphwkjg@kozik-lap>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/28/2016 01:11 AM, Krzysztof Kozlowski wrote:
> On Mon, Dec 26, 2016 at 02:20:26PM +0900, Jaehoon Chung wrote:
>> To use the generic PHY framework, adds the pcie_phy node.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> index 64226d5..2a15f18 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>> @@ -805,6 +805,11 @@
>>  			reg = <0x145f0000 0x1038>;
>>  		};
>>  
>> +		syscon_fsys: syscon@156f0000 {
>> +			compatible = "syscon";
>> +			reg = <0x156f0000 0x1044>;
>> +		};
>> +
>>  		gsc_0: video-scaler@13C00000 {
>>  			compatible = "samsung,exynos5433-gsc";
>>  			reg = <0x13c00000 0x1000>;
>> @@ -1443,6 +1448,15 @@
>>  				status = "disabled";
>>  			};
>>  		};
>> +
>> +		pcie_phy: pcie-phy@15680000 {
>> +			#phy-cells = <0>;
>> +			compatible = "samsung,exynos5433-pcie-phy";
> 
> Mostly we use the convention of compatible being first property.
> 
>> +			reg = <0x15680000 0x1000>;
>> +			samsung,pmureg-phandle = <&pmu_system_controller>;
>> +			samsung,fsys-sysreg = <&syscon_fsys>;
>> +			status = "okay";
> 
> Why do you need to put status=okay here?

Not need. Will remove.

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Krzysztof
> 
>> +		};
>>  	};
>>  
>>  	timer: timer {
>> -- 
>> 2.10.2
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

