Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52481 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934333AbdADIea (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 03:34:30 -0500
Subject: Re: [PATCH 3/4] Documetation: binding: modify the exynos5440 pcie
 binding
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, kishon@ti.com, jingoohan1@gmail.com,
        vivek.gautam@codeaurora.org, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <1c7c1319-70cd-e6d5-87d1-c329a8166497@samsung.com>
Date: Wed, 04 Jan 2017 17:23:24 +0900
MIME-version: 1.0
In-reply-to: <20170103195144.7fwtlvhzxhq3r25z@rob-hp-laptop>
Content-type: text/plain; charset=windows-1252
References: <20161228103454.26467-1-jh80.chung@samsung.com>
 <CGME20161228103455epcas5p2b3ea563efc00c776e77477ab3c778bb1@epcas5p2.samsung.com>
 <20161228103454.26467-4-jh80.chung@samsung.com>
 <20170103195144.7fwtlvhzxhq3r25z@rob-hp-laptop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/04/2017 04:51 AM, Rob Herring wrote:
> On Wed, Dec 28, 2016 at 07:34:53PM +0900, Jaehoon Chung wrote:
>> According to using PHY framework, modified the exynos5440-pcie binding.
>> And use "config" property to follow the designware-pcie binding.
> 
> You are breaking compatibility here. Please state that and why it is 
> okay to do so.

I will update it..And i'm modifying the patches about maintaining the backward compatibility.
So i will leave the current dt-binding. Just will add the dt-binding example for using phy framework.
How about?

And will add the "DEPRECATED" for some properties. Also will display the kernel message.

> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  .../bindings/pci/samsung,exynos5440-pcie.txt       | 29 +++++++++++++---------
>>  1 file changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
>> index 4f9d23d..51f6214 100644
>> --- a/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
>> @@ -5,10 +5,15 @@ and thus inherits all the common properties defined in designware-pcie.txt.
>>  
>>  Required properties:
>>  - compatible: "samsung,exynos5440-pcie"
>> -- reg: base addresses and lengths of the pcie controller,
>> -	the phy controller, additional register for the phy controller.
>> +- reg: base addresses and lengths of the pcie controller
>>  - interrupts: A list of interrupt outputs for level interrupt,
>>  	pulse interrupt, special interrupt.
>> +- phys: From PHY binding. Phandle for the Generic PHY.
>> +	Refer to Documentation/devicetree/bindings/phy/samsung-phy.txt
>> +- phy-names: Must be "pcie-phy".
> 
> -names is pointless for a single element.

Will remove.

> 
>> +
>> +Other common properties refer to
>> +	Documentation/devicetree/binding/pci/designware-pcie.txt
>>  
>>  Example:
>>  
>> @@ -16,18 +21,18 @@ SoC specific DT Entry:
>>  
>>  	pcie@290000 {
>>  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
>> -		reg = <0x290000 0x1000
>> -			0x270000 0x1000
>> -			0x271000 0x40>;
>> +		reg = <0x290000 0x1000>, <0x40000000 0x100>;
> 
> 256 bytes of config space?

Typo. Will fix.

> 
>> +		reg-names = "elbi", "config";
>>  		interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
>>  		clocks = <&clock 28>, <&clock 27>;
>>  		clock-names = "pcie", "pcie_bus";
>>  		#address-cells = <3>;
>>  		#size-cells = <2>;
>>  		device_type = "pci";
>> -		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000   /* configuration space */
>> -			  0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
>> +		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000   /* downstream I/O */
>>  			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
>> +		phys = <&pcie_phy0>;
>> +		phy-names = "pcie-phy";
>>  		#interrupt-cells = <1>;
>>  		interrupt-map-mask = <0 0 0 0>;
>>  		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -36,17 +41,17 @@ SoC specific DT Entry:
>>  
>>  	pcie@2a0000 {
>>  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
>> -		reg = <0x2a0000 0x1000
>> -			0x272000 0x1000
>> -			0x271040 0x40>;
>> +		reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
>> +		reg-names = "elbi", "config";
>>  		interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
>>  		clocks = <&clock 29>, <&clock 27>;
>>  		clock-names = "pcie", "pcie_bus";
>>  		#address-cells = <3>;
>>  		#size-cells = <2>;
>>  		device_type = "pci";
>> -		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000   /* configuration space */
>> -			  0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
>> +		phys = <&pcie_phy1>;
>> +		phy-names = "pcie-phy";
>> +		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000   /* downstream I/O */
>>  			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
>>  		#interrupt-cells = <1>;
>>  		interrupt-map-mask = <0 0 0 0>;
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

