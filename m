Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33292 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab2HQTdG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 15:33:06 -0400
Received: by yhmm54 with SMTP id m54so4307855yhm.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 12:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Aug 2012 13:32:45 -0600
Message-ID: <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
>> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
>> > around after init) causes:
>> >
>> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
>> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>> >
>> > The MIPS implementation of pcibios_update_irq() is __init, so there is
>> > conflict with the removal of __init from pci_fixup_irqs() and
>> > pdev_fixup_irq().
>> >
>> > Can you guys either remove the patch from linux-next, or improve it to also
>> > fix up any architecture implementations of pdev_update_irq()?
>>
>> Crap, there are lots of arches with this issue.  I'll fix it up.
>> Thanks for pointing it out!
>
> Oh wow... looks like I've opened a can of worms there. This requires
> quite a lot of other functions to have their annotations removed as
> well. Bjorn, how do you want to handle this?

David said "pdev_update_irq()," but I think he meant "pcibios_update_irq()."

Almost all the pcibios_update_irq() implementations are identical, so
I think I'll just supply a weak implementation and remove the
redundant arch versions.

This is just about the only thing in my "next" branch, so I'll clear
it out for now, until we get this resolved.

Bjorn
