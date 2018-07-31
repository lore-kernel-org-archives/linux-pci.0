Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbeHAAuS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Jul 2018 20:50:18 -0400
Date: Tue, 31 Jul 2018 18:07:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: bhelgaas@google.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2] PCI: Unify pci and normal dma direction definition
Message-ID: <20180731230740.GP45322@bhelgaas-glaptop.roam.corp.google.com>
References: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 18, 2018 at 09:40:35AM +0800, Shunyong Yang wrote:
> Current DMA direction definitions in pci-dma-compat.h and dma-direction.h
> are mirrored in value. Unifying them to enhance readability and avoid
> possible inconsistency.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>

Applied to pci/misc for v4.19, thanks!

> ---
> 
> v2:
>   Remove unnecessary comments and  braces according to Christoph's
>   comments.
> 
> ---
>  include/linux/dma-direction.h  | 6 ++----
>  include/linux/pci-dma-compat.h | 8 ++++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
> index 3649a031893a..9c96e30e6a0b 100644
> --- a/include/linux/dma-direction.h
> +++ b/include/linux/dma-direction.h
> @@ -1,14 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_DMA_DIRECTION_H
>  #define _LINUX_DMA_DIRECTION_H
> -/*
> - * These definitions mirror those in pci.h, so they can be used
> - * interchangeably with their PCI_ counterparts.
> - */
> +
>  enum dma_data_direction {
>  	DMA_BIDIRECTIONAL = 0,
>  	DMA_TO_DEVICE = 1,
>  	DMA_FROM_DEVICE = 2,
>  	DMA_NONE = 3,
>  };
> +
>  #endif
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index 0dd1a3f7b309..c3f1b44ade29 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -8,10 +8,10 @@
>  #include <linux/dma-mapping.h>
>  
>  /* This defines the direction arg to the DMA mapping routines. */
> -#define PCI_DMA_BIDIRECTIONAL	0
> -#define PCI_DMA_TODEVICE	1
> -#define PCI_DMA_FROMDEVICE	2
> -#define PCI_DMA_NONE		3
> +#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
> +#define PCI_DMA_TODEVICE	DMA_TO_DEVICE
> +#define PCI_DMA_FROMDEVICE	DMA_FROM_DEVICE
> +#define PCI_DMA_NONE		DMA_NONE
>  
>  static inline void *
>  pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> -- 
> 1.8.3.1
> 
