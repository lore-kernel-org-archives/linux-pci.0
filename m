Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760608;
	b=b9IpV8w9Dj0O3eu8Lq7h+nX7voPE/tCthAWhryqJU7sTlunfYRiES7wDoYWYlWP85OET
	 hgmnPjrajuww6nE1JvOWPiujXRJKFedhxfM2C8ApetPKYA3PglsdShAg4GtEJPFg7L3sX
	 q30i6UOOKD+UroC1lLG0lTxbagosZ1ukzvU3KbYZFVrqH5S49SWxvE9SlXrOKZ/V3ISPP
	 nHlKKMVXbS4nj4Dy44JKLI4DFobBksklGQAoFkMHlbEk7aHgO+ObUZWTc1ovzgTF3GQ/K
	 +mub2LgI6H4DNZzcoJJpHZnzKlszdwWasfweXgIgEXVY9Fbo8EmIxelRTRQf5oYQ94Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760608;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Mk+aeTZExqTm3OSQiwVPEtQaTQx1bXWlHZmFmi0Xo4A=;
	b=R1YnWgsDp1y4060cND2WMbt/ztkb/B8tYZIu6UB2LNdf3MSpJ0On6jr4HDG6uxOOG5Qk
	 uen5AbsN7U7T6oExKdPkLEaC79Y4f5iHAi41e2mJ+Rsv4uzzuKNS/pOMRr8+xpVB4203t
	 5tKGIz5B2ea+2lGUGXtGOtp15r5wZ/2x/qFF8Qa4TfQ+ziOYJIJh/7GPibdKtmaMz+m+Z
	 ZjEIs94ne0/Z3qziIPewwV5fwdd4QEScP9WBsbHWnDsvTzc+7MOf9BsmGFGIF8seL4TrG
	 St++Epxx7e9Z7d2LdGWn64VvrEgAFz/qpCGAnmvp67/Nt8klswBgkNNFOpxWzG/MDyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b33BBRHi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73C606D81B;
	Wed,  4 Nov 2026 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b33BBRHi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760607;
	b=1FVPJ2no+7sLp9nG7BMHQr0ndBDOfaPdSTcApVynBUbKc9gKEFDSAEkzPMUhXjvapLXG
	 2g5o96oK44cStt/ihe4vjtk/8sn3P/Pf5QqJPssEqOGBtCIfjk05Ss5dSawZoL/xGmaYY
	 MPlIMFDqX/73leuFDQYjzGYpKq9SgBTMzZ7Nq7i+G/nazCTFCO7TiRMeT8xG3yqk8KWmN
	 RjIMn+J5pPhc+SFXlLXqXCSTvK/m7xRJJgkpIhi7+xIxT3QCgFXNQQp49PTy6+U1xDbzK
	 vYQveOQvMIdoVgCqwZXDi54gLw402soT3a8WausQz45Jlj0LKxwv3tJnRbgsq9cvShg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760607;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Mk+aeTZExqTm3OSQiwVPEtQaTQx1bXWlHZmFmi0Xo4A=;
	b=Wp4whmNklbj4bEykETY1ObDGCrMf0moT9JwXL7+xo0mF7Wp+TCgJ/WWXTkNr64wL2kSi
	 I0lzJ6UQfEB/SeEhzI+1PB5cVI5VSZshi6ZExX/a5dot0QlSNV8MklFsboPVQmO+oDm0H
	 d/vseHB2H1ZuncMjO1gb4eHJ8laKm7YSODnNMirATSrr47eXi/njUdtk/lBy25FiOH3e3
	 GDn2RhVqmN5lmHG5FT3vKyY4mPcGE0FfbIUi4W+QrWaTyldu1Hcyx9BYi1nkk+CbnQNgx
	 yMX0CSJNM06CXo5XkQTCr1I+fIG5vLg3ceW/TzaZGN4UffmjEEh2+X5hU7Dba2qOfWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D55811F00919;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760607;
	bh=Mk+aeTZExqTm3OSQiwVPEtQaTQx1bXWlHZmFmi0Xo4A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=b33BBRHiVfzNxbihR1L/xAe+laInYi8kJed+e/XqYlFe/aBP8Srv4afE2pXOA2L87
	 J6/0i+pjWpQTX9t9o1ZnRP9AQhx7dK8Siw7Gs1NQEsWr0HhP51Rwta2paaEjuF+6hQ
	 U1twVdismQszjaJejzwKpOea4SP0b21eB0T4j9OAiODvxYAGLEhcbJD2H+bWOks6Hk
	 zA74QBelha+OL1NAd1Jmvp+uuOjFnmjJy9C/sDetffs1WZT3/3m6cUE5bs2Xzm0vfH
	 sYEVBCDhxYMqYr+glyKYqLQgBAr4/msMGOaYfEo502buyaOMkm9JEgRHAm8j+0sclf
	 iFiekvWql1zrQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 317CF46BDE;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Subject: [PATCH v4 00/25] dmaengine: Smart Data Accelerator Interface
 (SDXI) basic support
Date: Tue, 03 Nov 2026 20:49:41 -0600
Message-Id: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13OzwrCMAwG8FeRnq0k/bN1nnwP8dA1qfagg1WGM
 vbuVkW2eQqB7/clo8jcJ85ivxlFz0PKqbuVxWw3Ilz87cwyUdmFAmXBoZaZHkm2PrOsNdWhiRT
 Y1qLkLynfu/75qRqwjONXNWAXakAJkkAb9Kga1fqDv9IudNd3RclXYBD+80joTGhtqGDOnwoY1
 O9OBRZx6VRxzjUhMmHNOq6dnl21/k8XZ0i74FVLMfLspml6AV4KTbMwAQAA
X-Change-ID: 20250813-sdxi-base-73d7c9fdce57
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=12419;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=KldG2upmtPUxMc8dQVKIJu9jBq3M7jusAuPXMST8IYk=;
 b=nTO+gpoLwZ2VLQN/WMJzM6M/liRcBKGgRzckIbB+4zDIEPaeSu6+ONyBkn8XsbGC9Aatbshjc
 aRFS6xb8NggAsEthrm8kNYJHrmjYXxmUi0a4LsqBctHJfZmb1sX7f+P
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

The Smart Data Accelerator Interface (SDXI) is a vendor-neutral
architecture for memory-to-memory data movement offload designed for
kernel bypass and virtualization.

General information on SDXI may be found at:
https://www.snia.org/sdxi

This submission adds a driver with support for PCIe-hosted SDXI 1.0
implementations and includes a DMA engine provider with memcpy
capability.

Planned future SDXI work (out of scope for this series):

* Character device for exposing SDXI contexts to user space.

* Support for operation types to be added in future SDXI revisions.

* Greater configurability for control structures, e.g. descriptor ring
  size.

The latest released version of the SDXI specification is 1.0:
https://www.snia.org/sites/default/files/technical-work/sdxi/release/SNIA-SDXI-Specification-v1.0a.pdf

Starting with v4 the driver has been authored and modified with LLM
assistance. The code has changed a lot in response to Sashiko reviews and
it's been a long time since the last revision, so I dropped all
Reviewed-by: tags.

---
Changes in v4:
- Restructure the series to introduce helpers and resource management
  before their first users, with separate patches for function
  preparation, submission queues, and synchronized context release.
  Introduce the PCI remove callback earlier so SR-IOV cleanup is
  present from the initial PCI support. (Tycho Andersen)
- Rework function stopping to handle already-stopped functions without
  issuing a reset, wait for transient states, and escalate stalled
  soft stops to hard stops. Fall back to PCI function reset; if that
  fails, disable bus mastering and make a bounded attempt to drain
  pending transactions. (Sashiko)
- Sanitize inherited MMIO configuration before installing new control
  structures: disable error logging, discard stale context and RKey
  tables, clear error-log state, and disable supported mailbox
  interrupts.
- Stop/reset the function on activation failure and before freeing
  client contexts during removal. (Sashiko)
- Restore dma_set_mask_and_coherent() error checking and reject devices
  lacking the 64-bit atomic MMIO capability. (Sashiko for DMA mask
  error checking)
- Use the device's advertised maximum buffer size for context
  configuration and the DMA maximum segment size.
- Consolidate each submission queue's descriptor ring, write index,
  and context status into one DMA-coherent allocation.
- Replace per-operation completion allocations with a fixed,
  context-owned pool whose claims are independent of ring reuse.
  Retain timed-out completion blocks until context teardown rather
  than freeing memory the device may still access. (Sashiko)
- Rework completion checking to distinguish pending, successful, and
  failed operations. Read the signal with READ_ONCE() and endian
  conversion, place dma_rmb() after observing the terminal signal,
  and use read_poll_timeout() for polling. (Sashiko)
- Replace reservation iterators with indexed slot access, add
  variable-size reservations, and bound blocking reservations with
  a killable timeout. (Sashiko for iterator and unbounded-wait issues)
- Add sdxi_cxt_submit() to consolidate completion attachment, fencing,
  valid-bit publication, and optional doorbell ringing. Derive
  doorbell values from the current context write index.
- Add context-update descriptor encoding. Require a stopped context
  and complete update/sync before releasing its control structures;
  retain its resources and ID until function teardown if release
  fails. (Sashiko)
- Rework DMA preparation to store copy parameters outside the ring.
  Acquire completion claims and reserve ring space only when issuing,
  then populate every reserved slot. This avoids ring holes when
  prepared transactions are discarded. (Sashiko)
- Issue DMA transactions in cookie order, batch copies behind shared
  fenced completion interrupts, and queue work when ring or completion
  capacity is unavailable.
- Keep tx_status() read-only and retire transactions in cookie order
  through a shared IRQ/synchronization reaper. Report observed
  completion errors through tx_result as DMA_TRANS_ABORTED. (Sashiko)
- Rework termination to cancel submitted and pending work and reap
  published transactions without callbacks. Synchronize by polling
  and reaping transactions, then always flush virt-dma callbacks,
  eliminating the synchronization NOP reservation. (Sashiko)
- Initialize the AKey IDA before fallible context allocations, and
  sample the writable dma_channels parameter once during provider
  setup. (Sashiko)
- Expand KUnit coverage for completion-pool ownership, variable-size
  ring reservations, and context-update encoding. Fix the ring test's
  double advance and the context-stop test's incorrect union field.
  Suppress expected input-validation WARNs under KUnit and remove
  the dead size clamp. (Sashiko)
- Link to v3: https://patch.msgid.link/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com

Changes in v3:
- Fix akey allocation error path in dma.c to return a proper
  error value. (Tycho Andersen)
- Disable SR-IOV in PCI removal. (TA)
- Update the Rust list of PCI class codes simultaneously with the C
  header. (Sashiko)
- Properly build the bus-agnostic core support as a separate
  module (sdxi-core) from the PCI driver (sdxi-pci). (Sashiko)
- Add dependency on CONFIG_64BIT to simplify assumptions around MMIO
  and control structure accesses. (Sashiko)
- Use readq/writeq instead of ioread64/iowrite64 since we don't need
  to handle port space. (Sashiko)
- Correct vector allocation range to ensure the error IRQ index (0) is
  reserved. (Sashiko)
- Fix context control block dma pool allocation failure
  check. (Sashiko)
- Ensure device is in stopped state before clearing MMIO_CTL0
  configuration during init. (Sashiko)
- Add explicit alignment attributes to packed control structure
  types. (Sashiko)
- Rename prep_memcpy_polled() to prep_memcpy_nointr(). (Frank Li)
- Link to v2: https://patch.msgid.link/20260511-sdxi-base-v2-0-889cfed17e3f@amd.com

Changes in v2:
- Drop unneeded dma_set_mask_and_coherent() result check. (Frank Li)
- Inline SDXI_DRV_DESC directly into MODULE_DESCRIPTION(). (FL)
- Drop unneeded braces from simple conditionals. (FL)
- Drop sdxi logging wrapper macros; use dev_dbg, dev_info etc
  directly. (FL)
- Reordering of commit message (patch 04, "Feature
  discovery..."). (FL)
- Use read_poll_timeout() for function start and stop routines. (FL)
- Align multi-line FIELD_PREP() uses. (FL)
- Drop sdxi_create_dma_pool() helper. (FL)
- Remove unneeded dma_wmb() before iowrite64() to doorbell. (FL)
- Use WRITE_ONCE() to update descriptor ring write index. (FL)
- Make sdxi_completion_poll() eventually time out and adjust call
  sites. (FL)
- Remove vestigial sdxi_dma_unregister() declaration. (FL)
- Reserve context ID before allocating context data structures instead
  of after.
- Update context ID class to transfer ownership of ID to context
  object; sdxi_free_cxt() now responsible for releasing ID once
  assigned.
- Align small frequently-updated DMA pool objects to cacheline
  boundaries.
- Drop redundant dma_set_mask_and_coherent() from DMA provider.
- Log unarchitected function status values in sdxi_dev_gsv().
- Remove sdxi_to_dev(); the abstraction is unnecessary and sdxi->dev
  is shorter.
- Link to v1: https://patch.msgid.link/20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com

Changes in v1:
- Reorder series and introduce functionality incrementally while
  remaining buildable and functional at each step. (Jonathan Cameron)
- Use devres APIs where possible for device resources (JC)
- Use cleanup APIs to significantly reduce use of goto-oriented error
  unwinding. (JC)
- Drop SDXI_DEBUG config option. (JC)
- Cite SDXI spec version and section number consistently throughout. (JC)
- Combine local variable declarations of same type. (JC)
- Mark descriptor structs __packed. (JC)
- Use designated initializers in descriptor encoding functions. (JC)
- Prefer dev_err_probe() over sdxi_err() in sdxi_pci_init(). (JC)
- Prune unnecessary includes throughout source files. (JC)
- Remove unnecessary/unhelpful comments in several places. (JC)
- Remove SDXI spec material from "Add SNIA SDXI accelerator sub-class"
  commit message and reword the remainder. (Bjorn Helgaas)
- Remove unnecessary local for DMA_BIT_MASK() argument in
  sdxi_pci_init(). (BH)
- Use "{ }" for final null entry in id table, not "{ 0, }". (BH)
- Replace sample descriptor submission code from the SDXI spec with an
  improved API that has unit tests, eliminates a copy step for
  callers, and can block until ring space becomes available if
  desired.
- Omit the error log facility for now; it can be reintroduced later.
- Use a per-device xarray to allocate context IDs and map them to
  context objects.
- Implement interrupt-based completion signaling for memcpy operations
  in the DMA engine provider, DMA provider code mostly rewritten.

- Link to RFC: https://lore.kernel.org/r/20250905-sdxi-base-v1-0-d0341a1292ba@amd.com

---
Nathan Lynch (25):
      PCI: Add SNIA SDXI accelerator sub-class
      MAINTAINERS: Add entry for SDXI driver
      dmaengine: sdxi: Add PCI initialization
      dmaengine: sdxi: Prepare function and sanitize MMIO state
      dmaengine: sdxi: Feature discovery and initial configuration
      dmaengine: sdxi: Configure context tables
      dmaengine: sdxi: Allocate context control DMA pool
      dmaengine: sdxi: Introduce submission queue
      dmaengine: sdxi: Allocate administrative context
      dmaengine: sdxi: Install administrative context
      dmaengine: sdxi: Start functions on probe, stop on remove
      dmaengine: sdxi: Add client context allocation API
      dmaengine: sdxi: Add descriptor ring management
      dmaengine: sdxi: Add unit tests for descriptor ring reservations
      dmaengine: sdxi: Per-context access key (AKey) table entry allocator
      dmaengine: sdxi: Add completion status block API
      dmaengine: sdxi: Add unit tests for completion pool ownership
      dmaengine: sdxi: Add context submission helper
      dmaengine: sdxi: Encode context start, stop, update, and sync descriptors
      dmaengine: sdxi: Add client context release with update and sync
      dmaengine: sdxi: Provide context start and stop APIs
      dmaengine: sdxi: Encode copy and interrupt descriptors
      dmaengine: sdxi: Add unit tests for descriptor encoding
      dmaengine: sdxi: MSI/MSI-X vector allocation and mapping
      dmaengine: sdxi: Add DMA engine provider

 MAINTAINERS                         |   7 +
 drivers/dma/Kconfig                 |   2 +
 drivers/dma/Makefile                |   1 +
 drivers/dma/sdxi/.kunitconfig       |   4 +
 drivers/dma/sdxi/Kconfig            |  40 +++
 drivers/dma/sdxi/Makefile           |  17 ++
 drivers/dma/sdxi/completion.c       | 189 ++++++++++++
 drivers/dma/sdxi/completion.h       |  52 ++++
 drivers/dma/sdxi/completion_kunit.c | 131 ++++++++
 drivers/dma/sdxi/context.c          | 589 ++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h          | 122 ++++++++
 drivers/dma/sdxi/descriptor.c       | 220 ++++++++++++++
 drivers/dma/sdxi/descriptor.h       | 145 +++++++++
 drivers/dma/sdxi/descriptor_kunit.c | 537 ++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/device.c           | 473 +++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.c              | 509 +++++++++++++++++++++++++++++++
 drivers/dma/sdxi/dma.h              |  11 +
 drivers/dma/sdxi/hw.h               | 257 ++++++++++++++++
 drivers/dma/sdxi/mmio.h             |  85 ++++++
 drivers/dma/sdxi/pci.c              | 153 ++++++++++
 drivers/dma/sdxi/ring.c             | 143 +++++++++
 drivers/dma/sdxi/ring.h             |  94 ++++++
 drivers/dma/sdxi/ring_kunit.c       | 147 +++++++++
 drivers/dma/sdxi/sdxi.h             | 138 +++++++++
 drivers/dma/sdxi/submission.h       |  66 ++++
 include/linux/pci_ids.h             |   1 +
 rust/kernel/pci/id.rs               |   1 +
 27 files changed, 4134 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20250813-sdxi-base-73d7c9fdce57

Best regards,
--  
Nathan Lynch <nathan.lynch@amd.com>


