Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37366 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbcCGQfg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 11:35:36 -0500
Date: Mon, 7 Mar 2016 10:35:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] pci: move pci-bridge.h out of asm-generic
Message-ID: <20160307163529.GA13818@localhost>
References: <1457277475-8913-1-git-send-email-hch@lst.de>
 <1457277475-8913-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457277475-8913-3-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Arnd]

On Sun, Mar 06, 2016 at 04:17:54PM +0100, Christoph Hellwig wrote:
> This isn't an asm-generic header, but something used both by common code
> and architectures.

I did something similar with
http://lkml.kernel.org/r/20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com

The generic things in include/asm-generic/pci-bridge.h weren't really
bridge-related, so I moved them to include/linux/pci.h instead of creating
include/linux/pci-bridge.h.

Then include/asm-generic/pci-bridge.h was empty, so I removed it and the
includes of it.

There were a few arch-specific asm/pci-bridge.h files, but they do contain
arch-specific things, and they're only included by arch code, so I left
them alone.

My changes are in linux-next, and I plan to merge them during the v4.6
merge window.

Bjorn

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/pci.h          |  2 +-
>  arch/arm/include/asm/pci.h            |  2 +-
>  arch/arm64/include/asm/pci.h          |  2 +-
>  arch/mips/include/asm/pci.h           |  2 +-
>  arch/powerpc/include/asm/pci-bridge.h |  2 +-
>  arch/unicore32/include/asm/pci.h      |  2 +-
>  arch/x86/pci/common.c                 |  2 +-
>  drivers/of/of_pci.c                   |  2 +-
>  drivers/pci/pci.c                     |  2 +-
>  drivers/pci/probe.c                   |  2 +-
>  drivers/pci/setup-bus.c               |  2 +-
>  include/asm-generic/pci-bridge.h      | 74 -----------------------------------
>  include/linux/pci-bridge.h            | 74 +++++++++++++++++++++++++++++++++++
>  13 files changed, 85 insertions(+), 85 deletions(-)
>  delete mode 100644 include/asm-generic/pci-bridge.h
>  create mode 100644 include/linux/pci-bridge.h
> 
> diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
> index 98f2eee..a742497 100644
> --- a/arch/alpha/include/asm/pci.h
> +++ b/arch/alpha/include/asm/pci.h
> @@ -7,7 +7,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/scatterlist.h>
>  #include <asm/machvec.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  
>  /*
>   * The following structure is used to manage multiple PCI busses.
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index a563544..f869627 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -3,7 +3,7 @@
>  
>  #ifdef __KERNEL__
>  #include <asm-generic/pci-dma-compat.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  
>  #include <asm/mach/pci.h> /* for pci_sys_data */
>  
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72..a44f008 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -7,7 +7,7 @@
>  #include <linux/dma-mapping.h>
>  
>  #include <asm/io.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include <asm-generic/pci-dma-compat.h>
>  
>  #define PCIBIOS_MIN_IO		0x1000
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 98c31e5..bb94de4 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -102,7 +102,7 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <asm/io.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  
>  struct pci_dev;
>  
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 54843ca..fd0363d 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -10,7 +10,7 @@
>  #include <linux/pci.h>
>  #include <linux/list.h>
>  #include <linux/ioport.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  
>  struct device_node;
>  
> diff --git a/arch/unicore32/include/asm/pci.h b/arch/unicore32/include/asm/pci.h
> index 38b3f37..e36ca77 100644
> --- a/arch/unicore32/include/asm/pci.h
> +++ b/arch/unicore32/include/asm/pci.h
> @@ -14,7 +14,7 @@
>  
>  #ifdef __KERNEL__
>  #include <asm-generic/pci-dma-compat.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include <asm-generic/pci.h>
>  #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
>  
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index d34b511..edd0022 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -12,7 +12,7 @@
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
>  
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include <asm/acpi.h>
>  #include <asm/segment.h>
>  #include <asm/io.h>
> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> index b1449f7..64705ef 100644
> --- a/drivers/of/of_pci.c
> +++ b/drivers/of/of_pci.c
> @@ -5,7 +5,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_pci.h>
>  #include <linux/slab.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  
>  static inline int __of_pci_pci_compare(struct device_node *node,
>  				       unsigned int data)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..5e5a196 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -25,7 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include <asm/setup.h>
>  #include <linux/aer.h>
>  #include "pci.h"
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..af4dad3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -15,7 +15,7 @@
>  #include <linux/pci-aspm.h>
>  #include <linux/aer.h>
>  #include <linux/acpi.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include "pci.h"
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7796d0a..03c047c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -25,7 +25,7 @@
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
>  #include <linux/slab.h>
> -#include <asm-generic/pci-bridge.h>
> +#include <linux/pci-bridge.h>
>  #include "pci.h"
>  
>  unsigned int pci_flags;
> diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
> deleted file mode 100644
> index 20db2e5..0000000
> --- a/include/asm-generic/pci-bridge.h
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -/*
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -#ifndef _ASM_GENERIC_PCI_BRIDGE_H
> -#define _ASM_GENERIC_PCI_BRIDGE_H
> -
> -#ifdef __KERNEL__
> -
> -enum {
> -	/* Force re-assigning all resources (ignore firmware
> -	 * setup completely)
> -	 */
> -	PCI_REASSIGN_ALL_RSRC	= 0x00000001,
> -
> -	/* Re-assign all bus numbers */
> -	PCI_REASSIGN_ALL_BUS	= 0x00000002,
> -
> -	/* Do not try to assign, just use existing setup */
> -	PCI_PROBE_ONLY		= 0x00000004,
> -
> -	/* Don't bother with ISA alignment unless the bridge has
> -	 * ISA forwarding enabled
> -	 */
> -	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
> -
> -	/* Enable domain numbers in /proc */
> -	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
> -	/* ... except for domain 0 */
> -	PCI_COMPAT_DOMAIN_0	= 0x00000020,
> -
> -	/* PCIe downstream ports are bridges that normally lead to only a
> -	 * device 0, but if this is set, we scan all possible devices, not
> -	 * just device 0.
> -	 */
> -	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,
> -};
> -
> -#ifdef CONFIG_PCI
> -extern unsigned int pci_flags;
> -
> -static inline void pci_set_flags(int flags)
> -{
> -	pci_flags = flags;
> -}
> -
> -static inline void pci_add_flags(int flags)
> -{
> -	pci_flags |= flags;
> -}
> -
> -static inline void pci_clear_flags(int flags)
> -{
> -	pci_flags &= ~flags;
> -}
> -
> -static inline int pci_has_flag(int flag)
> -{
> -	return pci_flags & flag;
> -}
> -#else
> -static inline void pci_set_flags(int flags) { }
> -static inline void pci_add_flags(int flags) { }
> -static inline void pci_clear_flags(int flags) { }
> -static inline int pci_has_flag(int flag)
> -{
> -	return 0;
> -}
> -#endif	/* CONFIG_PCI */
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* _ASM_GENERIC_PCI_BRIDGE_H */
> diff --git a/include/linux/pci-bridge.h b/include/linux/pci-bridge.h
> new file mode 100644
> index 0000000..25416e0
> --- /dev/null
> +++ b/include/linux/pci-bridge.h
> @@ -0,0 +1,74 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +#ifndef _LINUX_PCI_BRIDGE_H
> +#define _LINUX_PCI_BRIDGE_H
> +
> +#ifdef __KERNEL__
> +
> +enum {
> +	/* Force re-assigning all resources (ignore firmware
> +	 * setup completely)
> +	 */
> +	PCI_REASSIGN_ALL_RSRC	= 0x00000001,
> +
> +	/* Re-assign all bus numbers */
> +	PCI_REASSIGN_ALL_BUS	= 0x00000002,
> +
> +	/* Do not try to assign, just use existing setup */
> +	PCI_PROBE_ONLY		= 0x00000004,
> +
> +	/* Don't bother with ISA alignment unless the bridge has
> +	 * ISA forwarding enabled
> +	 */
> +	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
> +
> +	/* Enable domain numbers in /proc */
> +	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
> +	/* ... except for domain 0 */
> +	PCI_COMPAT_DOMAIN_0	= 0x00000020,
> +
> +	/* PCIe downstream ports are bridges that normally lead to only a
> +	 * device 0, but if this is set, we scan all possible devices, not
> +	 * just device 0.
> +	 */
> +	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,
> +};
> +
> +#ifdef CONFIG_PCI
> +extern unsigned int pci_flags;
> +
> +static inline void pci_set_flags(int flags)
> +{
> +	pci_flags = flags;
> +}
> +
> +static inline void pci_add_flags(int flags)
> +{
> +	pci_flags |= flags;
> +}
> +
> +static inline void pci_clear_flags(int flags)
> +{
> +	pci_flags &= ~flags;
> +}
> +
> +static inline int pci_has_flag(int flag)
> +{
> +	return pci_flags & flag;
> +}
> +#else
> +static inline void pci_set_flags(int flags) { }
> +static inline void pci_add_flags(int flags) { }
> +static inline void pci_clear_flags(int flags) { }
> +static inline int pci_has_flag(int flag)
> +{
> +	return 0;
> +}
> +#endif	/* CONFIG_PCI */
> +
> +#endif	/* __KERNEL__ */
> +#endif	/* _LINUX_PCI_BRIDGE_H */
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
