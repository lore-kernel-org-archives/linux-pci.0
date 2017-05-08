Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdEHK7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 May 2017 06:59:44 -0400
Subject: Re: [RFC] pci: using new interrupt API to enable MSI and MSI-X
To: Joao Pinto <Joao.Pinto@synopsys.com>, kishon@ti.com,
        bhelgaas@google.com, jingoohan1@gmail.com
References: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
 <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
 <1b77d1ec-5fc8-d548-7e84-8d05a31849aa@synopsys.com>
 <c53eb6ec-14da-9bae-002b-6abc95c62b1e@arm.com>
 <39dba8bd-dbb7-3c2e-879b-78cf3bc463c8@synopsys.com>
Cc: linux-pci@vger.kernel.org
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <78df196c-0c86-8775-116c-0f4dd49d4008@arm.com>
Date: Mon, 8 May 2017 11:59:42 +0100
MIME-Version: 1.0
In-Reply-To: <39dba8bd-dbb7-3c2e-879b-78cf3bc463c8@synopsys.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/05/17 11:24, Joao Pinto wrote:
> Às 11:22 AM de 5/8/2017, Marc Zyngier escreveu:
>> On 08/05/17 10:59, Joao Pinto wrote:
>>> Às 3:57 PM de 5/5/2017, Marc Zyngier escreveu:
>>>> Joao,
>>>>
>>>> On 05/05/17 15:11, Joao Pinto wrote:
>>>>> Hello,
>>>>> I am currently adding the support for both MSI and MSI-x in pcie-designware and
>>>>> I am now facing a dificulty.
>>>>>
>>>>> My test endpoint is a USB 3.1 MSI / MSI-X capable and I tested that with
>>>>> the changes introduced by this patch we are able to enable MSI and MSI-X
>>>>> in this endpoint (depends on the usage of the MSI_FLAG_PCI_MSIX flag).
>>>>>
>>>>> The problem I am facing now is that Intc for the USB 3.1 Endpoint is completely
>>>>> bogus (524288) when it should be 1, and so I am not receiving any interrupts
>>>>> from the endpoint.
>>>>
>>>> It is not bogus at all. It is computed from the PCI requester ID in 
>>>> pci_msi_domain_calc_hwirq. What you're seeing is the PCI/MDI domain 
>>>> view of that interrupt, which is completely virtual.
>>>>
>>>> The real thing happens in your own irqdomain, where the hwirq for IRQ46 
>>>> is probably 1 (only you can know that). As for why it doesn't work, see 
>>>> below:
>>>>
>>>>>
>>>>> I would apreciate that more experienced people in this interrupt subject could
>>>>> give me an hint.
>>
>> [...]
>>
>>> Yep makes perfectly sense and thanks for clearing the Domains :), I understood
>>> them now.
>>
>> I guess that you have your MSI controller working with MSI-X now?
> 
> I started working one hour ago and still putting some subjects in order, I am
> going to return to PCI in a bit. I will keep you updated. I thought you were in
> US Pacific timezone.

I'm firmly rooted in BST! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
