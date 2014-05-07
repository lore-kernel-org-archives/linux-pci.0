Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-kernel@vger.kernel.org,
	James Bottomley <jbottomley@parallels.com>,
	linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/5] DMA-API: Clarify physical/bus address distinction
Date: Wed, 07 May 2014 09:37:04 +0200
Message-ID: <4295045.447pOn727x@wuerfel>
In-Reply-To: <20140506224819.17968.2922.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140506224819.17968.2922.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 May 2014 16:48:19 Bjorn Helgaas wrote:
> The DMA-API documentation sometimes refers to "physical addresses" when it
> really means "bus addresses."  Sometimes these are identical, but they may
> be different if the bridge leading to the bus performs address translation.
> Update the documentation to use "bus address" when appropriate.
> 
> Also, consistently capitalize "DMA", use parens with function names, use
> dev_printk() in examples, and reword a few sections for clarity.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks great!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Just some minor comments that you may include if you like (my Ack
holds if you don't as well).

> @@ -30,16 +28,16 @@ hardware exists.
>  
>  Note that the DMA API works with any bus independent of the underlying
>  microprocessor architecture. You should use the DMA API rather than
> -the bus specific DMA API (e.g. pci_dma_*).
> +the bus-specific DMA API (e.g. pci_dma_*).

It might make sense to change the example to dma_map_* rather than pci_dma_*,
which is rarely used these days. I think there was at one point a move
to replace remove the include/asm-generic/pci-dma-compat.h APIs.

>  First of all, you should make sure
>  
>  #include <linux/dma-mapping.h>
>  
> -is in your driver. This file will obtain for you the definition of the
> -dma_addr_t (which can hold any valid DMA address for the platform)
> -type which should be used everywhere you hold a DMA (bus) address
> -returned from the DMA mapping functions.
> +is in your driver, which provides the definition of dma_addr_t.  This type
> +can hold any valid DMA or bus address for the platform and should be used
> +everywhere you hold a DMA address returned from the DMA mapping functions
> +or a bus address read from a device register such as a PCI BAR.

The PCI BAR example is misleading I think: While the raw value of the
BAR would be a dma_addr_t that can be used for pci-pci DMA, we normally
only deal with translated BARs from pci_resource_*, which would be
a resource_size_t in the same space as phys_addr_t, which has the
PCI mem_offset added in.

> + * A dma_addr_t can hold any valid DMA or bus address for the platform.
> + * It can be given to a device to use as a DMA source or target, or it may
> + * appear on the bus when a CPU performs programmed I/O.  A CPU cannot
> + * reference a dma_addr_t directly because there may be translation between
> + * its physical address space and the bus address space.

On a similar note, I think the part 'or it may appear on the bus when a CPU
performs programmed I/O' is somewhat misleading: While true in theory, we
would never use a dma_addr_t to store an address to be used for PIO, because
the CPU needs to use either the phys_addr_t value associated with the physical
MMIO address or the __iomem pointer for the virtually mapped address.

	Arnd
