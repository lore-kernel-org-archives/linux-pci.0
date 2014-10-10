Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:65075 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaJJNy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 09:54:26 -0400
Received: by mail-ig0-f169.google.com with SMTP id uq10so6915243igb.4
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 06:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140910141514.GC27864@e106497-lin.cambridge.arm.com>
References: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
	<20140910141514.GC27864@e106497-lin.cambridge.arm.com>
Date: Fri, 10 Oct 2014 08:54:25 -0500
Message-ID: <CAA8O7CrqkjGTiK68iWDe6C9-VMT5OF=D72u4mR9edOzUGjQwPQ@mail.gmail.com>
Subject: Re: designware: prefetch and 64-bit addr support?
From: L H <swdevgid@gmail.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thank you Liviu for the detailed response.  I've been buried with work
and out on personal matters so I'm just now able to resume
participation on this thread.

I did successfully get prefetch memory support working on my platform.
As you indicated, because the prefetchable flags are preserved in the
resource, the PCI framework handled it just fine, with, however, a
small change to dw_pcie_setup_rc().   That's because that function
originally just assumed that the memory region was non-prefetch.  I
added a check for the prefetch flag in dw_pcie_setup_rc() and
initialized the root-complex's host bridge registers appropriately:


-       /* setup memory base, memory limit */
-       membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
-       memlimit = (config->mem_size + (u32)pp->mem_base) & 0xfff00000;
-       val = memlimit | membase;
-       dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
+       if (!(pp->mem.flags & IORESOURCE_PREFETCH)) {
+               /* setup memory base, memory limit */
+               membase = ((u32)pp->mem_base & 0xfff00000) >> 16;
+               memlimit = (config->mem_size + (u32)pp->mem_base) & 0xfff00000;
+               val = memlimit | membase;
+               dw_pcie_writel_rc(pp, val, PCI_MEMORY_BASE);
+       }
+       else {
+               /* setup prefetch memory base, limit */
+               membase = (lower_32_bits(pp->mem_base) & 0xfff00000) >> 16;
+               memlimit = (lower_32_bits(config->mem_size) +
+                               lower_32_bits(pp->mem_base)) & 0xfff00000;
+               val = memlimit | membase;
+               dw_pcie_writel_rc(pp, val, PCI_PREF_MEMORY_BASE);
+               dw_pcie_writel_rc(pp, upper_32_bits(pp->mem_base),
PCI_PREF_BASE_UPPER32);
+               dw_pcie_writel_rc(pp, upper_32_bits(pp->mem_base +
config->mem_size), PCI_PREF_LIMIT_UPPER32);
+       }

Note that this, of course, follows the current driver implementation
that supports only one PCI memory region:  either prefetch or
non-prefetch.  For the purposes of supporting more SoC's which employ
DesignWare, the driver can easily be extended to support both but I
understand the mindset of leaving that to whomever needs multiple
memory regions.

thanks again,
LH



On Wed, Sep 10, 2014 at 9:15 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Sep 03, 2014 at 09:57:11PM +0100, L H wrote:
>> Greetings my fellow PCI designware developers.  I'm working on an
>> implementation that relies on the PCIe DesignWare IP and am writing a
>> platform-specific layer to link with the designware code, but have run
>> into a couple challenges.
>>
>> Reading the pcie-designware.c (looking at the master branch of a repo
>> cloned from git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git --
>> is that the best branch/repo to view?), it appears to me that the
>> dw_pcie_host_init() code doesn't comprehend prefetch memory ranges,
>> but instead just assumes that a memory range is non-prefetch despite
>> its encoding in the device-tree.  Am I reading that correctly?  The
>> loop for walking the ranges begins with:
>>
>>     for_each_of_pci_range(&parser, &range) {
>>         unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
>>
>> The bitmask for IORESOURCE_TYPE_BITS would result in a restype
>> ignorant of the IORESOURCE_PREFETCH bit, right?   The ensuing code
>> flow then treats the range as non-prefetch unless I missed something.
>
> Hi LH,
>
> You are not reading all of the code. The designware code only cares
> about the type of the range (IO, MEM, cfg?). But the conversion from
> range to resource that happens in of_pci_range_to_resource() *does*
> preserve the prefetchable flags and that is being used by the generic
> PCI framework.
>
>>
>> Curiously, I also noted that the for_each_of_pcie_range() which calls
>> of_pci_range_parser_one() that in turn includes calls to
>> of_bus_pci_get_flags() does not set the IORESOURCE_MEM_64 bit parsed
>> from the range either.
>
> Where exactly do you expect those flags to be read into?
>
>>
>> If I followed that all correctly, is the proper assumption that all of
>> the current implementations relying on the designware code only use
>> 32-bit non-prefetch memory ranges?
>
> No, I don't think that is correct. What I would say is that the current
> designware PCIe code does not care whether the memory is prefetcheable
> or not for the DW specific part of the setup.
>
> Best regards,
> Liviu
>
>>
>> The platform which I'm working on will use a large 64-bit PCI memory
>> address space, and thus I need 64-bit memory apertures which implies,
>> I think, only prefetch memory.
>>
>> I hasten to add this isn't a complaint or critique of the valuable
>> work developed up to this point. I'm very grateful to have it as a
>> rich starting point.  I'm reaching out to the list here as a newbie to
>> verify my comprehension of the designware code, and if valid, to
>> inquire if there's any effort by anyone currently to support 64-bit
>> prefetch ranges.  I've accepted the real possibility that I might be
>> blazing this trail myself, but just wanted to check if anyone else has
>> considered it or working on this support to avoid a redundant effort.
>>
>> thanks,
>> LH
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
>
