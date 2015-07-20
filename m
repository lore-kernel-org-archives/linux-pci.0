Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59136 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489AbbGTOZS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:25:18 -0400
Date: Mon, 20 Jul 2015 16:25:15 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 8/8] PCI: Move ATS declarations to linux/pci.h so they're
 all together
Message-ID: <20150720142515.GH13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213247.18379.66315.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213247.18379.66315.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:47PM -0500, Bjorn Helgaas wrote:
> Move ATS declarations to linux/pci.h so they're all in one place.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci-ats.h |   41 -----------------------------------------
>  include/linux/pci.h     |    8 ++++++++
>  2 files changed, 8 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 5d81d47..57e0b82 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -3,47 +3,6 @@
>  
>  #include <linux/pci.h>
>  
> -/* Address Translation Service */
> -#ifdef CONFIG_PCI_ATS
> -
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -
> -/**
> - * pci_ats_enabled - query the ATS status
> - * @dev: the PCI device
> - *
> - * Returns 1 if ATS capability is enabled, or 0 if not.
> - */
> -static inline int pci_ats_enabled(struct pci_dev *dev)
> -{
> -	return dev->ats_cap && dev->ats_enabled;
> -}
> -
> -#else /* CONFIG_PCI_ATS */
> -
> -static inline int pci_enable_ats(struct pci_dev *dev, int ps)
> -{
> -	return -ENODEV;
> -}
> -
> -static inline void pci_disable_ats(struct pci_dev *dev)
> -{
> -}
> -
> -static inline int pci_ats_queue_depth(struct pci_dev *dev)
> -{
> -	return -ENODEV;
> -}
> -
> -static inline int pci_ats_enabled(struct pci_dev *dev)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_PCI_ATS */
> -
>  #ifdef CONFIG_PCI_PRI
>  
>  int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1997853..744a5e9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1300,8 +1300,16 @@ void ht_destroy_irq(unsigned int irq);
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +static inline int pci_ats_enabled(struct pci_dev *dev) { return dev->ats_enabled; }
>  #else
>  static inline void pci_ats_init(struct pci_dev *) { }
> +static inline int pci_enable_ats(struct pci_dev *, int) { return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *) { return -ENODEV; }
> +static inline int pci_ats_enabled(struct pci_dev *dev) { return 0; }
>  #endif
>  
>  void pci_cfg_access_lock(struct pci_dev *dev);

Reviewed-by: Joerg Roedel <jroedel@suse.de>

