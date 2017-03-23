Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964908AbdCWPw7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Mar 2017 11:52:59 -0400
Subject: Re: Help: MSI DWC connecting with a MSIx Endpoint
To: Joao Pinto <Joao.Pinto@synopsys.com>
References: <85bfa77f-6cd0-a669-c940-7fa7d9fb17a3@synopsys.com>
 <28a4e429-a2d2-8f28-e4fc-8eebae0b3367@arm.com>
 <4ade12d6-1887-4093-ee43-2101ca2986e0@synopsys.com>
 <9eec7e57-456e-fc98-91d9-bd5a32c347af@arm.com>
 <934e0800-a1df-2059-fc7e-def976572309@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <51813e48-210e-55a5-c904-fbf4562f48fe@arm.com>
Date: Thu, 23 Mar 2017 15:52:55 +0000
MIME-Version: 1.0
In-Reply-To: <934e0800-a1df-2059-fc7e-def976572309@synopsys.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23/03/17 15:22, Joao Pinto wrote:
> Hi Mark,
> 
> Às 10:41 AM de 3/21/2017, Marc Zyngier escreveu:
>> On 21/03/17 10:27, Joao Pinto wrote:
>>>
>>> Hi Mark,
>>>
>>> Às 6:16 PM de 3/20/2017, Marc Zyngier escreveu:
>>>> Hi Joao,
>>>>
>>>> On 20/03/17 17:30, Joao Pinto wrote:
>>>>> Hi Mark,
>>>>>
>> A very simple example using the current API is pcie-altera-msi.c (some
>> others are much more intricate), and should give you a good picture of
>> how PCI/MSI, generic MSI and MSI controllers interact.
>>
>> Start with understanding how the various layers interact via their own
>> IRQ domains, and implement their own IRQ chip. Happy to answer questions
>> (I'm sure you'll have some).
>>
>> Thanks,
>>
>> 	M.
> 
> I have one quick question... What address should I configure in vector_phy?
> is this needed in pcie-designware?

You may be in a better place than me to answer that question! ;-)

If I remember well, the Altera RC needs to be programmed with the
address of the MSI doorbell so that it can detect the end-point writes
to it, and it can be anything you want. In order not to waste any memory
space, we use the base address of the RC.

Both very nice and dead ugly, if you want my opinion.

If we look at this:

void dw_pcie_msi_init(struct pcie_port *pp)
{
        u64 msi_target;

        pp->msi_data = __get_free_pages(GFP_KERNEL, 0);
        msi_target = virt_to_phys((void *)pp->msi_data);

        /* program the msi_data */
        dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
                            (u32)(msi_target & 0xffffffff));
        dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
                            (u32)(msi_target >> 32 & 0xffffffff));
}

We can infer the Designware IP has a similar behaviour, except that it
wastes a page of RAM for no obvious reason. It'd be good to know if the
RC actually propagates the write to the memory. If it really does, then
that's the only way to do it. If it doesn't, then the Altera method is
much better...

Hope this helps,

	M.
-- 
Jazz is not dead. It just smells funny...
