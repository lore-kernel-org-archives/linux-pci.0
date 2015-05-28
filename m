Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22561 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbbE1AYG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 20:24:06 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	stable@vger.kernel.org.#.v3.19+
Subject: [PATCH 2/2] PCI: Doc updates for pci_bus_addr_t
Date: Wed, 27 May 2015 17:23:52 -0700
Message-Id: <1432772632-5139-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1432772632-5139-1-git-send-email-yinghai@kernel.org>
References: <1432772632-5139-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Make clear difference for pci_bus_addr_t and dma_addr_t.

Fixes: d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
Link: http://lkml.kernel.org/r/1427857069-6789-1-git-send-email-yinghai@kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96231
Reported-by: David Ahern <david.ahern@oracle.com>
Tested-by: David Ahern <david.ahern@oracle.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: David S. Miller <davem@davemloft.net>
CC: stable@vger.kernel.org	# v3.19+

---
 Documentation/DMA-API-HOWTO.txt |   29 +++++++++++++++++------------
 Documentation/DMA-API.txt       |   30 +++++++++++++++---------------
 include/linux/types.h           |   12 ++++++++++--
 3 files changed, 42 insertions(+), 29 deletions(-)

Index: linux-2.6/Documentation/DMA-API-HOWTO.txt
===================================================================
--- linux-2.6.orig/Documentation/DMA-API-HOWTO.txt
+++ linux-2.6/Documentation/DMA-API-HOWTO.txt
@@ -25,13 +25,18 @@ physical addresses.  These are the addre
 address is not directly useful to a driver; it must use ioremap() to map
 the space and produce a virtual address.
 
-I/O devices use a third kind of address: a "bus address" or "DMA address".
-If a device has registers at an MMIO address, or if it performs DMA to read
-or write system memory, the addresses used by the device are bus addresses.
-In some systems, bus addresses are identical to CPU physical addresses, but
-in general they are not.  IOMMUs and host bridges can produce arbitrary
+I/O devices use a third kind of address: a "bus address".  If a device has
+registers at an MMIO address, or if it performs DMA to read or write system
+memory, the addresses used by the device are bus addresses.  In some
+systems, bus addresses are identical to CPU physical addresses, but in
+general they are not.  IOMMUs and host bridges can produce arbitrary
 mappings between physical and bus addresses.
 
+From a device's point of view, DMA uses the bus address space, but it may
+be restricted to a subset of that space.  For example, even if a system
+supports 64-bit addresses for main memory and PCI BARs, it may use an IOMMU
+so devices only need to use 32-bit DMA addresses.
+
 Here's a picture and some examples:
 
                CPU                  CPU                  Bus
@@ -72,11 +77,11 @@ can use virtual address X to access the
 cannot because DMA doesn't go through the CPU virtual memory system.
 
 In some simple systems, the device can do DMA directly to physical address
-Y.  But in many others, there is IOMMU hardware that translates bus
+Y.  But in many others, there is IOMMU hardware that translates DMA
 addresses to physical addresses, e.g., it translates Z to Y.  This is part
 of the reason for the DMA API: the driver can give a virtual address X to
 an interface like dma_map_single(), which sets up any required IOMMU
-mapping and returns the bus address Z.  The driver then tells the device to
+mapping and returns the DMA address Z.  The driver then tells the device to
 do DMA to Z, and the IOMMU maps it to the buffer at address Y in system
 RAM.
 
@@ -98,7 +103,7 @@ First of all, you should make sure
 #include <linux/dma-mapping.h>
 
 is in your driver, which provides the definition of dma_addr_t.  This type
-can hold any valid DMA or bus address for the platform and should be used
+can hold any valid DMA address for the platform and should be used
 everywhere you hold a DMA address returned from the DMA mapping functions.
 
 			 What memory is DMA'able?
@@ -316,7 +321,7 @@ There are two types of DMA mappings:
   Think of "consistent" as "synchronous" or "coherent".
 
   The current default is to return consistent memory in the low 32
-  bits of the bus space.  However, for future compatibility you should
+  bits of the DMA space.  However, for future compatibility you should
   set the consistent mask even if this default is fine for your
   driver.
 
@@ -403,7 +408,7 @@ dma_alloc_coherent() returns two values:
 can use to access it from the CPU and dma_handle which you pass to the
 card.
 
-The CPU virtual address and the DMA bus address are both
+The CPU virtual address and the DMA address are both
 guaranteed to be aligned to the smallest PAGE_SIZE order which
 is greater than or equal to the requested size.  This invariant
 exists (for example) to guarantee that if you allocate a chunk
@@ -645,8 +650,8 @@ PLEASE NOTE:  The 'nents' argument to th
               dma_map_sg call.
 
 Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
-counterpart, because the bus address space is a shared resource and
-you could render the machine unusable by consuming all bus addresses.
+counterpart, because the DMA address space is a shared resource and
+you could render the machine unusable by consuming all DMA addresses.
 
 If you need to use the same streaming DMA region multiple times and touch
 the data in between the DMA transfers, the buffer needs to be synced
Index: linux-2.6/Documentation/DMA-API.txt
===================================================================
--- linux-2.6.orig/Documentation/DMA-API.txt
+++ linux-2.6/Documentation/DMA-API.txt
@@ -18,10 +18,10 @@ Part I - dma_ API
 To get the dma_ API, you must #include <linux/dma-mapping.h>.  This
 provides dma_addr_t and the interfaces described below.
 
-A dma_addr_t can hold any valid DMA or bus address for the platform.  It
-can be given to a device to use as a DMA source or target.  A CPU cannot
-reference a dma_addr_t directly because there may be translation between
-its physical address space and the bus address space.
+A dma_addr_t can hold any valid DMA address for the platform.  It can be
+given to a device to use as a DMA source or target.  A CPU cannot reference
+a dma_addr_t directly because there may be translation between its physical
+address space and the DMA address space.
 
 Part Ia - Using large DMA-coherent buffers
 ------------------------------------------
@@ -42,7 +42,7 @@ It returns a pointer to the allocated re
 address space) or NULL if the allocation failed.
 
 It also returns a <dma_handle> which may be cast to an unsigned integer the
-same width as the bus and given to the device as the bus address base of
+same width as the bus and given to the device as the DMA address base of
 the region.
 
 Note: consistent memory can be expensive on some platforms, and the
@@ -193,7 +193,7 @@ dma_map_single(struct device *dev, void
 		      enum dma_data_direction direction)
 
 Maps a piece of processor virtual memory so it can be accessed by the
-device and returns the bus address of the memory.
+device and returns the DMA address of the memory.
 
 The direction for both APIs may be converted freely by casting.
 However the dma_ API uses a strongly typed enumerator for its
@@ -212,20 +212,20 @@ contiguous piece of memory.  For this re
 this API should be obtained from sources which guarantee it to be
 physically contiguous (like kmalloc).
 
-Further, the bus address of the memory must be within the
+Further, the DMA address of the memory must be within the
 dma_mask of the device (the dma_mask is a bit mask of the
-addressable region for the device, i.e., if the bus address of
-the memory ANDed with the dma_mask is still equal to the bus
+addressable region for the device, i.e., if the DMA address of
+the memory ANDed with the dma_mask is still equal to the DMA
 address, then the device can perform DMA to the memory).  To
 ensure that the memory allocated by kmalloc is within the dma_mask,
 the driver may specify various platform-dependent flags to restrict
-the bus address range of the allocation (e.g., on x86, GFP_DMA
-guarantees to be within the first 16MB of available bus addresses,
+the DMA address range of the allocation (e.g., on x86, GFP_DMA
+guarantees to be within the first 16MB of available DMA addresses,
 as required by ISA devices).
 
 Note also that the above constraints on physical contiguity and
 dma_mask may not apply if the platform has an IOMMU (a device which
-maps an I/O bus address to a physical memory address).  However, to be
+maps an I/O DMA address to a physical memory address).  However, to be
 portable, device driver writers may *not* assume that such an IOMMU
 exists.
 
@@ -296,7 +296,7 @@ reduce current DMA mapping usage or dela
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction direction)
 
-Returns: the number of bus address segments mapped (this may be shorter
+Returns: the number of DMA address segments mapped (this may be shorter
 than <nents> passed in if some elements of the scatter/gather list are
 physically or virtually adjacent and an IOMMU maps them with a single
 entry).
@@ -340,7 +340,7 @@ must be the same as those and passed in
 API.
 
 Note: <nents> must be the number you passed in, *not* the number of
-bus address entries returned.
+DMA address entries returned.
 
 void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
@@ -507,7 +507,7 @@ it's asked for coherent memory for this
 phys_addr is the CPU physical address to which the memory is currently
 assigned (this will be ioremapped so the CPU can access the region).
 
-device_addr is the bus address the device needs to be programmed
+device_addr is the DMA address the device needs to be programmed
 with to actually address this memory (this will be handed out as the
 dma_addr_t in dma_alloc_coherent()).
 
Index: linux-2.6/include/linux/types.h
===================================================================
--- linux-2.6.orig/include/linux/types.h
+++ linux-2.6/include/linux/types.h
@@ -139,12 +139,20 @@ typedef unsigned long blkcnt_t;
  */
 #define pgoff_t unsigned long
 
-/* A dma_addr_t can hold any valid DMA or bus address for the platform */
+/*
+ * A dma_addr_t can hold any valid DMA address, i.e., any address returned
+ * by the DMA API.
+ *
+ * If the DMA API only uses 32-bit addresses, dma_addr_t need only be 32
+ * bits wide.  Bus addresses, e.g., PCI BARs, may be wider than 32 bits,
+ * but drivers do memory-mapped I/O to ioremapped kernel virtual addresses,
+ * so they don't care about the size of the actual bus addresses.
+ */
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 dma_addr_t;
 #else
 typedef u32 dma_addr_t;
-#endif /* dma_addr_t */
+#endif
 
 typedef unsigned __bitwise__ gfp_t;
 typedef unsigned __bitwise__ fmode_t;
