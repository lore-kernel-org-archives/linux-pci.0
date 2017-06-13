Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=S67v=5S=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
To: Mason <slash.tmp@free.fr>, Rob Herring <robh@kernel.org>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com>
 <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
 <e8cd62fb-f48e-c72a-f960-4794badfce70@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <6ae0bc1a-1680-1ff9-a650-d6935d8d0279@arm.com>
Date: Tue, 13 Jun 2017 12:55:48 +0100
MIME-Version: 1.0
In-Reply-To: <e8cd62fb-f48e-c72a-f960-4794badfce70@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 07/06/17 23:34, Mason wrote:
> Hello Rob,
> 
> On 07/06/2017 23:29, Rob Herring wrote:
>> On Wed, May 31, 2017 at 03:30:26PM +0200, Marc Gonzalez wrote:
>>> Binding for the Sigma Designs SMP8759 SoC.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>>  Documentation/devicetree/bindings/pci/tango-pcie.txt | 30 ++++++++++++++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>>> new file mode 100644
>>> index 000000000000..35ef2c811a27
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>>> @@ -0,0 +1,30 @@
>>> +Sigma Designs Tango PCIe controller
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: "sigma,smp8759-pcie"
>>> +- reg: address/size of PCI configuration space, address/size of register area
>>> +- device_type: "pci"
>>> +- #size-cells: <2>
>>> +- #address-cells: <3>
>>> +- msi-controller
>>> +- ranges: translation from system to bus addresses
>>> +- interrupts: spec for misc interrupts, spec for MSI
>>> +
>>> +http://elinux.org/Device_Tree_Usage#PCI_Address_Translation
>>> +http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
>>
>> Why are these here?
> 
> I found these references very helpful when writing the node.
> Where would you put them? In the example?

I don't think they belong in this document at all.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
