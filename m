Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:41369 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaFXVT1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jun 2014 17:19:27 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so1195589lbg.37
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2014 14:19:26 -0700 (PDT)
Message-ID: <53A9EB5F.4050708@cogentembedded.com>
Date: Wed, 25 Jun 2014 01:19:27 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Phil Edworthy <phil.edworthy@renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v8 1/3] PCI: host: rcar: Add Renesas R-Car PCIe driver
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com> <1399892270-25021-2-git-send-email-phil.edworthy@renesas.com> <53A209DA.9000000@cogentembedded.com> <20a0a16226d54b0e8d6f68e41046bbf2@HKXPR06MB168.apcprd06.prod.outlook.com> <53A897EF.2020804@cogentembedded.com> <666f39dbf0f149c6946d4c2665d3d85d@HKXPR06MB168.apcprd06.prod.outlook.com>
In-Reply-To: <666f39dbf0f149c6946d4c2665d3d85d@HKXPR06MB168.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 06/24/2014 02:01 PM, Phil Edworthy wrote:

>>>>       I'm investigating an imprecise external abort occurring once userland is
>>>> started when I have NetMos

>>      Or is it MosChip now? Can't remember all their renames. :-)

> Do you know of somewhere I can buy a card with this chipset in the EU? I had a
> quick search but couldn't find anything.

    No. But we probably can send such card to you.

[...]

>>>>> +
>>>>> +	/* First resource is for IO */
>>>>> +	mask = PAR_ENABLE;
>>>>> +	if (res->flags & IORESOURCE_IO)
>>>>> +		mask |= IO_SPACE;

>>>>       For the memory space this works OK as you're identity-mapping the
>>>> memory
>>>> ranges in your device trees. However, for the I/O space this means that it
>>>> won't work as the BARs in the PCIe devices get programmed with the PCI bus
>>>> addresses but the PCIe window translation register is programmed with a
>>>> CPU
>>>> address which don't at all match (given your device trees) and hence one
>>>> can't
>>>> access the card's I/O mapped registers at all...

>>> Hmm, I couldn't find any cards that supported I/O, so I wasn't able to test
>>> this. Clearly this is an issue that needs looking into.

>>      Will you look into it then, or should I?

> I'll look at it.

    Thanks.

[...]

>>>>> +
>>>>> +		if (win > PCI_MAX_RESOURCES)
>>>>> +			break;
>>>>> +	}
>>>>> +
>>>>> +	 err = rcar_pcie_parse_map_dma_ranges(pcie, pdev->dev.of_node);
>>>>> +	 if (err)
>>>>> +		return err;
>>>>> +
>>>>> +	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
>>>>> +	if (!of_id || !of_id->data)
>>>>> +		return -EINVAL;
>>>>> +	hw_init_fn = of_id->data;
>>>>> +
>>>>> +	/* Failure to get a link might just be that no cards are inserted */
>>>>> +	err = hw_init_fn(pcie);
>>>>> +	if (err) {
>>>>> +		dev_info(&pdev->dev, "PCIe link down\n");
>>>>> +		return 0;

>>>>       Not quite sure why you exit normally here without enabling the
>>>> hardware.
>>>> I think the internal bridge should be visible regardless of whether link is
>>>> detected or not...

>>> Why would you want to see the bridge when you can do nothing with it?
>> Aren't

>>      Because it's the way PCI works. You have the built-in devices always
>> present and seen on a PCI bus. :-)

>>> you are just wasting resources?

>>      I think it's rather you who are wasting resources. ;-) Why not just fail
>> the probe when you have no link?

> Ah, so we currently have a half-way house... not failing the probe, but not
> enabling the HW. Either all or nothing would be preferable.

    Actually, I tried ignoring the link test and the kernel died horrible 
death without any console output. :-/ Having enabled the earlyprintk support, 
I was able to see the reason: panic("PCI: unable to scan bus!") in 
arch/arm/kernel/bios32.c...

> Thanks
> Phil

WBR, Sergei

