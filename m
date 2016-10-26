Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932826AbcJZT46 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Oct 2016 15:56:58 -0400
Date: Wed, 26 Oct 2016 14:56:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: quirks: hide maybe-uninitialized warning
Message-ID: <20161026195653.GE17507@bhelgaas-glaptop.roam.corp.google.com>
References: <20161024153325.2752428-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161024153325.2752428-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 24, 2016 at 05:33:18PM +0200, Arnd Bergmann wrote:
> gcc -Wmaybe-uninitialized detects that quirk_intel_brickland_xeon_ras_cap
> uses uninitialized data when CONFIG_PCI is not set:
> 
> arch/x86/kernel/quirks.c: In function ‘quirk_intel_brickland_xeon_ras_cap’:
> arch/x86/kernel/quirks.c:641:13: error: ‘capid0’ is used uninitialized in this function [-Werror=uninitialized]
> 
> However, the function is also not called in this configuration, so we
> can avoid the warning by moving the existing #ifdef to cover it as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This fixes 3637efb00864 ("x86/mce: Add PCI quirks to identify Xeons with
machine check recovery"), which appeared in v4.9-rc1.  I assume it will be
merged for v4.9 via the x86 tree, as 3637efb00864 was.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  arch/x86/kernel/quirks.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index 51402a7e4ca6..0bee04d41bed 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -625,8 +625,6 @@ static void amd_disable_seq_and_redirect_scrub(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_NB_F3,
>  			amd_disable_seq_and_redirect_scrub);
>  
> -#endif
> -
>  #if defined(CONFIG_X86_64) && defined(CONFIG_X86_MCE)
>  #include <linux/jump_label.h>
>  #include <asm/string_64.h>
> @@ -657,3 +655,4 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2fc0, quirk_intel_brickland_xeon_
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, quirk_intel_brickland_xeon_ras_cap);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras_cap);
>  #endif
> +#endif
> -- 
> 2.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
