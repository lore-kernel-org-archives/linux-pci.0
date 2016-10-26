Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 26 Oct 2016 17:25:42 -0500
From: Rob Herring <robh@kernel.org>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V4 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <20161026222542.g4etrqesqb7febid@rob-hp-laptop>
References: <1476954940-242159-1-git-send-email-yuanzhichang@hisilicon.com>
 <1476954940-242159-3-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1476954940-242159-3-git-send-email-yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 benh@kernel.crashing.org, minyard@acm.org, arnd@arndb.de,
 catalin.marinas@arm.com, gabriele.paoloni@huawei.com, john.garry@huawei.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, zourongrong@gmail.com, linux-serial@vger.kernel.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, liviu.dudau@arm.com,
 kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 05:15:39PM +0800, zhichang.yuan wrote:
> Currently if the range property is not specified of_translate_one
> returns an error. There are some special devices that work on a
> range of I/O ports where it's is not correct to specify a range
> property as the cpu addresses are used by special accessors.
> Here we add a new exception in of_translate_one to return
> the cpu address if the range property is not there. The exception
> checks if the parent bus is ISA and if the special accessors are
> defined.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  arch/arm64/include/asm/io.h |  7 +++++++
>  arch/arm64/kernel/extio.c   | 24 +++++++++++++++++++++++
>  drivers/of/address.c        | 47 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/pci/pci.c           |  6 +++---
>  include/linux/of_address.h  | 17 ++++++++++++++++
>  5 files changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 136735d..e480199 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -175,6 +175,13 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  #define outsl outsl
>  
>  DECLARE_EXTIO(l, u32)
> +
> +
> +#define indirect_io_ison indirect_io_ison
> +extern int indirect_io_ison(void);
> +
> +#define chk_indirect_range chk_indirect_range
> +extern int chk_indirect_range(u64 taddr);
>  #endif
>  
>  
> diff --git a/arch/arm64/kernel/extio.c b/arch/arm64/kernel/extio.c
> index 80cafd5..55df8dc 100644
> --- a/arch/arm64/kernel/extio.c
> +++ b/arch/arm64/kernel/extio.c
> @@ -19,6 +19,30 @@
>  
>  struct extio_ops *arm64_extio_ops;
>  
> +/**
> + * indirect_io_ison - check whether indirectIO can work well. This function only call
> + *		before the target I/O address was obtained.
> + *
> + * Returns 1 when indirectIO can work.
> + */
> +int indirect_io_ison()
> +{
> +	return arm64_extio_ops ? 1 : 0;
> +}
> +
> +/**
> + * check_indirect_io - check whether the input taddr is for indirectIO.
> + * @taddr: the io address to be checked.
> + *
> + * Returns 1 when taddr is in the range; otherwise return 0.
> + */
> +int chk_indirect_range(u64 taddr)
> +{
> +	if (arm64_extio_ops->start > taddr || arm64_extio_ops->end < taddr)
> +		return 0;
> +
> +	return 1;
> +}
>  
>  BUILD_EXTIO(b, u8)
>  
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903..0bee822 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -479,6 +479,39 @@ static int of_empty_ranges_quirk(struct device_node *np)
>  	return false;
>  }
>  
> +
> +/*
> + * Check whether the current device being translating use indirectIO.
> + *
> + * return 1 if the check is past, or 0 represents fail checking.
> + */
> +static int of_isa_indirect_io(struct device_node *parent,

Make the return bool.

> +				struct of_bus *bus, __be32 *addr,
> +				int na, u64 *presult)
> +{
> +	unsigned int flags;
> +	unsigned int rlen;
> +
> +	/* whether support indirectIO */
> +	if (!indirect_io_ison())

indirect_io_is_enabled() would be a bit more readable.

> +		return 0;
> +
> +	if (!of_bus_isa_match(parent))
> +		return 0;
> +
> +	flags = bus->get_flags(addr);
> +	if (!(flags & IORESOURCE_IO))
> +		return 0;
> +
> +	/* there is ranges property, apply the normal translation directly. */
> +	if (of_get_property(parent, "ranges", &rlen))
> +		return 0;
> +
> +	*presult = of_read_number(addr + 1, na - 1);
> +
> +	return chk_indirect_range(*presult);
> +}
> +
>  static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  			    struct of_bus *pbus, __be32 *addr,
>  			    int na, int ns, int pna, const char *rprop)
> @@ -532,7 +565,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
>  	}
>  	memcpy(addr, ranges + na, 4 * pna);
>  
> - finish:
> +finish:

This hunk is unrelated. Drop it.

>  	of_dump_addr("parent translation for:", addr, pna);
>  	pr_debug("with offset: %llx\n", (unsigned long long)offset);
>  
> @@ -595,6 +628,15 @@ static u64 __of_translate_address(struct device_node *dev,
>  			result = of_read_number(addr, na);
>  			break;
>  		}
> +		/*
> +		 * For indirectIO device which has no ranges property, get
> +		 * the address from reg directly.
> +		 */
> +		if (of_isa_indirect_io(dev, bus, addr, na, &result)) {
> +			pr_info("isa indirectIO matched(%s)..addr = 0x%llx\n",
> +				of_node_full_name(dev), result);

This should be debugging.

> +			break;
> +		}
>  
>  		/* Get new parent bus and counts */
>  		pbus = of_match_bus(parent);
> @@ -688,8 +730,9 @@ static int __of_address_to_resource(struct device_node *dev,
>  	if (taddr == OF_BAD_ADDR)
>  		return -EINVAL;
>  	memset(r, 0, sizeof(struct resource));
> -	if (flags & IORESOURCE_IO) {
> +	if (flags & IORESOURCE_IO && taddr >= PCIBIOS_MIN_IO) {
>  		unsigned long port;
> +
>  		port = pci_address_to_pio(taddr);
>  		if (port == (unsigned long)-1)
>  			return -EINVAL;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ba34907..1a08511 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3263,7 +3263,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>  
>  #ifdef PCI_IOBASE
>  	struct io_range *range;
> -	resource_size_t allocated_size = 0;
> +	resource_size_t allocated_size = PCIBIOS_MIN_IO;
>  
>  	/* check if the range hasn't been previously recorded */
>  	spin_lock(&io_range_lock);
> @@ -3312,7 +3312,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>  
>  #ifdef PCI_IOBASE
>  	struct io_range *range;
> -	resource_size_t allocated_size = 0;
> +	resource_size_t allocated_size = PCIBIOS_MIN_IO;
>  
>  	if (pio > IO_SPACE_LIMIT)
>  		return address;
> @@ -3335,7 +3335,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  {
>  #ifdef PCI_IOBASE
>  	struct io_range *res;
> -	resource_size_t offset = 0;
> +	resource_size_t offset = PCIBIOS_MIN_IO;
>  	unsigned long addr = -1;
>  
>  	spin_lock(&io_range_lock);
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 3786473..0ba7e21 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -24,6 +24,23 @@ struct of_pci_range {
>  #define for_each_of_pci_range(parser, range) \
>  	for (; of_pci_range_parser_one(parser, range);)
>  
> +
> +#ifndef indirect_io_ison
> +#define indirect_io_ison indirect_io_ison
> +static inline int indirect_io_ison(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifndef chk_indirect_range
> +#define chk_indirect_range chk_indirect_range
> +static inline int chk_indirect_range(u64 taddr)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /* Translate a DMA address from device space to CPU space */
>  extern u64 of_translate_dma_address(struct device_node *dev,
>  				    const __be32 *in_addr);
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
