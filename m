Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 26 May 2017 15:57:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v9 1/7] LIB: Introduce a generic PIO mapping method
Message-ID: <20170526205744.GA21531@bhelgaas-glaptop.roam.corp.google.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-2-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1495712248-5232-2-git-send-email-gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, minyard@acm.org,
 arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org,
 catalin.marinas@arm.com, john.garry@huawei.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linuxarm@huawei.com,
 linux-acpi@vger.kernel.org, robh+dt@kernel.org,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>, benh@kernel.crashing.org,
 bhelgaas@google.com, frowand.list@gmail.com, brian.starkey@arm.com,
 linux-arm-kernel@lists.infradead.org, olof@lixom.net
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 25, 2017 at 12:37:22PM +0100, Gabriele Paoloni wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> In 'commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> pci_pio_to_address()")' a new I/O space management was supported. With that
> driver, the I/O ranges configured for PCI/PCIE hosts on some architectures
> can be mapped to logical PIO, converted easily between CPU address and the
> corresponding logicial PIO. Based on this, PCI I/O devices can be accessed
> in a memory read/write way through the unified in/out accessors.
> 
> But on some archs/platforms, there are bus hosts which access I/O
> peripherals with host-local I/O port addresses rather than memory
> addresses after memory-mapped.
> To support those devices, a more generic I/O mapping method is introduced
> here. Through this patch, both the CPU addresses and the host-local port
> can be mapped into the logical PIO space with different logical/fake PIOs.
> After this, all the I/O accesses to either PCI MMIO devices or host-local
> I/O peripherals can be unified into the existing I/O accessors defined in
> asm-generic/io.h and be redirected to the right device-specific hooks
> based on the input logical PIO.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> ---
>  include/asm-generic/io.h  |  50 +++++++++
>  include/linux/logic_pio.h | 110 ++++++++++++++++++
>  lib/Kconfig               |  26 +++++
>  lib/Makefile              |   2 +
>  lib/logic_pio.c           | 280 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 468 insertions(+)
>  create mode 100644 include/linux/logic_pio.h
>  create mode 100644 lib/logic_pio.c
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ef015e..f7fbec3 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> ...  

>  #ifndef inb
> +#ifdef CONFIG_INDIRECT_PIO
> +#define inb logic_inb
> +#else
>  #define inb inb
>  static inline u8 inb(unsigned long addr)
>  {
>  	return readb(PCI_IOBASE + addr);
>  }
> +#endif /* CONFIG_INDIRECT_PIO */
>  #endif
>  
>  #ifndef inw
> +#ifdef CONFIG_INDIRECT_PIO
> +#define inw logic_inw

Cosmetic: could these ifdefs all be collected in one place, e.g.,

  #ifdef CONFIG_INDIRECT_PIO
  #define inb logic_inb
  #define inw logic_inw
  #define inl logic_inl
  ...
  #endif

to avoid cluttering every one of the default definitions?  Could the
collection be in logic_pio.h itself, next to the extern declarations?

> +#else
>  #define inw inw
>  static inline u16 inw(unsigned long addr)
>  {
>  	return readw(PCI_IOBASE + addr);
>  }
> +#endif /* CONFIG_INDIRECT_PIO */
>  #endif

>  #ifndef insb_p
> diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
> new file mode 100644
> index 0000000..8e4dc65
> --- /dev/null
> +++ b/include/linux/logic_pio.h
> ...

> +extern u8 logic_inb(unsigned long addr);

I think you only build the definitions for these if
CONFIG_INDIRECT_PIO, so the declarations could be under that #idef,
too.

In PCI code, I omit the "extern" from function declarations.  This
isn't PCI code, and I don't know if there's a real consensus on this,
but there is some precedent: 5bd085b5fbd8 ("x86: remove "extern" from
function prototypes in <asm/proto.h>")

> +#ifdef CONFIG_LOGIC_PIO
> +extern struct logic_pio_hwaddr
> +*find_io_range_by_fwnode(struct fwnode_handle *fwnode);

If you have to split the line (this one would fit without the
"extern"), the "*" goes with the type, e.g.,

  struct logic_pio_hwaddr *
  find_io_range_by_fwnode(struct fwnode_handle *fwnode);

More occurrences below.

> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> new file mode 100644
> index 0000000..4a960cd
> --- /dev/null
> +++ b/lib/logic_pio.c
> ...

> +#if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
> +#define BUILD_LOGIC_PIO(bw, type)\
> +type logic_in##bw(unsigned long addr)\
> +{\
> +	type ret = -1;\
> +\
> +	if (addr < MMIO_UPPER_LIMIT) {\
> +		ret = read##bw(PCI_IOBASE + addr);\
> +	} else {\
> +		struct logic_pio_hwaddr *entry = find_io_range(addr);\
> +\
> +		if (entry && entry->ops)\
> +			ret = entry->ops->pfin(entry->devpara,\
> +					addr, sizeof(type));\
> +		else\
> +			WARN_ON_ONCE(1);\
> +	}	\
> +	return ret;\
> +}	\

I think these would be slightly easier to read if the line continuation
backslashes were aligned at the right, as with
ACPI_DECLARE_PROBE_ENTRY(), __atomic_op_acquire(), DECLARE_EWMA(),
etc.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
