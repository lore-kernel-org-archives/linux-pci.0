Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37360 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757008Ab2EDAal convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 May 2012 20:30:41 -0400
Received: by lahj13 with SMTP id j13so1660315lah.19
        for <linux-pci@vger.kernel.org>; Thu, 03 May 2012 17:30:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F9FE4F6.5070909@openwrt.org>
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
 <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 May 2012 18:30:20 -0600
Message-ID: <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
To: John Crispin <blogic@openwrt.org>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 1, 2012 at 7:28 AM, John Crispin <blogic@openwrt.org> wrote:
> On 30/04/12 19:54, David Daney wrote:
>> On 04/30/2012 10:46 AM, John Crispin wrote:
>>> On MIPS we want to call of_irq_map_pci from inside
>>>
>>> arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
>>>                 const struct pci_dev *dev, u8 slot, u8 pin);
>>>
>>> For this to work we need to change several functions to const usage.
>>
>> I think there is a mismatch on this throughout the kernel.
>>
>> Properly fixing it requires touching many more places than these.
>> Although I haven't tried it, I wouldn't be surprised if doing this
>> caused warnings to appear in non-MIPS code.
>>
>> Ralf had a patch at one point that tried to make this consistent
>> tree-wide, but it is not yet applied.
>>
>> David Daney
>
> Hi,
>
> Ok, lets see what Ralf has to say.
>
> I just tested the patch on x86 with OF enabled and drivers turned on
> that use the API. I did not see any errors appear.

I'm far from a const expert, but I think this should be safe.  Here's
my reasoning:

We're changing pci_swizzle_interrupt_pin() to take a pointer to a
constant struct pci_dev.  pci_swizzle_interrupt_pin() only reads the
struct pci_dev; it doesn't modify it.  It is legal to pass either
"struct pci_dev *" or "const struct pci_dev *" to a function expecting
"const struct pci_dev *"; the callee just won't be able to modify the
struct, even if the caller can.

Similar reasoning applies to of_irq_map_pci().

So I'm fine with this.  You sent it to Grant, so I'll assume he'll
merge it unless I hear otherwise.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
