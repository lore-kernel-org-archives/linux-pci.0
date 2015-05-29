Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 29 May 2015 17:31:00 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Add pci_bus_addr_t
Message-ID: <20150529223100.GE12733@google.com>
References: <1432772632-5139-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432772632-5139-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc David, linux-arch, linux-kernel]

TL;DR: Use the new pci_bus_addr_t to contain raw PCI bus addresses.  This
is of interest primarily in the PCI core because arch code mostly uses
resources (CPU physical addresses) and drivers mostly use ioremap to obtain
CPU virtual addresses.

On Wed, May 27, 2015 at 05:23:51PM -0700, Yinghai Lu wrote:
> David Ahern reported that d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
> to fit in upstream windows") fails to boot on sparc/T5-8:
> 
> pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address 0x110204000)
> 
> The problem is that sparc64 assumed that dma_addr_t only needed to hold DMA
> addresses, i.e., bus addresses returned via the DMA API (dma_map_single(),
> etc.), while the PCI core assumed dma_addr_t could hold *any* bus address,
> including raw BAR values.  On sparc64, all DMA addresses fit in 32 bits, so
> dma_addr_t is a 32-bit type.  However, BAR values can be 64 bits wide, so
> they don't fit in a dma_addr_t.  d63e2e1f3df9 added new checking that
> tripped over this mismatch.
> 
> Add pci_bus_addr_t, which is wide enough to hold any PCI bus address,
> including both raw BAR values and DMA addresses.  This will be 64 bits
> on 64-bit platforms and on platforms with a 64-bit dma_addr_t.  Then
> dma_addr_t only needs to be wide enough to hold addresses from the DMA API.
> 
> Fixes: d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
> Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> Link: http://lkml.kernel.org/r/1427857069-6789-1-git-send-email-yinghai@kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=96231
> Reported-by: David Ahern <david.ahern@oracle.com>
> Tested-by: David Ahern <david.ahern@oracle.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> [bhelgaas: changelog, bugzilla, Kconfig to ensure pci_bus_addr_t is at least as wide as dma_addr_t]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: David S. Miller <davem@davemloft.net>
> CC: stable@vger.kernel.org	# v3.19+

I applied these both to pci/resources for v4.2.  I combined them into one
patch so the code and corresponding documentation changes are all together.

> ---
>  drivers/pci/Kconfig |    4 ++++
>  drivers/pci/bus.c   |   10 +++++-----
>  drivers/pci/probe.c |   12 ++++++------
>  include/linux/pci.h |   12 +++++++++---
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 
> Index: linux-2.6/drivers/pci/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/pci/Kconfig
> +++ linux-2.6/drivers/pci/Kconfig
> @@ -1,6 +1,10 @@
>  #
>  # PCI configuration
>  #
> +config PCI_BUS_ADDR_T_64BIT
> +	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
> +	depends on PCI
> +
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
>  	depends on PCI
> Index: linux-2.6/drivers/pci/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/bus.c
> +++ linux-2.6/drivers/pci/bus.c
> @@ -92,11 +92,11 @@ void pci_bus_remove_resources(struct pci
>  }
>  
>  static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
>  static struct pci_bus_region pci_64_bit = {0,
> -				(dma_addr_t) 0xffffffffffffffffULL};
> -static struct pci_bus_region pci_high = {(dma_addr_t) 0x100000000ULL,
> -				(dma_addr_t) 0xffffffffffffffffULL};
> +				(pci_bus_addr_t) 0xffffffffffffffffULL};
> +static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
> +				(pci_bus_addr_t) 0xffffffffffffffffULL};
>  #endif
>  
>  /*
> @@ -200,7 +200,7 @@ int pci_bus_alloc_resource(struct pci_bu
>  					  resource_size_t),
>  		void *alignf_data)
>  {
> -#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
>  	int rc;
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
> Index: linux-2.6/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/probe.c
> +++ linux-2.6/drivers/pci/probe.c
> @@ -254,8 +254,8 @@ int __pci_read_base(struct pci_dev *dev,
>  	}
>  
>  	if (res->flags & IORESOURCE_MEM_64) {
> -		if ((sizeof(dma_addr_t) < 8 || sizeof(resource_size_t) < 8) &&
> -		    sz64 > 0x100000000ULL) {
> +		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
> +		    && sz64 > 0x100000000ULL) {
>  			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>  			res->start = 0;
>  			res->end = 0;
> @@ -264,7 +264,7 @@ int __pci_read_base(struct pci_dev *dev,
>  			goto out;
>  		}
>  
> -		if ((sizeof(dma_addr_t) < 8) && l) {
> +		if ((sizeof(pci_bus_addr_t) < 8) && l) {
>  			/* Above 32-bit boundary; try to reallocate */
>  			res->flags |= IORESOURCE_UNSET;
>  			res->start = 0;
> @@ -399,7 +399,7 @@ static void pci_read_bridge_mmio_pref(st
>  	struct pci_dev *dev = child->self;
>  	u16 mem_base_lo, mem_limit_lo;
>  	u64 base64, limit64;
> -	dma_addr_t base, limit;
> +	pci_bus_addr_t base, limit;
>  	struct pci_bus_region region;
>  	struct resource *res;
>  
> @@ -426,8 +426,8 @@ static void pci_read_bridge_mmio_pref(st
>  		}
>  	}
>  
> -	base = (dma_addr_t) base64;
> -	limit = (dma_addr_t) limit64;
> +	base = (pci_bus_addr_t) base64;
> +	limit = (pci_bus_addr_t) limit64;
>  
>  	if (base != base64) {
>  		dev_err(&dev->dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
> Index: linux-2.6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.orig/include/linux/pci.h
> +++ linux-2.6/include/linux/pci.h
> @@ -577,9 +577,15 @@ int raw_pci_read(unsigned int domain, un
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>  		  int reg, int len, u32 val);
>  
> +#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
> +typedef u64 pci_bus_addr_t;
> +#else
> +typedef u32 pci_bus_addr_t;
> +#endif
> +
>  struct pci_bus_region {
> -	dma_addr_t start;
> -	dma_addr_t end;
> +	pci_bus_addr_t start;
> +	pci_bus_addr_t end;
>  };
>  
>  struct pci_dynids {
> @@ -1127,7 +1133,7 @@ int __must_check pci_bus_alloc_resource(
>  
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
>  
> -static inline dma_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
> +static inline pci_bus_addr_t pci_bus_address(struct pci_dev *pdev, int bar)
>  {
>  	struct pci_bus_region region;
>  
