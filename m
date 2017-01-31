Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 30 Jan 2017 18:15:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V6 2/5] PCI: Adapt pci_register_io_range() for
 indirect-IO and  PCI I/O translation
Message-ID: <20170131001551.GC20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-3-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1485241525-201782-3-git-send-email-yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com,
 rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 liviu.dudau@arm.com, john.garry@huawei.com, zourongrong@gmail.com,
 robh+dt@kernel.org, bhelgaas@google.com, kantyzc@163.com,
 zhichang.yuan02@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 24, 2017 at 03:05:22PM +0800, zhichang.yuan wrote:
> After indirect-IO is introduced, system must can assigned indirect-IO devices
> with logical I/O ranges which are different from those for PCI I/O devices.
> Otherwise, I/O accessors can't identify whether the I/O port is for memory
> mapped I/O or indirect-IO.
> As current helper, pci_register_io_range(), is used for PCI I/O ranges
> registration and translation, indirect-IO devices should also apply these
> helpers to manage the I/O ranges. It will be easy to ensure the assigned
> logical I/O ranges unique.
> But for indirect-IO devices, there is no cpu address. The current
> pci_register_io_range() can not work for this case.
> 
> This patch makes some changes on the pci_register_io_range() to support the
> I/O range registration with device's fwnode also. After this, the indirect-IO
> devices can register the device-local I/O range to system logical I/O and
> easily perform the translation between device-local I/O range and sytem
> logical I/O range.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I had a couple trivial comments, but you can include my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci parts

in your next revision.  I don't know who you have in mind to merge this;
it doesn't really touch much of PCI.  But let me know if you need anything
else from me.

> ---
>  drivers/acpi/pci_root.c | 12 +++++-------
>  drivers/of/address.c    |  8 ++------
>  drivers/pci/pci.c       | 44 ++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pci.h     |  7 +++++--
>  4 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index bf601d4..6cadf05 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -730,7 +730,8 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>  	}
>  }
>  
> -static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
> +static void acpi_pci_root_remap_iospace(struct fwnode_handle *node,
> +					struct resource_entry *entry)
>  {
>  #ifdef PCI_IOBASE
>  	struct resource *res = entry->res;
> @@ -739,11 +740,7 @@ static void acpi_pci_root_remap_iospace(struct resource_entry *entry)
>  	resource_size_t length = resource_size(res);
>  	unsigned long port;
>  
> -	if (pci_register_io_range(cpu_addr, length))
> -		goto err;
> -
> -	port = pci_address_to_pio(cpu_addr);
> -	if (port == (unsigned long)-1)
> +	if (pci_register_io_range(node, cpu_addr, length, &port))
>  		goto err;
>  
>  	res->start = port;
> @@ -781,7 +778,8 @@ int acpi_pci_probe_root_resources(struct acpi_pci_root_info *info)
>  	else {
>  		resource_list_for_each_entry_safe(entry, tmp, list) {
>  			if (entry->res->flags & IORESOURCE_IO)
> -				acpi_pci_root_remap_iospace(entry);
> +				acpi_pci_root_remap_iospace(&device->fwnode,
> +							    entry);
>  
>  			if (entry->res->flags & IORESOURCE_DISABLED)
>  				resource_list_destroy_entry(entry);
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 02b2903..d85d228 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -2,6 +2,7 @@
>  #define pr_fmt(fmt)	"OF: " fmt
>  
>  #include <linux/device.h>
> +#include <linux/fwnode.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> @@ -323,14 +324,9 @@ int of_pci_range_to_resource(struct of_pci_range *range,
>  
>  	if (res->flags & IORESOURCE_IO) {
>  		unsigned long port;
> -		err = pci_register_io_range(range->cpu_addr, range->size);
> +		err = pci_register_io_range(&np->fwnode, range->cpu_addr, range->size, &port);
>  		if (err)
>  			goto invalid_range;
> -		port = pci_address_to_pio(range->cpu_addr);
> -		if (port == (unsigned long)-1) {
> -			err = -EINVAL;
> -			goto invalid_range;
> -		}
>  		res->start = port;
>  	} else {
>  		if ((sizeof(resource_size_t) < 8) &&
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a881c0d..5289221 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3241,6 +3241,7 @@ int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
>  #ifdef PCI_IOBASE
>  struct io_range {
>  	struct list_head list;
> +	struct fwnode_handle *node;
>  	phys_addr_t start;
>  	resource_size_t size;
>  };
> @@ -3253,7 +3254,8 @@ struct io_range {
>   * Record the PCI IO range (expressed as CPU physical address + size).
>   * Return a negative value if an error has occured, zero otherwise
>   */
> -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +int __weak pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
> +				 resource_size_t size, unsigned long *port)
>  {
>  	int err = 0;
>  
> @@ -3261,10 +3263,31 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>  	struct io_range *range;
>  	resource_size_t allocated_size = 0;
>  
> +	/*
> +	 * As indirect-IO which support multiple bus instances is introduced,
> +	 * the input 'addr' is probably not page-aligned. If the PCI I/O
> +	 * ranges are registered after indirect-IO, there is risk that the
> +	 * start logical PIO assigned to PCI I/O is not page-aligned.
> +	 * This will cause some I/O subranges are not remapped or overlapped
> +	 * in pci_remap_iospace() handling.
> +	 */
> +	WARN_ON(addr != IO_RANGE_IOEXT && !(addr & PAGE_MASK));
> +	/*
> +	 * MMIO will call ioremap, it is better to align size with PAGE_SIZE,
> +	 * then the return linux virtual PIO is page-aligned.
> +	 */
> +	if (size & PAGE_MASK)
> +		size = PAGE_ALIGN(size);
> +
>  	/* check if the range hasn't been previously recorded */
>  	spin_lock(&io_range_lock);
>  	list_for_each_entry(range, &io_range_list, list) {
> -		if (addr >= range->start && addr + size <= range->start + size) {
> +		if (node == range->node)
> +			goto end_register;
> +
> +		if (addr != IO_RANGE_IOEXT &&
> +		    addr >= range->start &&
> +		    addr + size <= range->start + size) {
>  			/* range already registered, bail out */
>  			goto end_register;
>  		}
> @@ -3290,6 +3313,7 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>  		goto end_register;
>  	}
>  
> +	range->node = node;
>  	range->start = addr;
>  	range->size = size;
>  
> @@ -3297,6 +3321,14 @@ int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
>  
>  end_register:
>  	spin_unlock(&io_range_lock);
> +
> +	*port = allocated_size;
> +#else
> +	/*
> +	 * powerpc and microblaze have their own registration,
> +	 * just look up the value here
> +	 */
> +	*port = pci_address_to_pio(addr);
>  #endif
>  
>  	return err;
> @@ -3315,7 +3347,9 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>  
>  	spin_lock(&io_range_lock);
>  	list_for_each_entry(range, &io_range_list, list) {
> -		if (pio >= allocated_size && pio < allocated_size + range->size) {
> +		if (range->start != IO_RANGE_IOEXT &&
> +			pio >= allocated_size &&
> +			pio < allocated_size + range->size) {
>  			address = range->start + pio - allocated_size;
>  			break;
>  		}
> @@ -3336,7 +3370,9 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  
>  	spin_lock(&io_range_lock);
>  	list_for_each_entry(res, &io_range_list, list) {
> -		if (address >= res->start && address < res->start + res->size) {
> +		if (res->start != IO_RANGE_IOEXT &&
> +			address >= res->start &&
> +			address < res->start + res->size) {
>  			addr = address - res->start + offset;
>  			break;
>  		}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a12..8d91af8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -34,6 +34,9 @@
>  
>  #include <linux/pci_ids.h>
>  
> +/* the macro below flags an invalid cpu address
> + * and is used by IO special hosts              */
> +#define IO_RANGE_IOEXT (resource_size_t)(-1ull)
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> @@ -1197,8 +1200,8 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
>  						  resource_size_t),
>  			void *alignf_data);
>  
> -
> -int pci_register_io_range(phys_addr_t addr, resource_size_t size);
> +int pci_register_io_range(struct fwnode_handle *node, phys_addr_t addr,
> +			  resource_size_t size, unsigned long *port);
>  unsigned long pci_address_to_pio(phys_addr_t addr);
>  phys_addr_t pci_pio_to_address(unsigned long pio);
>  int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
