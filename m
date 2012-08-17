Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48077 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab2HQVHE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 17:07:04 -0400
Received: by yenl14 with SMTP id l14so4392410yen.19
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 14:07:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com> <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 Aug 2012 15:06:42 -0600
Message-ID: <CAErSpo5G=N529J9uOdp3oV66=PRTVPA+BWxraN5aZ5JAH_31JA@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2012 at 2:48 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
>> On Fri, Aug 17, 2012 at 2:07 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > On Fri, Aug 17, 2012 at 01:32:45PM -0600, Bjorn Helgaas wrote:
>> >> On Fri, Aug 17, 2012 at 12:29 PM, Thierry Reding
>> >> <thierry.reding@avionic-design.de> wrote:
>> >> > On Fri, Aug 17, 2012 at 11:44:31AM -0600, Bjorn Helgaas wrote:
>> >> >> On Fri, Aug 17, 2012 at 11:36 AM, David Daney <ddaney.cavm@gmail.com> wrote:
>> >> >> > For MIPS, Thierry Reding's patch in linux-next (PCI: Keep pci_fixup_irqs()
>> >> >> > around after init) causes:
>> >> >> >
>> >> >> > WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from the
>> >> >> > function pci_fixup_irqs() to the function .init.text:pcibios_update_irq()
>> >> >> >
>> >> >> > The MIPS implementation of pcibios_update_irq() is __init, so there is
>> >> >> > conflict with the removal of __init from pci_fixup_irqs() and
>> >> >> > pdev_fixup_irq().
>> >> >> >
>> >> >> > Can you guys either remove the patch from linux-next, or improve it to also
>> >> >> > fix up any architecture implementations of pdev_update_irq()?
>> >> >>
>> >> >> Crap, there are lots of arches with this issue.  I'll fix it up.
>> >> >> Thanks for pointing it out!
>> >> >
>> >> > Oh wow... looks like I've opened a can of worms there. This requires
>> >> > quite a lot of other functions to have their annotations removed as
>> >> > well. Bjorn, how do you want to handle this?
>> >>
>> >> David said "pdev_update_irq()," but I think he meant "pcibios_update_irq()."
>> >>
>> >> Almost all the pcibios_update_irq() implementations are identical, so
>> >> I think I'll just supply a weak implementation and remove the
>> >> redundant arch versions.
>> >
>> > That makes sense. However I've just tested a build with section mismatch
>> > debugging enabled on ARM and there are a few more that need __init or
>> > __devinit removed to get rid of the warnings:
>> >
>> >         pci_common_init()
>> >         pcibios_init_hw()
>> >         pcibios_init_resources()
>> >         pcibios_swizzle()
>> >         pcibios_update_irq()
>> >
>> > pci_scan_root_bus() also needs __devinit removed. I haven't checked the
>> > other architectures because I'll have to build cross-compilers for them
>> > first, but I suspect most of them will have a similar list. I'm not sure
>> > how well this kind of change is going to go down with the respective
>> > architecture maintainers, though.
>>
>> Hmm, yeah, this is a mess, isn't it?  Just about everything in PCI
>> will need __devinit removed.  We've been assuming that the only way
>> for things to show up after init is via hotplug.  But you're breaking
>> that assumption by doing *all* enumeration after init.  There are
>> approximately a bajillion __init and __devinit annotations just in
>> drivers/pci, not to mention those in the architectures.
>>
>> Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
>> affect you?  I think we would still have to change some __inits to
>> __devinit, including pcibios_update_irq(), but it might be more
>> manageable.
>
> You said that depending on HOTPLUG wouldn't be enough because it would
> exclude reenumeration at runtime if HOTPLUG wasn't defined.

I'm suggesting that maybe we shouldn't support enumeration at runtime
unless HOTPLUG is defined.  So if you want to enumerate after init,
set CONFIG_HOTPLUG=y.

> Also it is
> theoretically possible to build a kernel without HOTPLUG but have the
> enumeration start after init because of deferred probing. Those cases
> won't work if we keep __init or __devinit respectively, right?

This is the situation (deferred probing with CONFIG_HOTPLUG=n) that
I'm suggesting might not need to work.  After all, hotplug essentially
means "adding devices after init."

> I won't be able to test anything beyond Tegra because I'm lacking the
> hardware. But with the section mismatch debugging enabled all issues
> should be detected at compile time anyway, so it's just a problem of
> getting cross-compilers for all architectures that support PCI.

I have cross-compilers for many of the architectures (relatively
painless to build with
http://git.infradead.org/users/segher/buildall.git), but this is
starting to look like it will take more time than I have right now.
