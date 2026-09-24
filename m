Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6EF3CE083;
	Thu, 24 Sep 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263340; cv=none; b=NqsV2xARnKq0Bi32Gc4dEhL0b0kTKYOiTaNRRdhG4cmXWBS+vZi9+sm4iNqHEVYd9VnY/ZYs9mT+Q7SCJCI9EOf/aHBj1LS4738/M72FSD5u4WWvEjH2XSPXgqszMrOc87LuKY7e3/SUIYtcqhHo/rxeWTOMbvVGHOG6irrA0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263340; c=relaxed/simple;
	bh=Z3xM5PeNRSVo6/67PqjMG5c2zx3cZmMjT45zFAV1z1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nd7kK/2n3JPEtYlBwUkDEoTZJY5f0kWutXjUaD7Du5idvuIKszW188Xt6NVBI6tllF0Wy0gmxB3MGESaynrP+ntYx1V4hDKAjaLlxR9LjxBG9JpWx5REOSJqGDQfHbYFmgYkPATjI8F/Sci6ZfxCLlc/43ynk3vT2Ty5cvWxo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=NmnNbN2b; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NmnNbN2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790263309;
	bh=9wjRblY2EBycMLFEydcvLOxLLDg4lrT0/3lskxRRua4=;
	h=From:To:Cc:Subject:Date:From;
	b=NmnNbN2bzKbXo5UHUTwQo1p15PxNWiRailKBPbzL3XE1z2z2qY6Q9Zed18atLCrMv
	 SfbhPVEYE6RFKb/nk53Ej73VX1Bk/hc5tkcOC5ysTy8jSpGI1PqWbMMxoiCj/bVU5z
	 8CIBp5n7pcKsgbh9vQtE874akqgKli99UydThO6oelGkJhzqVYln2fQ2gk2bgAxerc
	 N+sddqAK/rR6KC9f0nZCX+3B+GtO+mUsUfT2ekMnpbwh4ycWKGDP+InPpLIGGLOQQm
	 kNr2Acqs7S5EmARyM3QseZxMLeo16rkwpfG814NWNlBOXbSSrxQUaZTYEz6PoE7QTB
	 sKmF1L5upa8aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHcW2r4gz4wFP;
	Fri, 25 Sep 2026 01:21:46 +1000 (AEST)
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
Subject: [PATCH v7 0/9] vfio/pci: Add mmap() for DMABUFs
Date: Thu, 24 Sep 2026 16:21:43 +0100
Message-ID: <20260924152159.49702-1-matt@ozlabs.org>
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
processes by fd.  This is achieved by allowing the processes to mmap()
the DMABUFs; their access to the device is isolated to the exported
ranges.  The primary userspace driver process can forcibly revoke
access to previously-shared buffers upon cleanup (without requiring
cooperation from the subordinate processes).  This is an improvement
on sharing the VFIO device fd to subordinate processes, which would
allow global access.  See the RFCs for background.

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
but not sub-drivers: nvgrace-gpu's mmap() override path is unchanged;
I kept this out of scope for now not least because I don't have a
thorough test setup for this system.  I would prefer to help the
nvgrace-gpu maintainers enable BAR mmap() DMABUFs themselves.


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


Dear Reviewers,
===============

Along the way several related issues came up that warrant more
eyes, and I'd be grateful for your input:

1. If VFIO fd is opened O_RDONLY, it currently can't be mmap()ed
   (because PROT_WRITE is rejected in do_mmap(), and PROT_READ alone
   drops the VM_SHARED so VFIO's mmap rejects it).  BUT it seems we
   can export a DMABUF from it, and then pass the resulting fd around
   for P2P writes.

   I don't know if this is intentional/relied on/a known limitation,
   or a bug?

   a) We could reject export w/ -EPERM unless the device fd's f_mode
      has O_RDWR, to reflect the RW abilities of P2P

   If we agree it's a bug, I want to do this fix (a), as we can now
   export a DMABUF RW from an O_RDONLY device fd and then succeed to
   mmap() the DMABUF with RW.  (That said, even with an O_RDONLY
   device fd, the device state can still be changed/reset.  But it
   feels cleaner to prevent export for a O_RDONLY device fd, and match
   the device fd mmap() behaviour.)

   In future, we could consider finer-grained RD/WR if there's a
   future goal to tie DMABUF permissions to, say, iommufd
   IOMMU_READ/IOMMU_WRITE permissions:

   b) Instead of just failing if !O_RDWR, we could limit the
      get_dma_buf.open_flags to the VFIO device fd's f_mode, such as:

       VFIO device fd perms:    Export flags:           Result:
       O_RDWR                   O_RDWR, O_RDONLY        OK
       O_RDONLY                 O_RDONLY                OK
       O_RDONLY                 O_RDWR                  -EPERM
       O_WRONLY                 *			-EPERM
       *                 	O_WRONLY                -EPERM

     (Skipping WRONLY because a PROT_WRITE-only mmap() won't work,
      though it probably should be included for P2P.)

2. The mmap fault handler takes a bunch of locks non-interruptibly,
   and potentially depends on a lot of DMABUF-related activities
   completing.  I'd had a go at converting them to
   interruptible/killable forms, but that revealed there seems to be a
   wider issue if move/revoke doesn't complete in a timely fashion
   (due to buggy importers).  Where I got to was that just updating
   the fault handler won't fix the user experience of an unkillable
   task, and move()/revocation will need thought too.  I don't intend
   to fix this here but wanted to start discussion so we can address
   it in a follow up.  There's now a dependency between mmap_lock in
   the fault handler and the DMABUF resv (which might take a while to
   resolve), though revocation will be rare in practice.

3. vfio_basic_config_write() has an error path if
   vfio_default_config_write() fails that releases memory_lock but
   doesn't un-revoke BARs in the case of PCI_COMMAND.MSE being
   cleared.  When can the write fail, in practice, perhaps surprise
   removal?

   The effect on this series would be: a write of MSE=0 revokes BARs,
   vconfig[PCI_COMMAND]'s MSE becomes 0, but if the physical write
   fails then the physical MSE remains 1 and BAR VMAs stay revoked.

   This seemed a mess; fixing isn't as simple as un-revoking on the
   error path since vfio_default_config_write() has already trampled
   vconfig so that'd need unwinding.  It felt like a catastrophic
   scenario where BARs staying revoked isn't a bad outcome, but want
   to hear your experience of the likelihood of this issue.

4. The exchange of a VFIO fd mmap()'s vma->vm_file with an implicitly
   created DMABUF's file has implications on LSM.  For example, an
   mmap will be checked against the policy for a VFIO fd, but a
   subsequent mprotect() relates to the policy of the DMABUF file
   (which is anon/unique to the mapping).  This is pretty confusing.


END
===

This is based on v7.3-rc4

These commits are on GitHub for easier browsing, along with
"[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":

https://github.com/metamev/linux/compare/v7.3-rc4...dev/mev/vfio-dmabuf-mmap-v7

Thanks for reading,


Matt

================================================================================

Changelog:

v7:
 - Rebased, v7.3-rc4

 - "dma-buf: Export dma_buf_set_name()" is now "dma-buf: Provide
  dma_buf_set_name()": reworded commit message with rationale, and
  indicate it is only expected to be used by exporters.  Remove static
  helper for user ioctl & copy from user inline in the ioctl.

 - "vfio/pci: Permanently revoke a DMABUF on request" is now
  "vfio/pci: Revoke a DMABUF on request from userspace", with a
  clarified commit message, and removal of "temporary/permanent"
  language.  This still replaces the priv->revoked flag with an
  enum/third state, named OK/REVOKED for the existing two.  The new
  state, DEAD, is "sticky" from the VFIO-internal perspective, meaning
  it prevents any of the move-style transitions from REVOKED back to
  OK, guaranteeing that a DEAD buffer cannot ever be attached/mapped
  by a new or existing importer.  Clarified language around attach vs
  map to not imply a racing import will be detached; it might attach,
  but cannot map (and has no existing maps) after the ioctl returns.

 - Reworded several commit messages for more clarity/brevity.

 - "vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA":
  As of the recent e8efdf02d3a97 ("vfio: Enable cdev noiommu mode
  under iommufd") dev_name() can be much larger
  (e.g. noiommu_vfio1048575) and the discovery that
  drivers/pci/controller/vmd.c (others?) could create a domain up to
  MAX_INT means there isn't a nice way to guarantee a debug name is
  available across all cdev names and maximum sizes of all properties
  (e.g. 1M cdevs, 4G domains).  So, removed the cdev name from the
  debug name construction, which now looks like 'vfio:0001:02:03.4/5'.
  The cdev can be fished out of sysfs given the domain+BDF, and it's
  still useful debug.  Adjusted comments & commit message.

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

 drivers/dma-buf/dma-buf.c                     |  78 ++-
 drivers/vfio/pci/Kconfig                      |   4 +-
 drivers/vfio/pci/Makefile                     |   3 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  14 +-
 drivers/vfio/pci/vfio_pci_config.c            |  30 +-
 drivers/vfio/pci/vfio_pci_core.c              | 222 +++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 609 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h              |  54 +-
 include/linux/dma-buf.h                       |   2 +
 include/linux/vfio_pci_core.h                 |   3 +
 include/uapi/linux/vfio.h                     |  24 +
 11 files changed, 856 insertions(+), 187 deletions(-)

-- 
2.50.1 (Apple Git-155)

