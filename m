Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794A4570D1;
	Fri, 11 Sep 2026 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162945; cv=none; b=Y3kT6JKtgXqBiqPuoBeT0hwCVjn1jJBi3sUOoJJBOYH3FxkLrIimKMdB8jCsx6sMlJ8B28nfhNHESjV5Je3BgeQEZLh9yBtK8AKTgO3sTMLzoUF3N/O2WB+4JAN43Q2kZY5SNYrU0pR2sWph4jl82agUFD3Bsny5Jg1DqZ3dSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162945; c=relaxed/simple;
	bh=L4RuR8y2djty0eIoPifL/2u394+JklYinyWyQ5Pdhuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJVcX+E+rsO5cGebcM558ekTlywVR7osZmNfvwBzC4t9BAal6pqUy8AgPHBJodZJ3QTfd5q6wlAyAF2+mMZomRHIufy6k3R5cig+hQ+jbI+Qio6V0ogCs+LFv2DZrf3X+vqJI78E86tXM9f0anLAV2cvm2VHL4ASD0Dhzq+ubs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=v3iWZWQB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="v3iWZWQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789162921;
	bh=QuwLIzRAehYf76xWlDPh8mBvOF9JpERaXnMT/TZFFCE=;
	h=From:To:Cc:Subject:Date:From;
	b=v3iWZWQBoIZ8KorqiEZb+3twWgBG4r0kxdLX03CUdVAMBTFAyYNvB/pc0fs1ipxzQ
	 sF0fZPopnwGldDcFOzGvdD016yFLtAN7Q73/toWei9iL+/EJtBtMlGlep54N4axP1p
	 1cL2eKCHSW+llXdGu8RukGqEx/c86PJoFrJHN/bcrOvEjHFWc6YyvnQrx6HPMi6cwg
	 pGNPk2pitOqTt2caMkQi7nhnz3FLEUK64Z8nZZYoIu90HcahfBVPhNAtuTPzyO7Z2O
	 YH0O+IG9zD8lkPxoUvgkDEbq5pgWVfyuCdzkuUtkyZGfhRIsfd+iptT//y2gstKCOt
	 61xT5AA62XfHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hhSg92Vwpz4wSj;
	Sat, 12 Sep 2026 07:41:56 +1000 (AEST)
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
Subject: [PATCH v6 0/9] vfio/pci: Add mmap() for DMABUFs
Date: Fri, 11 Sep 2026 22:41:48 +0100
Message-ID: <20260911214200.33793-1-matt@ozlabs.org>
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

Reviews requested that we migrate the existing VFIO PCI BAR mmap() to
be backed by a DMABUF too, resulting in a common vm_ops and fault
handler for mmap()s of both the VFIO device and explicitly-exported
DMABUFs.  This will help future iommufd emulation of VFIO Type1
peer-to-peer, making it easier to get a DMABUF for a VFIO BAR as a DMA
target.

mmap() conversion to use DMABUF underneath has been done for vfio-pci,
but not sub-drivers:

  nvgrace-gpu's mmap() override path is unchanged; I kept this out of
  scope for now not least because I don't have a thorough test setup
  for this system.  I would prefer to help the nvgrace-gpu maintainers
  enable BAR mmap() DMABUFs themselves.


Notes on patches
================

 vfio/pci: Remove DMABUF export dependency on vdev->memory_lock

   In v5 of this series [1] we discover that doing an export from the
   VFIO mmap() path (fundamental!) adds a dependency between mmap_lock
   and vdev->memory_lock(W) because export was using memory_lock(W) to
   protect the vdev->dmabufs list and state within, and a deadlock
   scenario leapt out to bite.  (Details in [1].)

   The suggestion was to add a dedicated mutex/rwsem specifically for
   the DMABUFs/list, which is cleaner than overloading memory_lock(W).

   But whilst export could now downgrade to holding memory_lock just
   for _read_ to test __vfio_pci_memory_enabled(), a very similar
   deadlock can still arise due to a memory_lock(W) elsewhere
   depending on a prior memory_lock(R) to be released, and attempting
   to take memory_lock(R) will queue behind the (W) for fairness
   (effectively an R->R dependency).  I'd overlooked that rwsem cannot
   guarantee multiple readers.

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
   vfio_pci_core_runtime_resume().  This removes a window in which a
   waking waiter could have observed the DMABUF state as still revoked
   (or pm_runtime_engaged = true).  (The UAPI docs state the event
   means the resume's complete, so observing otherwise seemed
   unintended.)

   Also, when DMABUFs are later mmap()ed, a waiter waking and taking a
   fault could have seen the unrevoked state and SIGBUS just before
   taking the memory_lock.  (If the handler gets to acquire the lock,
   though, the resume sequence is complete, and the handler observes
   pm_runtime_engaged = false.)

   This fix is in this series because the issue will impact CPU access
   to the VMA as well (once they use DMABUFs), and so it's a strict
   dependency of later commits.


 dma-buf: Export dma_buf_set_name()

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
   is installed with the new dma_buf_set_name() above.  An alternative
   would be to add a creation-time name field to struct
   dma_buf_export_info, but a setter function is more useful: the name
   can be changed at will after init.


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
mmap_lock->memory_lock issue (which is now OK...).


Dear Reviewers,
===============

There was a lot of finessing v5->v6, all patches had
fixes/changes/cleanups/rewordings made, and so I have dropped previous
R-B tags.

Along the way several related issues came up that warrant more
eyes, and I'd be grateful for your input:

1. The mmap fault handler takes a bunch of locks non-interruptibly,
   and potentially depends on a lot of DMABUF-related activities
   completing.  I had a go at converting them to
   interruptible/killable forms, but pulling on the thread revealed
   there seems to be a wider issue if move/revoke doesn't complete in
   a timely fashion (due to buggy importers).  Where I got to was that
   just updating the fault handler won't fix the user experience of an
   unkillable task, and move()/revocation will need thought too.  I
   don't intend to fix this here but wanted to start discussion so we
   can address it in a follow up.  There's now a dependency between
   mmap_lock in the fault handler and the DMABUF resv (which might
   take a while to resolve).

2. vfio_basic_config_write() has an error path if
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

3. The exchange of a VFIO fd mmap()'s vma->vm_file with an implicitly
   created DMABUF's file has implications on LSM.  For example, an
   mmap will be checked against the policy for a VFIO fd, but a
   subsequent mprotect() relates to the DMABUF file's policy (which is
   anon/unique to the mapping).  This is pretty confusing.

4. If VFIO fd is opened O_RDONLY, it currently can't be mmap()ed
   (because PROT_WRITE is rejected in do_mmap(), and PROT_READ alone
   drops the VM_SHARED so VFIO's mmap rejects it).  But it seems we
   can export a DMABUF from it, and then pass the resulting fd around
   for P2P writes.

   I don't know if this is intentional, relied on, or a known
   limitation so haven't included a change here, but:

    a) We could reject export unless the device fd's f_mode has
       O_RDWR, to reflect the abilities of P2P

    b) Or, instead of just failing if !O_RDWR, we limit the
       get_dma_buf.open_flags to the VFIO device fd's f_mode, such as:

       VFIO device fd perms:    Export flags:           Result:
       O_RDWR                   O_RDWR, O_RDONLY        OK
       O_RDONLY                 O_RDONLY                OK
       O_RDONLY                 O_RDWR                  -EPERM
       O_WRONLY                 *                       -EPERM
       *                        O_WRONLY                -EPERM

      (Skipping WRONLY because a PROT_WRITE-only mmap() won't work,
       though it probably should be included for P2P.)

   If we can do at least (a) that seems good, because the knock-on
   effect in this series is that we can export a DMABUF RW from an
   O_RDONLY device fd and then succeed to mmap() the DMABUF with RW.
   (That said, even if one has an O_RDONLY device fd, the device state
   can still be changed/reset.  But it feels cleaner to least prevent
   export for a O_RDONLY device fd, and match the device fd mmap()
   behaviour.)

   Maybe (b) is step 2: Allowing finer-grained RD/WR could be useful
   if there's a future goal to tie DMABUF permissions to, say, iommufd
   IOMMU_READ/IOMMU_WRITE permissions.  I don't htink this is in place
   today, apologies if I'm missed something.


END
===

This is based on v7.2.

These commits are on GitHub for easier browsing, along with
"[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":

https://github.com/metamev/linux/compare/v7.2...dev/mev/vfio-dmabuf-mmap-v6


Thanks for reading [this astonishingly-long cover letter],


Matt

[1] https://lore.kernel.org/kvm/9a615f22-c0d4-46ae-9654-db11e94e5fec@ozlabs.org/


================================================================================
Changelog:

v6:

 - Dropped patches:
  PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()
  PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE

 - New patch, "vfio/pci: Remove DMABUF export dependency on vdev->memory_lock":

  memory_lock was overloaded to protect the vdev->dmabufs list, the
  entries' revoked status, etc.  Towards the goal of not needing
  memory_lock in export (so not creating a mmap_lock -> memory_lock
  dependency due to exporting from mmap()), add a new
  vdev->dmabuf_lock which protects the list and (writing) the
  revocation status.  (See details in cover letter.)

 - New patch, "vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume":

  Bugfix, as the resume path didn't un-revoke.  Previously affected
  "only" P2P, but since DMABUFs-everywhere it would affect BAR mmap()s
  too.

 - New patch, "dma-buf: Export dma_buf_set_name()":

  Change in dma-buf.c's dma_buf_set_name() to take a kernel-allocated
  string.  The original IOCTL-related path wraps this to strdup the
  user string first.

 - "vfio/pci: Add a helper to look up PFNs for DMABUFs":

  Commit message reworded explaining vma_pgoff_adjust, return -ERANGE
  for (non-transient) pagesize failure instead of -EAGAIN.  Add
  dmabuf_lock annotation and assert that the DMABUF isn't revoked
  (else new -ENODEV error), using a new vdev parameter (caller is
  expected to safely extract it from priv).

  Significant bugfix in the case of a VMA offset exceeding the 1TB
  stride between VFIO_PCI_OFFSET_MASK-sized regions, which would have
  silently wrapped due to being masked to 1TB.  This is fixed by
  including the VFIO region index in the high bits of vma_pgoff_adjust
  for the traditional mmap() path, so the subtraction from
  vma->vm_pgoff in ...find_pfn() removes the region index without
  masking.  For the DMABUF mmap() path, vma_pgoff_adjust = 0 and
  (thanks to no masking) large offsets can be used.

 - "vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA":

  Now permits a NULL p2pdma provider to be installed in the
  vfio_pci_dma_buf.  The regular BAR mmap() path doesn't need a
  provider for CPU access; the DMABUF backing the VMA exists primarily
  for the CPU, and removing this check decouples vfio-pci from
  depending on CONFIG_PCI_P2PDMA (_without_ going through the previous
  hoops of splitting up P2PDMA into a _CORE subset to provide the
  provider).

  Only DMABUF import/map needs a provider, which is available when
  P2PDMA is available; the previous series' first two patches (to
  always provide a provider) are now unnecessary and have been
  dropped.

  Squashed "vfio/pci: Provide a user-facing name for BAR mappings"
  into this patch, because it's now just very small due to the new
  dma_buf_set_name().  Comment that, because of careful construction
  of the name length, the setting of the name can't fail; but in case
  assumptions change, a check/kfree prevents it leaking.  (A new error
  path doing full unwind of the DMABUF creation is overkill.)

 - "vfio/pci: Convert BAR mmap() to use a DMABUF":

  Instead of the previous dropped P2PDMA split commits, allows
  pcim_p2pdma_provider() to return NULL if !CONFIG_VFIO_PCI_DMABUF
  (meaning !CONFIG_PCI_P2PDMA).  The provider isn't used unless the
  DMABUF is imported; prevent import to make this fail early (rather
  than at map), by creating an always-fail vfio_pci_dma_buf_attach()
  stub.  (Somewhat belt and braces, but makes clear you need P2PDMA to
  import a BAR VMA's DMABUF!)

 - "vfio/pci: Clean up BAR zap and revocation":

  The zap_bars_on_revoke flag is moved back to the bitfield, and is
  set from vfio_pci_core_init_dev() (instead of registration time).
  Reworked the hisi driver change to update this earlier.

 - "vfio/pci: Support mmap() of a VFIO DMABUF":

  Previous versions introduced a build issue (which was fixed by the
  next patch) due to a READ_ONCE of the priv->revoked bitfield member;
  removed.  It is added by the next patch in the series
  (s/revoked/status/).

  Added an explicit rejection for mmap of a DMABUF with
  vma_pgoff_adjust > 0.  Such buffers can only be created implicitly
  by the VFIO BAR mmap path, and an fd can't currently be recreated
  from a VMA (e.g. fished out of /proc/pid/map_files) because the anon
  inode ops don't support open.  But check added if a future mechanism
  arises and for clarity.  Rejecting an mmap of a DMABUF fd having
  vma_pgoff_adjust > 0 means vfio_pci_dma_buf_find_pfn() doesn't need
  to cope with the case of vma->vm_pgoff < priv->vma_pgoff_adjust and
  underflow.

 - "vfio/pci: Permanently revoke a DMABUF on request":

  Clarified docs for returned error values; re-added
  READ_ONCE(priv->status) for unlocked reads in both
  vfio_pci_dma_buf_attach() and vfio_pci_dma_buf_mmap().


v5:     https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/
v4:     https://lore.kernel.org/all/20260701171245.90111-1-matt@ozlabs.org/
v3:     https://lore.kernel.org/all/20260610154327.37758-1-matt@ozlabs.org/
v2:     https://lore.kernel.org/all/20260527102319.100128-1-mattev@meta.com/
v1:     https://lore.kernel.org/kvm/20260416131815.2729131-1-mattev@meta.com/
RFCv2:  https://lore.kernel.org/kvm/20260312184613.3710705-1-mattev@meta.com/
RFCv1:  https://lore.kernel.org/all/20260226202211.929005-1-mattev@meta.com/
Tech topic: https://lore.kernel.org/linux-iommu/20250918214425.2677057-1-amastro@fb.com/


Matt Evans (9):
  vfio/pci: Remove DMABUF export dependency on vdev->memory_lock
  vfio/pci: Un-revoke DMABUFs in LOW_POWER_ENTRY_WITH_WAKEUP resume
  dma-buf: Export dma_buf_set_name()
  vfio/pci: Add a helper to look up PFNs for DMABUFs
  vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA
  vfio/pci: Convert BAR mmap() to use a DMABUF
  vfio/pci: Clean up BAR zap and revocation
  vfio/pci: Support mmap() of a VFIO DMABUF
  vfio/pci: Permanently revoke a DMABUF on request

 drivers/dma-buf/dma-buf.c                     |  58 +-
 drivers/vfio/pci/Kconfig                      |   4 +-
 drivers/vfio/pci/Makefile                     |   3 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  14 +-
 drivers/vfio/pci/vfio_pci_config.c            |  30 +-
 drivers/vfio/pci/vfio_pci_core.c              | 222 +++++--
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 607 +++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h              |  54 +-
 include/linux/dma-buf.h                       |   2 +
 include/linux/vfio_pci_core.h                 |   3 +
 include/uapi/linux/vfio.h                     |  24 +
 11 files changed, 851 insertions(+), 170 deletions(-)

-- 
2.50.1 (Apple Git-155)

