Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27397 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbdKVKk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 05:40:57 -0500
Subject: =?UTF-8?Q?Re:_xhci=5fhcd_HC_died;_cleaning_up_with_TUSB7340_and_?=
 =?UTF-8?Q?=c2=b5PD720201?=
To: Chris Welch <Chris.Welch@viavisolutions.com>,
        "Quadros, Roger" <rogerq@ti.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        KISHON VIJAY ABRAHAM <kishon@ti.com>
References: <BN6PR18MB124994D85EAC4B5B1AD5EC56866E0@BN6PR18MB1249.namprd18.prod.outlook.com>
 <3dd7a4fc-da86-03cc-9b01-a0d29dd73230@ti.com>
 <f57ccfd8-0b99-278c-6c10-474395f96a3c@ti.com>
 <124458f9-f824-6acb-becb-12d768b6e501@ti.com>
 <9dcdbc2a-9296-b260-10ed-08fde0c6f67c@ti.com>
 <d07f7bc9-0064-e84f-6a53-0768d1fe83b7@ti.com>
 <0c095d7f-4bc1-2306-248f-035fd06c1ed8@ti.com>
 <BN6PR18MB1249B64650CF0E38AFF87A9386230@BN6PR18MB1249.namprd18.prod.outlook.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <32b12781-e4db-289d-2a73-cd0efb056fe8@ti.com>
Date: Wed, 22 Nov 2017 16:11:27 +0530
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
> 
> You should also look at incorporating the following that I needed to change to get our product working.  The first change fixes a miss by one error with the interrupt lines.  
> 
> The second change extends a patch you developed for errata i870 but we found is applicable to RC operation as well as EPs.  Thanks very much for your help!

BTW, do you have a test case which fails w/o errata i870 workaround?


-- 
Regards
Vignesh
