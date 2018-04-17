Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 04/10] bindings: PCI: designware: Add support for the
 EP in Designware driver
To: Rob Herring <robh@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1523881182.git.gustavo.pimentel@synopsys.com>
 <7d3445e3f8bb15d27987e0d061275d7d69f2c519.1523881182.git.gustavo.pimentel@synopsys.com>
 <20180416214324.wcyghdwejucoutki@rob-hp-laptop>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <e61b75ac-bd19-4e69-3138-702156a36d73@synopsys.com>
Date: Tue, 17 Apr 2018 14:33:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180416214324.wcyghdwejucoutki@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On 16/04/2018 22:43, Rob Herring wrote:
> On Mon, Apr 16, 2018 at 03:37:52PM +0100, Gustavo Pimentel wrote:
>> Add device tree binding documentation for the Endpoint in PCIe Designware
>> driver.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Change v1->v2:
>>  - Add a missing log description.
>>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
>> Change v2->v3:
>> - Reverted pcie_ep name to pcie.
>> Changes v3->v4:
>> - Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.
>>
>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 7f9804d..980fc9a 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -3,6 +3,7 @@
>>  Required properties:
>>  - compatible:
>>  	"snps,dw-pcie" for RC mode;
>> +	"snps,dw-pcie-ep" for EP mode;
>>  - reg: Should contain the configuration address space.
>>  - reg-names: Must be "config" for the PCIe configuration space.
>>      (The old way of getting the configuration address space from "ranges"
>> @@ -56,3 +57,15 @@ Example configuration:
>>  		#interrupt-cells = <1>;
>>  		num-lanes = <1>;
>>  	};
>> +or
>> +	pcie: pcie@dfc00000 {
>> +		compatible = "snps,dw-pcie-ep";
>> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
>> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
>> +		      <0xd0000000 0x2000000>; /* Configuration space */
>> +		reg-names = "dbi", "dbi2", "addr_space";
>> +		device_type = "pci";
> 
> This should not be present for endpoints.

You're correct. I'll remove it.

> 
> With that dropped,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> 
>> +		num-ib-windows = <6>;
>> +		num-ob-windows = <2>;
>> +		num-lanes = <1>;
>> +	};
>> -- 
>> 2.7.4
>>
>>

Thanks,
Gustavo
