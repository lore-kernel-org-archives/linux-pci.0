Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50640 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932364AbbEMSnu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 May 2015 14:43:50 -0400
Message-ID: <55539B63.2060203@hauke-m.de>
Date: Wed, 13 May 2015 20:43:47 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ray Jui <rjui@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 2/2] PCI: iproc: add bcma pcie driver
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>	<1431465781-10753-3-git-send-email-hauke@hauke-m.de>	<CACna6rxVpJ-4b_5jG91JN62jQHh8u=QaLpO+_7J9mFr+_ScPaA@mail.gmail.com>	<5553742E.7070204@broadcom.com> <CACna6rzT=218pQk9M6NJWH51wszn=p0LmHrizrvV9Xkn-=Om3Q@mail.gmail.com> <55537C43.4050606@broadcom.com>
In-Reply-To: <55537C43.4050606@broadcom.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/13/2015 06:30 PM, Ray Jui wrote:
> Hi Rafal,
> 
> On 5/13/2015 9:19 AM, Rafał Miłecki wrote:
>> On 13 May 2015 at 17:56, Ray Jui <rjui@broadcom.com> wrote:
>>> On 5/12/2015 11:27 PM, Rafał Miłecki wrote:
>>>> On 12 May 2015 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>>>> This driver adds support for the PCIe 2.0 controller found on the bcma
>>>>> bus. This controller can be found on (mostly) all Broadcom BCM470X /
>>>>> BCM5301X ARM SoCs.
>>>>>
>>>>> The driver found in the Broadcom SDK does some more stuff, like setting
>>>>> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
>>>>> PHY changes like "improving" the PCIe jitter and doing some special
>>>>> initializations for the 3rd PCIe port.
>>>>>
>>>>> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
>>>>> connected to them.
>>>>>
>>>>> PCI_DOMAINS is needed by this driver, because normally there is more
>>>>> than one PCIe controller and without PCI_DOMAINS only the first
>>>>> controller gets registered.
>>>>> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
>>>>>
>>>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>>>
>>>> Acked-by: Rafał Miłecki <zajec5@gmail.com>
>>>>
>>>>
>>>>> +static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>>>>> +{
>>>>> +       struct iproc_pcie *pcie;
>>>>> +       LIST_HEAD(res);
>>>>> +       struct resource res_mem;
>>>>> +       int ret;
>>>>> +
>>>>> +       pcie = devm_kzalloc(&bdev->dev, sizeof(*pcie), GFP_KERNEL);
>>>>> +       if (!pcie)
>>>>> +               return -ENOMEM;
>>>>> +
>>>>> +       pcie->dev = &bdev->dev;
>>>>> +       bcma_set_drvdata(bdev, pcie);
>>>>> +
>>>>> +       pcie->base = bdev->io_addr;
>>>>> +
>>>>> +       res_mem.start = bdev->addr_s[0];
>>>>> +       res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
>>>>> +       res_mem.name = "PCIe MEM space";
>>>>> +       res_mem.flags = IORESOURCE_MEM;
>>>>> +       pci_add_resource(&res, &res_mem);
>>>>> +
>>>>> +       pcie->resources = &res;
>>>>> +
>>>>> +       pcie->map_irq = iproc_pcie_bcma_map_irq;
>>>>> +
>>>>> +       ret = iproc_pcie_setup(pcie);
>>>>
>>>> I think I don't like this part of iproc design. It lefts
>>>> pcie->resources pointing to some random memory after the setup/probe
>>>> are done. Guess it should be a separated parameter or sth.
>>>>
>>>> The patch is still OK, I just refer to generic iproc possible issue.
>>>>
>>> Sorry Rafal, but could you please be more specific on this?
>>
>> iproc_pcie_pltfm_probe (and iproc_pcie_bcma_probe) have local "res"
>> variable (each its own). They do:
>> pcie->resources = &res;
>> and then they call
>> iproc_pcie_setup(pcie);
>>
>> After iproc_pcie_pltfm_probe / iproc_pcie_bcma_probe returns, the
>> pointer pcie->resources is not valid anymore, yet pcie struct is still
>> in use. Of course pcie->resources isn't used anymore, but still, it's
>> some in-struct pointer (to the random memory since local variable is
>> not accessible anymore).
>>
>> I think you should drop
>> struct list_head *resources;
>> from the struct iproc_pcie and use
>> iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *resources)
>>
> 
> Okay thanks. That makes sense.
> 
> Or I should keep a copy of the resources under pcie->resources. In the
> current pcie-iproc.c, the resource is not used anywhere else except when
> creating the root bus under iproc_pcie_setup. But in the future, I might
> need to add more code to explicitly program the outbound/inbound windows
> so this driver can work with some other iProc SoCs where the desired
> windows do not match power-on-reset values.
> 
> I plan to change this along with the window programming patch in the
> future. I also think Hauke's current patch is fine.
> 
> Thanks,
> 
> Ray
> 
I think parts of this resources are allocated and never freed.

pci_add_resource() allocates some bytes, but I do not see where they are
freed, this also applies to the platform driver.

Hauke
