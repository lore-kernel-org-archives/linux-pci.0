Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 12 Jul 2017 15:41:37 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        akpm@linux-foundation.org, albert@sifive.com,
        yamada.masahiro@socionext.com, mmarek@suse.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        mingo@redhat.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, davem@davemloft.net,
        mchehab@kernel.org, sfr@canb.auug.org.au, fweisbec@gmail.com,
        viro@zeniv.linux.org.uk, mcgrof@kernel.org, dledford@redhat.com,
        bart.vanassche@sandisk.com, sstabellini@kernel.org,
        daniel.vetter@ffwll.ch, mpe@ellerman.id.au, msalter@redhat.com,
        nicolas.dichtel@6wind.com, james.hogan@imgtec.com,
        paul.gortmaker@windriver.com, linux@roeck-us.net,
        heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org, patches@groups.riscv.org
Subject: Re: [PATCH 02/17] pci: Add a generic, weakly-linked
 pcibios_align_resource
Message-ID: <20170712134137.GT21846@wotan.suse.de>
References: <20170712013130.14792-1-palmer@dabbelt.com>
 <20170712013130.14792-3-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170712013130.14792-3-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 11, 2017 at 06:31:15PM -0700, Palmer Dabbelt wrote:
> Multiple architectures define this as trivial function, and I'm adding
> another one as part of the RISC-V port.  This adds a __weak version of
> pcibios_align_resource and deletes the now obselete ones in a handful of
> ports.
> 
> The only functional change should be that a handful of ports used to
> export pcibios_fixup_bus.  Only some architectures export this, so I
> just dropped it.

And for architectures that do use the routine in drivers they provide
the export. This is the case for x86 and the intel i915 driver.

> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

As I noted with the other PCI patch, these should have addressed
Bjorn Helgaas <bhelgaas@google.com> and linux-pci@vger.kernel.org.
You seem to have forgotten to do that this time again.

Provided you address the minor issues below here's a:

Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

Also, FWIW the 2 PCI patches you have are independent and could
be split off and merged, but it obviously would make sense to
keep them in a series if this is going in for this merge window.
If your tree is not being merged in this merge window then at least
you could try to get these 2 patches merged into Bjorn or Andrew's
tree if its not too late.

This patch however still needs refactoring, and since you will also
touch the next PCI patch that as well. Notes below.

> ---
>  arch/arc/kernel/pcibios.c        | 13 -------------
>  arch/arm64/kernel/pci.c          | 17 -----------------
>  arch/ia64/pci/pci.c              |  7 -------
>  arch/microblaze/pci/pci-common.c |  7 -------
>  arch/sparc/kernel/leon_pci.c     |  6 ------
>  arch/sparc/kernel/pci.c          | 10 ----------
>  arch/sparc/kernel/pcic.c         |  6 ------
>  arch/tile/kernel/pci.c           | 10 ----------
>  arch/tile/kernel/pci_gx.c        |  9 ---------
>  drivers/pci/setup-res.c          | 12 ++++++++++++
>  10 files changed, 12 insertions(+), 85 deletions(-)
> 
> diff --git a/arch/arc/kernel/pcibios.c b/arch/arc/kernel/pcibios.c
> index 72e1d73d0bd6..05aba5a7b5d2 100644
> --- a/arch/arc/kernel/pcibios.c
> +++ b/arch/arc/kernel/pcibios.c
> @@ -7,16 +7,3 @@
>   */
>  
>  #include <linux/pci.h>
> -
> -/*
> - * We don't have to worry about legacy ISA devices, so nothing to do here
> - */
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -}

You've mixed removing pcibios_fixup_bus() in this patch whereas you have another
patch which does this removal for you after this. Please split these removals out
into that patch.

> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index e2b7e4f9cc31..0e2ea1c78542 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -22,23 +22,6 @@
>  #include <linux/pci-ecam.h>
>  #include <linux/slab.h>
>  
> -/*
> - * Called after each bus is probed, but before its children are examined
> - */
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -	/* nothing to do, expected to be removed in the future */
> -}
> -
> -/*
> - * We don't have to worry about legacy ISA devices, so nothing to do here
> - */

Here is another one.

> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -
>  #ifdef CONFIG_ACPI
>  /*
>   * Try to assign the IRQ number when probing a new device
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index 4068bde623dc..f5ec736100ee 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -411,13 +411,6 @@ pcibios_disable_device (struct pci_dev *dev)
>  		acpi_pci_irq_disable(dev);
>  }
>  
> -resource_size_t
> -pcibios_align_resource (void *data, const struct resource *res,
> -		        resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -
>  /**
>   * ia64_pci_get_legacy_mem - generic legacy mem routine
>   * @bus: bus to get legacy memory base address for
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 404fb38d06b7..7a332e9f1de0 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -829,13 +829,6 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
>   * but we want to try to avoid allocating at 0x2900-0x2bff
>   * which might have be mirrored at 0x0100-0x03ff..
>   */
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -EXPORT_SYMBOL(pcibios_align_resource);
> -
>  int pcibios_add_device(struct pci_dev *dev)
>  {
>  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
> diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
> index 4371f72ff025..0eafdf3d036d 100644
> --- a/arch/sparc/kernel/leon_pci.c
> +++ b/arch/sparc/kernel/leon_pci.c
> @@ -94,9 +94,3 @@ void pcibios_fixup_bus(struct pci_bus *pbus)
>  		}
>  	}
>  }
> -
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 7eceaa10836f..3f8670c92951 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -690,16 +690,6 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
>  	return bus;
>  }
>  
> -void pcibios_fixup_bus(struct pci_bus *pbus)
> -{
> -}
> -

And another one.

  Luis

> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -
>  int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
>  	u16 cmd, oldcmd;
> diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> index a38787b84322..e038e343f2c1 100644
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c
> @@ -746,12 +746,6 @@ static void watchdog_reset() {
>  }
>  #endif
>  
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -
>  int pcibios_enable_device(struct pci_dev *pdev, int mask)
>  {
>  	return 0;
> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
> index bc6656b5708b..284ed23b3914 100644
> --- a/arch/tile/kernel/pci.c
> +++ b/arch/tile/kernel/pci.c
> @@ -67,16 +67,6 @@ static struct pci_ops tile_cfg_ops;
>  
>  
>  /*
> - * We don't need to worry about the alignment of resources.
> - */
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -			    resource_size_t size, resource_size_t align)
> -{
> -	return res->start;
> -}
> -EXPORT_SYMBOL(pcibios_align_resource);
> -
> -/*
>   * Open a FD to the hypervisor PCI device.
>   *
>   * controller_id is the controller number, config type is 0 or 1 for
> diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
> index b554a68eea1b..bdc623b91f7a 100644
> --- a/arch/tile/kernel/pci_gx.c
> +++ b/arch/tile/kernel/pci_gx.c
> @@ -108,15 +108,6 @@ static struct pci_ops tile_cfg_ops;
>  /* Mask of CPUs that should receive PCIe interrupts. */
>  static struct cpumask intr_cpus_map;
>  
> -/* We don't need to worry about the alignment of resources. */
> -resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> -				       resource_size_t size,
> -				       resource_size_t align)
> -{
> -	return res->start;
> -}
> -EXPORT_SYMBOL(pcibios_align_resource);
> -
>  /*
>   * Pick a CPU to receive and handle the PCIe interrupts, based on the IRQ #.
>   * For now, we simply send interrupts to non-dataplane CPUs.
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 85774b7a316a..597ed1f8b15c 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -234,6 +234,18 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
>  	return 0;
>  }
>  
> +/*
> + * We don't have to worry about legacy ISA devices, so nothing to do here.
> + * This is marked as __weak because multiple architectures define it, it should
> + * eventually go away.
> + */
> +__attribute__ ((weak))
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +                                      resource_size_t size, resource_size_t align)
> +{
> +       return res->start;
> +}
> +
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
> -- 
> 2.13.0
> 
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
