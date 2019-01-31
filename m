Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F50C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BA421872
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 22:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548974376;
	bh=RO2dtx7QhvtYR54Y8i+rMbw1VqImL12jpev9WhDv/FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vFHH4VPXR3hPP9eW1KO20/sfY+Z3RBEe0ibfHWfregHma8k2kveX+23zm8kssnxMJ
	 h9MrNSUpUgrqC7aD4T7sWAoaRYX2BUst7ewEFWzY3ibi95QB/wAyVyTBT4wNN49dwk
	 iDj4lj1tS+nBa2rMK9jDDHXtG42RUacEZuK0md/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfAaWjf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfAaWjf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 17:39:35 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2092084A;
        Thu, 31 Jan 2019 22:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548974373;
        bh=RO2dtx7QhvtYR54Y8i+rMbw1VqImL12jpev9WhDv/FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdv3LCOryxADkOQeo+k03JKDsuj3l2H1BYlm7WSZCQ3Kctxxc7pNb3yJnmS8Ov1c7
         TuG6/MwhhfLwfkm+JWYUkzkGX6yxuhVJCqFyiT7dWvCzgR0fznB5hNH+LKuqOtVlUk
         efb9q/rPVZ7q9J3pJMhh2JuRptTZgI5eC/kaot34=
Date:   Thu, 31 Jan 2019 16:39:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/9] PCI/MSI: Support allocating virtual MSI interrupts
Message-ID: <20190131223932.GR229773@google.com>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131185656.17972-3-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Marc]

On Thu, Jan 31, 2019 at 11:56:49AM -0700, Logan Gunthorpe wrote:
> For NTB devices, we want to be able to trigger MSI interrupts
> through a memory window. In these cases we may want to use
> more interrupts than the NTB PCI device has available in its MSI-X
> table.
> 
> We allow for this by creating a new 'virtual' interrupt. These
> interrupts are allocated as usual but are not programmed into the
> MSI-X table (as there may not be space for them).
> 
> The MSI address and data will then handled through an NTB MSI library
> introduced later in this series.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this along with the rest of the series, so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Minor question and typo below.

> ---
>  drivers/pci/msi.c   | 51 +++++++++++++++++++++++++++++++++++++--------
>  include/linux/msi.h |  1 +
>  include/linux/pci.h |  9 ++++++++
>  3 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..145587da686c 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -192,6 +192,9 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
>  
>  static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
>  {
> +	if (desc->msi_attrib.is_virtual)
> +		return NULL;
> +
>  	return desc->mask_base +
>  		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
>  }
> @@ -206,14 +209,19 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
>  u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
>  {
>  	u32 mask_bits = desc->masked;
> +	void __iomem *desc_addr;
>  
>  	if (pci_msi_ignore_mask)
>  		return 0;
> +	desc_addr = pci_msix_desc_addr(desc);
> +	if (!desc_addr)
> +		return 0;
>  
>  	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
>  	if (flag)
>  		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> -	writel(mask_bits, pci_msix_desc_addr(desc) + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +
> +	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  
>  	return mask_bits;
>  }
> @@ -273,6 +281,11 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  	if (entry->msi_attrib.is_msix) {
>  		void __iomem *base = pci_msix_desc_addr(entry);
>  
> +		if (!base) {
> +			WARN_ON(1);
> +			return;
> +		}
> +
>  		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
>  		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
>  		msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
> @@ -303,6 +316,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  	} else if (entry->msi_attrib.is_msix) {
>  		void __iomem *base = pci_msix_desc_addr(entry);
>  
> +		if (!base)
> +			goto skip;
> +
>  		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>  		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>  		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> @@ -327,6 +343,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  					      msg->data);
>  		}
>  	}
> +
> +skip:
>  	entry->msg = *msg;
>  }
>  
> @@ -550,6 +568,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
>  
>  	entry->msi_attrib.is_msix	= 0;
>  	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
> +	entry->msi_attrib.is_virtual    = 0;
>  	entry->msi_attrib.entry_nr	= 0;
>  	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
>  	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
> @@ -674,6 +693,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  	struct irq_affinity_desc *curmsk, *masks = NULL;
>  	struct msi_desc *entry;
>  	int ret, i;
> +	int vec_count = pci_msix_vec_count(dev);
>  
>  	if (affd)
>  		masks = irq_create_affinity_masks(nvec, affd);
> @@ -696,6 +716,10 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			entry->msi_attrib.entry_nr = entries[i].entry;
>  		else
>  			entry->msi_attrib.entry_nr = i;
> +
> +		entry->msi_attrib.is_virtual =
> +			entry->msi_attrib.entry_nr >= vec_count;
> +
>  		entry->msi_attrib.default_irq	= dev->irq;
>  		entry->mask_base		= base;
>  
> @@ -714,12 +738,19 @@ static void msix_program_entries(struct pci_dev *dev,
>  {
>  	struct msi_desc *entry;
>  	int i = 0;
> +	void __iomem *desc_addr;
>  
>  	for_each_pci_msi_entry(entry, dev) {
>  		if (entries)
>  			entries[i++].vector = entry->irq;
> -		entry->masked = readl(pci_msix_desc_addr(entry) +
> -				PCI_MSIX_ENTRY_VECTOR_CTRL);
> +
> +		desc_addr = pci_msix_desc_addr(entry);
> +		if (desc_addr)
> +			entry->masked = readl(desc_addr +
> +					      PCI_MSIX_ENTRY_VECTOR_CTRL);
> +		else
> +			entry->masked = 0;
> +
>  		msix_mask_irq(entry, 1);
>  	}
>  }
> @@ -932,7 +963,8 @@ int pci_msix_vec_count(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_msix_vec_count);
>  
>  static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
> -			     int nvec, const struct irq_affinity *affd)
> +			     int nvec, const struct irq_affinity *affd,
> +			     int flags)
>  {
>  	int nr_entries;
>  	int i, j;
> @@ -943,7 +975,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  	nr_entries = pci_msix_vec_count(dev);
>  	if (nr_entries < 0)
>  		return nr_entries;
> -	if (nvec > nr_entries)
> +	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
>  		return nr_entries;
>  
>  	if (entries) {
> @@ -1086,7 +1118,8 @@ EXPORT_SYMBOL(pci_enable_msi);
>  
>  static int __pci_enable_msix_range(struct pci_dev *dev,
>  				   struct msix_entry *entries, int minvec,
> -				   int maxvec, const struct irq_affinity *affd)
> +				   int maxvec, const struct irq_affinity *affd,
> +				   int flags)
>  {
>  	int rc, nvec = maxvec;
>  
> @@ -1110,7 +1143,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  				return -ENOSPC;
>  		}
>  
> -		rc = __pci_enable_msix(dev, entries, nvec, affd);
> +		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
>  		if (rc == 0)
>  			return nvec;
>  
> @@ -1141,7 +1174,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  		int minvec, int maxvec)
>  {
> -	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL);
> +	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
> @@ -1181,7 +1214,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  
>  	if (flags & PCI_IRQ_MSIX) {
>  		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> -						    max_vecs, affd);
> +						    max_vecs, affd, flags);
>  		if (msix_vecs > 0)
>  			return msix_vecs;
>  	}
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 784fb52b9900..6458ab049852 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -88,6 +88,7 @@ struct msi_desc {
>  				__u8	multi_cap	: 3;
>  				__u8	maskbit		: 1;
>  				__u8	is_64		: 1;
> +				__u8    is_virtual      : 1;

You did the right thing by using the same style as what's already
here, but does anybody know why are we using __u8 and __u16 here?

Those typedefs are in include/uapi/asm-generic/int-l64.h, which
suggests they're for things exported to user space, but I don't think
that's the case here, so I'm wondering if we could someday replace
these with u8 and u16.  Obviously that wouldn't be part of *this*
series.

>  				__u16	entry_nr;
>  				unsigned default_irq;
>  			} msi_attrib;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c2f082..ce0815c2c498 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1352,6 +1352,15 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
> +
> +/*
> + * Virtual interrupts allow for more interrupts to be allocated
> + * than the device has interrupts for. These are not programmed
> + * into the devices MSI-X table and must be handled by some

s/devices/device's/

> + * other driver means.
> + */
> +#define PCI_IRQ_VIRTUAL		(1 << 4)
> +
>  #define PCI_IRQ_ALL_TYPES \
>  	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
>  
> -- 
> 2.19.0
> 
