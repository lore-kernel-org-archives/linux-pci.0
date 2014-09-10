Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36491 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbaIJOPR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 10:15:17 -0400
Date: Wed, 10 Sep 2014 15:15:14 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: L H <swdevgid@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: designware: prefetch and 64-bit addr support?
Message-ID: <20140910141514.GC27864@e106497-lin.cambridge.arm.com>
References: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA8O7Crwi7=afUpLoC1O5H9ymjYEPyb63kO8QdFuPx6RUJ8NpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 03, 2014 at 09:57:11PM +0100, L H wrote:
> Greetings my fellow PCI designware developers.  I'm working on an
> implementation that relies on the PCIe DesignWare IP and am writing a
> platform-specific layer to link with the designware code, but have run
> into a couple challenges.
> 
> Reading the pcie-designware.c (looking at the master branch of a repo
> cloned from git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git --
> is that the best branch/repo to view?), it appears to me that the
> dw_pcie_host_init() code doesn't comprehend prefetch memory ranges,
> but instead just assumes that a memory range is non-prefetch despite
> its encoding in the device-tree.  Am I reading that correctly?  The
> loop for walking the ranges begins with:
> 
>     for_each_of_pci_range(&parser, &range) {
>         unsigned long restype = range.flags & IORESOURCE_TYPE_BITS;
> 
> The bitmask for IORESOURCE_TYPE_BITS would result in a restype
> ignorant of the IORESOURCE_PREFETCH bit, right?   The ensuing code
> flow then treats the range as non-prefetch unless I missed something.

Hi LH,

You are not reading all of the code. The designware code only cares
about the type of the range (IO, MEM, cfg?). But the conversion from
range to resource that happens in of_pci_range_to_resource() *does*
preserve the prefetchable flags and that is being used by the generic
PCI framework.

> 
> Curiously, I also noted that the for_each_of_pcie_range() which calls
> of_pci_range_parser_one() that in turn includes calls to
> of_bus_pci_get_flags() does not set the IORESOURCE_MEM_64 bit parsed
> from the range either.

Where exactly do you expect those flags to be read into?

> 
> If I followed that all correctly, is the proper assumption that all of
> the current implementations relying on the designware code only use
> 32-bit non-prefetch memory ranges?

No, I don't think that is correct. What I would say is that the current
designware PCIe code does not care whether the memory is prefetcheable
or not for the DW specific part of the setup.

Best regards,
Liviu

> 
> The platform which I'm working on will use a large 64-bit PCI memory
> address space, and thus I need 64-bit memory apertures which implies,
> I think, only prefetch memory.
> 
> I hasten to add this isn't a complaint or critique of the valuable
> work developed up to this point. I'm very grateful to have it as a
> rich starting point.  I'm reaching out to the list here as a newbie to
> verify my comprehension of the designware code, and if valid, to
> inquire if there's any effort by anyone currently to support 64-bit
> prefetch ranges.  I've accepted the real possibility that I might be
> blazing this trail myself, but just wanted to check if anyone else has
> considered it or working on this support to avoid a redundant effort.
> 
> thanks,
> LH
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

