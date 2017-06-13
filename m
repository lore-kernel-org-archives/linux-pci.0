Return-Path: <robh@kernel.org>
Return-Path: <robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e8cd62fb-f48e-c72a-f960-4794badfce70@free.fr>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <69f3ffe7-3c39-fa94-71f8-91744a869cc9@sigmadesigns.com> <20170607212907.2wr3hqbokjb74kj3@rob-hp-laptop>
 <e8cd62fb-f48e-c72a-f960-4794badfce70@free.fr>
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Jun 2017 09:23:55 -0500
Message-ID: <CAL_Jsq+n=sUg1MyDW7qY1a0kwSJJD00h7VztyTXK0eh_Uh2wmA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] PCI: Add DT binding for tango PCIe controller
To: Mason <slash.tmp@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 7, 2017 at 5:34 PM, Mason <slash.tmp@free.fr> wrote:
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

Yes, I refer to them regularly.

> Where would you put them? In the example?

They are useful to every PCI binding. That doesn't mean we should link
to them in for every single PCI host binding doc. They belong in a DT
howto or something if not there already.

Rob

>
>> There's several standard properties you are missing like bus-range.
>
> My reasoning for omitting "bus-range" was that the PCI core computes
> it by itself (1M per "bus" so SZ_4M => 4 devices). I thought redundant
> information was bad form?
>
>> Build your dts with "W=2". dtc recently gained some checks for PCI
>> bindings.
>
> I'll give it a try. Did v4.9 already support it?

No, v4.12.

>
>>> +Example:
>>> +
>>> +    pcie@2e000 {
>>> +            compatible = "sigma,smp8759-pcie";
>>> +            reg = <0x50000000 SZ_4M>, <0x2e000 0x100>;
>>> +            device_type = "pci";
>>> +            #size-cells = <2>;
>>> +            #address-cells = <3>;
>>> +            msi-controller;
>>> +            ranges = <0x02000000 0x0 0x00400000  0x50400000  0x0 SZ_60M>;
>>
>> I don't think SZ_60M exists or is available to dts files. Just put the
>> number in.
>
> I #defined it at the top of my DTS.
> Using symbolic constants in DTS is not acceptable?

We generally don't use them here (i.e. for reg). The main use is for
things also used by drivers like GPIO flags or IDs such as clock IDs.
So please drop these.

Rob
