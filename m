Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33224 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeHUXaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2018 19:30:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id t14-v6so2233924pgf.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2018 13:08:25 -0700 (PDT)
Date: Tue, 21 Aug 2018 13:08:24 -0700 (PDT)
Subject: Re: [PATCH] microblaze/PCI: Remove stale pcibios_align_resource() comment
In-Reply-To: <90363c9d-4084-dd2f-9956-42de2841bfc6@monstr.eu>
CC: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, bharatku@xilinx.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: monstr@monstr.eu
Message-ID: <mhng-f16f3cf1-f440-47b7-b1b7-a73836ab1c58@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 20 Aug 2018 23:24:53 PDT (-0700), monstr@monstr.eu wrote:
> On 20.8.2018 11:47, Lorenzo Pieralisi wrote:
>> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
>> Bridge IP driver")
>>
>> and
>>
>> commit ecf677c8dcaa ("PCI: Add a generic weak pcibios_align_resource()")
>>
>> first patched then removed pcibios_align_resource() from the microblaze
>> architecture code but failed to remove the comment that was added to
>> it.
>>
>> Remove it since it has now become stale and it is quite confusing.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> ---
>>  arch/microblaze/pci/pci-common.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
>> index f34346d56095..2ffd171af8b6 100644
>> --- a/arch/microblaze/pci/pci-common.c
>> +++ b/arch/microblaze/pci/pci-common.c
>> @@ -597,19 +597,6 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>>  }
>>  DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_resources);
>>
>> -/*
>> - * We need to avoid collisions with `mirrored' VGA ports
>> - * and other strange ISA hardware, so we always want the
>> - * addresses to be allocated in the 0x000-0x0ff region
>> - * modulo 0x400.
>> - *
>> - * Why? Because some silly external IO cards only decode
>> - * the low 10 bits of the IO address. The 0x00-0xff region
>> - * is reserved for motherboard devices that decode all 16
>> - * bits, so it's ok to allocate at, say, 0x2800-0x28ff,
>> - * but we want to try to avoid allocating at 0x2900-0x2bff
>> - * which might have be mirrored at 0x0100-0x03ff..
>> - */
>>  int pcibios_add_device(struct pci_dev *dev)
>>  {
>>  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>>
>
> Applied.

Sorry, I missed this.  Thanks for the fix!
