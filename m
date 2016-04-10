Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54245 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbcDJWWt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Apr 2016 18:22:49 -0400
Date: Sun, 10 Apr 2016 17:22:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: linux-pci@vger.kernel.org, mj@ucw.cz, bhelgaas@google.com,
	alex.williamson@redhat.com, david.daney@cavium.com
Subject: Re: [PATCH v4 2/2] Add support for enhanced allocation regions
Message-ID: <20160410222244.GD5852@localhost>
References: <1455238345-5602-1-git-send-email-sean.stalley@intel.com>
 <1455238345-5602-3-git-send-email-sean.stalley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455238345-5602-3-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

On Thu, Feb 11, 2016 at 04:52:25PM -0800, Sean O. Stalley wrote:
> Append [enhanced] to Regions that contain the BEI flag in sysfs.
> To do this, we need to add the resource flags to the pci_dev struct.
> This struct is passed through the libpci API, so we increment the API version number.
> 
> Don't tuncate least significant bits of the region size.

s/tuncate/truncate/

> ex: a 2000 byte region should display [size=2000] instead of [size=1K]

What do you think of this?  I don't object to the kernel PCI part of
it, but I don't want to apply it unless you plan to make lspci make
use of it.

Bjorn

> Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
> ---
>  lib/access.c   | 18 ++++++++++--------
>  lib/caps.c     |  2 +-
>  lib/filter.c   |  2 +-
>  lib/header.h   |  4 ++++
>  lib/libpci.ver |  5 +++++
>  lib/pci.h      |  3 +++
>  lib/sysfs.c    |  7 +++++--
>  lspci.c        | 12 +++++++++---
>  8 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/access.c b/lib/access.c
> index 5994008..17b8bed 100644
> --- a/lib/access.c
> +++ b/lib/access.c
> @@ -155,7 +155,7 @@ pci_write_block(struct pci_dev *d, int pos, byte *buf, int len)
>  }
>  
>  int
> -pci_fill_info_v34(struct pci_dev *d, int flags)
> +pci_fill_info_v35(struct pci_dev *d, int flags)
>  {
>    if (flags & PCI_FILL_RESCAN)
>      {
> @@ -169,17 +169,19 @@ pci_fill_info_v34(struct pci_dev *d, int flags)
>  }
>  
>  /* In version 3.1, pci_fill_info got new flags => versioned alias */
> -/* In versions 3.2, 3.3 and 3.4, the same has happened */
> -STATIC_ALIAS(int pci_fill_info(struct pci_dev *d, int flags), pci_fill_info_v34(d, flags));
> -DEFINE_ALIAS(int pci_fill_info_v30(struct pci_dev *d, int flags), pci_fill_info_v34);
> -DEFINE_ALIAS(int pci_fill_info_v31(struct pci_dev *d, int flags), pci_fill_info_v34);
> -DEFINE_ALIAS(int pci_fill_info_v32(struct pci_dev *d, int flags), pci_fill_info_v34);
> -DEFINE_ALIAS(int pci_fill_info_v33(struct pci_dev *d, int flags), pci_fill_info_v34);
> +/* In versions 3.2, 3.3, 3.4 and 3.5, the same has happened */
> +STATIC_ALIAS(int pci_fill_info(struct pci_dev *d, int flags), pci_fill_info_v35(d, flags));
> +DEFINE_ALIAS(int pci_fill_info_v30(struct pci_dev *d, int flags), pci_fill_info_v35);
> +DEFINE_ALIAS(int pci_fill_info_v31(struct pci_dev *d, int flags), pci_fill_info_v35);
> +DEFINE_ALIAS(int pci_fill_info_v32(struct pci_dev *d, int flags), pci_fill_info_v35);
> +DEFINE_ALIAS(int pci_fill_info_v33(struct pci_dev *d, int flags), pci_fill_info_v35);
> +DEFINE_ALIAS(int pci_fill_info_v34(struct pci_dev *d, int flags), pci_fill_info_v35);
>  SYMBOL_VERSION(pci_fill_info_v30, pci_fill_info@LIBPCI_3.0);
>  SYMBOL_VERSION(pci_fill_info_v31, pci_fill_info@LIBPCI_3.1);
>  SYMBOL_VERSION(pci_fill_info_v32, pci_fill_info@LIBPCI_3.2);
>  SYMBOL_VERSION(pci_fill_info_v33, pci_fill_info@LIBPCI_3.3);
> -SYMBOL_VERSION(pci_fill_info_v34, pci_fill_info@@LIBPCI_3.4);
> +SYMBOL_VERSION(pci_fill_info_v34, pci_fill_info@LIBPCI_3.4);
> +SYMBOL_VERSION(pci_fill_info_v35, pci_fill_info@@LIBPCI_3.5);
>  
>  void
>  pci_setup_cache(struct pci_dev *d, byte *cache, int len)
> diff --git a/lib/caps.c b/lib/caps.c
> index a812fb9..9a2e0a5 100644
> --- a/lib/caps.c
> +++ b/lib/caps.c
> @@ -106,7 +106,7 @@ pci_find_cap(struct pci_dev *d, unsigned int id, unsigned int type)
>  {
>    struct pci_cap *c;
>  
> -  pci_fill_info_v34(d, ((type == PCI_CAP_NORMAL) ? PCI_FILL_CAPS : PCI_FILL_EXT_CAPS));
> +  pci_fill_info_v35(d, ((type == PCI_CAP_NORMAL) ? PCI_FILL_CAPS : PCI_FILL_EXT_CAPS));
>    for (c=d->first_cap; c; c=c->next)
>      if (c->type == type && c->id == id)
>        return c;
> diff --git a/lib/filter.c b/lib/filter.c
> index d4254a0..ab1476f 100644
> --- a/lib/filter.c
> +++ b/lib/filter.c
> @@ -129,7 +129,7 @@ pci_filter_match_v33(struct pci_filter *f, struct pci_dev *d)
>      return 0;
>    if (f->device >= 0 || f->vendor >= 0)
>      {
> -      pci_fill_info_v34(d, PCI_FILL_IDENT);
> +      pci_fill_info_v35(d, PCI_FILL_IDENT);
>        if ((f->device >= 0 && f->device != d->device_id) ||
>  	  (f->vendor >= 0 && f->vendor != d->vendor_id))
>  	return 0;
> diff --git a/lib/header.h b/lib/header.h
> index b8f7dc1..7b9a803 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -1235,3 +1235,7 @@
>  
>  #define PCI_VENDOR_ID_INTEL		0x8086
>  #define PCI_VENDOR_ID_COMPAQ		0x0e11
> +
> +/* taken from <include/linux/ioport.h> */
> +
> +#define IORESOURCE_PCI_EA_BEI          (1<<5)
> diff --git a/lib/libpci.ver b/lib/libpci.ver
> index 7ac8d34..83f3c50 100644
> --- a/lib/libpci.ver
> +++ b/lib/libpci.ver
> @@ -66,3 +66,8 @@ LIBPCI_3.4 {
>  	global:
>  		pci_fill_info;
>  };
> +
> +LIBPCI_3.5 {
> +	global:
> +		pci_fill_info;
> +};
> diff --git a/lib/pci.h b/lib/pci.h
> index 9c1e281..a86bfd7 100644
> --- a/lib/pci.h
> +++ b/lib/pci.h
> @@ -136,6 +136,8 @@ struct pci_dev {
>    char *module_alias;			/* Linux kernel module alias */
>    char *label;				/* Device name as exported by BIOS */
>    int numa_node;			/* NUMA node */
> +  pciaddr_t flags[6];			/* Region IORESOURCE flags */
> +  pciaddr_t rom_flags;			/* Expansion ROM IORESOURCE flags */
>  
>    /* Fields used internally: */
>    struct pci_access *access;
> @@ -174,6 +176,7 @@ int pci_fill_info(struct pci_dev *, int flags) PCI_ABI; /* Fill in device inform
>  #define PCI_FILL_MODULE_ALIAS	0x0200
>  #define PCI_FILL_LABEL		0x0400
>  #define PCI_FILL_NUMA_NODE	0x0800
> +#define PCI_FILL_IO_FLAGS	0x1000
>  #define PCI_FILL_RESCAN		0x00010000
>  
>  void pci_setup_cache(struct pci_dev *, u8 *cache, int len) PCI_ABI;
> diff --git a/lib/sysfs.c b/lib/sysfs.c
> index 986ecc9..65f58bf 100644
> --- a/lib/sysfs.c
> +++ b/lib/sysfs.c
> @@ -153,14 +153,17 @@ sysfs_get_resources(struct pci_dev *d)
>  	size = end - start + 1;
>        else
>  	size = 0;
> -      flags &= PCI_ADDR_FLAG_MASK;
>        if (i < 6)
>  	{
> +	  d->flags[i] = flags;
> +	  flags &= PCI_ADDR_FLAG_MASK;
>  	  d->base_addr[i] = start | flags;
>  	  d->size[i] = size;
>  	}
>        else
>  	{
> +	  d->rom_flags = flags;
> +	  flags &= PCI_ADDR_FLAG_MASK;
>  	  d->rom_base_addr = start | flags;
>  	  d->rom_size = size;
>  	}
> @@ -208,7 +211,7 @@ static void sysfs_scan(struct pci_access *a)
>  	  d->vendor_id = sysfs_get_value(d, "vendor", 1);
>  	  d->device_id = sysfs_get_value(d, "device", 1);
>  	  d->device_class = sysfs_get_value(d, "class", 1) >> 8;
> -	  d->known_fields = PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES;
> +	  d->known_fields = PCI_FILL_IDENT | PCI_FILL_CLASS | PCI_FILL_IRQ | PCI_FILL_BASES | PCI_FILL_ROM_BASE | PCI_FILL_SIZES | PCI_FILL_IO_FLAGS;
>  	}
>        pci_link_dev(a, d);
>      }
> diff --git a/lspci.c b/lspci.c
> index fe7b7fe..52d14f3 100644
> --- a/lspci.c
> +++ b/lspci.c
> @@ -336,7 +336,7 @@ show_size(pciaddr_t x)
>    if (!x)
>      return;
>    for (i = 0; i < (sizeof(suffix) / sizeof(*suffix) - 1); i++) {
> -    if (x < 1024)
> +    if (x % 1024)
>        break;
>      x /= 1024;
>    }
> @@ -355,6 +355,7 @@ show_bases(struct device *d, int cnt)
>      {
>        pciaddr_t pos = p->base_addr[i];
>        pciaddr_t len = (p->known_fields & PCI_FILL_SIZES) ? p->size[i] : 0;
> +      pciaddr_t ioflg = (p->known_fields & PCI_FILL_IO_FLAGS) ? p->flags[i] : 0;
>        u32 flg = get_conf_long(d, PCI_BASE_ADDRESS_0 + 4*i);
>        if (flg == 0xffffffff)
>  	flg = 0;
> @@ -364,7 +365,9 @@ show_bases(struct device *d, int cnt)
>  	printf("\tRegion %d: ", i);
>        else
>  	putchar('\t');
> -      if (pos && !flg)			/* Reported by the OS, but not by the device */
> +      if (ioflg & IORESOURCE_PCI_EA_BEI)
> +	  printf("[enhanced] ");
> +      else if (pos && !flg)	/* Reported by the OS, but not by the device */
>  	{
>  	  printf("[virtual] ");
>  	  flg = pos;
> @@ -430,6 +433,7 @@ show_rom(struct device *d, int reg)
>    struct pci_dev *p = d->dev;
>    pciaddr_t rom = p->rom_base_addr;
>    pciaddr_t len = (p->known_fields & PCI_FILL_SIZES) ? p->rom_size : 0;
> +  pciaddr_t ioflg = (p->known_fields & PCI_FILL_IO_FLAGS) ? p->rom_flags : 0;
>    u32 flg = get_conf_long(d, reg);
>    word cmd = get_conf_word(d, PCI_COMMAND);
>    int virtual = 0;
> @@ -437,7 +441,9 @@ show_rom(struct device *d, int reg)
>    if (!rom && !flg && !len)
>      return;
>    putchar('\t');
> -  if ((rom & PCI_ROM_ADDRESS_MASK) && !(flg & PCI_ROM_ADDRESS_MASK))
> +  if (ioflg & IORESOURCE_PCI_EA_BEI)
> +      printf("[enhanced] ");
> +  else if ((rom & PCI_ROM_ADDRESS_MASK) && !(flg & PCI_ROM_ADDRESS_MASK))
>      {
>        printf("[virtual] ");
>        flg = rom;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
