Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1546C4A7
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869466; cv=none; b=bSZhSwM1npDQglulO5QLflLriSY0edQJW42919V/LihnFDsYnypKPUsgSYagg6D4JjNxPfbf3FenUxkuMk5yPY2xrfnVyYhefrSp+zvBAOLsPraZ0tevAAGcvYkMNLM+Ca0znJsC5PhVFbd8MQK6/NbOjKr1hq8oBXhsGYVh4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869466; c=relaxed/simple;
	bh=d4DCU8mD/yTPOADLz6OvOqZzysxSQNuEDRfElM8PO/E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q34SMbm8/PJRNmQwgGjHCwMZ5oPM4DI1/98mU91erTXSRZ3aBrk3QLNBbUEPRJB/lzMRSmUr1VafTQ1Q/lw/Lm1OzV8EgtFnA9M2cUrRpH/A788qljJr57iWB1V7L+azWL13zqXveuJ0b+DF+QpZWIjfdQh7PzyojMAMZQLL4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTw8KdEF; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTw8KdEF"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso2178175ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785869464; x=1786474264; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZMgXTe4N/BU5BfE5DQ6Wn9tDsHyqEvJihmfJhMDUmyg=;
        b=RTw8KdEFOIm+3zoTDgDSbe2em3xqI3bl5dvnFA2xfz/frYIXjtaOWoTRasBKTrtCqV
         GQ90TsCXV187DFCqFAUkGQx4ElKzMb5TVCuitq4MvmzLiAy4hhH2+LkyLPjJpdnBusRV
         dZzmeqgEL9C9vtHBEF0wyXL65jddU1JP70BJQJXvXFl84bDA6J+U706PVgK7vIkG1BpY
         Uoq+XEa2ilZC1ZmZ7P5ME+5Os7mnkp6fwSuNKbgnv+l/9VGCqVfdReV4njYktOwCKhAF
         FvRDld46WCcLhadfQ0HD65gLaWJisgQU1i1TnNk2xx8EYXwiy0z4Q4QxDKvNKiyRO65q
         eb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869464; x=1786474264;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMgXTe4N/BU5BfE5DQ6Wn9tDsHyqEvJihmfJhMDUmyg=;
        b=CpJvEo7uN2yAQcxvT2Zn3XrhRtWaMbiIh+Tv4AXIfcYiwX966p+fY9iTmRY6WCxJEc
         28Xe8Ali4NFcwTTMLlrf2JTIg7wTQC2jo+IMmebeeq/wqBpPpnpxQZf2NsXNxWoExLNq
         WeH/laws2A4uX55pdNIib6TkbcqgqOv4N56/8B0McvsoFaFyAjLAJ7Oav4eiJAHsMTg3
         rwUsASl8iScxm4tMfbuKUf/mWwqUGDmcytWWVk3uZuo9XHsWDwngjBnUielVEZyrmmIn
         yGpe+Pi+b85N5xSzJWagAPto++Yn4fjMVtXyx4XDFte5LKjubmL/jfJCaEtmaZQzY/mT
         Aybg==
X-Gm-Message-State: AOJu0YyJiQyBJkjr/uLQZ+b3HoxvnEx+38nlE53tyR8y34tNZCPsvNA/
	MmLVhiGFnsdDp+4nuV2yTWtQtHrLjBYCt0eNzGj+8UmGLKZGE9NgnrIwH760jAVQlBq82YDp5Vc
	Y60fAy1EFy8R0rzt/lCcIyUdz3HssBYZP4RHTMLL583MkxpXbdi7fTZQgp2OMurmIlXU94FJNud
	sRsOdde9b78uvd+HTxfVmfp0DeSB1q/ncKkGY=
X-Received: from plso11.prod.google.com ([2002:a17:902:bccb:b0:2ca:c3ac:bb34])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c27:b0:2ca:62e:cc4f
 with SMTP id d9443c01a7336-2d0ca9467bbmr8991665ad.23.1785869464151; Tue, 04
 Aug 2026 11:51:04 -0700 (PDT)
Date: Tue,  4 Aug 2026 18:50:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804185050.2053672-1-praan@google.com>
Subject: [RFC PATCH v2 0/5] vfio/pci: Support ZONE_DEVICE-backed DMABUF Exports
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Unnati Sachan <unnatisachan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce ZONE_DEVICE backing for VFIO-exposed PCIe BARs via the DMABUF
subsystem. This series is based on Matt's on-going work on VFIO DMABUF
mmap [1].

Currently, kernel drivers can register their BARs with the P2PDMA
subsystem to enable high-performance, page-backed P2P DMA. However, when
a device is bound to vfio-pci, this capability is missing. This prevents
userspace drivers from performing zero-copy P2P DMA via standard POSIX APIs
(e.g., O_DIRECT) which require struct page metadata.

Based on feedback from v1, this series pivots away from system-wide P2P
registration. Instead, it integrates with the ongoing VFIO DMABUF-mmap
work [1], introducing on-demand ZONE_DEVICE allocation exclusively for
DMABUF exports. This allows DMABUFs to optionally register with ZONE_DEVICE
while laying the groundwork for userspace NFS clients and other storage
targets to perform zero-copy P2PDMA against VFIO-managed memory.

(Note: There's on-going work to support P2PDMA on NFS [2])

Design
======
The proposed design involves the following:

a) On-Demand ZONE_DEVICE Registration
A new UAPI flag (VFIO_DMA_BUF_FLAG_ZONE_DEVICE_BACKED) is introduced to
the VFIO_DEVICE_FEATURE_DMA_BUF ioctl to allow users to explicitly "opt-in"
to struct page backing on a per-dmabuf export basis. This ensures we only
allocate vmemmap memory when requested by the user (e.g., NFS + O_DIRECT).

b) Sticky Registration
In order to prevent vmemmap memory fragmentation, ZONE_DEVICE allocations
are "sticky" at the BAR level. Since the ZONE_DEVICE registration relies
on the pci_p2pdma_add_resource() API internally, it is guaranteed to
have the allocations stay until the vfio-pci driver is unbound.

Thus, once a DMABUF export requests page backing, struct pages are allocated
for the entire BAR (even if the DMABUF spans a smaller region within the BAR),
and this allocation survives DMABUF closures and device resets. 

If VM1 opts-in to ZONE_DEVICE, undergoes a reset, and the device is subsequently
assigned to VM2 without the opt-in flag, VFIO simply exports the standard DMABUF
and ignores the underlying struct pages.

c) Revocation Strategy
During a device reset or teardown, VFIO revokes the DMABUF. the design implements
a synchronous revocation fence that blocks indefinitely until all struct page 
refcounts drop to 1 (meaning the importer has fully released them) to prevent
DMA-after-free corruption.

d) DMABUF Interoperability
A custom .map_dma_buf handler is implemented to ensure a ZONE_DEVICE-backed DMABUF
can be used as a regular VFIO-exported DMABUF ensuring importers can still use
standard SG-table-based APIs seamlessly alongside page-based ones.

e) Concurrency
The page allocation and refcount initialization are serialized via the memory_lock
write semaphore to prevent concurrent fault races. Additionally, we call a
unmap_mapping_range() during revocation while holding memory_lock without triggering
a circular rmap deadlock (mmap_lock -> memory_lock -> i_mmap_rwsem). This is safely
avoided because pages allocated via devm_memremap_pages() do not have page->mapping
set, rendering them invisible to the rmap.

Call for Review & Design Trade-Offs
====================================
Please provide feedback on the sticky registration and revocation strategy.

I've evaluated the following and would appreciate guidance on these tradeoffs:

a) Sticky Registration vs. Ephemeral Teardown
Instead of making vmemmap allocations sticky across resets, we could free and 
re-allocate them per-session. While this would eliminate the need for our 
indefinite polling loop (as the devres teardown handles it natively) and
clean up struct pages that are not needed anymore after the fd closure.

This design opts for the sticky approach to avoid vmemmap fragmentation over the 
host's uptime. 

b) pci_p2pdma_add_resource vs. Open-Coded devm_memremap

This implementation relies on pci_p2pdma_add_resource(), which couples the
vmemmap lifecycle to the vfio-pci driver unbind event. Alternatively, we 
could open-code a devm_memremap_pages() implementation (similar to P2PDMA API)
directly within VFIO to gain finer-grained control over the teardown
(maybe something like vfio_p2pdma_add_resource() or something).

I've avoided that in this version to first gain consensus on the fragmentation
and revocation fence.

c) Interoperability
The propsed design assumes that an importer of a ZONE_DEVICE DMABUF may still
want to utilize standard DMABUF operations, and thus implemented the .map_dma_buf
op. An alternative would be to strictly enforce that ZONE_DEVICE DMABUFs only 
support page-backed usage, explicitly rejecting standard DMABUF operations.

[1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/
[2] https://lore.kernel.org/all/20260720150601.2702700-1-praan@google.com/

Thanks,
Praan

Pranjal Shrivastava (5):
  vfio: Add UAPI flag for ZONE_DEVICE-backed DMABUF exports
  vfio/pci: Implement ZONE_DEVICE registration for DMABUFs
  vfio/pci: Implement page-backed .map_dma_buf handler
  vfio/pci: Add .mmap handler for page-backed DMABUFs
  vfio/pci: Add revocation fence for ZONE_DEVICE DMABUFs

 drivers/vfio/pci/Kconfig           |  11 ++
 drivers/vfio/pci/vfio_pci_core.c   |  39 +++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c | 213 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |   1 +
 include/linux/vfio_pci_core.h      |   4 +
 include/uapi/linux/vfio.h          |  10 +-
 6 files changed, 266 insertions(+), 12 deletions(-)

-- 
2.55.0.571.g244d577d93-goog
