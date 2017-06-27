Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753511AbdF0U5R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 16:57:17 -0400
Date: Tue, 27 Jun 2017 15:57:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 1/7] x86/pci: Remove duplicate defines
Message-ID: <20170627205714.GB764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170316215056.967808646@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316215056.967808646@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Thu, Mar 16, 2017 at 10:50:03PM +0100, Thomas Gleixner wrote:
> For some historic reason these defines are duplicated. Remove them.

Duplicated in arch/x86/include/asm/pci.h and
arch/x86/include/asm/pci_x86.h, I guess.

Good to remove the duplication, for sure.  I wonder why we didn't see
duplicate definition warnings.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/pci.h |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -76,14 +76,8 @@ static inline bool is_vmd(struct pci_bus
>  
>  extern unsigned int pcibios_assign_all_busses(void);
>  extern int pci_legacy_init(void);
> -# ifdef CONFIG_ACPI
> -#  define x86_default_pci_init pci_acpi_init
> -# else
> -#  define x86_default_pci_init pci_legacy_init
> -# endif
>  #else
> -# define pcibios_assign_all_busses()	0
> -# define x86_default_pci_init		NULL
> +static inline int pcibios_assign_all_busses(void) { return 0; }
>  #endif
>  
>  extern unsigned long pci_mem_start;
> 
> 
