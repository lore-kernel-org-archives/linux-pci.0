Return-Path: <SRS0=Adax=5M=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Adax=5M=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
To: Rob Herring <robh@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
 <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
From: Mason <slash.tmp@free.fr>
Message-ID: <e8cd62fb-f48e-c72a-f960-4794badfce70@free.fr>
Date: Thu, 8 Jun 2017 00:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

Hello Rob,

On 07/06/2017 23:29, Rob Herring wrote:
> On Wed, May 31, 2017 at 03:30:26PM +0200, Marc Gonzalez wrote:
>> Binding for the Sigma Designs SMP8759 SoC.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  Documentation/devicetree/bindings/pci/tango-pcie.txt | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>> new file mode 100644
>> index 000000000000..35ef2c811a27
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>> @@ -0,0 +1,30 @@
>> +Sigma Designs Tango PCIe controller
>> +
>> +Required properties:
>> +
>> +- compatible: "sigma,smp8759-pcie"
>> +- reg: address/size of PCI configuration space, address/size of register area
>> +- device_type: "pci"
>> +- #size-cells: <2>
>> +- #address-cells: <3>
>> +- msi-controller
>> +- ranges: translation from system to bus addresses
>> +- interrupts: spec for misc interrupts, spec for MSI
>> +
>> +http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
>> +http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
> 
> Why are these here?

I found these references very helpful when writing the node.
Where would you put them? In the example?

> There's several standard properties you are missing like bus-range.

My reasoning for omitting "bus-range" was that the PCI core computes
it by itself (1M per "bus" so SZ_4M => 4 devices). I thought redundant
information was bad form?

> Build your dts with "W=2". dtc recently gained some checks for PCI 
> bindings.

I'll give it a try. Did v4.9 already support it?

>> +Example:
>> +
>> +	pcie@2e000 {
>> +		compatible = "sigma,smp8759-pcie";
>> +		reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
>> +		device_type = "pci";
>> +		#size-cells = <2>;
>> +		#address-cells = <3>;
>> +		msi-controller;
>> +		ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
> 
> I don't think SZ_60M exists or is available to dts files. Just put the 
> number in.

I #defined it at the top of my DTS.
Using symbolic constants in DTS is not acceptable?

Thanks for having a look.

Regards.
