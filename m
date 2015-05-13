Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35040 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbbEMQTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 12:19:42 -0400
Received: by igbyr2 with SMTP id yr2so143566093igb.0
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 09:19:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5553742E.7070204@broadcom.com>
References: <1431465781-10753-1-git-send-email-hauke@hauke-m.de>
	<1431465781-10753-3-git-send-email-hauke@hauke-m.de>
	<CACna6rxVpJ-4b_5jG91JN62jQHh8u=QaLpO+_7J9mFr+_ScPaA@mail.gmail.com>
	<5553742E.7070204@broadcom.com>
Date: Wed, 13 May 2015 18:19:41 +0200
Message-ID: <CACna6rzT=218pQk9M6NJWH51wszn=p0LmHrizrvV9Xkn-=Om3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: add bcma pcie driver
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13 May 2015 at 17:56, Ray Jui <rjui@broadcom.com> wrote:
> On 5/12/2015 11:27 PM, Rafał Miłecki wrote:
>> On 12 May 2015 at 23:23, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> This driver adds support for the PCIe 2.0 controller found on the bcma
>>> bus. This controller can be found on (mostly) all Broadcom BCM470X /
>>> BCM5301X ARM SoCs.
>>>
>>> The driver found in the Broadcom SDK does some more stuff, like setting
>>> up some DMA memory areas, chaining MPS and MRRS to 512 and also some
>>> PHY changes like "improving" the PCIe jitter and doing some special
>>> initializations for the 3rd PCIe port.
>>>
>>> This was tested on a bcm4708 board with 2 PCIe ports and wireless cards
>>> connected to them.
>>>
>>> PCI_DOMAINS is needed by this driver, because normally there is more
>>> than one PCIe controller and without PCI_DOMAINS only the first
>>> controller gets registered.
>>> This controller gets 6 IRQs, the last one is trigged by all IRQ events.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>
>> Acked-by: Rafał Miłecki <zajec5@gmail.com>
>>
>>
>>> +static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
>>> +{
>>> +       struct iproc_pcie *pcie;
>>> +       LIST_HEAD(res);
>>> +       struct resource res_mem;
>>> +       int ret;
>>> +
>>> +       pcie = devm_kzalloc(&bdev->dev, sizeof(*pcie), GFP_KERNEL);
>>> +       if (!pcie)
>>> +               return -ENOMEM;
>>> +
>>> +       pcie->dev = &bdev->dev;
>>> +       bcma_set_drvdata(bdev, pcie);
>>> +
>>> +       pcie->base = bdev->io_addr;
>>> +
>>> +       res_mem.start = bdev->addr_s[0];
>>> +       res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
>>> +       res_mem.name = "PCIe MEM space";
>>> +       res_mem.flags = IORESOURCE_MEM;
>>> +       pci_add_resource(&res, &res_mem);
>>> +
>>> +       pcie->resources = &res;
>>> +
>>> +       pcie->map_irq = iproc_pcie_bcma_map_irq;
>>> +
>>> +       ret = iproc_pcie_setup(pcie);
>>
>> I think I don't like this part of iproc design. It lefts
>> pcie->resources pointing to some random memory after the setup/probe
>> are done. Guess it should be a separated parameter or sth.
>>
>> The patch is still OK, I just refer to generic iproc possible issue.
>>
> Sorry Rafal, but could you please be more specific on this?

iproc_pcie_pltfm_probe (and iproc_pcie_bcma_probe) have local "res"
variable (each its own). They do:
pcie->resources = &res;
and then they call
iproc_pcie_setup(pcie);

After iproc_pcie_pltfm_probe / iproc_pcie_bcma_probe returns, the
pointer pcie->resources is not valid anymore, yet pcie struct is still
in use. Of course pcie->resources isn't used anymore, but still, it's
some in-struct pointer (to the random memory since local variable is
not accessible anymore).

I think you should drop
struct list_head *resources;
from the struct iproc_pcie and use
iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *resources)

-- 
Rafał
