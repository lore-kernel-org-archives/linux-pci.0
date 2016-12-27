Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43604 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbcL0XEZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2016 18:04:25 -0500
Subject: Re: [RFC PATCH 5/6] Documentation: pci: add the exynos5433-pcie binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        kgene@kernel.org, javier@osg.samsung.com, kishon@ti.com,
        will.deacon@arm.com, catalin.marinas@arm.com, cpgs@samsung.com
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <d723ec48-af3c-6012-4f76-e8e73ad9af58@samsung.com>
Date: Wed, 28 Dec 2016 08:03:41 +0900
MIME-version: 1.0
In-reply-to: <20161227161916.nb6yf3n2kmkzkeg2@kozik-lap>
Content-type: text/plain; charset=utf-8
References: <20161226052029.10552-1-jh80.chung@samsung.com>
 <CGME20161226052031epcas5p4f151c41189f7b3811979ca1e10aab1be@epcas5p4.samsung.com>
 <20161226052029.10552-6-jh80.chung@samsung.com>
 <20161227161916.nb6yf3n2kmkzkeg2@kozik-lap>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/28/2016 01:19 AM, Krzysztof Kozlowski wrote:
> On Mon, Dec 26, 2016 at 02:20:28PM +0900, Jaehoon Chung wrote:
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  .../devicetree/bindings/pci/exynos5433-pcie.txt    | 36 ++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt b/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
>> new file mode 100644
>> index 0000000..932a847
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/exynos5433-pcie.txt
>> @@ -0,0 +1,36 @@
>> +* Samsung Exynos5433 PCIe interface
>> +
>> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> 
> Synopsys.

Will fix.

> 
>> +and thus inherits all the common properties defined in designware-pcie.txt.
>> +
>> +Required properties:
>> +- compatible: "samsung,exynos5433-pcie"
>> +- reg: base addresses and lengths of the pcie controller,
>> +	the phy controller, additional register for the phy controller.
> 
> You mentioned three regs but the example contains four of them. Is the
> config comming from snps,dw-pcie?

Oops..It's my mistake. Just needs to put three reg.
Elbi : External local Bus interface register.
Dbi : Data bus interface register.(Control register.)
Config : for configuration space.

"config" can be removed. Because it's not Exynos specific, synopsys's Required property.

> 
>> +- reg-names: Must be "elbi", "phy" and "dbi" for each regs
> 
> Again, three here, four in example.

Will fix.

> 
>> +- interrupt-names: Must be "intr" for legacy interrupt pin.
>> +
>> +Other common properites refer to
>> +	Documentation/devicetree/binding/pci/designware-pcie.txt
>> +
>> +Example:
>> +
>> +	pcie: pcie@15700000 {
>> +		compatible ="samsung,exynos5433-pcie", "snps,dw-pcie";
>                             ^
> 			    space needed
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +		device_type = "pci";
>> +		interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "intr";
>> +		clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
>> +		clock-names = "pcie", "pcie_bus";
>> +		num-lanes = <1>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pcie_bus>;
>> +		reg = <0x156b0000 0x1000>, <0x15680000 0x1000>,
>> +		    <0x15700000 0x1000>, <0x0c000000 0x1000>;
> 
> Indentation here looks wrong. You indented it with spaces after tabs...
> but not to align with line before.

Will fix.

Best Regards,
Jaehoon Chung

> 
> Beside that, fine with me:
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Best regards,
> Krzysztof
> 
> 
>> +		reg-names = "elbi", "phy", "dbi", "config";
>> +		ranges = <0x81000000 0 0	  0x0c001000 0 0x00010000
>> +			  0x82000000 0 0x0c011000 0x0c011000 0 0x3feefff>;
>> +		status = "disabled";
>> +	};
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

