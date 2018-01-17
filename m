Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:26525 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeAQNGe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jan 2018 08:06:34 -0500
Subject: Re: Re-activate task to add MSI-X to pcie-designware
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <647c9bb3-94f6-a138-fbde-e946c105d517@synopsys.com>
 <20171208110225.GC26816@red-moon>
 <9ede58a6-7c0d-ae66-4e15-147234cbad6d@ti.com>
 <69f78abd-f83e-b3a6-0daf-638f89d07f99@synopsys.com>
 <8771860f-babd-afcb-ed07-2642d2a4d6a8@ti.com>
 <0531c3e9-57e7-d531-1bee-a5a5bbff2a8c@synopsys.com>
 <2e04befd-9434-b3ec-0c18-96a80744e327@ti.com>
 <513e28db-924d-569c-b3ae-cbb949229cc9@ti.com>
 <cafeb5b6-4954-becf-0d30-8b6ee7e71efa@synopsys.com>
 <2b0ad2cb-735b-e847-4c23-862e35b2c596@ti.com>
 <aa4e1e2b-b88e-a7f8-ded1-6af411f03a82@synopsys.com>
 <68fe0782-8223-10c7-5d7c-863841fc1954@ti.com>
 <1a81cf97-2478-6155-860e-e967de521b01@synopsys.com>
CC: Murali Karicheri <m-karicheri2@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Nori, Sekhar" <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b87298f1-00e3-0e99-4d01-97e3b485fd9f@ti.com>
Date: Wed, 17 Jan 2018 18:35:56 +0530
MIME-Version: 1.0
In-Reply-To: <1a81cf97-2478-6155-860e-e967de521b01@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 09 January 2018 04:02 PM, Gustavo Pimentel wrote:
> On 29/12/2017 10:05, Kishon Vijay Abraham I wrote:
>> Hi Gustavo,
>>
>> On Friday 29 December 2017 03:18 PM, Gustavo Pimentel wrote:
>>> Hi Kishon,
>>>
>>> On 28/12/2017 14:58, Kishon Vijay Abraham I wrote:
>>>> Hi Gustavo,
>>>>
>>>> On Wednesday 27 December 2017 07:55 PM, Gustavo Pimentel wrote:
>>>>> On 26/12/2017 12:57, Kishon Vijay Abraham I wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Saturday 23 December 2017 03:46 PM, Kishon Vijay Abraham I wrote:
>>>>>>> Hi Gustavo,
>>>>>>>
>>>>>>> On Thursday 21 December 2017 07:38 PM, Gustavo Pimentel wrote:
>>>>>>>> On 20/12/2017 13:03, Kishon Vijay Abraham I wrote:This is our most recent
>>>>>>>> version of the patches that are running on our equipment, please check with yours
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On Monday 18 December 2017 09:31 PM, Gustavo Pimentel wrote:
>>>>>>>>>> Hi Kishon,
>>>>>>>>>>
>>>>>>>>>> I would like to collaborate with you on this subject, I have on my side João's
>>>>>>>>>> patches updated to the Bjorn's latest kernel version.
>>>>>>>>>
>>>>>>>>> cool, do you have a branch so that I can check what breaks in keystone and debug?
>>>>>>>>>
>>>>>>>> Unfortunately not, however I'll mailed you the patches immediately.
>>>>>>>> Once again, thanks.
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>> I tried raising MSI with pci_endpoint_test EP device (16 MSI interrupts). Here
>>>>>>> are some of my observations after applying your patch series.
>>>>>>>
>>>>>>> root@k2g-evm:~# cat /proc/interrupts
>>>>>>>            CPU0
>>>>>>>  17:          0     GICv2  29 Level     arch_timer
>>>>>>>  18:       1816     GICv2  30 Level     arch_timer
>>>>>>>  21:          0     GICv2  36 Edge      arm-pmu
>>>>>>>  22:        792     GICv2 196 Edge      ttyS0
>>>>>>>  23:          5     GICv2 120 Edge      2530000.i2c
>>>>>>>  24:          0     GICv2  33 Edge      soc:keystone_irq@26202a0
>>>>>>>  25:        901     GICv2 356 Level     2a00000.msgmgr rx_005_002
>>>>>>>  41:          0     GICv2 232 Edge      2700000.edma_ccint
>>>>>>>  43:          0     GICv2 249 Edge      2700000.edma_ccerrint
>>>>>>>  44:       2497     GICv2 240 Edge      2728000.edma_ccint
>>>>>>>  46:          0     GICv2 252 Edge      2728000.edma_ccerrint
>>>>>>>  47:       7551     GICv2 128 Edge      mmc0
>>>>>>>  48:          0     GICv2 160 Edge      2680000.keystone-dwc3, xhci-hcd:usb1
>>>>>>>  49:          0     GICv2 176 Edge      2580000.keystone-dwc3, xhci-hcd:usb3
>>>>>>>  50:          0     GICv2  96 Edge      21805400.spi
>>>>>>>  52:          0     GICv2 100 Edge      21805c00.spi
>>>>>>>  53:          0     GICv2 102 Edge      21806000.spi
>>>>>>>  54:          0     GICv2  92 Edge      pcie-error-irq
>>>>>>> 211:          0      GPIO  12 Edge    -davinci_gpio  23000000.mmc cd
>>>>>>> 280:          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
>>>>>>> 281:          0   PCI-MSI 524288 Edge      pci-endpoint-test
>>>>>>> 282:          0   PCI-MSI 524289 Edge      pci-endpoint-test
>>>>>>> 283:          0   PCI-MSI 524290 Edge      pci-endpoint-test
>>>>>>> 284:          0   PCI-MSI 524291 Edge      pci-endpoint-test
>>>>>>> 285:          0   PCI-MSI 524292 Edge      pci-endpoint-test
>>>>>>> 286:          0   PCI-MSI 524293 Edge      pci-endpoint-test
>>>>>>> 287:          0   PCI-MSI 524294 Edge      pci-endpoint-test
>>>>>>> 288:          0   PCI-MSI 524295 Edge      pci-endpoint-test
>>>>>>> 289:          0   PCI-MSI 524296 Edge      pci-endpoint-test
>>>>>>> 290:          0   PCI-MSI 524297 Edge      pci-endpoint-test
>>>>>>> 291:          0   PCI-MSI 524298 Edge      pci-endpoint-test
>>>>>>> 292:          0   PCI-MSI 524299 Edge      pci-endpoint-test
>>>>>>> 293:          0   PCI-MSI 524300 Edge      pci-endpoint-test
>>>>>>> 294:          0   PCI-MSI 524301 Edge      pci-endpoint-test
>>>>>>> 295:          0   PCI-MSI 524302 Edge      pci-endpoint-test
>>>>>>> 296:          0   PCI-MSI 524303 Edge      pci-endpoint-test
>>>>>>> IPI0:          0  CPU wakeup interrupts
>>>>>>> IPI1:          0  Timer broadcast interrupts
>>>>>>> IPI2:          0  Rescheduling interrupts
>>>>>>> IPI3:          0  Function call interrupts
>>>>>>> IPI4:          0  CPU stop interrupts
>>>>>>> IPI5:          0  IRQ work interrupts
>>>>>>> IPI6:          0  completion interrupts
>>>>>>> Err:          0
>>>>>>>
>>>>>>> root@k2g-evm:~# pcitest -m 1
>>>>>>> [   45.966437] keystone-pcie 21801000.pcie: ks_pcie_msi_irq_handler, irq 271
>>>>>>> [   45.973544] keystone-pcie 21801000.pcie: irq: bit 0, vector 0, virq 280
>>>>>>> MSI1:           NOT OKAY
>>>>>>>
>>>>>>> Here there is an off by one error. "pcitest -m 1" should ideally have raised an
>>>>>>> interrupt in 281 but from the above debug print it looks like it's raising an
>>>>>>> interrupt in 280.
>>>>>>
>>>>>> The above error was due to an pci_endpoint bug. I'll send a patch to fix this
>>>>>> separately.
>>>>>
>>>>> Ok great!
>>>>
>>>> This too looks like a bug with the new API. If the EP requests 16 interrupts,
>>>> the MSI vector (programmed in PCI_MSI_DATA) should be 0 and if 0 is not
>>>> available it should be 16
>>>> [From the spec: The Multiple Message Enable field (bits 6-4 of the Message
>>>> Control register) defines the number of low
>>>> order message data bits the function is permitted to modify to generate its
>>>> system software allocated vectors]. For 16 interrupts, Multiple Message Enable
>>>> will have a value of 4 which means the EP can modify the 4 low order bits to
>>>> raise the 16 interrupts.
>>>>
>>>> With this series added, PCI_MSI_DATA is programmed to 0x1 which gets masked
>>>> while the EP tries to raise an interrupt and hence we are observing off by one
>>>> error.
> 
> So the problem that you saying could be on setting the correct value on the
> PCI_MSI_DATA, right?

correct.
> While I'm trying to support pcitest to be able in future to run the same tests
> that you on my system, I have added some debug on msi.c file that could provide
> me the same info that you have refer before in a short time.
> With the same USB 3.1 PCIe board as a EP, I have generated 2 linux images (with
> and without the patches series).
> 
> Without the patches
> DEBUG:drivers/pci/msi.c:pci_msi_vec_count:881 msgctl = 0x86
> DEBUG:drivers/pci/msi.c:msi_setup_entry:554 control = 0x86
> DEBUG:drivers/pci/msi.c:msi_setup_entry:555 nvec = 0x1
> DEBUG:drivers/pci/msi.c:msi_setup_entry:563 entry->msi_attrib.multi_cap = 0x3
> DEBUG:drivers/pci/msi.c:msi_setup_entry:564 entry->msi_attrib.multiple = 0x0
> DEBUG:drivers/pci/msi.c:__pci_write_msi_msg:314 msgctl = 0x86
> DEBUG:drivers/pci/msi.c:__pci_write_msi_msg:317 entry->msi_attrib.multiple =
> 0x0, msgctl = 0x86
> 
> With the patches (I have commented the MSI_FLAG_PCI_MSIX flag)
> DEBUG:drivers/pci/msi.c:pci_msi_vec_count:882 msgctl = 0x86
> DEBUG:drivers/pci/msi.c:msi_setup_entry:555 control = 0x86
> DEBUG:drivers/pci/msi.c:msi_setup_entry:556 nvec = 0x1
> DEBUG:drivers/pci/msi.c:msi_setup_entry:564 entry->msi_attrib.multi_cap = 0x3
> DEBUG:drivers/pci/msi.c:msi_setup_entry:565 entry->msi_attrib.multiple = 0x0
> DEBUG:drivers/pci/msi.c:__pci_write_msi_msg:315 msgctl = 0x86
> DEBUG:drivers/pci/msi.c:__pci_write_msi_msg:318 entry->msi_attrib.multiple =
> 0x0, msgctl = 0x86

What is the msg data?
> 
> The defined values before the patch are the same with the patch series. Maybe
> this only happens with a bigger number of interrupts required. I will continue
> to work on pcitest to perform the same test that you have done.

The issue happens when 2 devices requesting for MSI.
> 
>>>
>>> The EP (USB 3.1 PCIe board) that I usually use only have 2 interrupts. I didn't
>>> perform the tests like you did. I typically plug the USB flash drive and observe
>>> the number of interrupts and perform some basic file operations on the USB flash
>>> drive (copy/move/delete/rename).
>>
>> Do you have PCIEPORTBUS enabled? That takes 1 interrupt (assuming your host has
>> the required capabilities). You should be able to reproduce the issue with just
>> PCIEPORTBUS enabled then. (With your series added msg_data on USB device will
>> be 0x1 whereas it should be 0x2.
> 
> I checked now, I have PCIEPORTBUS enabled.
> 
>>
>> Before the patch series order_base_2 below helped in taking care of that.
>> pos0 = bitmap_find_free_region(pp->msi_irq_in_use, MAX_MSI_IRQS,
>> order_base_2(no_irqs));
>>>
>>> Can you provide me information (source code, how to compile, how to use, that
>>> kind of info) about the pcitest tool that you mentioned? I would like to use it
>>> if possible, please.
>>
>> Documentation/PCI/endpoint/ should have all the info..
> 
> Ok. After this patch series, maybe we could improve the tool and add the MSI-X
> support also. :)

yeah.. that would be great!

Thanks
Kishon
