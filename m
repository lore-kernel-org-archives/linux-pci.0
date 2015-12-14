Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33724 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbLNQeB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 11:34:01 -0500
MIME-Version: 1.0
In-Reply-To: <20151214113016-mutt-send-email-mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
	<20151213212831.5410.84365.stgit@localhost.localdomain>
	<20151214113016-mutt-send-email-mst@redhat.com>
Date: Mon, 14 Dec 2015 08:34:00 -0800
Message-ID: <CAKgT0UdtY5stCPVA=-NoM+1C8Z3b+VXLL1OdrNth=dxvz0A9sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] x86: Create dma_mark_dirty to dirty pages used
 for DMA by VM guest
From: Alexander Duyck <alexander.duyck@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, kvm@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	x86@kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>, konrad.wilk@oracle.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Alexander Graf <agraf@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 14, 2015 at 6:00 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Dec 13, 2015 at 01:28:31PM -0800, Alexander Duyck wrote:
>> This patch is meant to provide the guest with a way of flagging DMA pages
>> as being dirty to the host when using a direct-assign device within a
>> guest.  The advantage to this approach is that it is fairly simple, however
>> It currently has a singificant impact on device performance in all the
>> scenerios where it won't be needed.
>>
>> As such this is really meant only as a proof of concept and to get the ball
>> rolling in terms of figuring out how best to approach the issue of dirty
>> page tracking for a guest that is using a direct assigned device.  In
>> addition with just this patch it should be possible to modify current
>> migration approaches so that instead of having to hot-remove the device
>> before starting the migration this can instead be delayed until the period
>> before the final stop and copy.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>>  arch/arm/include/asm/dma-mapping.h       |    3 ++-
>>  arch/arm64/include/asm/dma-mapping.h     |    5 ++---
>>  arch/ia64/include/asm/dma.h              |    1 +
>>  arch/mips/include/asm/dma-mapping.h      |    1 +
>>  arch/powerpc/include/asm/swiotlb.h       |    1 +
>>  arch/tile/include/asm/dma-mapping.h      |    1 +
>>  arch/unicore32/include/asm/dma-mapping.h |    1 +
>>  arch/x86/Kconfig                         |   11 +++++++++++
>>  arch/x86/include/asm/swiotlb.h           |   26 ++++++++++++++++++++++++++
>>  drivers/xen/swiotlb-xen.c                |    6 ++++++
>>  lib/swiotlb.c                            |    6 ++++++
>>  11 files changed, 58 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
>> index ccb3aa64640d..1962d7b471c7 100644
>> --- a/arch/arm/include/asm/dma-mapping.h
>> +++ b/arch/arm/include/asm/dma-mapping.h
>> @@ -167,7 +167,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>>       return 1;
>>  }
>>
>> -static inline void dma_mark_clean(void *addr, size_t size) { }
>> +static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
>>
>> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
>> index 61e08f360e31..8d24fe11c8a3 100644
>> --- a/arch/arm64/include/asm/dma-mapping.h
>> +++ b/arch/arm64/include/asm/dma-mapping.h
>> @@ -84,9 +84,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>>       return addr + size - 1 <= *dev->dma_mask;
>>  }
>>
>> -static inline void dma_mark_clean(void *addr, size_t size)
>> -{
>> -}
>> +static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  #endif       /* __KERNEL__ */
>>  #endif       /* __ASM_DMA_MAPPING_H */
>> diff --git a/arch/ia64/include/asm/dma.h b/arch/ia64/include/asm/dma.h
>> index 4d97f60f1ef5..d92ebeb2758e 100644
>> --- a/arch/ia64/include/asm/dma.h
>> +++ b/arch/ia64/include/asm/dma.h
>> @@ -20,5 +20,6 @@ extern unsigned long MAX_DMA_ADDRESS;
>>  #define free_dma(x)
>>
>>  void dma_mark_clean(void *addr, size_t size);
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  #endif /* _ASM_IA64_DMA_H */
>> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
>> index e604f760c4a0..567f6e03e337 100644
>> --- a/arch/mips/include/asm/dma-mapping.h
>> +++ b/arch/mips/include/asm/dma-mapping.h
>> @@ -28,6 +28,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>>  }
>>
>>  static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  #include <asm-generic/dma-mapping-common.h>
>>
>> diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
>> index de99d6e29430..b694e8399e28 100644
>> --- a/arch/powerpc/include/asm/swiotlb.h
>> +++ b/arch/powerpc/include/asm/swiotlb.h
>> @@ -16,6 +16,7 @@
>>  extern struct dma_map_ops swiotlb_dma_ops;
>>
>>  static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  extern unsigned int ppc_swiotlb_enable;
>>  int __init swiotlb_setup_bus_notifier(void);
>> diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
>> index 96ac6cce4a32..79953f09e938 100644
>> --- a/arch/tile/include/asm/dma-mapping.h
>> +++ b/arch/tile/include/asm/dma-mapping.h
>> @@ -58,6 +58,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>>  }
>>
>>  static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
>>  {
>> diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
>> index 8140e053ccd3..b9d357ab122d 100644
>> --- a/arch/unicore32/include/asm/dma-mapping.h
>> +++ b/arch/unicore32/include/asm/dma-mapping.h
>> @@ -49,6 +49,7 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>>  }
>>
>>  static inline void dma_mark_clean(void *addr, size_t size) {}
>> +static inline void dma_mark_dirty(void *addr, size_t size) {}
>>
>>  static inline void dma_cache_sync(struct device *dev, void *vaddr,
>>               size_t size, enum dma_data_direction direction)
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index db3622f22b61..f0b09156d7d8 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -841,6 +841,17 @@ config SWIOTLB
>>         with more than 3 GB of memory.
>>         If unsure, say Y.
>>
>> +config SWIOTLB_PAGE_DIRTYING
>> +     bool "SWIOTLB page dirtying"
>> +     depends on SWIOTLB
>> +     default n
>> +     ---help---
>> +       SWIOTLB page dirtying support provides a means for the guest to
>> +       trigger write faults on pages which received DMA from the device
>> +       without changing the data contained within.  By doing this the
>> +       guest can then support migration assuming the device and any
>> +       remaining pages are unmapped prior to the CPU itself being halted.
>> +
>>  config IOMMU_HELPER
>>       def_bool y
>>       depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU
>> diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
>> index ab05d73e2bb7..7f9f2e76d081 100644
>> --- a/arch/x86/include/asm/swiotlb.h
>> +++ b/arch/x86/include/asm/swiotlb.h
>> @@ -29,6 +29,32 @@ static inline void pci_swiotlb_late_init(void)
>>
>>  static inline void dma_mark_clean(void *addr, size_t size) {}
>>
>> +/*
>> + * Make certain that the pages get marked as dirty
>> + * now that the device has completed the DMA transaction.
>> + *
>> + * Without this we run the risk of a guest migration missing
>> + * the pages that the device has written to as they are not
>> + * tracked as a part of the dirty page tracking.
>> + */
>> +static inline void dma_mark_dirty(void *addr, size_t size)
>> +{
>> +#ifdef CONFIG_SWIOTLB_PAGE_DIRTYING
>
> I like where this is going. However
> as distributions don't like shipping multiple kernels,
> I think we also need a way to configure this
> at runtime, even if enabled at build time.

Agreed.  Like I sad in the cover page this is just needed until we can
come up with a way to limit the scope.  Then we could probably default
this to Y and distributions can have it enabled by default.

> How about
> - mark dirty is enabled at boot if requested (e.g. by kernel command line)
> - mark dirty can later be disabled/enabled by sysctl
>
> (Enabling at runtime might be a bit tricky as it has to
>  sync with all CPUs - use e.g. RCU for this?).

I was considering RCU but I am still not sure it is the best way to go
since all we essentially need to do is swap a couple of function
pointers.  I was thinking of making use of the dma_ops pointer
contained in dev_archdata.  If I were to create two dma_ops setups,
one with standard swiotlb and one with a dirty page pointer version
for the unmap and sync calls then it is just a matter of assigning a
pointer to enable the DMA page dirtying, and clearing the pointer to
disable it.  An alternative might be to just add a device specific
flag and then pass the device to the dma_mark_dirty function.  I'm
still debating the possible options.

> This way distro can use a guest agent to disable
> dirtying until before migration starts.

Right.  For a v2 version I would definitely want to have some way to
limit the scope of this.  My main reason for putting this out here is
to start altering the course of discussions since it seems like were
weren't getting anywhere with the ixgbevf migration changes that were
being proposed.

>> +     unsigned long pg_addr, start;
>> +
>> +     start = (unsigned long)addr;
>> +     pg_addr = PAGE_ALIGN(start + size);
>> +     start &= ~(sizeof(atomic_t) - 1);
>> +
>> +     /* trigger a write fault on each page, excluding first page */
>> +     while ((pg_addr -= PAGE_SIZE) > start)
>> +             atomic_add(0, (atomic_t *)pg_addr);
>> +
>> +     /* trigger a write fault on first word of DMA */
>> +     atomic_add(0, (atomic_t *)start);
>
> start might not be aligned correctly for a cast to atomic_t.
> It's harmless to do this for any memory, so I think you should
> just do this for 1st byte of all pages including the first one.

You may not have noticed it but I actually aligned start in the line
after pg_addr.  However instead of aligning to the start of the next
atomic_t I just masked off the lower bits so that we start at the
DWORD that contains the first byte of the starting address.  The
assumption here is that I cannot trigger any sort of fault since if I
have access to a given byte within a DWORD I will have access to the
entire DWORD.  I coded this up so that the spots where we touch the
memory should match up with addresses provided by the hardware to
perform the DMA over the PCI bus.

Also I intentionally ran from highest address to lowest since that way
we don't risk pushing the first cache line of the DMA buffer out of
the L1 cache due to the PAGE_SIZE stride.

- Alex
