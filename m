Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 7 Mar 2016 11:57:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] frv: remove stray pci_{alloc,free}_consistent
 declaration
Message-ID: <20160307175753.GB13818@localhost>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
 <1457277475-8913-2-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457277475-8913-2-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David M, David H]

On Sun, Mar 06, 2016 at 04:17:53PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied with acks from David M & David H to pci/misc for v4.6, thanks!

> ---
>  arch/frv/include/asm/pci.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/frv/include/asm/pci.h b/arch/frv/include/asm/pci.h
> index e43d22c..7e96b57 100644
> --- a/arch/frv/include/asm/pci.h
> +++ b/arch/frv/include/asm/pci.h
> @@ -32,12 +32,6 @@ extern void consistent_sync_page(struct page *page, unsigned long offset,
>  				 size_t size, int direction);
>  #endif
>  
> -extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> -				  dma_addr_t *dma_handle);
> -
> -extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
> -				void *vaddr, dma_addr_t dma_handle);
> -
>  /* Return the index of the PCI controller for device PDEV. */
>  #define pci_controller_num(PDEV)	(0)
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
