Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39214 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbcA2O2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 09:28:33 -0500
Date: Fri, 29 Jan 2016 14:28:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, mark.brown@linaro.org
Subject: Re: [PATCH] PCI: generic: map config window in one go
Message-ID: <20160129142831.GF4541@arm.com>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ard,

On Fri, Jan 29, 2016 at 03:17:15PM +0100, Ard Biesheuvel wrote:
> Instead of iterating over the PCI config window and performing individual
> ioremap() calls on all the adjacent slices, perform a single ioremap() to
> map the entire region, and divvy it up later. This not only prevents
> leaving some of it mapped if we fail half way through, it also ensures that
> archs that support huge-vmap can use section mappings to perform the
> mapping.
> 
> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
> saving 512 KB worth of page tables.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---

The code was written this way in response to feedback during driver review
that we couldn't necessarily grab that much contiguous vmalloc space on
32-bit ARM. Unless that's changed, we probably want to to predicate this
change on having a 64-bit arch.

Will
