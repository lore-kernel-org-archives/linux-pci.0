Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424089AbcBQVTc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Feb 2016 16:19:32 -0500
Date: Wed, 17 Feb 2016 14:19:32 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Luis Henriques <luis.henriques@canonical.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: stub pci_write_msi_msg when CONFIG_PCI_MSI is
 disabled
Message-ID: <20160217141932.283ced46@t450s.home>
In-Reply-To: <1455743138-17224-1-git-send-email-luis.henriques@canonical.com>
References: <20160203205108.GA9181@charon.olymp>
	<1455743138-17224-1-git-send-email-luis.henriques@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc +bjorn, +linux-pci]

On Wed, 17 Feb 2016 21:05:38 +0000
Luis Henriques <luis.henriques@canonical.com> wrote:

> Stubbing function pci_write_msi_msg when CONFIG_PCI_MSI is disabled fixes
> a link failure in vfio:
> 
> drivers/built-in.o: In function `vfio_msi_set_vector_signal':
> :(.text+0x626640): undefined reference to `pci_write_msi_msg'
> 
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> ---
>  include/linux/msi.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index a2a0068a8387..09dc375d11d8 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -105,18 +105,19 @@ struct msi_desc {
>  
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
>  void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
> +void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
>  #else /* CONFIG_PCI_MSI */
>  static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>  {
>  	return NULL;
>  }
> +static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg) { }
>  #endif /* CONFIG_PCI_MSI */
>  
>  struct msi_desc *alloc_msi_entry(struct device *dev);
>  void free_msi_entry(struct msi_desc *entry);
>  void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
> -void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
>  
>  u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
>  u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);

