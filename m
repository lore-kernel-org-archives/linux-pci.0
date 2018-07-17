Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2018 10:36:29 -0400
Date: Tue, 17 Jul 2018 07:03:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] PCI: Unify pci and normal dma direction definition
Message-ID: <20180717140335.GA23500@infradead.org>
References: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
> index 3649a031893a..9d52716e9218 100644
> --- a/include/linux/dma-direction.h
> +++ b/include/linux/dma-direction.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_DMA_DIRECTION_H
>  #define _LINUX_DMA_DIRECTION_H
>  /*
> - * These definitions mirror those in pci.h, so they can be used
> + * These definitions mirror those in pci-dma-compat.h, so they can be used
>   * interchangeably with their PCI_ counterparts.
>   */

I think we can just drop this comment anymore.

> +#define PCI_DMA_BIDIRECTIONAL	(DMA_BIDIRECTIONAL)
> +#define PCI_DMA_TODEVICE	(DMA_TO_DEVICE)
> +#define PCI_DMA_FROMDEVICE	(DMA_FROM_DEVICE)
> +#define PCI_DMA_NONE		(DMA_NONE)

No need for the braces.
