Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:19280 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756216AbeAHNs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jan 2018 08:48:27 -0500
Subject: Re: [PATCH v2 1/2] PCI: dra7xx: Fix legacy INTD IRQ handling
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-2-vigneshr@ti.com>
 <953c7aac-0429-8fc7-02ce-ace94aa735f3@ti.com>
 <ebf49e7f-7008-18b8-62d9-9f3dc2de6a54@ti.com>
 <20180104161202.GB12239@red-moon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <493a4f80-677c-b213-d13a-e922b28c38e0@ti.com>
Date: Mon, 8 Jan 2018 19:18:59 +0530
MIME-Version: 1.0
In-Reply-To: <20180104161202.GB12239@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thursday 04 January 2018 09:42 PM, Lorenzo Pieralisi wrote:
> On Thu, Jan 04, 2018 at 07:04:30PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Thursday 04 January 2018 11:38 AM, Kishon Vijay Abraham I wrote:
>>>
>>>
>>> On Friday 29 December 2017 05:11 PM, Vignesh R wrote:
>>>> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
>>>> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
>>>> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
>>>> pci-dra7xx driver following warning is seen:
>>>>
>>>>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
>>>>        error: hwirq 0x4 is too large for dummy
>>>>
>>>> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
>>>> range into the 0-3 as done in other PCIe drivers.
>>>>
>>>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> Reported-by: Chris Welch <Chris.Welch@viavisolutions.com>
>>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>>
>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/dwc/pci-dra7xx.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>>> index 58aed0896468..892f93910012 100644
>>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>>> @@ -226,6 +226,7 @@ static int dra7xx_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>>>>  
>>>>  static const struct irq_domain_ops intx_domain_ops = {
>>>>  	.map = dra7xx_pcie_intx_map,
>>>> +	.xlate = pci_irqd_intx_xlate,
>>
>> Looking at this again, I think the mapping should be done in device tree using
>> the interrupt-map property.
>>
>> Lorenzo, can you hold merging this patch till we verify using the dt approach?
> 
> Yes and I agree that's a DT mapping bug.

I did some testing by changing interrupt-map property of PCIe node as as
below:
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 261b5deb2456..2b1a2c5303bb 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -332,10 +332,10 @@
                                phys = <&pcie1_phy>;
                                phy-names = "pcie-phy0";
                                interrupt-map-mask = <0 0 0 7>;
-                               interrupt-map = <0 0 0 1 &pcie1_intc 1>,
-                                               <0 0 0 2 &pcie1_intc 2>,
-                                               <0 0 0 3 &pcie1_intc 3>,
-                                               <0 0 0 4 &pcie1_intc 4>;
+                               interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+                                               <0 0 0 2 &pcie1_intc 1>,
+                                               <0 0 0 3 &pcie1_intc 2>,
+                                               <0 0 0 4 &pcie1_intc 3>;


Although this eliminates need for xlate, we still need driver change to
call the correct handler with above change:

static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
@@ -269,7 +270,7 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int
irq, void *arg)
 	case INTC:
 	case INTD:
 		generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
-						    ffs(reg)));
+						    ffs(reg) - 1));
 		break;
 	}


If we merge the driver change then the DT backward compatibility is
broken. Right now INTA/B/C keep working even with buggy interrupt-map
settings. But, if we fix  interrupt-map and merge above driver change,
then we will be *breaking* DT backward compatibility and INTA/B/C will
no longer work with older DTs.
Therefore, IMO, this patch should be merged in order to keep DT backward
compatibility and live with wrong DT representation.


-- 
Regards
Vignesh
