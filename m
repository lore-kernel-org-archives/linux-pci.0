Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57018 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab2GUAwd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jul 2012 20:52:33 -0400
Received: by lbbgm6 with SMTP id gm6so5753307lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 20 Jul 2012 17:52:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C3F57A84-3334-4A30-8D55-773F11B0B511@e.co.za>
References: <C3F57A84-3334-4A30-8D55-773F11B0B511@e.co.za>
Date: Fri, 20 Jul 2012 17:52:31 -0700
Message-ID: <CAD-6qVX_Ve8z64-TnotKGzjty3Ze9j5UjjYvMbbB77av39a02w@mail.gmail.com>
Subject: Re: pci_iomap bug?
From: Alex Solomatnikov <solomatnikov@gmail.com>
To: Bert van Leeuwen <bert@e.co.za>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think I've seen almost exactly the same message in mail archive from
5 years ago or so :)


It is not necessarily a bug: mapping something as uncached would not
make it non-functional. Maybe, it would be much slower than cached.

AFAIU caching of PCI MMIO does not work correctly on x86 unless it is read-only:

http://kerneltrap.org/mailarchive/linux-kernel/2008/4/29/1657814

"an ioremap_cached() function can be used by the handful of places
that really wants a cached mapping (but beware
of the caching rules! PCI MMIO space shouldn't use this unless it's a
ROM! See the rules above)"

I tried to do cached mapping on 4 different recent x86 systems and
indeed it does not work on any of them. On 2 systems writes to cached
PCI MMIO cause MCE and system crash, on another writes are silently
dropped, on 4th writes work correctly but as uncached (even though
MTRR and PAT are both set as cached).


It seems that the problem is messy code and API. It could have been
something like this:

#ifdef ARCH_HAS_IOREMAP_CACHE
    if (flags & IORESOURCE_CACHEABLE)
      return ioremap_cache(start, len);
#endif
#ifdef ARCH_HAS_IOREMAP_CACHE_READ_ONLY
    if((flags & IORESOURCE_CACHEABLE) && (flags & IORESOURCE_READ_ONLY))
      return ioremap_cache_read_only(start, len);
#endif
    return ioremap_nocache(start, len);


Also, the naming of ioremap functions is not consistent across
architectures (at least in CentOS 6/2.6.32):

grep -rn ioremap_cach *
arch/mips/include/asm/io.h:254: * ioremap_cachable -   map bus memory
into CPU space
arch/mips/include/asm/io.h:268:#define ioremap_cachable(offset, size)					\
arch/mips/include/asm/io.h:272: * These two are MIPS specific ioremap
variant.  ioremap_cacheable_cow
arch/mips/include/asm/io.h:277:#define ioremap_cacheable_cow(offset, size)				\
arch/ia64/include/asm/io.h:429:static inline void __iomem *
ioremap_cache (unsigned long phys_addr, unsigned long size)
arch/x86/kernel/kdebugfs.c:51:		p = ioremap_cache(pa, count);
arch/x86/kernel/kdebugfs.c:134:			data = ioremap_cache(pa_data, sizeof(*data));
arch/x86/kernel/crash_dump_64.c:37:	vaddr = ioremap_cache(pfn <<
PAGE_SHIFT, PAGE_SIZE);
arch/x86/include/asm/efi.h:36:#define efi_ioremap(addr, size,
type)		ioremap_cache(addr, size)
arch/x86/include/asm/io.h:161:extern void __iomem
*ioremap_cache(resource_size_t offset, unsigned long size);
arch/x86/mm/ioremap.c:239:void __iomem *ioremap_cache(resource_size_t
phys_addr, unsigned long size)
arch/x86/mm/ioremap.c:244:EXPORT_SYMBOL(ioremap_cache);
arch/sh/include/asm/io.h:288:#define ioremap_cache(offset, size)			\
arch/arm/include/asm/io.h:225:#define
ioremap_cached(cookie,size)	__arm_ioremap(cookie, size,
MT_DEVICE_CACHED)
arch/arm/include/asm/io.h:231:#define
ioremap_cached(cookie,size)	__arch_ioremap((cookie), (size),
MT_DEVICE_CACHED)
arch/arm/mm/mmu.c:210:	[MT_DEVICE_CACHED] = {	  /* ioremap_cached */
Documentation/x86/pat.txt:35:ioremap_cache          |    --    |    WB
     |       WB         |
drivers/acpi/apei/erst.c:1152:	erst_erange.vaddr =
ioremap_cache(erst_erange.base,
drivers/acpi/apei/einj.c:209:	trigger_tab =
ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
drivers/acpi/apei/einj.c:233:	trigger_tab =
ioremap_cache(trigger_paddr, table_size);
drivers/mtd/maps/pxa2xx-flash.c:75:		ioremap_cached(info->map.phys,
info->map.size);
drivers/char/toshiba.c:429:	void __iomem *bios =
ioremap_cache(0xf0000, 0x10000);
drivers/lguest/lguest_device.c:31:	return (__force void
*)ioremap_cache(phys_addr, PAGE_SIZE*pages);
include/linux/acpi_io.h:10:       return ioremap_cache(phys, size);


On Fri, Jul 20, 2012 at 6:37 AM, Bert van Leeuwen <bert@e.co.za> wrote:
> I noticed that the pci_iomap() function in the lib/iomap.c file seems (to me) do be doing the wrong thing here:
>
>     if (flags & IORESOURCE_CACHEABLE)
>       return ioremap(start, len);
>     return ioremap_nocache(start, len);
>
> since, as of 2.6.26 or so, the ioremap() function is defined as:
> static inline void __iomem *ioremap(resource_size_t offset, unsigned long size)
> {
>   return ioremap_nocache(offset, size);
> }
>
> So it seems to me that pci_iomap() is calling ioremap_nocache() regardless of the IORESOURCE_CACHEABLE flag?--
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
