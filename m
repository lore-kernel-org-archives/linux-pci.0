Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 6 Jun 2018 17:01:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        guohanjun@huawei.com, jcm@redhat.com, toshi.kani@hpe.com,
        tanxiaojun@huawei.com, wangzhou1@hisilicon.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI ACPI: Avoid panic when PCI IO resource's size is
 not page aligned
Message-ID: <20180606220143.GA128611@bhelgaas-glaptop.roam.corp.google.com>
References: <1528250793-57034-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528250793-57034-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 06, 2018 at 10:06:33AM +0800, Yisheng Xie wrote:
> Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:
> 
>  [    2.470908] kernel BUG at lib/ioremap.c:72!
>  [    2.475079] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>  [    2.480551] Modules linked in:
>  [    2.483594] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-00062-g0b41260-dirty #23
>  [    2.491756] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI Nemo 2.0 RC0 - B120 03/23/2018
>  [    2.500614] pstate: 80c00009 (Nzcv daif +PAN +UAO)
>  [    2.505395] pc : ioremap_page_range+0x268/0x36c
>  [    2.509912] lr : pci_remap_iospace+0xe4/0x100
>  [...]
>  [    2.603733] Call trace:
>  [    2.606168]  ioremap_page_range+0x268/0x36c
>  [    2.610337]  pci_remap_iospace+0xe4/0x100
>  [    2.614334]  acpi_pci_probe_root_resources+0x1d4/0x214
>  [    2.619460]  pci_acpi_root_prepare_resources+0x18/0xa8
>  [    2.624585]  acpi_pci_root_create+0x98/0x214
>  [    2.628843]  pci_acpi_scan_root+0x124/0x20c
>  [    2.633013]  acpi_pci_root_add+0x224/0x494
>  [    2.637096]  acpi_bus_attach+0xf8/0x200
>  [    2.640918]  acpi_bus_attach+0x98/0x200
>  [    2.644740]  acpi_bus_attach+0x98/0x200
>  [    2.648562]  acpi_bus_scan+0x48/0x9c
>  [    2.652125]  acpi_scan_init+0x104/0x268
>  [    2.655948]  acpi_init+0x308/0x374
>  [    2.659337]  do_one_initcall+0x48/0x14c
>  [    2.663160]  kernel_init_freeable+0x19c/0x250
>  [    2.667504]  kernel_init+0x10/0x100
>  [    2.670979]  ret_from_fork+0x10/0x18
> 
> The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
> not 64KB aligned, however, ioremap_page_range() request the range as page
> aligned or it will trigger a BUG_ON() on ioremap_pte_range() it calls, as
> ioremap_pte_range increase the addr by PAGE_SIZE, which makes addr != end
> until trigger BUG_ON, if its incoming end is not page aligned. More detail
> trace is as following:
> 
>  ioremap_page_range
>  -> ioremap_p4d_range
>     -> ioremap_p4d_range
>        -> ioremap_pud_range
>           -> ioremap_pmd_range
>              -> ioremap_pte_range
> 
> This patch avoid panic by align the vaddr and phys_addr.
> 
> Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
> Tested-by: Xiaojun Tan <tanxiaojun@huawei.com>
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
> v4:
>  - align vaddr and phys_addr  - per Bjorn
> v3:
>  - pci_remap_iospace() sanitize its arguments instead - per Rafael
> v2:
>  - Let the caller of ioremap_page_range() align the request by PAGE_SIZE - per Toshi
> 
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dbfe7c4..652f7d6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3537,6 +3537,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  {
>  #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
>  	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
> +	unsigned long last_vaddr;
>  
>  	if (!(res->flags & IORESOURCE_IO))
>  		return -EINVAL;
> @@ -3544,7 +3545,16 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
>  	if (res->end > IO_SPACE_LIMIT)
>  		return -EINVAL;
>  
> -	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
> +	/* It will be mess if vaddr's offset is not equal to phys_addr's */
> +	if ((vaddr & ~PAGE_MASK) != (phys_addr & ~PAGE_MASK))
> +		return -EINVAL;
> +
> +	/* Mappings have to be page-aligned */
> +	last_vaddr = PAGE_ALIGN(vaddr + resource_size(res));
> +	phys_addr &= PAGE_MASK;
> +	vaddr &= PAGE_MASK;

I think this stuff should be put into ioremap_page_range().  Almost
every caller does this sort of thing before calling
ioremap_page_range(), so you could clean up a fair amount of code if
you added one copy into ioremap_page_range() and removed it from all
the callers.

> +	return ioremap_page_range(vaddr, last_vaddr, phys_addr,
>  				  pgprot_device(PAGE_KERNEL));
>  #else
>  	/* this architecture does not have memory mapped I/O space,
