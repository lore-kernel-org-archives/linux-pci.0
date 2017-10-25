Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:49318 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdJYQAF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2017 12:00:05 -0400
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00A252D@AcuExch.aculab.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-5-git-send-email-jim2101024@gmail.com> <063D6719AE5E284EB5DD2968C1650D6DD00A252D@AcuExch.aculab.com>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Wed, 25 Oct 2017 12:00:03 -0400
Message-ID: <CANCKTBuH_FsRAEWtae5L_YvvC6QQSKETLNKU+G+8_LGwMy6smw@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: host: brcmstb: add dma-ranges for inbound traffic
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 25, 2017 at 5:46 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Jim QuinlanPCIE_IPROC_MSI
>> Sent: 24 October 2017 19:16
>> The Broadcom STB PCIe host controller is intimately related to the
>> memory subsystem.  This close relationship adds complexity to how cpu
>> system memory is mapped to PCIe memory.  Ideally, this mapping is an
>> identity mapping, or an identity mapping off by a constant.  Not so in
>> this case.
>>
>> Consider the Broadcom reference board BCM97445LCC_4X8 which has 6 GB
>> of system memory.  Here is how the PCIe controller maps the
>> system memory to PCIe memory:
>>
>>   memc0-a@[        0....3fffffff] <=> pci@[        0....3fffffff]
>>   memc0-b@[100000000...13fffffff] <=> pci@[ 40000000....7fffffff]
>>   memc1-a@[ 40000000....7fffffff] <=> pci@[ 80000000....bfffffff]
>>   memc1-b@[300000000...33fffffff] <=> pci@[ c0000000....ffffffff]
>>   memc2-a@[ 80000000....bfffffff] <=> pci@[100000000...13fffffff]
>>   memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
>
> I presume the first column is the 'cpu physical address'
> and the second the 'pci' address?
>
Yes.  I probably made this more difficult to read because I ordered
the rows by PCI addresses.

> ...
>
> Isn't this just the same as having an iommu that converts 'bus'
> addresses into 'physical' ones?

Pretty much, but for PCIe devices only.  This could be done by somehow
overriding the arch specific phys_to_dma() and dma_to_phys() calls.

>
> A simple table lookup of the high address bits will do the
> conversion.
True, but this table could be passed something like ARM_MAPPING_ERROR,
which may be out the table (the driver is not privy to
ARM_MAPPING_ERROR's definition).

Thanks,
Jim

>
>         David
>
