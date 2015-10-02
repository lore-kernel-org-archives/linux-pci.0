Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:9078 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbJBAoj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 20:44:39 -0400
Subject: Re: [PATCH v2] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
References: <1443689961-23909-1-git-send-email-bharatku@xilinx.com>
 <2677327.lnRZhqx5GI@wuerfel>
CC: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>,
	<bhelgaas@google.com>, <tinamdar@apm.com>, <treding@nvidia.com>,
	<Minghuan.Lian@freescale.com>, <m-karicheri2@ti.com>,
	<hauke@hauke-m.de>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Ravi Kiran Gummaluri <rgummal@xilinx.com>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <560DD374.4000708@broadcom.com>
Date: Thu, 1 Oct 2015 17:44:36 -0700
MIME-Version: 1.0
In-Reply-To: <2677327.lnRZhqx5GI@wuerfel>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 10/1/2015 2:52 AM, Arnd Bergmann wrote:
> On Thursday 01 October 2015 14:29:21 Bharat Kumar Gogada wrote:
>> Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
>>
>> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>> ---
>> Removed unneccessary comments
>> Modified setup_sspl implementation
>> Added more details in binding Documentation
>> ---
>>  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   49 +
>>  drivers/pci/host/Kconfig                           |    9 +
>>  drivers/pci/host/Makefile                          |    1 +
>>  drivers/pci/host/pcie-xilinx-nwl.c                 | 1029 ++++++++++++++++++++
>>  4 files changed, 1088 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>>  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
>>
>> diff --git a/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>> new file mode 100644
>> index 0000000..ed87184
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
>> @@ -0,0 +1,49 @@
>> +* Xilinx NWL PCIe Root Port Bridge DT description
>> +
>> +Required properties:
>> +- compatible: Should contain "xlnx,nwl-pcie-2.11"
>> +- #address-cells: Address representation for root ports, set to <3>
>> +- #size-cells: Size representation for root ports, set to <2>
>> +- #interrupt-cells: specifies the number of cells needed to encode an
>> +	interrupt source. The value must be 1.
>> +- reg: Should contain Bridge, PCIe Controller registers location,
>> +	configuration sapce, and length
>> +- reg-names: Must include the following entries:
>> +	"breg": bridge registers
>> +	"pcireg": PCIe controller registers
>> +	"cfg": configuration space region
>> +- device_type: must be "pci"
>> +- interrupts: Should contain NWL PCIe interrupt
>> +- interrupt-names: Must include the following entries:
>> +	"misc": interrupt asserted when miscellaneous is recieved
>> +	"intx": interrupt that is asserted when an legacy interrupt is received
>> +	"msi_1, msi_0": interrupt asserted when msi is recieved
> 
> The msi and intx interrupts don't really belong here: For intx, please
> use an interrupt-map property as the other host drivers do.
> 
> For MSI, the usual answer is that there should be a separate device node
> for the MSI controller, and an msi-parent property in the PCI host.
> 
> This lets you use the same code for hosts that have a GICv2m or GICv3
> that comes with its own MSI controller.
> 

Sorry for stealing this discussion, :)

I have some questions here, since this affects how I should implement
the MSI support for iProc based PCIe controller. I understand it makes
more sense to use separate device node for MSI and have "msi-parent"
from the pci node points to the MSI node, and that MSI node can be
gicv2m or gicv3 based on more advanced ARMv8 platforms.

Then I would assume the MSI controller would deserve its own driver?
Which is a lot of people do nowadays. In that case, how I should handle
the case when the iProc MSI support is handled through some event queue
mechanism with their registers embedded in the PCIe controller register
space?

Does the following logic make sense to you?

1. parse phandle of "msi-parent"
2. Call of_pci_find_msi_chip_by_node to hook it up to msi chip already
registered (in the gicv2m and gicv3 case)
3. If failed, fall back to use the iProc's own event queue logic by
calling iproc_pcie_msi_init.

The iProc MSI still has its own node that looks like this:
141 msi0: msi@20020000 {
142                         msi-controller;
143                         interrupt-parent = <&gic>;
144                         interrupts = <GIC_SPI 277 IRQ_TYPE_NONE>,
145                                      <GIC_SPI 278 IRQ_TYPE_NONE>,
146                                      <GIC_SPI 279 IRQ_TYPE_NONE>,
147                                      <GIC_SPI 280 IRQ_TYPE_NONE>,
148                                      <GIC_SPI 281 IRQ_TYPE_NONE>,
149                                      <GIC_SPI 282 IRQ_TYPE_NONE>;
150                         brcm,num-eq-region = <1>;
151                         brcm,num-msi-msg-region = <1>;
152                 };

But it does not have its own "reg" since they are embedded in the PCI
controller's registers and it relies on one calling iproc_pcie_msi_init
to pass in base register value and some other information.

Thanks,

Ray
