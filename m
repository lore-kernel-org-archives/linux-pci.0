Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33486 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbLMV2M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Dec 2015 16:28:12 -0500
Received: by pabur14 with SMTP id ur14so93246166pab.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Dec 2015 13:28:11 -0800 (PST)
Subject: [RFC PATCH 0/3] x86: Add support for guest DMA dirty page tracking
From: Alexander Duyck <aduyck@mirantis.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
	qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, yang.zhang.wz@gmail.com, mst@redhat.com,
	konrad.wilk@oracle.com, dgilbert@redhat.com, agraf@suse.de,
	alex.williamson@redhat.com
Date: Sun, 13 Dec 2015 13:28:09 -0800
Message-ID: <20151213212557.5410.48577.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set is meant to be the guest side code for a proof of concept
involving leaving pass-through devices in the guest during the warm-up
phase of guest live migration.  In order to accomplish this I have added a
new function called dma_mark_dirty that will mark the pages associated with
the DMA transaction as dirty in the case of either an unmap or a
sync_.*_for_cpu where the DMA direction is either DMA_FROM_DEVICE or
DMA_BIDIRECTIONAL.  The pass-through device must still be removed before
the stop-and-copy phase, however allowing the device to be present should
significantly improve the performance of the guest during the warm-up
period.

This current implementation is very preliminary and there are number of
items still missing.  Specifically in order to make this a more complete 
solution we need to support:
1.  Notifying hypervisor that drivers are dirtying DMA pages received
2.  Bypassing page dirtying when it is not needed.

The two mechanisms referenced above would likely require coordination with
QEMU and as such are open to discussion.  I haven't attempted to address
them as I am not sure there is a consensus as of yet.  My personal
preference would be to add a vendor-specific configuration block to the
emulated pci-bridge interfaces created by QEMU that would allow us to
essentially extend shpc to support guest live migration with pass-through
devices.

The functionality in this patch set is currently disabled by default.  To
enable it you can select "SWIOTLB page dirtying" from the "Processor type
and features" menu.

---

Alexander Duyck (3):
      swiotlb: Fold static unmap and sync calls into calling functions
      xen/swiotlb: Fold static unmap and sync calls into calling functions
      x86: Create dma_mark_dirty to dirty pages used for DMA by VM guest


 arch/arm/include/asm/dma-mapping.h       |    3 +
 arch/arm64/include/asm/dma-mapping.h     |    5 +-
 arch/ia64/include/asm/dma.h              |    1 
 arch/mips/include/asm/dma-mapping.h      |    1 
 arch/powerpc/include/asm/swiotlb.h       |    1 
 arch/tile/include/asm/dma-mapping.h      |    1 
 arch/unicore32/include/asm/dma-mapping.h |    1 
 arch/x86/Kconfig                         |   11 ++++
 arch/x86/include/asm/swiotlb.h           |   26 ++++++++
 drivers/xen/swiotlb-xen.c                |   92 +++++++++++++-----------------
 lib/swiotlb.c                            |   83 ++++++++++++---------------
 11 files changed, 123 insertions(+), 102 deletions(-)

--
