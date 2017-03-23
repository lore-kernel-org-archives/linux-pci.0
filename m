Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52156 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933890AbdCWPXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2017 11:23:19 -0400
Subject: Re: Help: MSI DWC connecting with a MSIx Endpoint
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <85bfa77f-6cd0-a669-c940-7fa7d9fb17a3@synopsys.com>
 <28a4e429-a2d2-8f28-e4fc-8eebae0b3367@arm.com>
 <4ade12d6-1887-4093-ee43-2101ca2986e0@synopsys.com>
 <9eec7e57-456e-fc98-91d9-bd5a32c347af@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <934e0800-a1df-2059-fc7e-def976572309@synopsys.com>
Date: Thu, 23 Mar 2017 15:22:18 +0000
MIME-Version: 1.0
In-Reply-To: <9eec7e57-456e-fc98-91d9-bd5a32c347af@arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark,

Às 10:41 AM de 3/21/2017, Marc Zyngier escreveu:
> On 21/03/17 10:27, Joao Pinto wrote:
>>
>> Hi Mark,
>>
>> Às 6:16 PM de 3/20/2017, Marc Zyngier escreveu:
>>> Hi Joao,
>>>
>>> On 20/03/17 17:30, Joao Pinto wrote:
>>>> Hi Mark,
>>>>
> A very simple example using the current API is pcie-altera-msi.c (some
> others are much more intricate), and should give you a good picture of
> how PCI/MSI, generic MSI and MSI controllers interact.
> 
> Start with understanding how the various layers interact via their own
> IRQ domains, and implement their own IRQ chip. Happy to answer questions
> (I'm sure you'll have some).
> 
> Thanks,
> 
> 	M.

I have one quick question... What address should I configure in vector_phy?
is this needed in pcie-designware?

Thanks
