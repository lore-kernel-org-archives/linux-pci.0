Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33303 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbcA2OcC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 09:32:02 -0500
Received: by mail-io0-f169.google.com with SMTP id f81so90380766iof.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2016 06:32:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160129142831.GF4541@arm.com>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
	<20160129142831.GF4541@arm.com>
Date: Fri, 29 Jan 2016 15:32:01 +0100
Message-ID: <CAKv+Gu_V83bUktPX0EiHd6qCDT2y0NEx=4n-uVv=P2MF9AZbMQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: generic: map config window in one go
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <mark.brown@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29 January 2016 at 15:28, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ard,
>
> On Fri, Jan 29, 2016 at 03:17:15PM +0100, Ard Biesheuvel wrote:
>> Instead of iterating over the PCI config window and performing individual
>> ioremap() calls on all the adjacent slices, perform a single ioremap() to
>> map the entire region, and divvy it up later. This not only prevents
>> leaving some of it mapped if we fail half way through, it also ensures that
>> archs that support huge-vmap can use section mappings to perform the
>> mapping.
>>
>> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
>> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
>> saving 512 KB worth of page tables.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>
> The code was written this way in response to feedback during driver review
> that we couldn't necessarily grab that much contiguous vmalloc space on
> 32-bit ARM. Unless that's changed, we probably want to to predicate this
> change on having a 64-bit arch.
>

Ah right. How about testing for the ARCH_HAVE_HUGE_VMAP Kconfig symbol
explicitly?
