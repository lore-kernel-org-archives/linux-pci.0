Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:45523 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbaGCT7W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 15:59:22 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so1635491igd.8
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 12:59:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140703131526.GG28852@google.com>
References: <20140611060118.GB3169@yanx>
	<CAE9FiQWe2bf7QbKn9kmZS34a4cMewsdD-9qAELdXs-dEtx70GQ@mail.gmail.com>
	<20140702210736.GB28852@google.com>
	<CAE9FiQU5Ltu89zmRG0h2aXfXH0oCcTEP=jF7b=zHi=SaOA2rKg@mail.gmail.com>
	<20140703131526.GG28852@google.com>
Date: Thu, 3 Jul 2014 12:59:21 -0700
Message-ID: <CAE9FiQWPGXMBYmpzyk8cicKZ1ELUZiARkZjr2vvgntmt3bt1jQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Allow very large resource windows
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 3, 2014 at 6:15 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> >> +     mem64_mask = b_res->flags & IORESOURCE_MEM_64;
>> >> +
>> >> +     /* kernel does not support 64bit res */
>> >> +     if (sizeof(resource_size_t) == 4)
>> >> +             mem64_mask &= ~IORESOURCE_MEM_64;
>
> I think you're fixing two things at once, and they should be split
> into two separate patches:
>
>   1) Change aligns[] size to increase support alignment from 8GB to 2^63
>
>      I'm not sure about going all the way to aligns[44].  That array
>      by itself puts 352 bytes in the stack frame (240 of which are
>      added by this patch), which seems excessive.  I suspect that
>      supporting BARs up to 64GB or 128GB would be enough for the
>      foreseeable future.

ok, let's use 128G this time.

>
>   2) Adding mem64_mask
>
>      I think the idea is that even if we have a 64-bit window, we
>      can't use anything above 4GB if we only have 32-bit resources.
>      That's true, but I don't think we can enforce that in
>      pbus_size_mem() because we're only figuring out how much space is
>      needed; we have no idea where that space will be allocated.

with current version of __pci_bus_size_bridges, we separate pref_mem64 with
pref_mem32 to calling pbus_size_mem.

so if we have pref 64bit window, we will only size pref 64 bit
children under it.
and will only assign pref 64bit mem64 to them late.

If the bridge does not support 64bit pref windows, and child support
64bit pref mmio, then bridge will try to use pref 32 window, in that
case, .... could have
size overflow as you state follow.

>
> And I think there are more problems:
>
>   - I don't think we handle overflow of "size" correctly.  Assume that
>     we have BARs of 2GB, 2GB, and 8GB.  If we have 32-bit resources,
>     when we add those up, it will overflow and we'll mistakenly think
>     we only need 8MB.

in this case we should check the overflow.

>
>   - We shouldn't set "r->flags = 0".  The warning says we're disabling
>     the BAR, but this *doesn't* disable the BAR, and in fact, there is
>     no way to disable a single BAR.  What we can do is turn off
>     PCI_COMMAND_MEMORY to disable all the memory BARs for the device.
>     And to do that, we need to keep IORESOURCE_MEM in r->flags so
>     pci_enable_resources() can tell that this is a memory BAR.

when we try to size it,  means that bar is not assigned. with r->flags
= 0, means
we will ignore it all the way.

Thanks

Yinghai
