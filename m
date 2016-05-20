Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53481 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbcETSur (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 May 2016 14:50:47 -0400
Date: Fri, 20 May 2016 13:50:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ian Stakenvicius <axs@gentoo.org>
Cc: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] Fix lack of exposure of pci_init for LIBPCI_3.0 on
 pciutils-3.5.0
Message-ID: <20160520185041.GA3818@localhost>
References: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1c0deb86-fee3-4de3-fb00-baf6e71ac7fd@gentoo.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin, Keith]

This is related to the pciutils commit
ab61451d4751 ("pciutils: Add support for 32-bit PCI domains")

On Fri, May 20, 2016 at 01:31:59PM -0400, Ian Stakenvicius wrote:
> The changes included in commit ab61451d47514c473953a24aa4f4f816b77
> were not sufficient to maintain ABI compatibility with older versions
> of libpci.so.3, as pci_init is only exposed under symbol version
> LIBPCI_3.5.
> 
> This patch uses the code pattern for the versioning of pci_fill_info()
> to ensure a pci_init symbol is exposed with LIBPCI_3.0 version.
> 
> Bug: http://bugs.gentoo.org/583580
> ---
>  lib/init.c     | 2 ++
>  lib/internal.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/lib/init.c b/lib/init.c
> index 9a043ee..c7800e0 100644
> --- a/lib/init.c
> +++ b/lib/init.c
> @@ -214,6 +214,8 @@ pci_init_v35(struct pci_access *a)
>  }
>   STATIC_ALIAS(void pci_init(struct pci_access *a), pci_init_v35(a));
> +DEFINE_ALIAS(void pci_init_v30(struct pci_access *a), pci_init_v35);
> +SYMBOL_VERSION(pci_init_v30, pci_init@LIBPCI_3.0);
>  SYMBOL_VERSION(pci_init_v35, pci_init@@LIBPCI_3.5);
>   void
> diff --git a/lib/internal.h b/lib/internal.h
> index f2027f8..cbac2a7 100644
> --- a/lib/internal.h
> +++ b/lib/internal.h
> @@ -61,6 +61,7 @@ void *pci_malloc(struct pci_access *, int);
>  void pci_mfree(void *);
>  char *pci_strdup(struct pci_access *a, const char *s);
>  +void pci_init_v30(struct pci_access *a) VERSIONED_ABI;
>  void pci_init_v35(struct pci_access *a) VERSIONED_ABI;
>   /* access.c */
> -- 
> 2.7.3
> 
> 



