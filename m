Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE83644A4;
	Wed, 15 Jul 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138022; cv=none; b=UYt6m24Dh4CY04soYvKVSoBiCymGtXF8U0bzoJkNAelmP+B4/QkAltJVZsfGaDERv6zPiqHLC96UDrUpVKzt9v0JFyKQXJQQArn6KssJARgV1jBidHXk2YAVvxjsQSYqW8iokjmniSOh8o81u4IeR4R1iYP+eAToEF9JE/4FvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138022; c=relaxed/simple;
	bh=oxjvc5GzSbctUlb+qIaa1wlQoZalbhkhrBJwhhNjLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLBVTENYdyPCTMML3sRicMAZ12v50ons78lUTRJK+sZqfFLYHwhmJw5dWdR/nuSrKRENOvMpakJFy+/M4/AUcEvDQE/23n05svjAxDWqszKiP5j5hS0TrtcVEZChHCRj0IT2hN466TQEimupQfsvqpOh/DaaELyUAGERlw1OS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=NMLzoZdn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NMLzoZdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137672;
	bh=Ag64aC6A30cZLTDoIogox6cPsztZDfKJp3k1bxsmacI=;
	h=From:To:Cc:Subject:Date:From;
	b=NMLzoZdn0RrMMUBfebmKeU0Z/zMSaPCohWoTHC3bvS1zGbABkLXJWn0D6xs8JTqNO
	 kT/nRIXKPJCDRFlYPmg3w25uJaOLWEBVVyPKxduB8b7zOJN0CSv/uHWeaJazN0Xksu
	 44/WgyfinEqafQNcz1K9KnRl4/H1MJDW/9MRzQ695ILWkO3SDiKMrkM3V8sw2YYFO1
	 h1iZY+KvT/GWfXjJUWzd9p0xXsREcF+KVSYUPZljy0Omgo7AGWh8596rc9EIuMJ5A5
	 p3wc5O+gbugYweCx7WxWAmr/Eai025s3wSmK7JKLU/S1cGwlD85xA12aq9zLIdzFTZ
	 ak/cAbzibAR8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kCn5xR5z4wBD;
	Thu, 16 Jul 2026 03:47:49 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
Date: Wed, 15 Jul 2026 18:47:23 +0100
Message-ID: <20260715174737.15287-1-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,


The goal of this series is to enable userspace driver designs that use
VFIO to export DMABUFs representing subsets of PCI device BARs, and
"vend" those buffers from a primary process to other subordinate
processes by fd.  These processes then mmap() the buffers and their
access to the device is isolated to the exported ranges.  This is an
improvement on sharing the VFIO device fd to subordinate processes,
which would allow unfettered access.

This is achieved by enabling mmap() of vfio-pci DMABUFs, passed by fd
to subordinate processes.  Second, a new revocation mechanism is added
to allow the primary process to forcibly revoke access to
previously-shared BAR spans, even if the subordinate processes haven't
cleanly exited.

(The related topic of safe delegation of iommufd control to the
subordinate processes is not addressed here, and is follow-up work.)

The background/rationale is covered in more detail in the RFC cover
letters.

Feedback from the RFCs requested that, instead of creating
DMABUF-specific vm_ops and .fault paths, to go the whole way and
migrate the existing VFIO PCI BAR mmap() to be backed by a DMABUF too,
resulting in a common vm_ops and fault handler for mmap()s of both the
VFIO device and explicitly-exported DMABUFs.  This will help future
iommufd emulation of VFIO Type1 peer-to-peer, making it easier to get
a DMABUF for a VFIO BAR as a DMA target.

mmap() conversion to use DMABUF underneath has been done for vfio-pci,
but not sub-drivers:

  nvgrace-gpu's mmap() override path is unchanged; I kept this out of
  scope for now not least because I don't have a thorough test setup
  for this system.  I would prefer to help the nvgrace-gpu maintainers
  enable BAR mmap() DMABUFs themselves.


Notes on patches
================

 PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()
 PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE

   Later in the series, vfio-pci's mmap() is going to depend on
   pcim_p2pdma_provider() which depended on CONFIG_PCI_P2PDMA, which
   in turn depended on ZONE_DEVICE.  That isn't available on 32-bit
   and some archs, because they lack MEMORY_HOTPLUG and friends.
   VFIO does _not_ require actual P2P to be present for basic mmap()
   functionality, only for the optional CONFIG_DMA_SHARED_BUFFER
   feature.

   These split out p2pdma_core.c under CONFIG_PCI_P2PDMA_CORE (which
   currently contains pcim_p2pdma_provider()), and an optional
   CONFIG_PCI_P2PDMA which depends on ZONE_DEVICE etc. providing
   P2P functionality in the existing p2pdma.c.  The first splits
   out pool cleanup from the release path, and the second does the
   refactor/code move to the new file.


 vfio/pci: Add a helper to look up PFNs for DMABUFs
 vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA

   The first adds a DMABUF VMA fault handler helper to determine
   arbitrary-sized PFNs from ranges in DMABUF.  The second refactors
   DMABUF export for use by the existing export feature, and adds a
   helper that creates a DMABUF corresponding to a VFIO BAR mmap()
   request.


 vfio/pci: Convert BAR mmap() to use a DMABUF

   The vfio-pci core mmap() creates a DMABUF with the helper above,
   and the vm_ops fault handler uses the other helper to resolve the
   fault.  Because this depends on DMABUF structs/code,
   CONFIG_VFIO_PCI_CORE needs to depend on CONFIG_DMA_SHARED_BUFFER.
   The CONFIG_VFIO_PCI_DMABUF still conditionally enables the export
   support code.

   NOTE: The user mmap()s a device fd, but the resulting VMA's vm_file
   becomes that of the DMABUF.  The DMABUF takes ownership of the
   device file and put()s it on release, which maintains the existing
   behaviour of a VMA keeping the VFIO device open.

   BAR zapping then happens via the existing vfio_pci_dma_buf_move()
   path, which now needs to unmap PTEs in the DMABUF's address_space.


 vfio/pci: Provide a user-facing name for BAR mappings

   There was a request for decent debug naming in /proc/<pid>/maps
   etc.  comparable to the existing VFIO names: since the VMAs are
   DMABUFs, they have a "dmabuf:" prefix and can't be 100% identical
   to before.  This is a user-visible change, but this patch at least
   now gives us extra info on the BDF & BAR being mapped.


 vfio/pci: Clean up BAR zap and revocation

   In general (see NOTE!) the vfio_pci_zap_bars() is now obsolete,
   since it unmaps PTEs in the VFIO device address_space which is now
   unused.  This consolidates all calls (e.g. around reset) with the
   neighbouring vfio_pci_dma_buf_move()s into new functions, to
   revoke/unrevoke (making the steps clearer).

   NOTE: Because drivers can use their own vm_ops and override .mmap,
   the core must conservatively assume an overridden .mmap might still
   add PTEs to the VFIO device address_space and therefore still does
   the zap.  A new flag, zap_bars_on_revoke, enables the zap when
   .mmap is overridden.  A driver that does not need the zap can clear
   this to opt-out, e.g. if the driver calls down to the common mmap
   (and so uses DMABUFs).  hisi-acc-vfio-pci does just this, and thus
   sets the opt-out flag.


 vfio/pci: Support mmap() of a VFIO DMABUF

   Adds mmap() for a DMABUF fd exported from vfio-pci.

   It was a goal to keep the VFIO device fd lifetime behaviour
   unchanged with respect to the DMABUFs.  An application can close
   all device fds, and this will revoke/clean up all DMABUFs; then, no
   mappings or other access can be performed.  When enabling mmap() of
   the DMABUFs, this means access through the VMA is also revoked.
   This complicates the fault handler because whilst the DMABUF
   exists, it has no guarantee that the corresponding VFIO device is
   still alive.  Adds synchronisation ensuring the vdev is available
   before vdev->memory_lock is touched; this holds the device
   registration so that even if the buffer has been cleaned up, vdev
   hasn't been freed and so the lock can be safely taken.


 vfio/pci: Permanently revoke a DMABUF on request

   This is mostly a rename of `revoked` to an enum, `status`, and
   adding a third state for a buffer: usable, revoked temporary,
   revoked permanent.  A new VFIO feature is added,
   VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE, which takes a DMABUF (exported
   from the same device) and permanently revokes it.  Thus a userspace
   driver can guarantee any downstream consumers of a shared fd are
   prevented from accessing a BAR range, and that range can be reused.
   NOTE: This might block userspace, waiting on importers to detach.

   The code doing revocation in vfio_pci_dma_buf_move() is moved, to a
   common function for use by ..._move() and this new feature.

   NOTE: See changelog, by request v4 added a condition to the
   existing code to elide the unnecessary invalidation/sync on the
   un-revoke path.)


NOTE: Previous versions contained an additional feature patch,
"vfio/pci: Add mmap() attributes to DMABUF feature".  This has been
dropped in v5 because:

 - The mechanism simply set vma->vm_page_prot.  This would be
   sufficient for arm64 and other architectures.

 - However, (locally-run claude-opus-4-8) Sashiko flagged that, on
   x86, additional memtype handling is required to set up the PAT.
   Without this, the memtype is returned back to UC- by
   pfnmap_setup_cachemode() upon PTE creation.

Most other sources of userspace WC mappings create PTEs eagerly with
e.g. io_remap_pfn_range() which memtype_reserve() WC for the range.
Getting them with lazy-fault used by vfio-pci is more complicated
(e.g. perhaps registering WC for BARs with PAT/MTRRs, and deciding how
to deal with aliasing...).  Since this feature is not critical for
this series to be useful, I've decided for now to drop it in favour of
a simpler series now and revisiting this separ*ately.


Testing
=======

(The [RFC ONLY] userspace test program, for QEMU edu-plus, can be
found in the GitHub branch below.  It at least illustrates how the
export, map, revoke, and close semantics interoperate.)

This code has been tested in mapping DMABUFs of single/multiple ranges
from multiple BARs, aliasing mmap()s, aliasing ranges across DMABUFs,
vm_pgoff > 0, revocation, shutdown/cleanup scenarios, and hugepage
mappings.  No regressions observed on the VFIO selftests, or on our
internal vfio-pci applications.  VFIO on i386 has been build-tested.


Dear Reviewers,
===============

I was grateful for the reviews and Reviewed-Bys on previous versions.
Thanks; I've added some Reviewed-Bys/Acks.  I have NOT included your
tags where the patch has materially changed after your review (or
where requested changes ended up more than super-trivial).  I hope
that's okay.


End
===

This is based on v7.2-rc3.

These commits are on GitHub for easier browsing, along with
"[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":

https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-mmap-v5


Thanks for reading,


Matt


================================================================================
Changelog:

v5:

 - Rebased on 7.2-rc3

 - Dropped the memattr/WC feature (see explanation above).

 - "vfio/pci: Convert BAR mmap() to use a DMABUF": Fixed a
   potentially-nasty bug (which (locally-run) Sashiko found!)  whereby
   the unmap_mapping_range() performed in cleanup was passed a range
   up from offset zero for the DMABUF size.  Initially this was how
   all DMABUFs were created and an appropriate zap, but a new version
   kept the VFIO region index encoded in the offset -- for BAR > 0 the
   unmap span would then mismatch.  Instead, pass size 0 to mean an
   "all" range.  Because the goal is to shoot down everything relating
   to one DMABUF and the address_space can only contain things
   relating to that DMABUF, this is equivalent and has the bonus of
   never failing to match mappings...

   Praan, Kevin, I kept your R-Bs on this fix.

 - The revoke patch converts vfio_pci_dma_buf_cleanup()'s priv->vdev =
   NULL to a WRITE_ONCE, corresponding to the revoke function's
   READ_ONCE (performed to test that the VFIO and DMABUF are related).

 - Clarified the VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE UAPI comments,
   documenting previously-missing error cases and their reasons.


v4:	https://lore.kernel.org/all/20260701171245.90111-1-matt@ozlabs.org/
v3: 	https://lore.kernel.org/all/20260610154327.37758-1-matt@ozlabs.org/
v2: 	https://lore.kernel.org/all/20260527102319.100128-1-mattev@meta.com/
v1: 	https://lore.kernel.org/kvm/20260416131815.2729131-1-mattev@meta.com/
RFCv2:	https://lore.kernel.org/kvm/20260312184613.3710705-1-mattev@meta.com/
RFCv1:	https://lore.kernel.org/all/20260226202211.929005-1-mattev@meta.com/
Tech topic: https://lore.kernel.org/linux-iommu/20250918214425.2677057-1-amastro@fb.com/


Matt Evans (9):
  PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()
  PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
  vfio/pci: Add a helper to look up PFNs for DMABUFs
  vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
  vfio/pci: Convert BAR mmap() to use a DMABUF
  vfio/pci: Provide a user-facing name for BAR mappings
  vfio/pci: Clean up BAR zap and revocation
  vfio/pci: Support mmap() of a VFIO DMABUF
  vfio/pci: Permanently revoke a DMABUF on request

 MAINTAINERS                                   |   2 +-
 drivers/pci/Kconfig                           |   5 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/p2pdma.c                          | 113 +---
 drivers/pci/p2pdma.h                          |  29 +
 drivers/pci/p2pdma_core.c                     | 122 +++++
 drivers/vfio/pci/Kconfig                      |   5 +-
 drivers/vfio/pci/Makefile                     |   3 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |   8 +
 drivers/vfio/pci/vfio_pci_config.c            |  30 +-
 drivers/vfio/pci/vfio_pci_core.c              | 210 +++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 515 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h              |  53 +-
 include/linux/pci-p2pdma.h                    |  24 +-
 include/linux/pci.h                           |   2 +-
 include/linux/vfio_pci_core.h                 |   1 +
 include/uapi/linux/vfio.h                     |  25 +
 17 files changed, 875 insertions(+), 273 deletions(-)
 create mode 100644 drivers/pci/p2pdma.h
 create mode 100644 drivers/pci/p2pdma_core.c

-- 
2.50.1 (Apple Git-155)

