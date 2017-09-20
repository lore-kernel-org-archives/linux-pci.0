Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Sep 2017 10:14:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Joerg Roedel <jroedel@suse.de>, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Add dummy for pci_acs_enabled() if CONFIG_PCI=n to
 fix iommmu build
Message-ID: <20170920101459.3a6735ad@w520.home>
In-Reply-To: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
References: <1505132955-9517-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 11 Sep 2017 14:29:15 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> If CONFIG_PCI=n, and gcc (e.g. 4.1.2) decides not to inline
> get_pci_function_alias_group(), the build fails with:
> 
>     drivers/iommu/iommu.o: In function `get_pci_function_alias_group':
>     iommu.c:(.text+0xfdc): undefined reference to `pci_acs_enabled'
> 
> Due to the various dummies for PCI calls in the CONFIG_PCI=n case,
> pci_acs_enabled() isn't actually ever called, but not all versions of
> gcc are smart enough to realize that.
> 
> While explicitly marking get_pci_function_alias_group() inline would fix
> the build, this would inflate the code for the CONFIG_PCI=y case, as
> get_pci_function_alias_group() is a not-so-small function called from
> two places.
> 
> Hence fix the issue by introducing a dummy for pci_acs_enabled()
> instead.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f68c58a93dd045b9..f4f8ee5a7362e982 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1685,6 +1685,8 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  
>  #define dev_is_pci(d) (false)
>  #define dev_is_pf(d) (false)
> +static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
> +{ return false; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
