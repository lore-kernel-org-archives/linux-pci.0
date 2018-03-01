Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031631AbeCAPOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Mar 2018 10:14:04 -0500
Date: Thu, 1 Mar 2018 09:13:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 4/6] x86: Consolidate PCI_MMCONFIG configs
Message-ID: <20180301151359.GC13722@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com>
 <8527c92b2e2920b8cd9096ddcbbb6d0f4004eb69.1519882849.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8527c92b2e2920b8cd9096ddcbbb6d0f4004eb69.1519882849.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 01, 2018 at 06:40:47AM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since e279b6c1d329 ("x86: start unification of arch/x86/Kconfig.*"), we
> have two PCI_MMCONFIG entries, one from the original i386 and another
> from x86_64. This consolidates both entries into a single one.
> 
> The logic for x86_32, where this option was not under user control,
> remains identical. On x86_64, PCI_MMCONFIG becomes additionally
> configurable for SFI systems even if ACPI was disabled. This just
> simplifies the logic without restricting the configurability in any way.

Thanks for mentioning this difference.  It's probably trivial, but if
you have any other reason to respin this series, I would split this
into two patches:

  - allow PCI_MMCONFIG on x86_64 with SFI
  - consolidate PCI_MMCONFIG with no logical change at all

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

But either way,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/x86/Kconfig | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..aef9d67ac186 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2641,8 +2641,9 @@ config PCI_DIRECT
>  	depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
>  
>  config PCI_MMCONFIG
> -	def_bool y
> -	depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
> +	bool "Support mmconfig PCI config space access" if X86_64
> +	default y
> +	depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))
>  
>  config PCI_OLPC
>  	def_bool y
> @@ -2657,10 +2658,6 @@ config PCI_DOMAINS
>  	def_bool y
>  	depends on PCI
>  
> -config PCI_MMCONFIG
> -	bool "Support mmconfig PCI config space access"
> -	depends on X86_64 && PCI && ACPI
> -
>  config PCI_CNB20LE_QUIRK
>  	bool "Read CNB20LE Host Bridge Windows" if EXPERT
>  	depends on PCI
> -- 
> 2.13.6
> 
