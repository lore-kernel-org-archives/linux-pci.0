Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35469 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbcEIXPO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2016 19:15:14 -0400
Subject: Re: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
To: Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
 <20160509192641.GA4936@rob-hp-laptop>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	bhelgaas@google.com, arnd@arndb.de
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <573119FF.9000306@gmail.com>
Date: Mon, 9 May 2016 16:15:11 -0700
MIME-Version: 1.0
In-Reply-To: <20160509192641.GA4936@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2016 12:26 PM, Rob Herring wrote:
> On Thu, May 05, 2016 at 12:14:59PM -0700, Florian Fainelli wrote:
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
>> +
>> +- interrupt-map: see pci.txt
>> +
>> +- interrupt-map-mask: see pci.txt
>> +
>> +- #address-cells: must be set to <3>, see pci.txt
>> +
>> +- #size-cells: must be set to <2>, see pci.txt
>> +
>> +- ranges: ranges for the PCI outbound windows, no I/O or prefetchable windows
>> +  must be specified here, only non-prefetchable. 32-bits windows or 64-bits
>> +  windows are allowed based on the host processor's capabilities (ARM w/ LPAE,
>> +  ARM64).
>> +
>> +- #interrupt-cells: set to <1>, see pci.txt
>> +
>> +- brcm,log2-scb-sizes: log2 size of the SCB window that is mapped to PCIe space
>> +  there must be exactly one value per memory controller present in the system
>> +  (ranges from 1 to 3)
>> +
>> +Optional properties:
>> +
>> +- msi-controller: indicates that this is a MSI controller node (when supported)
>> +
>> +- clocks: phandle to the functional clock that feeds into the PCIe RC block
>> +
>> +- clock-names: the name(s) of the clocks specified in 'clocks'.  Note
>> +  that if the 'clocks' property is given, 'clock-names' is mandatory,
>> +  and the name of the clock is expected to be "pcie".
>> +
>> +- brcm,ssc: boolean that indicates usage of spread-spectrum clocking
> 
> Shouldn't this be a property of the phy? Is there no separate phy to 
> control?

No, the PHY is baked into the PCIe root complex, which is why this is a
property of the root complex node since the two are conflated.

> 
>> +
>> +- brcm,gen: integer that indicates desired forced generation of link: 1 => 2.5
>> +  Gbps, 2 => 5.0 Gbps, 3 => 8.0 Gbps. Will override the auto-negotation if
>> +  specified.
>> +
>> +- <*>-supply: see Documentation/devicetree/bindings/regulator/regulator.txt
>> +
>> +- <*>-supply-names: see Documentation/devicetree/bindings/regulator/regulator.txt
>> +
>> +Example Node:
>> +
>> +This example assumes that the top-level #address-cells = <2> and #size-cells =
>> +<2>, e.g: ARM LPAE configuration.
>> +
>> +	pcie0: pcie-controller@f0460000 {
>> +		reg = <0x0 0xf0460000 0x0 0x9310>;
>> +		interrupts = <0x0 0x33 0x4>, <0x0 0x34, 0x4>;
>                                                       ^
> typo

Whoops, thanks.

> 
>> +		interrupt-names = "pcie", "msi";
>> +		compatible = "brcm,bcm7445-pcie";
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		/* Two non-prefetchable 32-bits memory space, each of 128MB
>> + 		 * with the following mapping:
>> +		 * PCIe address		=> CPU physical address space
>> +		 * 0x00_0000_0000	=> 0x00_C000_0000
>> +		 * 0x00_0800_0000	=> 0x00_C800_0000
>> +		 */
>> +		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000>,
>> +			 <0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
>> +		#interrupt-cells = <1>;
>> +		interrupt-map-mask = <0xf800 0 0 7>;
>> +		interrupt-map = <0 0 0 1 &intc 47 3
>> +				 0 0 0 2 &intc 48 3
>> +				 0 0 0 3 &intc 49 3
>> +				 0 0 0 4 &intc 50 3>;
>> +		clocks = <&pcie0>;
>> +		clock-names = "pcie";
>> +		brcm,ssc;
>> +		brcm,log2-scb-sizes = <0x1e 0x1e 0x1e>;
>> +		vreg-wifi-pwr-supply-names = "vreg-wifi-pwr";
>> +		vreg-wifi-pwr-supply = <&vreg-wifi-pwr>;
> 
> The supply for the PCIE RC is called "vreg-wifi-pwr"? Seems a bit 
> strange.

It can be called anything, this just happens to be the example, but I
can certainly drop that, since a) this is optional and b) we need to
rework that in the driver anyway.
-- 
Florian
