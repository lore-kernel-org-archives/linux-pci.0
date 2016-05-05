Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
To: Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <f.fainelli@gmail.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
 <4513390.VWu0VVAxOl@wuerfel>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com
From: Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <572BBF2E.5010606@broadcom.com>
Date: Thu, 5 May 2016 14:46:22 -0700
MIME-Version: 1.0
In-Reply-To: <4513390.VWu0VVAxOl@wuerfel>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/05/16 14:15, Arnd Bergmann wrote:
> On Thursday 05 May 2016 12:14:59 Florian Fainelli wrote:
>> From: Jim Quinlan <jim2101024@gmail.com>
>>
>> This patchs adds the Device Tree bindings for the Broadcom STB PCIe root
>> complex hardware.
>>
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> Changes in v2:
>>
>> - rewrite the binding document almost from scratch to include many more
>>   references to existing documents
>> - describe missing properties
>> - give better examples
>>
>>  .../devicetree/bindings/pci/brcm,brcmstb-pcie.txt  | 98 ++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
>> new file mode 100644
>> index 000000000000..3682b0f0bc26
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/brcm,brcmstb-pcie.txt
>> @@ -0,0 +1,98 @@
>> +Broadcom STB PCIe Host Controller Device Tree Bindings
>> +
>> +This document describes the binding of the PCIe Root Complex hardware found in
>> +Broadcom Set Top Box System-on-Chips such as BCM7425 (MIPS), BCM7435 (MIPS) and
>> +BCM7445 (ARMv7).
>> +
>> +Required properties:
>> +- compatible: must be one of: "brcm,bcm7425-pcie"
>> +			      "brcm,bcm7435-pcie"
>> +			      "brcm,bcm7445-pcie"
>> +
>> +- reg: specifies the physical base address of the controller registers and
>> +  its length
>> +
>> +- interrupt-parent: must be a reference (phandle) to the parent interrupt
>> +  controller in the system (7038-l1-intc on MIPS, GIC on ARM/ARM64)
>> +
>> +- interrrupts: first interrupt must be the Level 1 interrupt number corresponding
>> +  to the main PCIe RC interrupt, second interrupt must be the MSI interrupt
>> +  See the interrupt-parent documentation for the number of cells and their meaning:
>> +  MIPS: Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
>> +  ARM/ARM64: Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>> +
>> +- interrupt-names: must be "pcie", and if present "msi"
> 
> When I suggested splitting out the MSI support, I was thinking (but not writing)
> that you'd use an msi-parent property to refer to the node that holds the
> msi-controller as well.

Humm fair enough.

> 
>> +- ranges: ranges for the PCI outbound windows, no I/O or prefetchable windows
>> +  must be specified here, only non-prefetchable. 32-bits windows or 64-bits
>> +  windows are allowed based on the host processor's capabilities (ARM w/ LPAE,
>> +  ARM64).
> 
> So this supports 64-bit non-prefetchable windows? Usually 64-bit windows
> are prefetchable.
> 
>> +- brcm,log2-scb-sizes: log2 size of the SCB window that is mapped to PCIe space
>> +  there must be exactly one value per memory controller present in the system
>> +  (ranges from 1 to 3)
> 
> I'm still not too happy with this property. I see no reason for the log2
> format (rather than length in bytes, or offset/length tuples, or dma-ranges,
> or phandles pointing to the memory controllers). I think we need to discuss
> this some more.

Sure, works for me.

> 
>> +- brcm,gen: integer that indicates desired forced generation of link: 1 => 2.5
>> +  Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps. Will override the auto-negotation if
>> +  specified.
> 
> to repeat my earlier comment from v1:
> 
> Shouldn't the link generation be probed automatically?

It is, but if the property is present, we can foce the link negotiation,
We have had cases where this was desired and helpful.

> 
>> +- <*>-supply: see Documentation/devicetree/bindings/regulator/regulator.txt
>> +
>> +- <*>-supply-names: see Documentation/devicetree/bindings/regulator/regulator.txt
> 
> I don't see supply-names documented there.

Meh, I read that wrong, will fix that.

Thanks!
-- 
Florian
