Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:22206 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdKTNbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2017 08:31:06 -0500
Subject: =?UTF-8?Q?Re:_xhci=5fhcd_HC_died;_cleaning_up_with_TUSB7340_and_?=
 =?UTF-8?Q?=c2=b5PD720201?=
To: Vignesh R <vigneshr@ti.com>
CC: Chris Welch <Chris.Welch@viavisolutions.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Joao Pinto <jpinto@synopsys.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>
References: <BN6PR18MB124994D85EAC4B5B1AD5EC56866E0@BN6PR18MB1249.namprd18.prod.outlook.com>
 <3dd7a4fc-da86-03cc-9b01-a0d29dd73230@ti.com>
 <f57ccfd8-0b99-278c-6c10-474395f96a3c@ti.com>
 <124458f9-f824-6acb-becb-12d768b6e501@ti.com>
 <9dcdbc2a-9296-b260-10ed-08fde0c6f67c@ti.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <d07f7bc9-0064-e84f-6a53-0768d1fe83b7@ti.com>
Date: Mon, 20 Nov 2017 15:31:00 +0200
MIME-Version: 1.0
In-Reply-To: <9dcdbc2a-9296-b260-10ed-08fde0c6f67c@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/11/17 15:19, Vignesh R wrote:
> 
> 
> On Monday 20 November 2017 01:31 PM, Roger Quadros wrote:
> [...]
>>>
>>> So, could you try reverting commit 8c934095fa2f3 and 
>>> also apply below patch and let me know if that fixes the issue?
>>>
>>> -----------
>>>
>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>> index e77a4ceed74c..8280abc56f30 100644
>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>> @@ -259,10 +259,17 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>>         u32 reg;
>>>  
>>>         reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>>> +       dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>>>  
>>>         switch (reg) {
>>>         case MSI:
>>> -               dw_handle_msi_irq(pp);
>>> +               /*
>>> +                * Need to make sure no MSI IRQs are pending before
>>> +                * exiting handler, else the wrapper will not catch new
>>> +                * IRQs. So loop around till dw_handle_msi_irq() returns
>>> +                * IRQ_NONE
>>> +                */
>>> +               while (dw_handle_msi_irq(pp) != IRQ_NONE);
>>
>> To avoid this kind of looping, shouldn't we be disabling all IRQ events while
>> the interrupt handler is running and enable them just before we return from the hardirq
>> handler?
> 
> IIUC, you are saying to disable all MSIs at PCIe designware core level,
> then call dw_handle_msi_irq() and then enable MSIs after hardirq
> returns. But, the problem is if PCIe EP raises another MSI after the
> call to EP's handler but before re-enabling MSIs, then it will be
> ignored as IRQs are not yet enabled.
> Ideally, EP's support Per Vector Masking(PVM) which allow RC to prevent
> EP from sending MSI messages for sometime. But, unfortunately, the cards
> mentioned here don't support this feature.

I'm not aware of MSIs.

But for any typical hardware, there should be an interrupt event enable register and an
interrupt mask register.

In the IRQ handler, we mask the interrupt but still keep the interrupt events enabled so that
they can be latched during the time the interrupt was masked.

When the interrupt is unmasked at end of the IRQ handler, it should re-trigger the interrupt
if any events were latched and pending.

This way you don't need to keep checking for any pending events in the IRQ handler.

> 
>>
>>
>>>                 break;
>>>         case INTA:
>>>         case INTB:
>>> @@ -273,8 +280,6 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>>                 break;
>>>         }
>>>  
>>> -       dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>>> -
>>>         return IRQ_HANDLED;
>>>  }
>>>
>>>
>>>
>>>
>>
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
