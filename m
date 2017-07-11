Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59030 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752577AbdGKSvl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jul 2017 14:51:41 -0400
Date: Tue, 11 Jul 2017 20:51:37 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pci@vger.kernel.org
Cc: yamada.masahiro@socionext.com, mmarek@suse.com,
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
        linux-kernel@vger.kernel.org, patches@groups.riscv.org,
        akpm@linux-foundation.org, albert@sifive.com
Subject: Re: [PATCH 03/17] pci: Add a generic, weakly-linked pcibios_fixup_bus
Message-ID: <20170711185137.GE21846@wotan.suse.de>
References: <20170711013924.22085-1-palmer@dabbelt.com>
 <20170711013924.22085-4-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170711013924.22085-4-palmer@dabbelt.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 06:39:10PM -0700, Palmer Dabbelt wrote:
> Multiple architectures define this as an empty function, and I'm adding
> another one as part of the RISC-V port.  This adds a __weak version of
> pci_fixup_bios and deletes the now obselete ones in a handful of ports.
> 
> The only functional change should be that microblaze used to export
> pcibios_fixup_bus.  None of the other architectures export this, so I
> just dropped it.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>

Reviewed-by: Luis R. Rodriguez <mcgrof@kernel.org>

But this should also get review by Bjorn and linux-pci, now Cc'd. Finally a series of
build tests across all architectures would be good too, but for that I'll ask for
Guenter's help once you have your respective branch up.

 Luis

> ---
>  arch/cris/arch-v32/drivers/pci/bios.c |  4 ----
>  arch/microblaze/pci/pci-common.c      |  6 ------
>  arch/s390/pci/pci.c                   |  4 ----
>  arch/sh/drivers/pci/pci.c             |  8 --------
>  arch/tile/kernel/pci.c                |  8 --------
>  arch/tile/kernel/pci_gx.c             |  5 -----
>  drivers/pci/probe.c                   | 10 ++++++++++
>  7 files changed, 10 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index 394c2a73d5e2..5cc622c0225e 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -2,10 +2,6 @@
>  #include <linux/kernel.h>
>  #include <hwregs/intr_vect.h>
>  
> -void pcibios_fixup_bus(struct pci_bus *b)
> -{
> -}
> -
>  void pcibios_set_master(struct pci_dev *dev)
>  {
>  	u8 lat;
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 7a332e9f1de0..5835c09c6e26 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -810,12 +810,6 @@ void pcibios_setup_bus_devices(struct pci_bus *bus)
>  	}
>  }
>  
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -	/* nothing to do */
> -}
> -EXPORT_SYMBOL(pcibios_fixup_bus);
> -
>  /*
>   * We need to avoid collisions with `mirrored' VGA ports
>   * and other strange ISA hardware, so we always want the
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 7b30af5da222..ddb9923fb45d 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -262,10 +262,6 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
>  	return rc;
>  }
>  
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -}
> -
>  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index c99ee286b69f..749642e1272e 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -155,14 +155,6 @@ static int __init pcibios_init(void)
>  subsys_initcall(pcibios_init);
>  
>  /*
> - *  Called after each bus is probed, but before its children
> - *  are examined.
> - */
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -}
> -
> -/*
>   * We need to avoid collisions with `mirrored' VGA ports
>   * and other strange ISA hardware, so we always want the
>   * addresses to be allocated in the 0x000-0x0ff region
> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
> index 284ed23b3914..8999a20ed9d1 100644
> --- a/arch/tile/kernel/pci.c
> +++ b/arch/tile/kernel/pci.c
> @@ -359,14 +359,6 @@ int __init pcibios_init(void)
>  }
>  subsys_initcall(pcibios_init);
>  
> -/*
> - * No bus fixups needed.
> - */
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -	/* Nothing needs to be done. */
> -}
> -
>  void pcibios_set_master(struct pci_dev *dev)
>  {
>  	/* No special bus mastering setup handling. */
> diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
> index bdc623b91f7a..0a7642184a9a 100644
> --- a/arch/tile/kernel/pci_gx.c
> +++ b/arch/tile/kernel/pci_gx.c
> @@ -1029,11 +1029,6 @@ int __init pcibios_init(void)
>  }
>  subsys_initcall(pcibios_init);
>  
> -/* No bus fixups needed. */
> -void pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -}
> -
>  /* Process any "pci=" kernel boot arguments. */
>  char *__init pcibios_setup(char *str)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c31310db0404..2ef1248bf112 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2288,6 +2288,16 @@ void pcie_bus_configure_settings(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL_GPL(pcie_bus_configure_settings);
>  
> +/*
> + * Called after each bus is probed, but before its children are examined.  This
> + * is marked as __weak because multiple architectures define it
> + */
> +__attribute__ ((weak))
> +void pcibios_fixup_bus(struct pci_bus *bus)
> +{
> +       /* nothing to do, expected to be removed in the future */
> +}
> +
>  unsigned int pci_scan_child_bus(struct pci_bus *bus)
>  {
>  	unsigned int devfn, pass, max = bus->busn_res.start;
> -- 
> 2.13.0
> 
> 
