Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
To: Mason <slash.tmp@free.fr>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
 <62bb805a-abd6-9aca-3641-8037f42a3b95@arm.com>
 <57673076-4fbd-92ab-453c-3d77fd65407f@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <1b0ec9c9-1036-619e-19c7-16818ca728e3@arm.com>
Date: Thu, 25 May 2017 13:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <57673076-4fbd-92ab-453c-3d77fd65407f@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 25/05/17 13:00, Mason wrote:
> On 25/05/2017 10:48, Marc Zyngier wrote:
> 
>> On 20/04/17 15:31, Marc Gonzalez wrote:
>>
>>> This driver is required to work around several hardware bugs in the
>>> PCIe controller.
>>>
>>> NB: Revision 1 does not support legacy interrupts, or IO space.
>>>
>>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>>> ---
>>>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++++++
>>>  drivers/pci/host/Kconfig                             |   8 ++
>>>  drivers/pci/host/Makefile                            |   1 +
>>>  drivers/pci/host/pcie-tango.c                        | 161 +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pci_ids.h                              |   2 +
>>>  5 files changed, 204 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/tango-pcie.txt b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>>> new file mode 100644
>>> index 000000000000..3353b4e77309
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/tango-pcie.txt
>>> @@ -0,0 +1,32 @@
>>> +Sigma Designs Tango PCIe controller
>>> +
>>> +Required properties:
>>> +
>>> +- compatible: "sigma,smp8759-pcie"
>>> +- reg: address/size of PCI configuration space, address/size of register area
>>> +- device_type: "pci"
>>> +- #size-cells: <2>
>>> +- #address-cells: <3>
>>> +- #interrupt-cells: <1>
>>
>> What is the point of having an #interrupt-cells when this is *not* an
>> interrupt controller (as it doesn't support legacy interrupts)?
> 
> My mistake.
> 
> Thanks for kindly pointing out that the #interrupt-cells property
> is not needed when a controller doesn't support legacy interrupts.
> 
> If a controller does support legacy interrupts, then I see other
> bindings define #interrupt-cells and interrupt-map.
> Is interrupt-controller also required?

Probably.

> Is that redundant with msi-controller?

No.

> (Rev2 will support legacy interrupts.)
> 
> References for my own information:
> http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/pci/altera-pcie.txt
> http://elinux.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
> 
>> As mentioned earlier, this needs to be a separate patch to be reviewed
>> by the Keepers of the Faith (aka the DT maintainers).
> 
> robh already acked v3 two months ago, but can split it up,
> and CC the DT folks for v5.

You didn't add the Acked-by to this patch, making Rob's effort pretty
useless.

>>> +static int smp8759_init(struct tango_pcie *pcie, void __iomem *base)
>>> +{
>>> +	pcie->mux		= base + 0x48;
>>> +	pcie->msi_status	= base + 0x80;
>>> +	pcie->msi_enable	= base + 0xa0;
>>> +	pcie->msi_doorbell	= 0xa0000000 + 0x2e07c;
>>> +
>>> +	return tango_check_pcie_link(base + 0x74);
>>
>> Please have some defines for these magic values.
> 
> Typical driver do
> #define MUX_OFFSET 0x48
> and then access the register's value through
> readl_relaxed(pcie->base + MUX_OFFSET);
> 
> I can't do that because the registers were shuffled around
> between revision 1 and revision 2. Thus, instead of an
> explicitly-named macro (MUX_OFFSET), I used an explicitly-
> named field (pcie->mux) and access the register's value
> through readl_relaxed(pcie->mux);

That doesn't prevent you from having a TANGO_V1_MUX_OFFSET define, which
you can supplement with a V2 at some point.

> This is equivalent to providing the offset definitions in the
> init functions, instead of at the top of the file.

Sorry, my brain parses text far better than hex number.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
