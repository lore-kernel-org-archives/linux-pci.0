Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38435 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaA2JNv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 04:13:51 -0500
Received: by mail-lb0-f180.google.com with SMTP id n15so1198181lbi.25
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 01:13:49 -0800 (PST)
Message-ID: <52E8C64B.8060307@cogentembedded.com>
Date: Wed, 29 Jan 2014 13:13:47 +0400
From: Valentine <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
To: Simon Horman <horms@verge.net.au>
CC: Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: rcar: fix bridge logic configuration accesses
References: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk> <1390903616-8073-4-git-send-email-ben.dooks@codethink.co.uk> <52E807E9.8060900@cogentembedded.com> <20140129064234.GG23833@verge.net.au>
In-Reply-To: <20140129064234.GG23833@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/29/2014 10:42 AM, Simon Horman wrote:
> On Tue, Jan 28, 2014 at 11:41:29PM +0400, Valentine wrote:
>> On 01/28/2014 02:06 PM, Ben Dooks wrote:
>>> The bridge logic at slot 0 only supports reads up to 0x40 and the
>>> rest of the PCI configuration space for this slot is marked as
>>> reserved in the manual.
>>>
>>> Trying a read from offset 0x100 is producing an error from the
>>> bridge. With error interrupts enabled, the following is printed:
>>
>> I don't think this is a critical error.
>> The bridge works fine after an attempt to access the unsupported PCIe/PCI-X 2 area.
>>
>> If you want to prevent the access, I'm OK with it.
>> But I think it's better to do "if (where <= 0x100)"
>> and drop the slot check since all other slots do not support
>> access beyond 0x100 as well.
>>
>> The PCI code attempts to access beyond 0x100 only once when probing PCI bridges
>> to see if they support PCIe/PCI-X 2 area which is 4K.
>> The area beyond 0x40 is never accessed because the bridge does not expose any PCI capabilities.
>>
>>>
>>> pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014
>>
>> Did you experience any problems other than this message
>> printed by the IRQ handler introduced by the previous patch?
>
> I am wondering if the documentation for the r8a7790 and r8a7791 are
> the same with regards to the <= 0x100 limit.
>

It is the same since it is neither a PCIe nor a PCI-X 2 device.

Thanks,
Val.

>>
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>> Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> Cc: Simon Horman <horms@verge.net.au>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: linux-pci@vger.kernel.org
>>> Cc: linux-sh@vger.kernel.org
>>> ---
>>>   drivers/pci/host/pci-rcar-gen2.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
>>> index 01ba069..42f0105 100644
>>> --- a/drivers/pci/host/pci-rcar-gen2.c
>>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>>> @@ -119,6 +119,10 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
>>>   	if (slot > 2)
>>>   		return NULL;
>>>
>>> +	/* bridge logic only has registers to 0x40 */
>>> +	if (slot == 0x0 && where >= 0x40)
>>> +		return NULL;
>>> +
>>>   	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
>>>   		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
>>>
>>>
>>
>> Thanks,
>> Val.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

