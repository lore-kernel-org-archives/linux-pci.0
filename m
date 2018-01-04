Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:47127 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeADGOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 01:14:31 -0500
Subject: Re: [PATCH v2 2/2] PCI: dra7xx: Iterate over INTx status bits
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20171229114131.22296-1-vigneshr@ti.com>
 <20171229114131.22296-3-vigneshr@ti.com> <20180102154750.GA13516@red-moon>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <71dda179-8b0a-3ee4-ebd3-c7f4127c01e6@ti.com>
Date: Thu, 4 Jan 2018 11:45:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180102154750.GA13516@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 02 January 2018 09:17 PM, Lorenzo Pieralisi wrote:
> On Fri, Dec 29, 2017 at 05:11:31PM +0530, Vignesh R wrote:
>> It is possible that more than one legacy IRQ may be set at the same
>> time, therefore iterate and handle all the pending INTx interrupts
>> before clearing the status and exiting the IRQ handler. Otherwise, some
>> interrupts would be lost.
>> 
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/pci/dwc/pci-dra7xx.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>> index 892f93910012..48c6ae535847 100644
>> --- a/drivers/pci/dwc/pci-dra7xx.c
>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>> @@ -257,7 +257,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>        struct dra7xx_pcie *dra7xx = arg;
>>        struct dw_pcie *pci = dra7xx->pci;
>>        struct pcie_port *pp = &pci->pp;
>> -     u32 reg;
>> +     unsigned long reg;
>> +     u32 virq, bit;
>>  
>>        reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>>  
>> @@ -269,8 +270,11 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>        case INTB:
>>        case INTC:
>>        case INTD:
>> -             generic_handle_irq(irq_find_mapping(dra7xx->irq_domain,
>> -                                                 ffs(reg) - 1));
>> +             for_each_set_bit(bit, &reg, PCI_NUM_INTX) {
>> +                     virq = irq_find_mapping(dra7xx->irq_domain, bit);
>> +                     if (virq)
>> +                             generic_handle_irq(virq);
>> +             }
>>                break;
>>        }
> 
> It is not strictly related to this patch but why MSI and INTX are
> handled as mutually exclusive in dra7xx_pcie_msi_irq_handler() ?

I think the driver previously assumed MSI and legacy IRQs are exclusive
of each other, which is not true. Will try to fix this along with couple
of other fixes that I have for MSI IRQ handling.


-- 
Regards
Vignesh
