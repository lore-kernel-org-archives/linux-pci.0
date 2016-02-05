Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:63931 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbcBENiP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 08:38:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Mark Brown <mark.brown@linaro.org>
Subject: Re: [PATCH] PCI: generic: map config window in one go
Date: Fri, 05 Feb 2016 14:37:44 +0100
Message-ID: <1507671.sEYIrU8dv6@wuerfel>
In-Reply-To: <CAKv+Gu8oZADs_FRN=p7_Nz0wXJVWVmzVNsxtzscyp7_cFAreAQ@mail.gmail.com>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org> <4090946.AhejVJy7MO@wuerfel> <CAKv+Gu8oZADs_FRN=p7_Nz0wXJVWVmzVNsxtzscyp7_cFAreAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 05 February 2016 11:48:54 Ard Biesheuvel wrote:
> On 29 January 2016 at 15:52, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 29 January 2016 15:32:01 Ard Biesheuvel wrote:
> >> On 29 January 2016 at 15:28, Will Deacon <will.deacon@arm.com> wrote:
> >> > Hi Ard,
> >> >
> >> > On Fri, Jan 29, 2016 at 03:17:15PM +0100, Ard Biesheuvel wrote:
> >> >> Instead of iterating over the PCI config window and performing individual
> >> >> ioremap() calls on all the adjacent slices, perform a single ioremap() to
> >> >> map the entire region, and divvy it up later. This not only prevents
> >> >> leaving some of it mapped if we fail half way through, it also ensures that
> >> >> archs that support huge-vmap can use section mappings to perform the
> >> >> mapping.
> >> >>
> >> >> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
> >> >> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
> >> >> saving 512 KB worth of page tables.
> >> >>
> >> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> ---
> >> >
> >> > The code was written this way in response to feedback during driver review
> >> > that we couldn't necessarily grab that much contiguous vmalloc space on
> >> > 32-bit ARM. Unless that's changed, we probably want to to predicate this
> >> > change on having a 64-bit arch.
> >> >
> >>
> >> Ah right. How about testing for the ARCH_HAVE_HUGE_VMAP Kconfig symbol
> >> explicitly?
> >>
> >
> > Testing for 64BIT should be sufficient.
> >
> 
> Does it make sense to spin a v2 for this patch? Given the discussion
> we had regarding allocating only the config regions for busses that
> are populated, perhaps there is a better approach here?

Allocating only the config regions that are actually used would
be ideal, the problem is that you need to access the config space
in order to know which ones are, so this is certainly a bit tricky.

Are there any downsides to the x86 approach of using fixmap to
map each patch separately during the access? It's probably a bit
slower per access, but we don't do a lot of those accesses after
the system is booted.

	Arnd
