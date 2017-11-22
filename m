Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:53984 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdKVI7G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 03:59:06 -0500
Subject: =?UTF-8?Q?Re:_xhci=5fhcd_HC_died;_cleaning_up_with_TUSB7340_and_?=
 =?UTF-8?Q?=c2=b5PD720201?=
To: Chris Welch <Chris.Welch@viavisolutions.com>,
        "Quadros, Roger" <rogerq@ti.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
References: <BN6PR18MB124994D85EAC4B5B1AD5EC56866E0@BN6PR18MB1249.namprd18.prod.outlook.com>
 <3dd7a4fc-da86-03cc-9b01-a0d29dd73230@ti.com>
 <f57ccfd8-0b99-278c-6c10-474395f96a3c@ti.com>
 <124458f9-f824-6acb-becb-12d768b6e501@ti.com>
 <9dcdbc2a-9296-b260-10ed-08fde0c6f67c@ti.com>
 <d07f7bc9-0064-e84f-6a53-0768d1fe83b7@ti.com>
 <0c095d7f-4bc1-2306-248f-035fd06c1ed8@ti.com>
 <BN6PR18MB1249B64650CF0E38AFF87A9386230@BN6PR18MB1249.namprd18.prod.outlook.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <dfd0fdd5-ed97-d2f9-29ec-7c7ffc8ea1ce@ti.com>
Date: Wed, 22 Nov 2017 14:29:06 +0530
MIME-Version: 1.0
In-Reply-To: <BN6PR18MB1249B64650CF0E38AFF87A9386230@BN6PR18MB1249.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 21 November 2017 08:20 PM, Chris Welch wrote:
> 
> 
>> -----Original Message-----
>> From: Vignesh R [mailto:vigneshr@ti.com]
>> Sent: Tuesday, November 21, 2017 12:48 AM
>> To: Roger Quadros <rogerq@ti.com>
>> Cc: Chris Welch <Chris.Welch@viavisolutions.com>; linux-usb@vger.kernel.org;
>> linux-pci@vger.kernel.org; Joao Pinto <jpinto@synopsys.com>; KISHON VIJAY
>> ABRAHAM <kishon@ti.com>
>> Subject: Re: xhci_hcd HC died; cleaning up with TUSB7340 and µPD720201
>>
>>
>>
>> On Monday 20 November 2017 07:01 PM, Roger Quadros wrote:
>>> On 20/11/17 15:19, Vignesh R wrote:
>>>>
>>>>
>>>> On Monday 20 November 2017 01:31 PM, Roger Quadros wrote:
>>>> [...]
>>>>>>
>>>>>> So, could you try reverting commit 8c934095fa2f3 and also apply
>>>>>> below patch and let me know if that fixes the issue?
>>>>>>
>>>>>> -----------
>>>>>>
>>>>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c
>>>>>> b/drivers/pci/dwc/pci-dra7xx.c index e77a4ceed74c..8280abc56f30
>>>>>> 100644
>>>>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>>>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>>>>> @@ -259,10 +259,17 @@ static irqreturn_t
>> dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>>>>>>         u32 reg;
>>>>>>
>>>>>>         reg = dra7xx_pcie_readl(dra7xx,
>>>>>> PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>>>>>> +       dra7xx_pcie_writel(dra7xx,
>>>>>> + PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>>>>>>
>>>>>>         switch (reg) {
>>>>>>         case MSI:
>>>>>> -               dw_handle_msi_irq(pp);
>>>>>> +               /*
>>>>>> +                * Need to make sure no MSI IRQs are pending before
>>>>>> +                * exiting handler, else the wrapper will not catch new
>>>>>> +                * IRQs. So loop around till dw_handle_msi_irq() returns
>>>>>> +                * IRQ_NONE
>>>>>> +                */
>>>>>> +               while (dw_handle_msi_irq(pp) != IRQ_NONE);
> 
> The patch looks good, I haven't had a failure in a few days of testing.  

Thanks for testing! I will submit patches formally with some minor tweaks.

> 
> You should also look at incorporating the following that I needed to change to get our product working.  The first change fixes a miss by one error with the interrupt lines.  

Yeah, this is a known issue and has been discussed[1] before. We are
exploring better solution

> 
> The second change extends a patch you developed for errata i870 but we found is applicable to RC operation as well as EPs.  Thanks very much for your help!

Thanks for pointing that out, will submit a patch for errata workaround.

[1] https://lkml.org/lkml/2016/9/14/241

Regards
Vignesh
> 
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> old mode 100644
> new mode 100755
> index defa272..6245d89
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -238,8 +238,8 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
>                 dev_err(dev, "No PCIe Intc node found\n");
>                 return -ENODEV;
>         }
> -
> -       dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +        // PCI interrupt lines start at 1 not zero so need to add 1
> +       dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, 4 + 1,
>                                                    &intx_domain_ops, pp);
>         if (!dra7xx->irq_domain) {
>                 dev_err(dev, "Failed to get a INTx IRQ domain\n");
> @@ -706,10 +706,16 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>                 dra7xx_pcie_writel(dra7xx, PCIECTRL_TI_CONF_DEVICE_TYPE,
>                                    DEVICE_TYPE_RC);
>  
> +               // Errata i870 applies to RC as well as EP
> +               ret = dra7xx_pcie_ep_legacy_mode(dev);
> +               if (ret)
> +                       goto err_gpio;
> +
>                 ret = dra7xx_add_pcie_port(dra7xx, pdev);
>                 if (ret < 0)
>                         goto err_gpio;
>                 break;
> 
> 
>>>>>
>>>>> To avoid this kind of looping, shouldn't we be disabling all IRQ
>>>>> events while the interrupt handler is running and enable them just
>>>>> before we return from the hardirq handler?
>>>>
>>>> IIUC, you are saying to disable all MSIs at PCIe designware core
>>>> level, then call dw_handle_msi_irq() and then enable MSIs after
>>>> hardirq returns. But, the problem is if PCIe EP raises another MSI
>>>> after the call to EP's handler but before re-enabling MSIs, then it
>>>> will be ignored as IRQs are not yet enabled.
>>>> Ideally, EP's support Per Vector Masking(PVM) which allow RC to
>>>> prevent EP from sending MSI messages for sometime. But,
>>>> unfortunately, the cards mentioned here don't support this feature.
>>>
>>> I'm not aware of MSIs.
>>>
>>> But for any typical hardware, there should be an interrupt event
>>> enable register and an interrupt mask register.
>>>
>>> In the IRQ handler, we mask the interrupt but still keep the interrupt
>>> events enabled so that they can be latched during the time the interrupt was
>> masked.
>>>
>>> When the interrupt is unmasked at end of the IRQ handler, it should
>>> re-trigger the interrupt if any events were latched and pending.
>>>
>>> This way you don't need to keep checking for any pending events in the IRQ
>> handler.
>>>
>>
>> Thanks for the suggestion! I tried using interrupt masking at designware level.
>> But, unfortunately that does not help and my test cases still fail.
>> Seems like designware MSI status register is a non-masked status and dra7xx
>> specific wrapper seems to be relying on this non-masked status to raise
>> IRQ(instead of actual IRQ signal of designware) to CPU. There is very little
>> documentation in the TRM wrt how wrapper forwards designware IRQ status to
>> CPU.
>>
>> So, at best, I will add a check in the above while() loop and break and exit IRQ
>> handler, lets say after 1K loops.
>>
>>
>> --
>> Regards
>> Vignesh
