Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:51740 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdEHJ7H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2017 05:59:07 -0400
Subject: Re: [RFC] pci: using new interrupt API to enable MSI and MSI-X
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
 <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
CC: <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <1b77d1ec-5fc8-d548-7e84-8d05a31849aa@synopsys.com>
Date: Mon, 8 May 2017 10:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 3:57 PM de 5/5/2017, Marc Zyngier escreveu:
> Joao,
> 
> On 05/05/17 15:11, Joao Pinto wrote:
>> Hello,
>> I am currently adding the support for both MSI and MSI-x in pcie-designware and
>> I am now facing a dificulty.
>>
>> My test endpoint is a USB 3.1 MSI / MSI-X capable and I tested that with
>> the changes introduced by this patch we are able to enable MSI and MSI-X
>> in this endpoint (depends on the usage of the MSI_FLAG_PCI_MSIX flag).
>>
>> The problem I am facing now is that Intc for the USB 3.1 Endpoint is completely
>> bogus (524288) when it should be 1, and so I am not receiving any interrupts
>> from the endpoint.
> 
> It is not bogus at all. It is computed from the PCI requester ID in 
> pci_msi_domain_calc_hwirq. What you're seeing is the PCI/MDI domain 
> view of that interrupt, which is completely virtual.
> 
> The real thing happens in your own irqdomain, where the hwirq for IRQ46 
> is probably 1 (only you can know that). As for why it doesn't work, see 
> below:
> 
>>
>> I would apreciate that more experienced people in this interrupt subject could
>> give me an hint.
>>
>> I send you the "lspci -v" results and /proc/interrupts.
>>
>> Thank you so much for your help.
>>
>> # cat /proc/interrupts
>>            CPU0
>>   3:        755  ARC In-core Intc   3  Timer0 (per-cpu-tick)
>>   4:          0  dw-apb-ictl   4  eth0
>>   8:          1  dw-apb-ictl   8  ehci_hcd:usb1, ohci_hcd:usb2
>>   9:         37  dw-apb-ictl   7  dw-mci
>>  14:          0  dw-apb-ictl  14  e001d000.i2c
>>  16:          0  dw-apb-ictl  16  e001f000.i2c
>>  19:        145  dw-apb-ictl  19  serial
>>  45:          0   PCI-MSI   0  aerdrv
>>  46:          0   PCI-MSI 524288  xhci_hcd
>>
>> # lspci -v
>> 00:00.0 PCI bridge: Synopsys, Inc. Device eddc (rev 01) (prog-if 00 [Normal decode])
>>         Flags: bus master, fast devsel, latency 0, IRQ 45
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>>         Memory behind bridge: d0400000-d04fffff
>>         [virtual] Expansion ROM at d0500000 [disabled] [size=64K]
>>         Capabilities: [40] Power Management version 3
>>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>         Capabilities: [70] Express Root Port (Slot-), MSI 00
>>         Capabilities: [100] Advanced Error Reporting
>>         Capabilities: [148] #19
>>         Capabilities: [158] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>>         Kernel driver in use: pcieport
>>
>> 01:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller (prog-if 30 [XHCI])
>>         Subsystem: ASMedia Technology Inc. ASM1142 USB 3.1 Host Controller
>>         Flags: bus master, fast devsel, latency 0, IRQ 46
>>         Memory at d0400000 (64-bit, non-prefetchable) [size=32K]
>>         Capabilities: [50] MSI: Enable+ Count=1/8 Maskable- 64bit+
>>         Capabilities: [68] MSI-X: Enable- Count=8 Masked-
>>         Capabilities: [78] Power Management version 3
>>         Capabilities: [80] Express Endpoint, MSI 00
>>         Capabilities: [100] Virtual Channel
>>         Capabilities: [200] Advanced Error Reporting
>>         Capabilities: [280] #19
>>         Capabilities: [300] Latency Tolerance Reporting
>>         Kernel driver in use: xhci_hcd
>>
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>>  .../devicetree/bindings/pci/designware-pcie.txt    |   2 +
>>  drivers/pci/dwc/pcie-designware-host.c             | 292 ++++++++-------------
>>  drivers/pci/dwc/pcie-designware-plat.c             |  35 +--
>>  drivers/pci/dwc/pcie-designware.h                  |   7 +-
>>  4 files changed, 143 insertions(+), 193 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index b2480dd..41803ea 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -34,6 +34,8 @@ Optional properties:
>>  RC mode:
>>  - num-viewport: number of view ports configured in
>>    hardware. If a platform does not specify it, the driver assumes 2.
>> +- num-vectors: number of available interrupt vectors. If a platform does not
>> +  specify it, the driver assumes 1.
>>  - bus-range: PCI bus numbers covered (it is recommended
>>    for new devicetrees to specify this property, to keep backwards
>>    compatibility a range of 0x00-0xff is assumed if not present)
>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>> index 28ed32b..96a5fb3 100644
>> --- a/drivers/pci/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>> @@ -11,6 +11,9 @@
>>   * published by the Free Software Foundation.
>>   */
>>  
>> +#include <linux/interrupt.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/msi.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_pci.h>
>> @@ -53,32 +56,43 @@ static struct irq_chip dw_msi_irq_chip = {
>>  	.irq_unmask = pci_msi_unmask_irq,
>>  };
> 
> It looks to me like the first mistake is just above. You don't seem to
> propagate the mask/unmask operations into the parent domain, so your
> interrupts are never enabled... You'd need something like this:
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 28ed32ba4f1b..d42b8b12f168 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -45,12 +45,22 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
>  	return dw_pcie_write(pci->dbi_base + where, size, val);
>  }
>  
> +static void dw_msi_mask_irq(struct irq_data *d)
> +{
> +	pci_msi_mask_irq(d);
> +	irq_chip_mask_parent(d);
> +}
> +
> +static void dw_msi_unmask_irq(struct irq_data *d)
> +{
> +	pci_msi_unmask_irq(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
>  static struct irq_chip dw_msi_irq_chip = {
>  	.name = "PCI-MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> +	.irq_mask = dw_msi_mask_irq,
> +	.irq_unmask = dw_msi_unmask_irq,
>  };
> 
> I haven't dug any further, but this should be fixed first.
> 
> Thanks,
> 
> 	M.
> 

Yep makes perfectly sense and thanks for clearing the Domains :), I understood
them now.

Best regards,
Joao
