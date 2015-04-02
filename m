Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40618 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbbDBDzU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Apr 2015 23:55:20 -0400
Date: Thu, 2 Apr 2015 11:55:13 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v5 05/10] pci: make msi/msix shutdown functions static
Message-ID: <20150402035513.GH15412@fam-t430.nay.redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-6-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-6-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
> pci_msi_shutdown and pci_msix_shutdown are now internal to msi.c, drop
> them from header and make them static.

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/pci.h | 4 ----
>  drivers/pci/msi.c   | 4 ++--
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 211e9da..a34df45 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1209,11 +1209,9 @@ struct msix_entry {
>  
>  #ifdef CONFIG_PCI_MSI
>  int pci_msi_vec_count(struct pci_dev *dev);
> -void pci_msi_shutdown(struct pci_dev *dev);
>  void pci_disable_msi(struct pci_dev *dev);
>  int pci_msix_vec_count(struct pci_dev *dev);
>  int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
> -void pci_msix_shutdown(struct pci_dev *dev);
>  void pci_disable_msix(struct pci_dev *dev);
>  void pci_restore_msi_state(struct pci_dev *dev);
>  int pci_msi_enabled(void);
> @@ -1237,13 +1235,11 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  }
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> -static inline void pci_msi_shutdown(struct pci_dev *dev) { }
>  static inline void pci_disable_msi(struct pci_dev *dev) { }
>  static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
>  static inline int pci_enable_msix(struct pci_dev *dev,
>  				  struct msix_entry *entries, int nvec)
>  { return -ENOSYS; }
> -static inline void pci_msix_shutdown(struct pci_dev *dev) { }
>  static inline void pci_disable_msix(struct pci_dev *dev) { }
>  static inline void pci_restore_msi_state(struct pci_dev *dev) { }
>  static inline int pci_msi_enabled(void) { return 0; }
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index f66be86..ea78a07 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -887,7 +887,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_msi_vec_count);
>  
> -void pci_msi_shutdown(struct pci_dev *dev)
> +static void pci_msi_shutdown(struct pci_dev *dev)
>  {
>  	struct msi_desc *desc;
>  	u32 mask;
> @@ -993,7 +993,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
>  }
>  EXPORT_SYMBOL(pci_enable_msix);
>  
> -void pci_msix_shutdown(struct pci_dev *dev)
> +static void pci_msix_shutdown(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  
> -- 
> MST
> 
