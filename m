Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41006 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759605AbdEZFqG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 May 2017 01:46:06 -0400
Date: Fri, 26 May 2017 07:46:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: bhelgaas@google.com, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/msi: fix the pci_alloc_irq_vectors_affinity stub
Message-ID: <20170526054604.GA18291@lst.de>
References: <20170520132129.16430-1-hch@lst.de> <20170520132129.16430-2-hch@lst.de> <20170520165954.GA26936@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170520165954.GA26936@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

can you take this regression fix and sent it to Linux before -rc3?
I had hope we could get it into -rc2 but already missed that, and
I haven't heard a comment since..

On Sat, May 20, 2017 at 06:59:54PM +0200, Christoph Hellwig wrote:
> We need to return an error for any call that asks for MSI / MSI-X
> vectors only, so that non-trivial fallback logic can work properly.
> 
> Also valid dev->irq and use the "correct" errno value based on feedback
> from Linus.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: aff17164 ("PCI: Provide sensible IRQ vector alloc/free routines")
> ---
> 
> Changes from V1:
>  - use == comparism
>  - return -ENOSPC
>  - verify dev->irq
> 
>  include/linux/pci.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33c2b0b77429..fc2e832d7b9c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1342,9 +1342,9 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			       unsigned int max_vecs, unsigned int flags,
>  			       const struct irq_affinity *aff_desc)
>  {
> -	if (min_vecs > 1)
> -		return -EINVAL;
> -	return 1;
> +	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
> +		return 1;
> +	return -ENOSPC;
>  }
>  
>  static inline void pci_free_irq_vectors(struct pci_dev *dev)
> -- 
> 2.11.0
---end quoted text---
