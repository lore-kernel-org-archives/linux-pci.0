Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] bindings: PCI: designware: Example update
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
 <1936f007686d3cbb0ed3072d4cd81abc961bf358.1523881182.git.gustavo.pimentel@synopsys.com>
 <20180416213919.blju6rzkq5md62q4@rob-hp-laptop>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f62b174f-23a6-992f-90ec-223aa9b44e0d@synopsys.com>
Date: Tue, 17 Apr 2018 14:47:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180416213919.blju6rzkq5md62q4@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On 16/04/2018 22:39, Rob Herring wrote:
> On Mon, Apr 16, 2018 at 03:37:49PM +0100, Gustavo Pimentel wrote:
>> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
>> however it still be compatible with any previous DT that uses the old
>> reg-name.
>>
>> Replaces the PCIe base address example by a real PCIe base address in use.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes v1->v2:
>>  - Removed any iATU reference or changes to avoid confusion.
>>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
>> Changes v2->v3:
>> - Nothing changed, just to follow the patch set version.
>> Changes v3->v4:
>> - Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.
>>
>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 1da7ade..7f9804d 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -1,7 +1,8 @@
>>  * Synopsys DesignWare PCIe interface
>>  
>>  Required properties:
>> -- compatible: should contain "snps,dw-pcie" to identify the core.
>> +- compatible:
>> +	"snps,dw-pcie" for RC mode;
>>  - reg: Should contain the configuration address space.
>>  - reg-names: Must be "config" for the PCIe configuration space.
>>      (The old way of getting the configuration address space from "ranges"
>> @@ -41,11 +42,11 @@ EP mode:
>>  
>>  Example configuration:
>>  
>> -	pcie: pcie@dffff000 {
>> +	pcie: pcie@dfc00000 {
>>  		compatible = "snps,dw-pcie";
>> -		reg = <0xdffff000 0x1000>, /* Controller registers */
>> -		      <0xd0000000 0x2000>; /* PCI config space */
>> -		reg-names = "ctrlreg", "config";
>> +		reg = <0xdfc00000 0x0001000>, /* IP registers */
>> +		      <0xd0000000 0x0002000>; /* Configuration space */
>> +		reg-names = "dbi", "config";
>>  		#address-cells = <3>;
>>  		#size-cells = <2>;
>>  		device_type = "pci";
>> @@ -54,5 +55,4 @@ Example configuration:
>>  		interrupts = <25>, <24>;
>>  		#interrupt-cells = <1>;
>>  		num-lanes = <1>;
>> -		num-viewport = <3>;
> 
> Seems like a spurious change?

This item is optional, according to the description, if not specified the driver
assumes by default 2.
By maintaining the configuration like this, I can guarantee that is a functional
configuration, since it's one that I normally use. But I can reverted if you desire.

> 
>>  	};
>> -- 
>> 2.7.4
>>
>>

Thanks,
Gustavo
