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
Subject: Re: [PATCH v2 3/5] sh/PCI: Pass GAPSPCI_DMA_BASE CPU address to dma_declare_coherent_memory()
Date: Wed, 07 May 2014 09:55:16 +0200
Message-ID: <6994558.Q3OYh8PWMa@wuerfel>
In-Reply-To: <20140506224833.17968.87108.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140506224833.17968.87108.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 May 2014 16:48:33 Bjorn Helgaas wrote:
> @@ -51,8 +53,12 @@ static void gapspci_fixup_resources(struct pci_dev *dev)
>                 /*
>                  * Redirect dma memory allocations to special memory window.
>                  */
> +               region.start = GAPSPCI_DMA_BASE;
> +               region.end = GAPSPCI_DMA_BASE + GAPSPCI_DMA_SIZE - 1;
> +               res.flags = IORESOURCE_MEM;
> +               pcibios_bus_to_resource(dev->bus, &res, &region);
>                 BUG_ON(!dma_declare_coherent_memory(&dev->dev,
> -                                               GAPSPCI_DMA_BASE,
> +                                               res->start,
>                                                 GAPSPCI_DMA_BASE,
>                                                 GAPSPCI_DMA_SIZE,
>                                                 DMA_MEMORY_MAP |

Not sure if this is an improvement. I understand the intention, but
it's actually possible for the offset to be different both ways:

Your patch applies the outbound mem_offset that was provided when
registering the MMIO resource for the PCI host bridge. What the driver
needs instead is the inbound DMA offset that gets applied by some
host bridges that don't have a 1:1 mapping but also don't have an
IOMMU. We know that on this particular platform, both are zero, so
the original code works and it will keep working with your change,
but I think it's a mistake anyway. I have seen both kinds of offsets
in the past on real machines, but I am not aware of any where they
are both nonzero and have the same value.

	Arnd
