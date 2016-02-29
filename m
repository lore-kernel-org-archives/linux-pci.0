Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33618 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbcB2W5A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Feb 2016 17:57:00 -0500
Date: Mon, 29 Feb 2016 16:56:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] arm: kernel: pci: remove pci=firmware command line
 parameter handling
Message-ID: <20160229225653.GE3653@localhost>
References: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456767800-6609-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 29, 2016 at 05:43:20PM +0000, Lorenzo Pieralisi wrote:
> According to kernel documentation, the pci=firmware command line
> parameter is only meant to be used on IXP2000 ARM platforms to prevent
> the kernel from assigning PCI resources configured by the bootloader.
> 
> Since the IXP2000 ARM platforms support has been removed from the
> kernel in commit:
> 
> commit c65f2abf54a6 ("ARM: remove ixp23xx and ixp2000 platforms")
> 
> its platforms specific kernel parameters should be removed
> too from the kernel documentation along with the kernel code
> currently handling them in that they have just become obsolete.
> 
> This patch removes the pci=firmware command line parameter handling
> from ARM code and the related kernel parameters documentation
> section.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

It looks like Rob merged c65f2abf54a6, so maybe he will merge this as
well?  Otherwise I'd be happy to merge it; just let me know if you
want me to.

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  Documentation/kernel-parameters.txt | 5 -----
>  arch/arm/kernel/bios32.c            | 3 ---
>  2 files changed, 8 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 9a53c92..e213acc 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2875,11 +2875,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  				for broken drivers that don't call it.
>  		skip_isa_align	[X86] do not align io start addr, so can
>  				handle more pci cards
> -		firmware	[ARM] Do not re-enumerate the bus but instead
> -				just use the configuration from the
> -				bootloader. This is currently used on
> -				IXP2000 systems where the bus has to be
> -				configured a certain way for adjunct CPUs.
>  		noearly		[X86] Don't do any early type 1 scanning.
>  				This might help on some broken boards which
>  				machine check when some devices' config space
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 066f7f9..05e61a2 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -550,9 +550,6 @@ char * __init pcibios_setup(char *str)
>  	if (!strcmp(str, "debug")) {
>  		debug_pci = 1;
>  		return NULL;
> -	} else if (!strcmp(str, "firmware")) {
> -		pci_add_flags(PCI_PROBE_ONLY);
> -		return NULL;
>  	}
>  	return str;
>  }
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
