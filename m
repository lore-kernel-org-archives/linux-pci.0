Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA9322C73;
	Tue, 14 Jul 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051648; cv=none; b=IIfT0tSrxF5Y/kv9fOyAqtf305+iISuzmCKkShT1DtcYWwKyNI/DcalkV6abTflNa/siGtDNTm6hrOb5rVHYkw4X4z9bQEl+XUmrXuCW2Tw0qtE2XW29oFGLR13KDxfYiP/Om6dIus6X29gntzZeaMwO0z+WukhTaRvcckoNcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051648; c=relaxed/simple;
	bh=F8YAPz3YJMrpervYmcEjkztcnjnSo9TzyEJnuDY/XfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF1n95bNRpHZwajiJs1swzA25cMiqD7EYg0U52IObc2UuKY9FR8naqrnJ8jNIpzK1RA68gaDW3N5iS5wvA1jmHwsN7BmJuLbGIRS4HOsdBv2rtQBKOjLe2hcAewdLZp473dCeQv/xFSbJWMYhjAQBR73zQ3MGt/KaOog07yNox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z2GqdmU5; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z2GqdmU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1784051641; x=1815587641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlfdqCBExmqnMvSIl+ICBRF9OZWN9GRMQv3KWNjGbBQ=;
  b=Z2GqdmU5+kO1o+nlz6trgWZUf/bTDTLwcvwASHUA09PyhHV7yZWyRXcq
   LaaD282DOfL5epztedVW0nqmUTG13FmzCzL2Nk83BIojEtTgXb/pi5vuH
   QSY44RTV+BJNty9Ule9VQAsBj35NEGEDrghoza/Bfuoqg+JtwyV9P2XkM
   dSod6pRAtQbLixLmIBvCAgS5zCo4ixqiBCUX0p7dQmzKCAA3w/TUuzbPM
   tJ+qIvizk8qceGOJEqzW8deegIcS5YXM7X5frXCjsj6zJvL2zvYjVHH+V
   IGp2z8l4NAhdVu1izU5gJZ8LeZoesdX2SPx3znhtk/i6zi4uT+9JkGXgx
   w==;
X-CSE-ConnectionGUID: vjc118hQR6axuexBuFgdQA==
X-CSE-MsgGUID: gWfPtDZBReqICramdXmWhA==
X-IronPort-AV: E=Sophos;i="6.25,164,1779148800"; 
   d="scan'208";a="23551570"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:53:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:21509]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525] with esmtp (Farcaster)
 id 47a947d0-5997-4d35-96a5-b22b2913611b; Tue, 14 Jul 2026 17:53:57 +0000 (UTC)
X-Farcaster-Flow-ID: 47a947d0-5997-4d35-96a5-b22b2913611b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 17:53:57 +0000
Received: from uc3bb594dafa956.fritz.box (10.1.213.26) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 14 Jul 2026 17:53:55 +0000
From: hangej <hangej@amazon.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dwmw2@infradead.org>, <kexec@lists.infradead.org>, <hangej@amazon.com>
Subject: [PATCH v3] pci_crash: capture PCI config space at panic time
Date: Tue, 14 Jul 2026 19:53:02 +0200
Message-ID: <20260714175305.2783480-1-hangej@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521223010.2681515-1-hangej@amazon.com>
References: <20260521223010.2681515-1-hangej@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Johannes Hange <hangej@amazon.com>

When a system crashes and kexec boots into the crash kernel, PCI device
state is lost.  AER registers are volatile and cleared by device reset,
making post-mortem root cause analysis difficult.

Add CONFIG_PCI_CRASH to capture PCI configuration space (including AER
extended capability registers) during panic, before kexec.  The data is
exported via VMCOREINFO so crash analysis tools can extract it from the
vmcore.

Hook point: crash_save_vmcoreinfo() inside __crash_kexec(), which runs
before machine_kexec() -- the only reliable capture point since panic
notifiers run after kexec by default.

Key design choices:

- No config reads at init or hotplug; the buffer is pre-allocated and
  filled only at crash time so the registers reflect crash-time state.

- capture=always (default): capture all devices unconditionally.
  capture=aer: quick-scan root port ROOT_STATUS and bail if no
  uncorrectable errors are present.  always is the default because a PCI
  link-down can cause an MCE or NMI watchdog timeout before DPC/AER fires,
  so the crash reason is unrelated yet the AER registers still hold the
  originating error.

- devices= filter applied at rebuild time (zero crash-path cost).

- 200ms debounced workqueue rebuild for VF enumeration storms.

- kvmalloc buffer + kmalloc pagemap for the physical page directory
  (vmalloc addresses need explicit page-to-phys translation).

- dcache flush (arm64/x86) ensures the data survives kexec.

Crash-context safety:

- Config reads use pci_bus_read_config_dword_trylock(), a new internal
  accessor in drivers/pci/access.c (where pci_lock lives) that takes
  pci_lock with a trylock and skips the device on contention.  Depending on
  crash_kexec_post_notifiers the other CPUs may still be running or already
  halted (possibly holding pci_lock), and the panicking CPU may itself have
  been interrupted mid config access while holding it.  pci_lock is a raw,
  non-reentrant spinlock, so a blocking acquire could deadlock the dump in
  either case.  The trylock covers pci_lock only: arm64 ECAM and x86-64
  MMCONFIG are fully covered; legacy x86 conf1/mmconfig_32 take a second
  blocking lock (pci_config_lock) below bus->ops->read() and remain outside
  its scope.  This does not make the read fault-tolerant, which is why
  unreachable devices are skipped first.  The accessor is declared in
  linux/pci_crash.h and is not exported, since its only caller is this
  built-in feature.

- A config read to a device whose PCIe link is physically down can raise a
  synchronous external abort on some architectures (notably arm64), which
  in the crash path is unrecoverable.  Reachability is therefore decided
  before touching the endpoint: pci_dev_is_disconnected() / channel_offline
  / D3cold are flag-only (no MMIO), and the immediate upstream PCIe port's
  Data Link Layer Link Active bit is read on the on-die parent (which always
  responds) to detect a down link without accessing the endpoint itself.
  Every crash-path config read is fail-closed: if a read cannot complete
  (lock contention or PCIBIOS error), the device is treated as unreachable
  and the AER quick-scan treats it as "no error seen".
  See Documentation/PCI/pci-crash-capture.rst for the narrow arm64 residual
  (TOCTOU and multi-level link loss), which is documented rather than
  silently left in place.

- Live capture state is a single RCU-published snapshot; the rebuild worker
  swaps it via rcu_assign_pointer() and retires the old one via call_rcu(),
  while pci_crash_save() reads it under rcu_read_lock().  RCU keeps the
  snapshot alive for the fill, but the exported buffer/pagemap addresses are
  consumed after pci_crash_save() returns (the VMCOREINFO export, and
  machine_kexec() snapshotting RAM) -- i.e. after rcu_read_unlock().  On the
  default panic path peer CPUs are still live and may retire snapshots.
  pci_crash_save() therefore pins the snapshot it captured
  (pci_crash_captured_snap); the RCU free callback leaks a pinned snapshot
  instead of freeing it, which is harmless while rebooting into the crash
  kernel.

- The buffer is capped at 24 MiB, per-device reads clamped to 4096 bytes,
  and every record bounds-checked against the buffer end.

The on-wire buffer/pagemap layout is shared with the userspace vmcore
parser and is asserted with BUILD_BUG_ON(); the format and the exported
VMCOREINFO keys (PCI_CRASH_PAGEMAP, PCI_CRASH_VERSION, PCI_CRASH_BUF_SZ)
are documented in Documentation/PCI/pci-crash-capture.rst.

Build-tested on x86_64 (mainline).  Runtime-tested on 6.6 with forced
panics: ~2ms for 31 PCIe devices (4096B config each), sub-microsecond AER
bail on non-PCI panics.  The arm64 read path is not yet build- or
runtime-tested in this environment.

See Documentation/PCI/pci-crash-capture.rst for full details.

Signed-off-by: Johannes Hange <hangej@amazon.com>
---
 Documentation/PCI/index.rst                   |    1 +
 Documentation/PCI/pci-crash-capture.rst       |  232 ++++
 .../admin-guide/kernel-parameters.txt         |   16 +
 MAINTAINERS                                   |    8 +
 drivers/pci/access.c                          |   60 +
 include/linux/pci_crash.h                     |  122 ++
 kernel/Kconfig.kexec                          |   16 +
 kernel/Makefile                               |    1 +
 kernel/pci_crash.c                            | 1001 +++++++++++++++++
 kernel/vmcore_info.c                          |   13 +
 10 files changed, 1470 insertions(+)
 create mode 100644 Documentation/PCI/pci-crash-capture.rst
 create mode 100644 include/linux/pci_crash.h
 create mode 100644 kernel/pci_crash.c

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 5d720d2a415e..7f499a43ddb4 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -19,4 +19,5 @@ PCI Bus Subsystem
    endpoint/index
    controller/index
    boot-interrupts
+   pci-crash-capture
    tph
diff --git a/Documentation/PCI/pci-crash-capture.rst b/Documentation/PCI/pci-crash-capture.rst
new file mode 100644
index 000000000000..2e1c7f238269
--- /dev/null
+++ b/Documentation/PCI/pci-crash-capture.rst
@@ -0,0 +1,232 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+PCI Crash Capture Buffer
+========================
+
+Overview
+========
+
+The PCI crash capture module (``CONFIG_PCI_CRASH``) saves PCI configuration
+space for all (or selected) devices at panic time.  The data is written into
+a pre-allocated buffer whose physical pages are exported via VMCOREINFO,
+allowing crash analysis tools to extract device state from the vmcore.
+
+This is useful because AER (Advanced Error Reporting) registers are volatile
+and cleared by device reset during kexec into the crash kernel.  Capturing
+them before kexec preserves the error state that caused or contributed to the
+crash.
+
+Boot Parameters
+===============
+
+``pci_crash.capture=`` (default: ``always``)
+  When to capture PCI config space.  Comma-separated tokens:
+
+  ``aer``
+    Capture only if a root port reports an uncorrectable error in its
+    AER ROOT_STATUS register.  Non-PCI panics skip capture entirely
+    (a handful of MMIO reads to root ports, sub-microsecond).
+
+  ``always``
+    Capture on every panic regardless of AER state.  Useful for
+    cascading failures where a PCI link-down causes an MCE or NMI
+    watchdog timeout before DPC/AER fires, so the crash reason is
+    unrelated but the AER registers still hold the originating error.
+
+``pci_crash.devices=`` (default: ``all``)
+  Which devices to include in the capture buffer.  Comma-separated tokens:
+
+  ``all``
+    Every PCI device in the system.
+
+  ``bridges``
+    PCI-to-PCI bridges (class 0604) and CardBus bridges (class 0607).
+
+  ``root_ports``
+    PCIe root ports only.
+
+  ``XXYY``
+    Hex PCI class code (class byte XX, subclass byte YY).
+    Up to 8 class codes may be specified.
+
+  Bridges are always implicitly included regardless of the filter value
+  because they hold AER registers needed for root cause analysis.  The
+  filter is applied at device enumeration and hotplug rebuild time, not at
+  crash time (zero overhead on the panic path).
+
+Both parameters are writable at runtime via sysfs
+(``/sys/module/pci_crash/parameters/``).
+
+Architecture
+============
+
+::
+
+  late_initcall
+      │
+      ├── register PCI bus notifier (before the first rebuild)
+      ├── enumerate PCI devices (filtered by devices= param)
+      ├── allocate buffer via kvmalloc (may be vmalloc for >4 MiB)
+      ├── build pagemap: kmalloc'd array of per-page physical addresses
+      └── publish snapshot via rcu_assign_pointer()
+
+  hotplug (BUS_NOTIFY_ADD_DEVICE / BUS_NOTIFY_DEL_DEVICE)
+      │
+      └── schedule delayed rebuild (200 ms debounce)
+              └── re-enumerate, re-allocate buffer + pagemap,
+                  publish new snapshot, retire old via call_rcu()
+
+  panic (__crash_kexec → crash_save_vmcoreinfo → pci_crash_save)
+      │
+      ├── rcu_read_lock(); sample the published snapshot
+      ├── quick-scan root port AER ROOT_STATUS (capture=aer)
+      │     └── bail if no uncorrectable errors
+      ├── for each device: skip if unreachable, else read config space
+      │     via pci_bus_read_config_dword_trylock()
+      ├── flush dcache (buffer + pagemap) to RAM
+      └── VMCOREINFO exports: PCI_CRASH_PAGEMAP, PCI_CRASH_BUF_SZ,
+          PCI_CRASH_VERSION
+
+Buffer Format
+=============
+
+The buffer consists of a 32-byte header followed by variable-length
+device records:
+
+.. code-block:: c
+
+    struct pci_crash_buffer_header {   /* 32 bytes */
+        __le32 magic;           /* 0x50434943 "PCIC" */
+        __le32 version;         /* 1 */
+        __le32 device_count;
+        __le32 config_size;     /* 0 = variable-length records */
+        __le64 timestamp;       /* ktime_get_real_fast_ns() */
+        __le32 flags;           /* reserved */
+        __le32 reserved;
+    };
+
+    struct pci_crash_device_record {   /* 8 + cfg_size bytes */
+        __le16 domain;
+        __u8   bus;
+        __u8   devfn;
+        __le32 config_size;     /* 256 or 4096 */
+        __u8   config_data[];   /* 0xffffffff for unreachable dwords */
+    };
+
+The pagemap (exported via ``PCI_CRASH_PAGEMAP``) allows the parser to
+locate buffer pages without walking page tables:
+
+.. code-block:: c
+
+    struct pci_crash_pagemap {
+        __le32 magic;           /* 0x5043504d "PCPM" */
+        __le32 num_pages;
+        __le64 buf_size;
+        __le32 buf_offset;      /* offset of buffer start within first page */
+        __le64 addrs[];         /* physical address per page */
+    };
+
+All multi-byte fields are little-endian.  The struct sizes and the
+``addrs[]`` offset are asserted with ``BUILD_BUG_ON()`` so the on-wire
+layout cannot drift away from the userspace parser silently.
+
+VMCOREINFO keys
+===============
+
+``pci_crash_save()`` exports the following keys into VMCOREINFO (consumed by
+makedumpfile / the crash-utility and any bespoke vmcore parser).  They are
+emitted whenever a valid snapshot exists at panic time; the buffer may be
+unfilled when the AER quick-scan found no errors and skipped the capture
+(``capture=aer``).  Parsers must check the buffer header magic (``PCIC``)
+to confirm config space was actually captured:
+
+``PCI_CRASH_PAGEMAP=<hex>``
+  Physical address of the ``struct pci_crash_pagemap``.  The pagemap is
+  always kmalloc'd (direct-mapped), so this physical address is stable and
+  the parser can read it directly from the vmcore.  From the pagemap the
+  parser reconstructs the (possibly vmalloc'd, physically discontiguous)
+  buffer page by page.
+
+``PCI_CRASH_VERSION=<dec>``
+  On-wire format version (``PCI_CRASH_VERSION``).  Parsers must reject a
+  version they do not understand rather than misinterpret the layout.
+
+``PCI_CRASH_BUF_SZ=<dec>``
+  Total buffer size in bytes, matching ``pci_crash_pagemap::buf_size``.
+
+Safety Considerations
+=====================
+
+``pci_crash_save()`` runs from ``crash_save_vmcoreinfo()`` inside
+``__crash_kexec()``, before ``machine_kexec()``.  It executes in crash
+context, so every access on that path is constrained accordingly:
+
+- **Config reads use** ``pci_bus_read_config_dword_trylock()``, which takes
+  ``pci_lock`` with a *trylock* and skips the device on contention.  Depending
+  on ``crash_kexec_post_notifiers`` the other CPUs may still be running or may
+  already be halted (possibly while holding ``pci_lock``), and the panicking
+  CPU may itself have been interrupted mid config access while holding it.
+  ``pci_lock`` is a raw, non-reentrant spinlock, so a blocking acquire could
+  deadlock the dump in either case; the trylock skips the device instead.  This
+  avoids the lock deadlock only; it does not make the read itself fault-safe,
+  which is why unreachable devices are skipped first (below).
+
+- **Unreachable devices are skipped before any access to them.**  A config
+  read to a device whose PCIe link is physically down can, on some
+  architectures (notably arm64), raise a synchronous external abort.  Before
+  reading an endpoint, the module establishes reachability *without touching
+  the endpoint*:
+
+  - software state -- ``pci_dev_is_disconnected()``, ``pci_channel_offline()``
+    and ``PCI_D3cold`` are flag reads (no MMIO); they catch devices a
+    subsystem has already marked gone or powered off; and
+
+  - the immediate upstream PCIe port's Link Status (Data Link Layer Link
+    Active).  The upstream port is on-die and always responds, so reading its
+    Link Status cannot fault on the endpoint's dead link; if the link is down,
+    the endpoint is skipped and its record is filled with ``0xffffffff``.
+
+- ``ktime_get_real_fast_ns()`` is NMI-safe (lockless timekeeper snapshot).
+
+- **Live capture state is a single RCU-published snapshot.**  The rebuild
+  worker (process context) swaps it via ``rcu_assign_pointer()`` and frees the
+  old snapshot via ``call_rcu()``; ``pci_crash_save()`` reads it under
+  ``rcu_read_lock()``.  RCU keeps the snapshot alive for the *fill*, but the
+  exported buffer/pagemap addresses are consumed after ``pci_crash_save()``
+  returns (the VMCOREINFO export, and ``machine_kexec()`` snapshotting RAM),
+  i.e. after ``rcu_read_unlock()`` -- and on the default panic path peer CPUs
+  are still live and may retire snapshots.  ``pci_crash_save()`` therefore
+  *pins* the snapshot it captured (``pci_crash_captured_snap``); the RCU free
+  callback leaks a pinned snapshot instead of freeing it, which is harmless
+  because the system is rebooting into the crash kernel.
+
+- Buffer capped at 24 MiB to bound allocation on systems with thousands of
+  VFs; per-device reads are clamped to 4096 bytes and the fill loop
+  bounds-checks every record against the buffer end.
+
+- ``pci_crash_ready`` defers param parsing and rebuild until ``late_initcall``
+  completes; kernel command-line values are stored and take effect once the
+  PCI subsystem is up.
+
+Architecture support and residual risk
+---------------------------------------
+
+The upstream-port Link-Status pre-check eliminates the common and
+deterministic hang: an endpoint whose link is already down at panic is never
+read.  Two narrow residual cases remain on architectures where a config read
+to a dead device raises a fatal abort (e.g. arm64 ``do_sea()``, which has no
+kernel-mode recovery for an external abort):
+
+- a link that drops in the small window *between* the upstream-port check and
+  the endpoint read (a true hardware race); and
+
+- a multi-level fabric collapse in which an upstream port is itself behind a
+  dead link (only the immediate parent is checked).
+
+On x86 a read to an absent device returns all-ones harmlessly, so these cases
+are arm64-specific.  Capturing such a device may therefore, in those narrow
+races, abort the dump on arm64.  Making the read itself recoverable would
+require new architecture support in the abort handler and is intentionally not
+part of this module; it can be added later as a separate, properly-typed
+arch facility without changing the on-wire format.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..7ef515c8b849 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5298,6 +5298,22 @@ Kernel parameters
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
 
+	pci_crash.capture=
+			[PCI] When to capture PCI config space at panic time.
+			always (default): capture on every panic.
+			aer: capture only if root port AER reports
+				uncorrectable errors.
+			Requires CONFIG_PCI_CRASH=y.
+
+	pci_crash.devices=
+			[PCI] Which devices to include in crash capture.
+			all (default): every PCI device.
+			bridges: PCI bridges only.
+			root_ports: PCIe root ports only.
+			XXYY: hex class code (up to 8).
+			Bridges always implicitly included.
+			Requires CONFIG_PCI_CRASH=y.
+
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
 	pd_ignore_unused
diff --git a/MAINTAINERS b/MAINTAINERS
index f37a81950e25..47a562820582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20560,6 +20560,14 @@ S:	Maintained
 F:	drivers/leds/leds-pca9532.c
 F:	include/linux/leds-pca9532.h
 
+PCI CRASH BUFFER
+M:	Johannes Hange <hangej@amazon.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/PCI/pci-crash-capture.rst
+F:	include/linux/pci_crash.h
+F:	kernel/pci_crash.c
+
 PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 M:	Pali Rohár <pali@kernel.org>
diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..c05d02efd602 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
+#include <linux/pci_crash.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
@@ -27,9 +28,11 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 #ifdef CONFIG_PCI_LOCKLESS_CONFIG
 # define pci_lock_config(f)	do { (void)(f); } while (0)
 # define pci_unlock_config(f)	do { (void)(f); } while (0)
+# define pci_trylock_config(f)	({ (void)(f); true; })
 #else
 # define pci_lock_config(f)	raw_spin_lock_irqsave(&pci_lock, f)
 # define pci_unlock_config(f)	raw_spin_unlock_irqrestore(&pci_lock, f)
+# define pci_trylock_config(f)	raw_spin_trylock_irqsave(&pci_lock, f)
 #endif
 
 #define PCI_OP_READ(size, type, len) \
@@ -85,6 +88,63 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
+#ifdef CONFIG_PCI_CRASH
+/**
+ * pci_bus_read_config_dword_trylock - non-blocking config read for the crash path
+ * @bus: target PCI bus
+ * @devfn: target device/function
+ * @pos: dword-aligned config space offset
+ * @value: result; set to ~0 (PCI "no response") if the read is skipped
+ *
+ * Like pci_bus_read_config_dword() but acquires pci_lock with a trylock instead
+ * of blocking.  The PCI crash capture (CONFIG_PCI_CRASH) reads config space from
+ * crash_save_vmcoreinfo() inside __crash_kexec(), which can run while a halted
+ * peer CPU still holds pci_lock, or after this CPU was interrupted mid config
+ * access while holding it.  pci_lock is a raw (non-reentrant) spinlock, so a
+ * blocking acquire in either case would spin forever and hang the dump.  On
+ * contention this skips the device (value ~0, PCIBIOS_SET_FAILED) instead.
+ *
+ * This only avoids the pci_lock deadlock.  On x86 with legacy conf1 or
+ * mmconfig_32 port-I/O, a second blocking lock (pci_config_lock in
+ * arch/x86/pci/common.c) is taken below bus->ops->read() and is NOT covered
+ * by this trylock -- those paths can still hang the dump.  arm64 ECAM and
+ * x86-64 MMCONFIG are fully covered (no second lock).  The trylock also does
+ * not make the underlying MMIO access fault-tolerant: a read to a device whose
+ * link is down can still raise an external abort, so callers must confirm the
+ * device is reachable first.
+ *
+ * Context: crash/panic path only.  Returns 0 on success or a PCIBIOS_* error
+ * (PCIBIOS_SET_FAILED on lock contention).
+ */
+int pci_bus_read_config_dword_trylock(struct pci_bus *bus, unsigned int devfn,
+				      int pos, u32 *value)
+{
+	unsigned long flags;
+	u32 data = 0;
+	int res;
+
+	if (pos & 3) {
+		PCI_SET_ERROR_RESPONSE(value);
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+	if (!bus || !bus->ops || !bus->ops->read) {
+		PCI_SET_ERROR_RESPONSE(value);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+	if (!pci_trylock_config(flags)) {
+		PCI_SET_ERROR_RESPONSE(value);
+		return PCIBIOS_SET_FAILED;
+	}
+	res = bus->ops->read(bus, devfn, pos, 4, &data);
+	if (res)
+		PCI_SET_ERROR_RESPONSE(value);
+	else
+		*value = data;
+	pci_unlock_config(flags);
+	return res;
+}
+#endif /* CONFIG_PCI_CRASH */
+
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 			    int where, int size, u32 *val)
 {
diff --git a/include/linux/pci_crash.h b/include/linux/pci_crash.h
new file mode 100644
index 000000000000..dc29fe120ba9
--- /dev/null
+++ b/include/linux/pci_crash.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * PCI Crash Buffer - Capture PCI config space at panic time
+ *
+ * This module captures PCI configuration space data (including AER
+ * extended capability registers) for all PCI devices at panic time.
+ * The data is stored in a buffer whose pages are captured in the
+ * vmcore for off-site analysis.
+ *
+ * Copyright (c) 2026 Amazon.com, Inc. or its affiliates.
+ */
+#ifndef _LINUX_PCI_CRASH_H
+#define _LINUX_PCI_CRASH_H
+
+#include <linux/types.h>
+
+#define PCI_CRASH_MAGIC         0x50434943  /* "PCIC" in ASCII */
+#define PCI_CRASH_VERSION       1
+
+/**
+ * struct pci_crash_buffer_header - Header for PCI crash buffer
+ * @magic:        Magic number (PCI_CRASH_MAGIC)
+ * @version:      Format version (PCI_CRASH_VERSION)
+ * @device_count: Number of device records following this header
+ * @config_size:  0 -- indicates variable-length records. Each device
+ *                record stores its own config_size (pdev->cfg_size:
+ *                256 for legacy PCI, 4096 for PCIe). Parsers walk
+ *                records sequentially using per-record config_size.
+ * @timestamp:    Capture timestamp from ktime_get_real_fast_ns()
+ * @flags:        Reserved for future use (0 for now)
+ * @reserved:     Padding to align to 32 bytes
+ *
+ * Total size: 32 bytes
+ */
+struct pci_crash_buffer_header {
+	__le32 magic;
+	__le32 version;
+	__le32 device_count;
+	__le32 config_size;
+	__le64 timestamp;
+	__le32 flags;
+	__le32 reserved;
+} __packed;
+
+/**
+ * struct pci_crash_device_record - Per-device record in crash buffer
+ * @domain:      PCI domain number
+ * @bus:         PCI bus number
+ * @devfn:       Device and function number (PCI_DEVFN format)
+ * @config_size: Config space size for this device (pdev->cfg_size:
+ *               256 for legacy PCI, 4096 for PCIe)
+ * @config_data: Raw PCI config space (config_size bytes)
+ *
+ * Records are variable-length: total size per record is
+ * PCI_CRASH_RECORD_META + config_size bytes.
+ */
+struct pci_crash_device_record {
+	__le16 domain;
+	__u8   bus;
+	__u8   devfn;
+	__le32 config_size;
+	__u8   config_data[];
+} __packed;
+
+#define PCI_CRASH_HEADER_SIZE  sizeof(struct pci_crash_buffer_header)
+#define PCI_CRASH_RECORD_META  sizeof(struct pci_crash_device_record)
+
+/**
+ * struct pci_crash_pagemap - Physical page directory for crash buffer
+ *
+ * The PCI crash buffer may be allocated via vmalloc (for buffers
+ * exceeding ~4 MB where the buddy allocator cannot provide contiguous
+ * pages).  virt_to_phys() returns garbage for vmalloc addresses, so
+ * we maintain this small kmalloc'd directory that maps the buffer's
+ * virtual pages to their actual physical addresses.
+ *
+ * At panic time, crash_core.c exports the pagemap's physical address
+ * via VMCOREINFO.  The parser reads the pagemap, then reads each
+ * physical page from the vmcore to reconstruct the full buffer.
+ *
+ * The pagemap itself is always kmalloc'd (direct-mapped), so
+ * virt_to_phys() works correctly on it.
+ *
+ * @magic:     0x5043504d ("PCPM") -- validates this is a pagemap
+ * @num_pages: Number of entries in the addrs[] array
+ * @buf_size:  Exact buffer size in bytes (last page may be partial)
+ * @buf_offset: Offset of buffer start within the first page
+ * @addrs:     Physical address of each PAGE_SIZE page backing the buffer
+ */
+struct pci_crash_pagemap {
+	__le32 magic;
+	__le32 num_pages;
+	__le64 buf_size;
+	__le32 buf_offset;
+	__le64 addrs[];
+} __packed;
+
+#define PCI_CRASH_PAGEMAP_MAGIC  0x5043504d  /* "PCPM" in ASCII */
+
+struct pci_bus;
+
+#ifdef CONFIG_PCI_CRASH
+void pci_crash_save(void);
+extern void *pci_crash_buffer;
+extern size_t pci_crash_buffer_size;
+extern phys_addr_t pci_crash_pagemap_phys;
+
+/*
+ * Non-blocking config read used only by the crash capture path; defined in
+ * drivers/pci/access.c (where pci_lock lives).  Not exported and not part of
+ * the public PCI API -- it is specific to this feature.
+ */
+int pci_bus_read_config_dword_trylock(struct pci_bus *bus, unsigned int devfn,
+				      int pos, u32 *value);
+#else
+static inline void pci_crash_save(void) {}
+#define pci_crash_buffer        ((void *)NULL)
+#define pci_crash_buffer_size   ((size_t)0)
+#define pci_crash_pagemap_phys  ((phys_addr_t)0)
+#endif
+
+#endif /* _LINUX_PCI_CRASH_H */
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 15632358bcf7..056767c8ea8d 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -179,4 +179,20 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+
+config PCI_CRASH
+	bool "Capture PCI config space at panic time"
+	depends on VMCORE_INFO && PCI && (ARM64 || X86)
+	help
+	  Capture PCI configuration space (including AER extended capability
+	  registers) for all PCI devices at panic time.  The data is stored
+	  in a buffer whose pages are recorded in VMCOREINFO for off-site
+	  crash analysis.
+
+	  This is useful for diagnosing PCI errors that caused or contributed
+	  to the crash, especially when AER registers are volatile and cleared
+	  by device reset during kexec.
+
+	  If unsure, say Y.
+
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index 1e1a31673577..584ab235496e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
 obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
+obj-$(CONFIG_PCI_CRASH) += pci_crash.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
diff --git a/kernel/pci_crash.c b/kernel/pci_crash.c
new file mode 100644
index 000000000000..d0e69fb75f9d
--- /dev/null
+++ b/kernel/pci_crash.c
@@ -0,0 +1,1001 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PCI Crash Buffer - Capture PCI config space for crash analysis
+ *
+ * Copyright (c) 2026 Amazon.com, Inc. or its affiliates.
+ *
+ * Captures PCI configuration space at crash time so AER error
+ * registers reflect the crash-time state for off-site analysis.
+ *
+ * Design:
+ * - Init (late_initcall): enumerate devices, allocate buffer.
+ * - Hotplug: bus notifier queues deferred rebuild of device list
+ *   and buffer via workqueue -- no PCI reads.
+ * - Crash: crash_save_vmcoreinfo() calls pci_crash_save() which
+ *   reads config space into buffer, flushes dcache to RAM so
+ *   data survives kexec into crash kernel.
+ *
+ * Records are variable-length: each device's record is exactly
+ * 8 + pdev->cfg_size bytes (264 for legacy PCI, 4104 for PCIe).
+ * The parser walks records sequentially using per-record config_size.
+ *
+ * Buffer pages may be physically scattered (kvmalloc falls back to
+ * vmalloc for buffers exceeding ~4 MB).  A small kmalloc'd pagemap
+ * records each page's physical address so the crash parser can
+ * reconstruct the buffer without page-table walking.
+ *
+ * Config reads at crash time use pci_bus_read_config_dword_trylock(), which
+ * trylocks pci_lock and skips the device on contention.  pci_crash_save() runs
+ * from crash_save_vmcoreinfo() inside __crash_kexec(); depending on
+ * crash_kexec_post_notifiers, peer CPUs may already be halted (possibly while
+ * holding pci_lock) and this CPU may itself hold pci_lock (a panic inside a
+ * config access).  pci_lock is a raw, non-reentrant spinlock, so a blocking
+ * acquire would deadlock the dump in either case; the trylock skips instead.
+ * This guards against the lock deadlock only -- a read to an unreachable device
+ * is handled separately by pci_crash_endpoint_reachable().
+ * for_each_pci_dev() needs pci_bus_sem -- only used at init/hotplug.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/crash_dump.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_crash.h>
+#include <linux/slab.h>
+#include <linux/timekeeping.h>
+#include <linux/workqueue.h>
+#include <linux/rcupdate.h>
+
+#include <linux/cacheflush.h>
+#include <linux/unaligned.h>
+
+/**
+ * pci_crash_flush_dcache() - Flush a memory region from CPU cache to RAM
+ * @addr: virtual address of region to flush
+ * @size: size in bytes
+ *
+ * Used at crash time to ensure the crash kernel sees our buffer/pagemap
+ * writes after kexec.
+ */
+static inline void pci_crash_flush_dcache(void *addr, size_t size)
+{
+	/* Only ARM64 and x86 implemented; Kconfig enforces depends on (ARM64 || X86). */
+#ifdef CONFIG_ARM64
+	unsigned long start = (unsigned long)addr;
+	unsigned long end = start + size;
+
+	dcache_clean_inval_poc(start, end);
+#elif defined(CONFIG_X86)
+	clflush_cache_range(addr, size);
+#else
+#error "CONFIG_PCI_CRASH requires ARM64 or X86 dcache flush support (Kconfig depends)"
+#endif
+}
+
+/*
+ * Live capture state is published as a single RCU-managed snapshot so the
+ * lockless crash-time reader (pci_crash_save) always observes a consistent
+ * {devs, num_devs, buffer, pagemap} set and can never race the rebuild
+ * worker freeing the old arrays.  The retired snapshot is reclaimed via
+ * call_rcu() once no reader can hold it -- see pci_crash_rebuild_snapshot().
+ */
+struct pci_crash_snapshot {
+	struct pci_dev		**devs;
+	unsigned int		num_devs;
+	void			*buffer;
+	size_t			buffer_size;
+	struct pci_crash_pagemap *pagemap;
+	size_t			pagemap_size;
+	phys_addr_t		pagemap_phys;
+	struct rcu_head		rcu;
+};
+
+static struct pci_crash_snapshot __rcu *pci_crash_snap;
+
+/*
+ * Scalars consumed by crash_core.c's crash_save_vmcoreinfo() right AFTER it
+ * calls pci_crash_save().  pci_crash_save() publishes them from the snapshot
+ * it captured; on a skipped or failed capture they are set to 0 so no stale
+ * pagemap is exported into the vmcore.
+ */
+void *pci_crash_buffer;
+EXPORT_SYMBOL_GPL(pci_crash_buffer);
+
+size_t pci_crash_buffer_size;
+EXPORT_SYMBOL_GPL(pci_crash_buffer_size);
+
+phys_addr_t pci_crash_pagemap_phys;
+EXPORT_SYMBOL_GPL(pci_crash_pagemap_phys);
+
+/*
+ * Set by pci_crash_save() to the snapshot it captured, so its buffer/pagemap
+ * (whose addresses are exported into the vmcore via vmcore_info.c) cannot be
+ * reclaimed out from under the crash kernel.  pci_crash_save() publishes the
+ * buffer scalars and returns; vmcore_info.c then reads them and machine_kexec()
+ * snapshots RAM -- all AFTER rcu_read_unlock(), so RCU read-side protection has
+ * already ended by the time the buffer matters.  A rebuild racing on a live
+ * peer CPU (the default panic path runs __crash_kexec() before halting peers)
+ * could otherwise call_rcu()-free this snapshot before kexec.  The free
+ * callback below honours this pin and leaks the snapshot instead -- harmless,
+ * the system is going down.  Written under rcu_read_lock() before the scalars
+ * are published, so the grace period ordering guarantees the callback sees it.
+ */
+static struct pci_crash_snapshot *pci_crash_captured_snap;
+
+/* Reclaim a retired snapshot after a grace period: drop dev refs + free. */
+static void pci_crash_snapshot_free_rcu(struct rcu_head *head)
+{
+	struct pci_crash_snapshot *s =
+		container_of(head, struct pci_crash_snapshot, rcu);
+	unsigned int i;
+
+	/*
+	 * Pinned by an in-progress crash capture: its buffer address is live in
+	 * the vmcore export.  Leak it rather than free memory kexec will read.
+	 */
+	if (READ_ONCE(pci_crash_captured_snap) == s)
+		return;
+
+	for (i = 0; i < s->num_devs; i++)
+		if (s->devs && s->devs[i])
+			pci_dev_put(s->devs[i]);
+	kvfree(s->devs);
+	kvfree(s->buffer);
+	kfree(s->pagemap);
+	kfree(s);
+}
+
+static DEFINE_MUTEX(pci_crash_lock);
+
+/*
+ * Set in pci_crash_init() after delayed_work, PCI bus and notifier are
+ * ready.  Guards parse + rebuild in param setters: at boot (level -1)
+ * the setter just stores the string; pci_crash_init() parses and does
+ * the initial rebuild once PCI is up.
+ */
+static bool pci_crash_ready;
+
+/*
+ * capture -- when to capture PCI config space.
+ * Comma-separated tokens:
+ *   aer    -- root port ROOT_STATUS has uncorrectable errors
+ *   always -- every panic regardless of PCI error state (default)
+ *
+ * Writable at runtime (0644) so operators and tests can toggle without
+ * reboot.  Writes re-parse capture_flags immediately.
+ */
+#define PCI_CRASH_PARAM_CAPTURE_LEN	32
+static char capture[PCI_CRASH_PARAM_CAPTURE_LEN] = "always";
+
+#define PCI_CRASH_CAPTURE_AER		BIT(0)
+#define PCI_CRASH_CAPTURE_ALWAYS	BIT(1)
+static unsigned long capture_flags = PCI_CRASH_CAPTURE_ALWAYS;
+
+static void pci_crash_parse_capture(void);
+
+static int capture_param_set(const char *val, const struct kernel_param *kp)
+{
+	char *trimmed;
+
+	if (strlen(val) >= sizeof(capture))
+		return -EINVAL;
+
+	/* Serialize against concurrent sysfs writers mutating the string. */
+	mutex_lock(&pci_crash_lock);
+	strscpy(capture, val, sizeof(capture));
+	trimmed = strim(capture);
+	if (trimmed != capture)
+		memmove(capture, trimmed, strlen(trimmed) + 1);
+	if (READ_ONCE(pci_crash_ready))
+		pci_crash_parse_capture();
+	mutex_unlock(&pci_crash_lock);
+	return 0;
+}
+
+static int capture_param_get(char *buf, const struct kernel_param *kp)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", capture);
+}
+
+static const struct kernel_param_ops capture_param_ops = {
+	.set = capture_param_set,
+	.get = capture_param_get,
+};
+module_param_cb(capture, &capture_param_ops, NULL, 0644);
+MODULE_PARM_DESC(capture, "When to capture: aer, always (default: always)");
+
+/*
+ * devices -- which devices to capture.
+ * Comma-separated tokens:
+ *   all        -- every PCI device (default)
+ *   bridges    -- PCI bridges (class 0604, 0607)
+ *   root_ports -- PCIe root ports only
+ *   XXYY       -- hex PCI class code (class + subclass)
+ *
+ * Bridges are always implicitly included regardless of filter value
+ * because they hold the AER registers needed for root cause analysis.
+ * Applies at rebuild time only -- zero cost at crash time.  Writable
+ * at runtime (0644); writes re-parse and trigger async rebuild.
+ */
+#define PCI_CRASH_PARAM_DEVICES_LEN	256
+static char devices[PCI_CRASH_PARAM_DEVICES_LEN] = "all";
+
+static void pci_crash_parse_devices(void);
+static struct delayed_work pci_crash_rebuild_dwork;
+
+/* Debounce period for bus notifications (ms).
+ * SR-IOV liveupdate can enumerate ~3000 VFs in ~1.5s -- this coalesces
+ * the storm into a single rebuild after the last event.
+ */
+#define PCI_CRASH_REBUILD_DELAY_MS	200
+
+static int devices_param_set(const char *val, const struct kernel_param *kp)
+{
+	if (strlen(val) >= sizeof(devices))
+		return -EINVAL;
+
+	mutex_lock(&pci_crash_lock);
+	strscpy(devices, val, sizeof(devices));
+	{
+		char *trimmed = strim(devices);
+
+		if (trimmed != devices)
+			memmove(devices, trimmed, strlen(trimmed) + 1);
+	}
+	if (READ_ONCE(pci_crash_ready)) {
+		pci_crash_parse_devices();
+		mod_delayed_work(system_wq, &pci_crash_rebuild_dwork,
+				 msecs_to_jiffies(PCI_CRASH_REBUILD_DELAY_MS));
+	}
+	mutex_unlock(&pci_crash_lock);
+	return 0;
+}
+
+static int devices_param_get(char *buf, const struct kernel_param *kp)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", devices);
+}
+
+static const struct kernel_param_ops devices_param_ops = {
+	.set = devices_param_set,
+	.get = devices_param_get,
+};
+module_param_cb(devices, &devices_param_ops, NULL, 0644);
+MODULE_PARM_DESC(devices,
+	"Which devices: all, bridges, root_ports, XXYY hex class (default: all)");
+
+#define PCI_CRASH_DEVICES_ALL		BIT(0)
+#define PCI_CRASH_DEVICES_BRIDGES	BIT(1)
+#define PCI_CRASH_DEVICES_ROOT_PORTS	BIT(2)
+/* Max distinct class-code filters in a devices= list; 8 covers realistic use. */
+#define PCI_CRASH_MAX_DEVICE_CLASSES	8
+static unsigned long devices_flags = PCI_CRASH_DEVICES_ALL;
+static u16 device_classes[PCI_CRASH_MAX_DEVICE_CLASSES];
+static unsigned int device_class_count;
+
+static void pci_crash_parse_capture(void)
+{
+	char *buf, *token, *rest;
+	unsigned long flags = 0;
+
+	if (!*capture) {
+		WRITE_ONCE(capture_flags, PCI_CRASH_CAPTURE_ALWAYS);
+		return;
+	}
+
+	buf = kstrdup(capture, GFP_KERNEL);
+	if (!buf) {
+		WRITE_ONCE(capture_flags, PCI_CRASH_CAPTURE_ALWAYS);
+		return;
+	}
+
+	rest = buf;
+	while ((token = strsep(&rest, ",")) != NULL) {
+		if (strcmp(token, "aer") == 0)
+			flags |= PCI_CRASH_CAPTURE_AER;
+		else if (strcmp(token, "always") == 0)
+			flags |= PCI_CRASH_CAPTURE_ALWAYS;
+		else
+			pr_warn("unknown capture token: %s\n",
+				token);
+	}
+	kfree(buf);
+
+	if (!flags) {
+		pr_warn("no valid capture tokens, defaulting to always\n");
+		flags = PCI_CRASH_CAPTURE_ALWAYS;
+	}
+	WRITE_ONCE(capture_flags, flags);
+}
+
+static void pci_crash_parse_devices(void)
+{
+	char *buf, *token, *rest;
+	unsigned long val;
+
+	devices_flags = 0;
+	device_class_count = 0;
+
+	if (!*devices) {
+		devices_flags = PCI_CRASH_DEVICES_ALL;
+		return;
+	}
+
+	buf = kstrdup(devices, GFP_KERNEL);
+	if (!buf) {
+		devices_flags = PCI_CRASH_DEVICES_ALL;
+		return;
+	}
+
+	rest = buf;
+	while ((token = strsep(&rest, ",")) != NULL) {
+		if (strcmp(token, "all") == 0) {
+			devices_flags |= PCI_CRASH_DEVICES_ALL;
+		} else if (strcmp(token, "bridges") == 0) {
+			devices_flags |= PCI_CRASH_DEVICES_BRIDGES;
+		} else if (strcmp(token, "root_ports") == 0) {
+			devices_flags |= PCI_CRASH_DEVICES_ROOT_PORTS;
+		} else if (kstrtoul(token, 16, &val) == 0 && val <= 0xFFFF) {
+			if (device_class_count < PCI_CRASH_MAX_DEVICE_CLASSES)
+				device_classes[device_class_count++] = (u16)val;
+			else
+				pr_warn("too many device classes (max %d)\n",
+					PCI_CRASH_MAX_DEVICE_CLASSES);
+		} else {
+			pr_warn("unknown devices token: %s\n",
+				token);
+		}
+	}
+	kfree(buf);
+
+	if (!devices_flags && device_class_count == 0) {
+		pr_warn("no valid devices tokens, defaulting to all\n");
+		devices_flags = PCI_CRASH_DEVICES_ALL;
+	}
+}
+
+static bool pci_crash_device_matches(struct pci_dev *pdev)
+{
+	unsigned int i;
+	u16 dev_class = pdev->class >> 8;
+
+	if (devices_flags & PCI_CRASH_DEVICES_ALL)
+		return true;
+
+	/* Bridges always included -- they hold AER registers */
+	if (dev_class == PCI_CLASS_BRIDGE_PCI ||
+	    dev_class == PCI_CLASS_BRIDGE_CARDBUS)
+		return true;
+
+	if ((devices_flags & PCI_CRASH_DEVICES_ROOT_PORTS) &&
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		return true;
+
+	for (i = 0; i < device_class_count; i++) {
+		if (dev_class == device_classes[i])
+			return true;
+	}
+
+	return false;
+}
+
+/* Sanity limit -- prevents multi-GB allocations on systems with many VFs */
+#define PCI_CRASH_MAX_BUFFER_SIZE	(24 * 1024 * 1024)
+
+/*
+ * PCIe extended config space size. Per-device reads are clamped to this in
+ * case a device's cfg_size is corrupt at crash time.
+ */
+#define PCI_CRASH_MAX_CFG_SIZE		4096
+
+/**
+ * pci_crash_build_pagemap() - Build physical page directory for buffer
+ * @buf: buffer allocated via kvmalloc (may be vmalloc'd)
+ * @buf_size: buffer size in bytes
+ *
+ * Allocates a kmalloc'd directory containing the physical address of
+ * each page backing @buf.  The pagemap is always direct-mapped, so
+ * virt_to_phys() works on it at crash time.
+ *
+ * Returns the new pagemap, or NULL on allocation failure.
+ */
+static struct pci_crash_pagemap *pci_crash_build_pagemap(void *buf,
+							 size_t buf_size)
+{
+	unsigned int num_pages = DIV_ROUND_UP(offset_in_page(buf) + buf_size, PAGE_SIZE);
+	struct pci_crash_pagemap *pm;
+	unsigned int i;
+
+	pm = kmalloc(struct_size(pm, addrs, num_pages), GFP_KERNEL);
+	if (!pm)
+		return NULL;
+
+	pm->magic = cpu_to_le32(PCI_CRASH_PAGEMAP_MAGIC);
+	pm->num_pages = cpu_to_le32(num_pages);
+	pm->buf_size = cpu_to_le64(buf_size);
+	pm->buf_offset = cpu_to_le32(offset_in_page(buf));
+
+	for (i = 0; i < num_pages; i++) {
+		struct page *page;
+		phys_addr_t pa;
+
+		if (is_vmalloc_addr(buf + i * PAGE_SIZE))
+			page = vmalloc_to_page(buf + i * PAGE_SIZE);
+		else
+			page = virt_to_page(buf + i * PAGE_SIZE);
+
+		if (!page) {
+			kfree(pm);
+			return NULL;
+		}
+		pa = page_to_phys(page);
+		pm->addrs[i] = cpu_to_le64(pa);
+	}
+
+	return pm;
+}
+
+/**
+ * pci_crash_endpoint_reachable() - Decide if @pdev is safe to read at crash time
+ * @pdev: PCI device about to be read
+ *
+ * A config read to a device whose PCIe link is physically down can, on some
+ * architectures (notably arm64), raise a synchronous external abort.  In the
+ * crash path that abort is unrecoverable -- the arm64 SEA handler (do_sea())
+ * has no kernel-mode fixup and calls arm64_notify_die(), double-faulting the
+ * panic and hanging the very dump we are trying to produce.  On x86 such a
+ * read returns all-ones harmlessly.  So before touching an endpoint we must
+ * establish reachability WITHOUT reading the endpoint itself.
+ *
+ * Two cheap, panic-safe signals are used, in order:
+ *
+ *  1. Software state -- pci_dev_is_disconnected(), pci_channel_offline() and
+ *     PCI_D3cold are pure flag reads (no MMIO).  They catch devices a
+ *     subsystem has already marked gone (hotplug remove, failed AER/DPC
+ *     recovery, powered-off).  They are necessary but not sufficient: in the
+ *     cascading-failure window this feature targets, a link can be down before
+ *     any subsystem has updated error_state, so these flags can still read
+ *     "live".
+ *
+ *  2. Parent-bridge link state -- read PCI_EXP_LNKSTA on the immediate upstream
+ *     PCIe port and test Data Link Layer Link Active (DLLLA).  The upstream
+ *     port is on-die and always responds, so reading *its* config space cannot
+ *     raise an abort caused by the endpoint's dead link.  If DLLLA is clear,
+ *     the endpoint is unreachable and is skipped without ever being touched.
+ *     The bridge read uses the crash-safe trylock accessor so it cannot hang
+ *     on pci_lock either.
+ *
+ * Returns false if @pdev should be skipped (record filled with 0xFFFFFFFF).
+ *
+ * Residual: a single immediate-parent check; a link that drops between this
+ * check and the read (TOCTOU), or a multi-level fabric collapse where the
+ * upstream port itself sits behind a dead link, is not covered here.  See
+ * Documentation/PCI/pci-crash-capture.rst for the documented arm64 caveat.
+ */
+static bool pci_crash_endpoint_reachable(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	u32 lnksta = 0;
+	u16 sta;
+	int pos;
+
+	/* Software-state flags: pure reads, no MMIO -- always panic-safe. */
+	if (pci_dev_is_disconnected(pdev) || pci_channel_offline(pdev) ||
+	    pdev->current_state == PCI_D3cold)
+		return false;
+
+	/*
+	 * Live link check via the immediate upstream PCIe port.  Only meaningful
+	 * for a device sitting below a PCIe downstream/root port; for non-PCIe
+	 * or root-complex-integrated devices there is no such link to test, so
+	 * treat them as reachable and let the crash-safe accessor handle the read.
+	 */
+	bridge = pci_upstream_bridge(pdev);
+	if (bridge && pci_is_pcie(bridge) &&
+	    (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(bridge) == PCI_EXP_TYPE_DOWNSTREAM) &&
+	    bridge->pcie_cap && bridge->bus) {
+		pos = bridge->pcie_cap + PCI_EXP_LNKSTA;
+		/*
+		 * Read the aligned dword containing LNKSTA from the on-die
+		 * upstream port (always present), then extract the 16-bit field.
+		 *
+		 * Fail closed: if the bridge read cannot complete -- lock
+		 * contention (PCIBIOS_SET_FAILED) or any PCIBIOS error -- we
+		 * cannot prove the link is up, so treat the endpoint as
+		 * unreachable rather than issuing an MMIO read that may raise a
+		 * fatal external abort.  Contention is exactly a crash-path
+		 * condition we assume is likely, so "unknown" must mean "skip".
+		 */
+		if (pci_bus_read_config_dword_trylock(bridge->bus, bridge->devfn,
+						      pos & ~0x3, &lnksta) != 0)
+			return false;
+
+		sta = (pos & 0x2) ? (lnksta >> 16) : (lnksta & 0xffff);
+		if (!(sta & PCI_EXP_LNKSTA_DLLLA))
+			return false;	/* link down -> endpoint gone */
+	}
+
+	return true;
+}
+
+/**
+ * pci_crash_read_config_space() - Read config space for one device
+ * @pdev: PCI device to read
+ * @ptr: destination pointer within the crash buffer
+ * @cfg_size: number of config bytes to read (already clamped by the caller)
+ *
+ * Reads @cfg_size bytes one dword at a time.  Devices deemed unreachable by
+ * pci_crash_endpoint_reachable() (disconnected, in error recovery, powered
+ * off, or behind a down PCIe link) are skipped without being touched: on x86
+ * such a read returns all-ones harmlessly, but on other architectures (e.g.
+ * arm64) it can raise a fatal external abort that double-faults the panic
+ * path.  Skipped or failed reads store 0xFFFFFFFF -- the standard PCI
+ * convention for absent/unreachable registers.
+ */
+static void pci_crash_read_config_space(struct pci_dev *pdev, u8 *ptr,
+					unsigned int cfg_size)
+{
+	struct pci_crash_device_record *record =
+		(struct pci_crash_device_record *)ptr;
+	u8 *cfg_data = ptr + PCI_CRASH_RECORD_META;
+	unsigned int offset;
+	u32 val;
+
+	/* Defensive: never trust cfg_size, never deref a torn-down bus. */
+	if (cfg_size > PCI_CRASH_MAX_CFG_SIZE)
+		cfg_size = PCI_CRASH_MAX_CFG_SIZE;
+
+	if (!pdev->bus) {
+		record->domain = 0;
+		record->bus = 0;
+		record->devfn = pdev->devfn;
+		record->config_size = cpu_to_le32(cfg_size);
+		memset(cfg_data, 0xff, cfg_size);
+		return;
+	}
+
+	record->domain = cpu_to_le16(pci_domain_nr(pdev->bus));
+	record->bus = pdev->bus->number;
+	record->devfn = pdev->devfn;
+	record->config_size = cpu_to_le32(cfg_size);
+
+	if (!pci_crash_endpoint_reachable(pdev)) {
+		memset(cfg_data, 0xff, cfg_size);
+		return;
+	}
+
+	for (offset = 0; offset < cfg_size; offset += 4) {
+		if (pci_bus_read_config_dword_trylock(pdev->bus, pdev->devfn,
+						      offset, &val)) {
+			put_unaligned_le32(0xFFFFFFFF, &cfg_data[offset]);
+			continue;
+		}
+		put_unaligned_le32(val, &cfg_data[offset]);
+	}
+}
+
+/**
+ * pci_crash_fill_buffer() - Populate buffer with config space
+ * @s: snapshot whose buffer is filled from its captured device list
+ *
+ * Records are variable-length: each is PCI_CRASH_RECORD_META +
+ * pdev->cfg_size bytes. The header's config_size is 0 to indicate
+ * variable-length; parsers walk records using per-record config_size.
+ *
+ * Uses ktime_get_real_fast_ns() for the timestamp -- safe in NMI/panic
+ * context (lockless, reads the NMI-safe timekeeper snapshot).
+ *
+ * Caller holds rcu_read_lock() so @s stays valid for the whole fill.
+ */
+static void pci_crash_fill_buffer(struct pci_crash_snapshot *s)
+{
+	struct pci_crash_buffer_header *header = s->buffer;
+	struct pci_dev **devs = s->devs;
+	u8 *ptr, *end;
+	unsigned int i;
+
+	header->magic = cpu_to_le32(PCI_CRASH_MAGIC);
+	header->version = cpu_to_le32(PCI_CRASH_VERSION);
+	header->device_count = cpu_to_le32(s->num_devs);
+	header->config_size = 0;
+	header->timestamp = cpu_to_le64(ktime_get_real_fast_ns());
+	header->flags = 0;
+	header->reserved = 0;
+
+	ptr = (u8 *)s->buffer + PCI_CRASH_HEADER_SIZE;
+	end = (u8 *)s->buffer + s->buffer_size;
+	for (i = 0; i < s->num_devs; i++) {
+		struct pci_dev *pdev = devs[i];
+		unsigned int cfg_size;
+		size_t rec_size;
+
+		if (unlikely(!pdev))
+			break;
+
+		cfg_size = pdev->cfg_size;
+		if (cfg_size > PCI_CRASH_MAX_CFG_SIZE)
+			cfg_size = PCI_CRASH_MAX_CFG_SIZE;
+		rec_size = PCI_CRASH_RECORD_META + cfg_size;
+
+		/*
+		 * Never write past the buffer if the device set or a device's
+		 * cfg_size grew since the buffer was sized at rebuild time.
+		 */
+		if (unlikely(ptr + rec_size > end))
+			break;
+
+		pci_crash_read_config_space(pdev, ptr, cfg_size);
+		ptr += rec_size;
+	}
+
+	header->device_count = cpu_to_le32(i);
+}
+
+/**
+ * pci_crash_rebuild_snapshot() - Rebuild device list and allocate buffer
+ *
+ * Two-pass approach:
+ *   Pass 1: count PCI devices
+ *   Pass 2: populate device array (filtered) and compute exact buffer
+ *            size from actual pdev->cfg_size per device (no padding)
+ *
+ * The devices param controls which devices are included.  Bridges are
+ * always included regardless of devices setting (they hold AER registers).
+ * devices=all (default) includes everything.
+ *
+ * Does NOT read PCI config space -- reads happen only at crash time.
+ * This keeps rebuild fast during VF enumeration storms (~6000 ADD
+ * events on large accelerator hosts during liveupdate).
+ *
+ * After allocation, builds the pagemap so the crash parser can
+ * locate the buffer's physical pages in the vmcore.
+ *
+ * Publishes the new snapshot via rcu_assign_pointer() and retires the
+ * previous one via call_rcu(), so the lockless crash-time reader never
+ * sees a half-updated state or a freed array.
+ *
+ * Caller must hold pci_crash_lock.
+ */
+static void pci_crash_rebuild_snapshot(void)
+{
+	struct pci_crash_snapshot *old, *new;
+	struct pci_dev *pdev = NULL;
+	unsigned int count = 0, i;
+	size_t total_size;
+
+	old = rcu_dereference_protected(pci_crash_snap,
+					lockdep_is_held(&pci_crash_lock));
+
+	/* Pass 1: count devices (upper bound). */
+	for_each_pci_dev(pdev)
+		count++;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new) {
+		pr_warn_ratelimited("snapshot alloc failed; keeping previous (capture may be stale)\n");
+		return;
+	}
+
+	if (count == 0) {
+		pr_info("no PCI devices found\n");
+		goto publish;	/* publish an empty snapshot */
+	}
+
+	new->devs = kvmalloc_array(count, sizeof(*new->devs),
+				   GFP_KERNEL | __GFP_ZERO);
+	if (!new->devs) {
+		kfree(new);
+		pr_warn_ratelimited("devs alloc failed; keeping previous (capture may be stale)\n");
+		return;
+	}
+
+	/*
+	 * Pass 2: populate filtered device array and compute the exact
+	 * buffer size.  count (pass 1) is an upper bound; actual may be less.
+	 */
+	total_size = PCI_CRASH_HEADER_SIZE;
+	pdev = NULL;
+	i = 0;
+	for_each_pci_dev(pdev) {
+		if (i >= count) {
+			pci_dev_put(pdev);
+			break;
+		}
+		if (!pci_crash_device_matches(pdev))
+			continue;
+		new->devs[i] = pci_dev_get(pdev);
+		total_size += PCI_CRASH_RECORD_META + pdev->cfg_size;
+		i++;
+	}
+	new->num_devs = i;
+
+	if (new->num_devs == 0) {
+		/* Publish empty: releases the previous (now stale) device set. */
+		kvfree(new->devs);
+		new->devs = NULL;
+		pr_info("no devices match devices=%s\n", devices);
+		goto publish;
+	}
+
+	if (total_size > PCI_CRASH_MAX_BUFFER_SIZE) {
+		pr_warn("buffer too large (%zu > %d bytes)\n",
+			total_size, PCI_CRASH_MAX_BUFFER_SIZE);
+		goto err_free_devs;
+	}
+
+	new->buffer = kvmalloc(total_size, GFP_KERNEL | __GFP_ZERO);
+	if (!new->buffer)
+		goto err_free_devs;
+	new->buffer_size = total_size;
+
+	new->pagemap = pci_crash_build_pagemap(new->buffer, total_size);
+	if (!new->pagemap)
+		goto err_free_buf;
+	new->pagemap_size = struct_size(new->pagemap, addrs,
+					le32_to_cpu(new->pagemap->num_pages));
+	new->pagemap_phys = virt_to_phys(new->pagemap);
+
+	pr_info("rebuild: %u devices (%zu bytes, %u pages)\n",
+		new->num_devs, total_size,
+		le32_to_cpu(new->pagemap->num_pages));
+
+publish:
+	/*
+	 * Publish the new snapshot and retire the old one.  Readers in
+	 * pci_crash_save() hold rcu_read_lock(), so call_rcu() defers the old
+	 * snapshot's frees (array, buffer, pagemap, dev refs) until no
+	 * crash-time reader can still hold it -- closing the UAF/OOB window.
+	 */
+	rcu_assign_pointer(pci_crash_snap, new);
+	if (old)
+		call_rcu(&old->rcu, pci_crash_snapshot_free_rcu);
+	return;
+
+err_free_buf:
+	kvfree(new->buffer);
+err_free_devs:
+	for (i = 0; i < new->num_devs; i++)
+		pci_dev_put(new->devs[i]);
+	kvfree(new->devs);
+	kfree(new);
+	/*
+	 * Allocation failed building the new snapshot.  Keep the existing
+	 * snapshot live (do not publish) so capture still works with the
+	 * prior device set; warn (ratelimited) so persistent failures show.
+	 */
+	pr_warn_ratelimited("rebuild failed; keeping previous snapshot (capture may be stale)\n");
+}
+
+#ifdef CONFIG_PCIEAER
+/*
+ * Quick-scan root ports for a received uncorrectable AER error -- the signal
+ * that this panic is PCI-related and worth capturing.  Returns true on the
+ * first root port whose ROOT_STATUS reports an uncorrectable error.
+ */
+static bool pci_crash_aer_error_present(struct pci_crash_snapshot *s)
+{
+	unsigned int i;
+
+	for (i = 0; i < s->num_devs; i++) {
+		struct pci_dev *pdev = s->devs[i];
+		u32 status = 0;
+
+		if (!pdev || !pdev->aer_cap)
+			continue;
+		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+			continue;
+		/*
+		 * Same reachability gate as the capture path.  A root port is
+		 * on-die (no upstream bridge), so this reduces to the software-
+		 * state flags -- we read the port's own AER registers, never an
+		 * endpoint behind a potentially-dead link.
+		 */
+		if (!pci_crash_endpoint_reachable(pdev))
+			continue;
+
+		/*
+		 * Fail closed, like the reachability check: a failed read
+		 * (lock contention or PCIBIOS error) sets status to ~0, which
+		 * would falsely test as "uncorrectable error present" and force
+		 * a pointless full capture.  Unknown means "no error seen".
+		 */
+		if (pci_bus_read_config_dword_trylock(pdev->bus, pdev->devfn,
+						      pdev->aer_cap + PCI_ERR_ROOT_STATUS,
+						      &status) != 0)
+			continue;
+		if (status & PCI_ERR_ROOT_UNCOR_RCV)
+			return true;
+	}
+	return false;
+}
+#else
+static inline bool pci_crash_aer_error_present(struct pci_crash_snapshot *s)
+{
+	return false;
+}
+#endif
+
+/**
+ * pci_crash_save() - Capture PCI config space at crash time
+ *
+ * Called from crash_save_vmcoreinfo() inside __crash_kexec(), which
+ * runs before machine_kexec() boots the crash kernel.  This is the
+ * only reliable capture point -- panic notifiers run AFTER kexec by
+ * default (crash_kexec_post_notifiers=0).
+ *
+ * Capture check (capture param):
+ *   always  -- capture unconditionally
+ *   aer     -- quick-scan root port AER ROOT_STATUS for uncorrectable
+ *             errors; skip if none found
+ *
+ * When capture=always, captures on every panic.
+ * This is useful for cascading failures: a PCI link-down can cause
+ * an MCE or NMI watchdog timeout before DPC/AER fires, so the crash
+ * reason is UNKNOWN but AER registers may still hold error state.
+ *
+ * Reads config space fresh -- successful reads get current register
+ * state, failed reads (offline devices) write 0xFFFFFFFF.
+ *
+ * Flushes both buffer and pagemap from CPU cache to RAM so data
+ * survives kexec into crash kernel.
+ *
+ * Runs under rcu_read_lock(): a rebuild worker may still be mid-flight on a
+ * peer CPU, so RCU keeps the sampled snapshot alive for the whole capture.
+ */
+void pci_crash_save(void)
+{
+	struct pci_crash_snapshot *s;
+	unsigned long cflags;
+
+	/* Cleared first; set only on a successful capture below. */
+	pci_crash_buffer = NULL;
+	pci_crash_buffer_size = 0;
+	pci_crash_pagemap_phys = 0;
+
+	rcu_read_lock();
+	s = rcu_dereference(pci_crash_snap);
+	if (!s || s->num_devs == 0)
+		goto out;
+	if (!s->buffer || s->buffer_size == 0)
+		goto out;
+
+	/*
+	 * Pin this snapshot so a rebuild racing on a live peer CPU cannot
+	 * call_rcu()-free its buffer/pagemap before machine_kexec() snapshots
+	 * RAM.  The scalars below are read by vmcore_info.c AFTER we return and
+	 * rcu_read_unlock() -- i.e. after RCU read-side protection has ended --
+	 * so RCU alone does not keep the buffer alive that long.  Written here,
+	 * under rcu_read_lock() and before the scalars are published; the free
+	 * callback honours it (see pci_crash_snapshot_free_rcu).
+	 */
+	WRITE_ONCE(pci_crash_captured_snap, s);
+
+	/*
+	 * Publish the buffer location now -- before the AER quick-scan that may
+	 * skip the capture -- so vmcore_info.c always exports a valid (possibly
+	 * empty) buffer.  vmcore_info.c reads only these scalars, immediately
+	 * after we return and still inside __crash_kexec() before
+	 * machine_kexec().
+	 */
+	pci_crash_buffer = s->buffer;
+	pci_crash_buffer_size = s->buffer_size;
+	pci_crash_pagemap_phys = s->pagemap_phys;
+
+	cflags = READ_ONCE(capture_flags);
+	if (!(cflags & PCI_CRASH_CAPTURE_ALWAYS)) {
+		if (!(cflags & PCI_CRASH_CAPTURE_AER)) {
+			/* Neither 'always' nor a usable 'aer' mode -- skip. */
+			goto out;
+		}
+		if (!pci_crash_aer_error_present(s)) {
+			pr_info("no PCI errors detected, skipping capture\n");
+			goto out;
+		}
+	}
+
+	pci_crash_fill_buffer(s);
+
+	/*
+	 * Flush buffer and pagemap from CPU cache to RAM so the
+	 * crash kernel sees our writes after kexec.
+	 */
+	pci_crash_flush_dcache(s->buffer, s->buffer_size);
+	if (s->pagemap && s->pagemap_size > 0)
+		pci_crash_flush_dcache(s->pagemap, s->pagemap_size);
+
+	pr_info("CAPTURE: %u devices, %zu bytes\n",
+		s->num_devs, s->buffer_size);
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(pci_crash_save);
+
+static void pci_crash_rebuild_worker(struct work_struct *work)
+{
+	mutex_lock(&pci_crash_lock);
+	pci_crash_rebuild_snapshot();
+	mutex_unlock(&pci_crash_lock);
+}
+
+static int pci_crash_bus_notifier(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	if (action == BUS_NOTIFY_ADD_DEVICE ||
+	    action == BUS_NOTIFY_DEL_DEVICE)
+		mod_delayed_work(system_wq, &pci_crash_rebuild_dwork,
+				 msecs_to_jiffies(PCI_CRASH_REBUILD_DELAY_MS));
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block pci_crash_bus_nb = {
+	.notifier_call = pci_crash_bus_notifier,
+};
+
+static int __init pci_crash_init(void)
+{
+	/*
+	 * The on-wire buffer/pagemap layout is shared with userspace vmcore
+	 * parsers, which hardcode these sizes.  Catch any struct drift at
+	 * build time.
+	 */
+	BUILD_BUG_ON(sizeof(struct pci_crash_buffer_header) != 32);
+	BUILD_BUG_ON(sizeof(struct pci_crash_device_record) != 8);
+	BUILD_BUG_ON(offsetof(struct pci_crash_pagemap, addrs) != 20);
+
+	/* Nothing to do in crash kernel -- the buffer from the first kernel
+	 * is already in RAM (flushed before kexec) and the parser finds it
+	 * via the pagemap in VMCOREINFO.
+	 */
+	if (is_kdump_kernel())
+		return 0;
+
+	INIT_DELAYED_WORK(&pci_crash_rebuild_dwork, pci_crash_rebuild_worker);
+
+	pci_crash_parse_capture();
+	pci_crash_parse_devices();
+
+	/*
+	 * Register the hotplug notifier BEFORE the initial snapshot so no
+	 * ADD/DEL event in the startup window is missed.  The notifier only
+	 * schedules the debounced rebuild worker, which serializes on
+	 * pci_crash_lock behind this initial rebuild.
+	 */
+	bus_register_notifier(&pci_bus_type, &pci_crash_bus_nb);
+
+	mutex_lock(&pci_crash_lock);
+	pci_crash_rebuild_snapshot();
+	mutex_unlock(&pci_crash_lock);
+
+	WRITE_ONCE(pci_crash_ready, true);
+
+#ifndef CONFIG_PCIEAER
+	if ((capture_flags & PCI_CRASH_CAPTURE_AER) &&
+	    !(capture_flags & PCI_CRASH_CAPTURE_ALWAYS))
+		pr_warn("capture=aer but CONFIG_PCIEAER=n; capture will not trigger unless set to 'always'\n");
+#endif
+
+	rcu_read_lock();
+	{
+		struct pci_crash_snapshot *s = rcu_dereference(pci_crash_snap);
+
+		pr_info("ready: %u devices (%zu bytes), capture=%s devices=%s\n",
+			s ? s->num_devs : 0, s ? s->buffer_size : 0,
+			capture, devices);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+late_initcall(pci_crash_init);
+
+/* Built-in only: crash infrastructure must outlive all drivers. */
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Capture PCI config space at panic time for crash analysis");
+MODULE_AUTHOR("Amazon.com, Inc.");
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8614430ca212..8813f7e2e516 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/pci_crash.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -91,6 +92,18 @@ void crash_save_vmcoreinfo(void)
 		vmcoreinfo_data = vmcoreinfo_data_safecopy;
 
 	vmcoreinfo_append_str("CRASHTIME=%lld\n", ktime_get_real_seconds());
+
+	/* Capture PCI config space before kexec into crash kernel */
+	pci_crash_save();
+	if (pci_crash_pagemap_phys && pci_crash_buffer_size > 0) {
+		vmcoreinfo_append_str("PCI_CRASH_PAGEMAP=0x%llx\n",
+				      (unsigned long long)pci_crash_pagemap_phys);
+		vmcoreinfo_append_str("PCI_CRASH_VERSION=%d\n",
+				      PCI_CRASH_VERSION);
+		vmcoreinfo_append_str("PCI_CRASH_BUF_SZ=%zu\n",
+				      pci_crash_buffer_size);
+	}
+
 	update_vmcoreinfo_note();
 }
 
-- 
2.47.3

