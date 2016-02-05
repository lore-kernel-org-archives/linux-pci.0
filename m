Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34985 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcBEKsz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 05:48:55 -0500
Received: by mail-ig0-f176.google.com with SMTP id hb3so11062791igb.0
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2016 02:48:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4090946.AhejVJy7MO@wuerfel>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160129142831.GF4541@arm.com>
	<CAKv+Gu_V83bUktPX0EiHd6qCDT2y0NEx=4n-uVv=P2MF9AZbMQ@mail.gmail.com>
	<4090946.AhejVJy7MO@wuerfel>
Date: Fri, 5 Feb 2016 11:48:54 +0100
Message-ID: <CAKv+Gu8oZADs_FRN=p7_Nz0wXJVWVmzVNsxtzscyp7_cFAreAQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: generic: map config window in one go
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mark Brown <mark.brown@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29 January 2016 at 15:52, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 29 January 2016 15:32:01 Ard Biesheuvel wrote:
>> On 29 January 2016 at 15:28, Will Deacon <will.deacon@arm.com> wrote:
>> > Hi Ard,
>> >
>> > On Fri, Jan 29, 2016 at 03:17:15PM +0100, Ard Biesheuvel wrote:
>> >> Instead of iterating over the PCI config window and performing individual
>> >> ioremap() calls on all the adjacent slices, perform a single ioremap() to
>> >> map the entire region, and divvy it up later. This not only prevents
>> >> leaving some of it mapped if we fail half way through, it also ensures that
>> >> archs that support huge-vmap can use section mappings to perform the
>> >> mapping.
>> >>
>> >> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
>> >> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
>> >> saving 512 KB worth of page tables.
>> >>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> ---
>> >
>> > The code was written this way in response to feedback during driver review
>> > that we couldn't necessarily grab that much contiguous vmalloc space on
>> > 32-bit ARM. Unless that's changed, we probably want to to predicate this
>> > change on having a 64-bit arch.
>> >
>>
>> Ah right. How about testing for the ARCH_HAVE_HUGE_VMAP Kconfig symbol
>> explicitly?
>>
>
> Testing for 64BIT should be sufficient.
>

Does it make sense to spin a v2 for this patch? Given the discussion
we had regarding allocating only the config regions for busses that
are populated, perhaps there is a better approach here?
