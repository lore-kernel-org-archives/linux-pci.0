Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FE30E82B;
	Tue,  6 Oct 2026 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315421; cv=none; b=hNrQoKlLHcULkMiuxZO2/c6yuIX7IM6Zf74c2iwstjsve6IpWD2pBtaHkSjXjczndmc6VSIYxR/e6SS27UY3Rdyh9h9XY7OQ1D9w3kmJccd/SsJlK3yQ3v/TzIaQLMRnuRz7NVWfL892BareNyGNcSfk5N/u1mTLfWLGPTqWm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315421; c=relaxed/simple;
	bh=cmIw9EGj6tdclgJ+9rvLrITazUzkenCXpYmRlU2mOuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2z1BPvT3gWEdj/CI9/m/Y4DY8U9rE3nSeHRl+P4zL3Rt5REa8EdnqqzLB0woOvaG+g6VmxrcgN/BbSa3QmRW8hPTxLDt7FgkRo6XdBT2IFnFC87eCvQH4eMLKgWfV7812tKYhn/wjzeugUO4qn2GG+x3x6rE4CRsi0GFg1emZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=fcv1G/i/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="fcv1G/i/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1791315415;
	bh=7FwHW/kz9OvyjnbInxvjFAMnT8ybPDtZB0CrAm1lGGU=;
	h=From:To:Cc:Subject:Date:From;
	b=fcv1G/i/qHxKckbz38i9ymJ2i+7pDpZkPPq+53qguyYZOhMFOX4+d22ZG/J7Y+fyR
	 Mr60il3hOexUpfpz54lnDyQJrBgTWj38iUPfOCvc3L1LijyuW0lwxO6dEk3b5zgj8O
	 +RQfQeueto1gVotY2DNGvn/VYIqvf2OWfkDyK1HfkAFn56h7c8q4AuVJ23AS2md+h0
	 8CFCThSD9fEpyC228aOAuoYSRfxw2ogVZtLAVpbbcmzAs1fT2rVsIW/cjiOqKjcnSY
	 1OF3+DBg0Q6DjbmEG/asmdRkeg82TGVHQQahMFB/Xlo0Zm8N5+v/P5/ZYpXZ1avi5J
	 dMvKWvxEOyH2Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hzmjL3MGdz4w9b;
	Wed, 07 Oct 2026 06:36:54 +1100 (AEDT)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
Subject: [PATCH v8 0/9] vfio/pci: Add mmap() for DMABUFs
Date: Tue,  6 Oct 2026 20:36:28 +0100
Message-ID: <20261006193643.76330-1-matt@ozlabs.org>
X-Mailer: git-send-email 2.47.3
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
processes by fd.  This is achieved by allowing the processes to mmap()
the DMABUFs; their access to the device is isolated to the exported
ranges.  The primary userspace driver process can forcibly revoke
access to previously-shared buffers upon cleanup (without requiring
cooperation from the subordinate processes).  This is an improvement
on sharing the VFIO device fd to subordinate processes, which would
allow unfettered access.  See the RFCs for background.

The existing VFIO PCI BAR mmap() becomes backed by a DMABUF too,
keeping common vm_ops and fault handler for VMAs from the VFIO device
and explicitly-exported DMABUFs.  This will help future iommufd
emulation of VFIO Type1 peer-to-peer, making it easier to get a DMABUF
for a VFIO BAR as a DMA target.

Below are per-patch notes & background info, and at the bottom are
several related questions that reviewers may like to consider (worth
at least skipping to #1, a possible bug).


Notes on patches
================

mmap() conversion to use DMABUF underneath has been done for vfio-pci,
but not sub-drivers:

nvgrace-gpu's mmap() override path is unchanged; I kept this out of
scope for now not least because I don't have a thorough test setup for
this system.  I would prefer to help the nvgrace-gpu maintainers
enable BAR mmap() DMABUFs themselves.

It's also worth noting that one reason for nvgrace-gpu's special BAR
handling is to map RESMEM with a WC memory type.  This is unchanged
for existing mmap() but WC is not currently supported for mapping
DMABUFs exported for that BAR; all DMABUF VMAs currently have the same
memory type and control of UC/WC for a mapping is future work.


 vfio/pci: Remove DMABUF export dependency on vdev->memory_lock

   In v5 of this series we discover that doing an export from the VFIO
   mmap() path (fundamental!) adds a dependency between mmap_lock and
   vdev->memory_lock(W) because export was using memory_lock(W) to
   protect the vdev->dmabufs list and state within, and a deadlock
   scenario leapt out to bite:

   https://lore.kernel.org/kvm/9a615f22-c0d4-46ae-9654-db11e94e5fec@ozlabs.org/

   The suggestion was to add a dedicated mutex/rwsem specifically for
   the DMABUFs/list, which is cleaner than overloading memory_lock(W).

   But whilst export could now downgrade to holding memory_lock(R) to
   test __vfio_pci_memory_enabled(), a very similar deadlock can still
   arise due to a memory_lock(W) elsewhere depending on a prior
   memory_lock(R) to be released, and attempting to take
   memory_lock(R) will queue behind the (W) for fairness (effectively
   an R->R dependency).  I'd overlooked that rwsem cannot guarantee
   multiple readers.

   To be able to export while holding mmap_lock, export cannot hold
   memory_lock at all.  Instead of testing __vfio_pci_memory_enabled()
   (which tracks PCI_COMMAND.MSE and PM state), this patch tracks
   device-global DMABUF revocation state in a new vdev->bars_revoked
   flag updated by vfio_pci_dma_buf_move().  If an mmap() is somehow
   performed during a period when DMABUFs are all revoked, then the
   DMABUF is created revoked.  Move() already bookends reset, PM
   transitions etc., so subsequent revocation state changes work
   as-is.  This flag is also protected by the dmabuf_lock and thus
   memory_lock is not required to export.


 vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume

   On LOW_POWER entry, DMABUFs have a move(revoke=true), but the
   runtime resume path didn't un-revoke.  This adds a corresponding
   move(revoke=false), which will later turn into
   vfio_pci_unrevoke_bars().

   NOTE: the unrevoke is reordered _before_ the eventfd_signal() in
   vfio_pci_core_runtime_resume() to remove a window in which a waking
   waiter could have observed the DMABUF state as still revoked (or
   pm_runtime_engaged = true).  (The UAPI docs state the event means
   the resume's complete, so observing otherwise seemed unintended.)

   Also, when DMABUFs are later mmap()ed, a waiter waking and taking a
   fault could have seen the unrevoked state and SIGBUS just before
   taking the memory_lock.  (If the handler gets to acquire the lock,
   though, the resume sequence is complete, and the handler observes
   pm_runtime_engaged = false.)

   This fix is in this series because the issue will impact CPU access
   to the VMA as well (once they use DMABUFs), and so it's a strict
   dependency of later commits.


 dma-buf: Provide dma_buf_set_name()

   Makes dma_buf_set_name() available for use (by helper patch),
   taking a kernel-allocated string.  The pre-existing local helper
   becomes a wrapper copying a __user string for the set-name ioctl.


 vfio/pci: Add a helper to look up PFNs for DMABUFs

   Adds a DMABUF VMA fault handler helper to determine arbitrary-sized
   PFNs from ranges in DMABUF.


 vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA

   Refactors DMABUF export for use by the existing export feature, and
   adds a helper that creates a DMABUF corresponding to a VFIO BAR
   mmap() request.

   There was a request for decent debug naming in /proc/<pid>/maps
   etc.  comparable to the existing VFIO names: since the VMAs are
   DMABUFs, they have a "dmabuf:" prefix and can't be 100% identical
   to before.  This is a user-visible change, but this patch at least
   now gives us extra info on the BDF & BAR being mmap()ed.  The name
   is installed with the new dma_buf_set_name() above.


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

   NOTE: As local LLM reviews did, Sashiko might falsely worry about
   the DMABUF fd being obtained through /proc/pid/map_files and
   remapped, but the file is an anon inode and doesn't support the
   open op (-ENXIO) so AFAICT this is currently impossible.

   NOTE: A side-effect of this is that is_mergeable_vma() will be
   false between adjacent mappings of VFIO BARs; merging would require
   rebuilding a larger DMABUF representing the union, not just
   plugging the VMAs together.

   The DMABUF backing the BAR is an implicit/internal export, even
   when the CONFIG_VFIO_PCI_DMABUF feature is not included because
   CONFIG_PCI_P2PDMA is not available.  Without P2PDMA, it's
   acceptable for the DMABUF to not have a P2PDMA provider.  In this
   configuration, the VFIO DMABUF .attach prohibits any import, which
   avoids getting as far as a WARN in dma_buf_map_attachment(), which
   would fail without P2PDMA anyway.


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
   before the locks in vdev are touched; this holds the device
   registration so that even if the buffer has been cleaned up, vdev
   hasn't been freed and so the locks can be safely taken.


 vfio/pci: Revoke a DMABUF on request from userspace

   This is mostly a rename of `revoked` to an enum, `status`, and
   adding a third state for a buffer: usable, revoked temporary,
   revoked permanent.  A new VFIO feature is added,
   VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE, which takes a DMABUF (exported
   from the same device) and permanently revokes it.  Thus a userspace
   driver can guarantee any downstream consumers of a shared fd are
   prevented from accessing a BAR range, and that range can be reused.
   NOTE: This might block userspace, waiting on importers to detach.

   The code doing revocation in vfio_pci_dma_buf_move() is moved, to a
   common function used by ..._move() and this new feature.


Testing
=======

(The [RFC ONLY] userspace test program, which drives a QEMU
bochs-display function, can be found in the GitHub branch below.  It
at least illustrates how the export, map, revoke, and close semantics
interoperate.  WIP on a follow-up with a proper vfio-selftests style
test based on this -- this won't be part of this series.)

This code has been tested in mapping DMABUFs of single/multiple ranges
from multiple BARs, aliasing mmap()s, aliasing ranges across DMABUFs,
vm_pgoff > 0, revocation, shutdown/cleanup scenarios, and hugepage
mappings.  No regressions observed on the VFIO selftests, or on our
internal vfio-pci applications.  VFIO on i386 has been build-tested.
Thanks to Alex Mastro for building a (WIP) testcase for the
prior mmap_lock->memory_lock issue.


END
===

This is based on v7.3-rc6

These commits are on GitHub for easier browsing, along with
"[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":

https://github.com/evansm7/linux/compare/v7.3-rc6...dev/mev/vfio-dmabuf-mmap-v8

Also please see...

https://lore.kernel.org/all/f8efaabd-c06e-4f04-8cfa-489c148e37ba@ozlabs.org/
("[PATCH] dma-buf: Annul dmabuf->file on file release")

...which fixes a stale file pointer issue that could affect VFIO's
DMABUF export.  Although the issue exists prior to this series, the
addition of another dmabuf->file dereference adds additional
unpleasant failure modes (for example, unmap_mapping_range() the wrong
file, or good old random data dereference, etc.)


Thanks for reading,


Matt



================================================================================
Changelog:

v8:

 - Rebased, on v7.3-rc6

 - "dma-buf: Provide dma_buf_set_name()": Comment and "DOC: locking
   convention" updates.  dma_buf_set_name() is is listed in the "do
   not hold resv" category

v7:	https://lore.kernel.org/all/20260924152159.49702-1-matt@ozlabs.org/
v6:	https://lore.kernel.org/all/20260911214200.33793-1-matt@ozlabs.org/
v5:	https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/
v4:	https://lore.kernel.org/all/20260701171245.90111-1-matt@ozlabs.org/
v3: 	https://lore.kernel.org/all/20260610154327.37758-1-matt@ozlabs.org/
v2: 	https://lore.kernel.org/all/20260527102319.100128-1-mattev@meta.com/
v1: 	https://lore.kernel.org/kvm/20260416131815.2729131-1-mattev@meta.com/
RFCv2:	https://lore.kernel.org/kvm/20260312184613.3710705-1-mattev@meta.com/
RFCv1:	https://lore.kernel.org/all/20260226202211.929005-1-mattev@meta.com/
Tech topic: https://lore.kernel.org/linux-iommu/20250918214425.2677057-1-amastro@fb.com/

Matt Evans (9):
  vfio/pci: Remove DMABUF export dependency on vdev->memory_lock
  vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume
  dma-buf: Provide dma_buf_set_name()
  vfio/pci: Add a helper to look up PFNs for DMABUFs
  vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
  vfio/pci: Convert BAR mmap() to use a DMABUF
  vfio/pci: Clean up BAR zap and revocation
  vfio/pci: Support mmap() of a VFIO DMABUF
  vfio/pci: Revoke a DMABUF on request from userspace

 drivers/dma-buf/dma-buf.c                     |  84 ++-
 drivers/vfio/pci/Kconfig                      |   4 +-
 drivers/vfio/pci/Makefile                     |   3 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  14 +-
 drivers/vfio/pci/vfio_pci_config.c            |  30 +-
 drivers/vfio/pci/vfio_pci_core.c              | 222 +++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 609 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h              |  54 +-
 include/linux/dma-buf.h                       |  16 +-
 include/linux/vfio_pci_core.h                 |   3 +
 include/uapi/linux/vfio.h                     |  24 +
 11 files changed, 870 insertions(+), 193 deletions(-)

-- 
2.47.3

