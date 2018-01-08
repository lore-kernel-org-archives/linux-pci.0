Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:29314 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757183AbeAHM3C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jan 2018 07:29:02 -0500
Subject: Re: [PATCH 1/8] arch/sh: add sh7786_mm_sel() function
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
 <20171204150907.24345-2-thomas.petazzoni@free-electrons.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <a306b914-e95a-4199-60de-39e88782ac05@free.fr>
Date: Mon, 8 Jan 2018 13:28:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171204150907.24345-2-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/12/2017 16:09, Thomas Petazzoni wrote:

> The SH7786 has different physical memory layout configurations,
> configurable through the MMSELR register. The configuration is
> typically defined by the bootloader, so Linux generally doesn't care.
> 
> Except that depending on the configuration, some PCI MEM areas may or
> may not be available. This commit adds a helper function that allows
> to retrieve the current physical memory layout configuration. It will
> be used in a following patch to exclude unusable PCI MEM areas during
> the PCI initialization.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/sh/include/cpu-sh4/cpu/sh7786.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
> index 0df09e638f09..96b8cb1f754a 100644
> --- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
> +++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
> @@ -14,6 +14,8 @@
>  #ifndef __CPU_SH7786_H__
>  #define __CPU_SH7786_H__
>  
> +#include <linux/io.h>
> +
>  enum {
>  	/* PA */
>  	GPIO_PA7, GPIO_PA6, GPIO_PA5, GPIO_PA4,
> @@ -131,4 +133,9 @@ enum {
>  	GPIO_FN_IRL7, GPIO_FN_IRL6, GPIO_FN_IRL5, GPIO_FN_IRL4,
>  };
>  
> +static inline u32 sh7786_mm_sel(void)
> +{
> +	return __raw_readl(0xFC400020) & 0x7;

I thought we were never supposed to use __raw_readl(), rather use readl_relaxed() instead?

The difference is that readl_relaxed() takes care of endianness, which would seem relevant
since you have both endianness. Am I missing something?

Regards.
