Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Mar 2017 20:41:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 02/22] asm-generic/io.h: add ioremap_nopost remap
 interface
Message-ID: <20170328014110.GI25380@bhelgaas-glaptop.roam.corp.google.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
 <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170327094954.7162-3-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Tony Luck <tony.luck@intel.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 27, 2017 at 10:49:30AM +0100, Lorenzo Pieralisi wrote:
> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> Posting") mandate non-posted configuration transactions. As further
> highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
> Considerations for the Enhanced Configuration Access Mechanism"),
> through ECAM and ECAM-derivative configuration mechanism, the memory
> mapped transactions from the host CPU into Configuration Requests on the
> PCI express fabric may create ordering problems for software because
> writes to memory address are typically posted transactions (unless the
> architecture can enforce through virtual address mapping non-posted
> write transactions behaviour) but writes to Configuration Space are not
> posted on the PCI express fabric.
> 
> Current DT and ACPI host bridge controllers map PCI configuration space
> (ECAM and ECAM-derivative) into the virtual address space through
> ioremap() calls, that are non-cacheable device accesses on most
> architectures, but may provide "bufferable" or "posted" write semantics
> in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
> to be buffered in the bus connecting the host CPU to the PCI fabric;
> this behaviour, as underlined in the PCIe specifications, may trigger
> transactions ordering rules and must be prevented.
> 
> Introduce a new generic and explicit API to create a memory
> mapping for ECAM and ECAM-derivative config space area that
> defaults to ioremap_nocache() (which should provide a sane default
> behaviour) but still allowing architectures on which ioremap_nocache()
> results in posted write transactions to override the function
> call with an arch specific implementation that complies with
> the PCI specifications for configuration transactions.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> ---
>  arch/alpha/include/asm/io.h | 1 +
>  arch/avr32/include/asm/io.h | 1 +
>  arch/frv/include/asm/io.h   | 1 +
>  arch/ia64/include/asm/io.h  | 1 +
>  arch/x86/include/asm/io.h   | 1 +
>  include/asm-generic/io.h    | 4 ++++
>  6 files changed, 9 insertions(+)
> 
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index ff40491..27379ea 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -300,6 +300,7 @@ static inline void __iomem * ioremap_nocache(unsigned long offset,
>  }
>  
>  #define ioremap_uc ioremap_nocache
> +#define ioremap_nopost ioremap_nocache
>  
>  static inline void iounmap(volatile void __iomem *addr)
>  {
> diff --git a/arch/avr32/include/asm/io.h b/arch/avr32/include/asm/io.h
> index f855646..3f1ced8 100644
> --- a/arch/avr32/include/asm/io.h
> +++ b/arch/avr32/include/asm/io.h
> @@ -298,6 +298,7 @@ extern void __iounmap(void __iomem *addr);
>  #define ioremap_wc ioremap_nocache
>  #define ioremap_wt ioremap_nocache
>  #define ioremap_uc ioremap_nocache
> +#define ioremap_nopost ioremap_nocache
>  
>  #define cached(addr) P1SEGADDR(addr)
>  #define uncached(addr) P2SEGADDR(addr)
> diff --git a/arch/frv/include/asm/io.h b/arch/frv/include/asm/io.h
> index 8062fc7..302fb8c 100644
> --- a/arch/frv/include/asm/io.h
> +++ b/arch/frv/include/asm/io.h
> @@ -290,6 +290,7 @@ static inline void __iomem *ioremap_fullcache(unsigned long physaddr, unsigned l
>  
>  #define ioremap_wc ioremap_nocache
>  #define ioremap_uc ioremap_nocache
> +#define ioremap_nopost ioremap_nocache
>  
>  extern void iounmap(void volatile __iomem *addr);
>  
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index 5de673a..70a4985 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
> @@ -434,6 +434,7 @@ static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned lo
>  }
>  #define ioremap_cache ioremap_cache
>  #define ioremap_uc ioremap_nocache
> +#define ioremap_nopost ioremap_nocache
>  
>  
>  /*
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 7afb0e2..50b292f 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -171,6 +171,7 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
>  extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size);
>  extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
>  #define ioremap_uc ioremap_uc
> +#define ioremap_nopost ioremap_nocache

These are all the same as the default from asm-generic.h.  Do we really
need these definitions in alpha, avr32, frv, ia64, x86?

>  extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
>  extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size, unsigned long prot_val);
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ef015e..0e81938 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -915,6 +915,10 @@ extern void ioport_unmap(void __iomem *p);
>  #endif /* CONFIG_GENERIC_IOMAP */
>  #endif /* CONFIG_HAS_IOPORT_MAP */
>  
> +#ifndef ioremap_nopost
> +#define ioremap_nopost ioremap_nocache
> +#endif
> +
>  #ifndef xlate_dev_kmem_ptr
>  #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
>  static inline void *xlate_dev_kmem_ptr(void *addr)
> -- 
> 2.10.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
