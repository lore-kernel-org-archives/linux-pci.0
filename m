Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36788 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbcBEOJu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 09:09:50 -0500
Received: by mail-io0-f176.google.com with SMTP id g73so129546449ioe.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2016 06:09:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1507671.sEYIrU8dv6@wuerfel>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
	<4090946.AhejVJy7MO@wuerfel>
	<CAKv+Gu8oZADs_FRN=p7_Nz0wXJVWVmzVNsxtzscyp7_cFAreAQ@mail.gmail.com>
	<1507671.sEYIrU8dv6@wuerfel>
Date: Fri, 5 Feb 2016 15:09:49 +0100
Message-ID: <CAKv+Gu8aw0NepDSp_mQAuGK+2u5q40K2XGJBWhGyr4nA2E5uxw@mail.gmail.com>
Subject: Re: [PATCH] PCI: generic: map config window in one go
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Mark Brown <mark.brown@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5 February 2016 at 14:37, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 05 February 2016 11:48:54 Ard Biesheuvel wrote:
>> On 29 January 2016 at 15:52, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 29 January 2016 15:32:01 Ard Biesheuvel wrote:
>> >> On 29 January 2016 at 15:28, Will Deacon <will.deacon@arm.com> wrote:
>> >> > Hi Ard,
>> >> >
>> >> > On Fri, Jan 29, 2016 at 03:17:15PM +0100, Ard Biesheuvel wrote:
>> >> >> Instead of iterating over the PCI config window and performing individual
>> >> >> ioremap() calls on all the adjacent slices, perform a single ioremap() to
>> >> >> map the entire region, and divvy it up later. This not only prevents
>> >> >> leaving some of it mapped if we fail half way through, it also ensures that
>> >> >> archs that support huge-vmap can use section mappings to perform the
>> >> >> mapping.
>> >> >>
>> >> >> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
>> >> >> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
>> >> >> saving 512 KB worth of page tables.
>> >> >>
>> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >> >> ---
>> >> >
>> >> > The code was written this way in response to feedback during driver review
>> >> > that we couldn't necessarily grab that much contiguous vmalloc space on
>> >> > 32-bit ARM. Unless that's changed, we probably want to to predicate this
>> >> > change on having a 64-bit arch.
>> >> >
>> >>
>> >> Ah right. How about testing for the ARCH_HAVE_HUGE_VMAP Kconfig symbol
>> >> explicitly?
>> >>
>> >
>> > Testing for 64BIT should be sufficient.
>> >
>>
>> Does it make sense to spin a v2 for this patch? Given the discussion
>> we had regarding allocating only the config regions for busses that
>> are populated, perhaps there is a better approach here?
>
> Allocating only the config regions that are actually used would
> be ideal, the problem is that you need to access the config space
> in order to know which ones are, so this is certainly a bit tricky.
>
> Are there any downsides to the x86 approach of using fixmap to
> map each patch separately during the access? It's probably a bit
> slower per access, but we don't do a lot of those accesses after
> the system is booted.
>

Yes, I guess that makes a lot more sense than ioremapping 10s to 100s
of MBs and hardly ever using them.
