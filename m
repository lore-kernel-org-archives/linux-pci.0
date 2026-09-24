Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78794CE66A
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271310; cv=none; b=jwO0vRmAF08eWa8gCbM6X5JJ4zP44PDDbtTQaqzRaNdUra6Jqijc/gYg7lMrNYH2gmW6euH5NVP728VN5lJD1fIt6o0cqWvDJMjet19PXCkBLSEx4lpSoZyX8c22iMLHC7TgdaY61jtUQR+Y5PWhtNIfRcSbhif0ZchbH5F//7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271310; c=relaxed/simple;
	bh=gB+2zgUJpk/C+IftryDSf7E7Kv7fJP0rypavlWS2Ee4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jyZeQxh9z4cTeBcRqptEd1tsGfmpUoWHDm3Sgt6UPv7qPwto6J4YInpf5W2I1GLON6GWVZ7f+i7lfgiWGh4L9QMq1nT/kY0T4Lf/uD71CWF+QCcrQtkiMbrYhzIIqChSOvfsrlPuiPATH8jvxZ7JUctBHZqVEYTMxCu3MFDNtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AgdHdBUi; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AgdHdBUi"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a0ae3eac32so134782a91.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271308; x=1790876108; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bifIYNcf5W5G5Dl02fXRxJ/gYcCscStcB/nVOPYZVpA=;
        b=AgdHdBUiA/MztcqC1Vm5UKaDSeAQnorsai4CXuV8EE8knwdkCZBW0XBgzKq2vm0wPb
         NdiUsNKtl8Uog0KOb2yDhBnZ0+u3zwafBhRy1d9Rnu0k3ETgcnwjE5NvsvyYUtABrRM6
         6b0kWa2wOfiLC1GGWkkXpExI6Q2alcdCLP2NRvtyfLbj48SYfbT67WY0YUkKjnMZGHLK
         etkSbdyJXzBjbicprk5wL0fXL5oC0geh9LZE4WLuT9/Sv0IeLwSWVMr7fbSNbDcDNWvR
         apxiJ5/QcUJZdVriTjILkGNVMXQmeLnleNH9oO0rH0ufO1EvWgPRUyXZjoiZP2sga1AS
         SezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271308; x=1790876108;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bifIYNcf5W5G5Dl02fXRxJ/gYcCscStcB/nVOPYZVpA=;
        b=nD7vjKZNlPth6Lh1W/SVibotdZGn+QDJkscM/IndjYiFw7H053z9eGCczLBVJu+Ulc
         MFIICrMrKDyS+K2k7k3ukjB0WBkc6nWsCJMR+kzeJ8Klin8o9oWzrRwkDc1k0HaetJfI
         COY14NAgRzR6vpEpnhH4L2/B+cpHC//JrBJqM5uOiwYzoE7MpuC/2vNqvS3kYAL6XIch
         PvUsWV5Z0EXdP7sk0D7+gSMsBKNxKIFuPX3PDRuTqWJAGnpuNIqCplVlodbVRWYLXW0O
         uMnYX/aBEBCOGVY7dxZ1Yti4u5lHFK5vXOwJm3v3igXujsJ7CRZYaAmV4PJYvbvyTZMU
         zHGA==
X-Forwarded-Encrypted: i=1; AKwUvBxSiE5KySXBA5WXNNMN4L36EPwhAo4MNzLb4NXwk+7y4PSJtqmtDxxr1OD79Xz22bBGBn+3ZxPKKDE=@vger.kernel.org
X-Gm-Message-State: AFuF++kFijJ+hSLwFb7FA+gKQWTbxsovcIbG7CMdC2x5hzsF5mzRmvr9
	V3AwxeSNP4Rt7QBTb0UeRchsfsx4sG6DwAybzOeWo312/FV6gXLgEdyjkut+rwladLo3DcofRWV
	5a0X/GnMxJqQJBA==
X-Received: from pgdh26.prod.google.com ([2002:a05:6a02:519a:b0:cc5:1155:96c7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c4:b0:39e:6c69:f46f with SMTP id 98e67ed59e1d1-3a098cf446amr2985971a91.46.1790271307721;
 Thu, 24 Sep 2026 10:35:07 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:46 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-1-dmatlack@google.com>
Subject: [PATCH 00/15] PCI: Index saved capability state by configuration
 space offset
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

This series replaces the per-capability save buffers in the PCI core with
a single per-device store indexed by the offset of each register in the
device's configuration space, and lays out struct pci_saved_state the
same way.

Motivation
----------

VFIO needs to carry a device's saved state across a Live Update kexec.
VFIO snapshots a device's pristine configuration with
pci_store_saved_state() when the device is first opened and restores it
with pci_load_and_free_saved_state() when the device is last closed, and
a Live Update kexec can happen in between.

struct pci_saved_state cannot be handed to the next kernel today. Its
layout is defined entirely by the kernel that produced it: which
capabilities get a record, how large each record is, and what each word
within a record means are all properties of the code that happens to be
saving them. Nothing ties a saved value back to the register it came
from, so a receiving kernel has no way to tell whether a blob describes
the device in front of it.

The layout this state wants is the one the device already defines. If a
saved value is identified by the configuration space offset of its
register, the shape of the blob becomes a property of the hardware rather
than of the kernel version, and the receiving kernel can validate it
against the device it enumerated.

The same change addresses a second problem. Capability save buffers are
allocated at nine sites (plus one hand-built by a quirk) spread across
three phases of a device's life (device configuration, capability init
and, for DPC, portdrv bind). Each allocation can fail on its own. Four
of them (AER, DPC, PTM, TPH) ignore the failure and their save paths
skip a missing buffer quietly, so the capability goes unsaved with no
indication why. After this series a device has exactly one saved state
allocation, and its failure is reported.

The series is roughly net-neutral in size (680 insertions, 621
deletions), but most of what it adds is the store itself: 305 lines in
drivers/pci/saved-caps.c, nearly half of them comments. Outside of it
the series removes 246 more lines than it adds.

More importantly, it replaces save/restore code that only worked because
of careful orchestration. The save and restore routines of each
capability had to walk the same registers in the same order through a
running buffer cursor, the allocation had to be sized to match what the
save side would later write, and code elsewhere had to know which slot
held which register. VC went further, using a single walker in three
modes to size, save and restore. Getting any of these out of step put the
wrong value into a register on restore, usually without any error. After
this series, saving is a single pass over the reservation bitmap, and
each restore routine names its registers by configuration space offset,
so it reads as a plain list of the registers being put back. Reserving,
bounds checking, allocating, saving and restoring live in one helper
library that every capability shares.

Series overview
---------------

  Patch 1 moves the DPC save buffer allocation from dpc_probe() to
  pci_dpc_init(), so that every capability save buffer is allocated in
  one phase of a device's life, which patch 2 relies on. It also closes a
  window in which a reset loses the DPC Control register.

  Patch 2 adds the store. Capabilities reserve registers by configuration
  space offset during device setup, and the values are allocated in a
  single array once every capability has been initialized.

  Patch 3 lays out struct pci_saved_state by configuration space offset:
  a bitmap of the DWORDs that were saved, plus their values. It comes
  before the conversions so that the blob describes a device's complete
  saved state at every commit in the series; see "Design notes" below.

  Patches 4-11 convert PCIe, PCI-X, LTR, L1SS, AER, PTM, TPH and DPC to
  the store, one capability at a time.

  Patch 12 lifts the VC Resource Control restore out of the VC
  save/restore walker, and patch 13 converts VC to the store. VC is
  converted last because its walker also handles the arbitration
  tables, whose size the device reports at runtime.

  Patch 14 collapses the save side. Once every capability has reserved
  its registers, the reservation bitmap says exactly which DWORDs
  pci_save_state() has to read, so eight per-capability save functions
  are replaced by one pass over the bitmap.

  Patch 15 removes struct pci_cap_saved_state and the machinery that
  managed it.

Design notes
------------

The store covers capability registers only. The configuration space
header continues to be saved in pci_dev.saved_config_space, which is
embedded in struct pci_dev so that saving it cannot fail, and which a
couple of drivers index directly.

struct pci_saved_caps is embedded in struct pci_dev for the same reason.
Every device needs its reservation bitmap during enumeration, so
allocating it separately would save nothing and only add a failure path
that every caller has to tolerate. It costs 136 bytes per device, which
the allocations it replaces more than pay for; see "Memory overhead"
below.

Registers are saved a DWORD at a time, since configuration space reads
have no side effects, but restored at their own width, because
neighbouring registers within a DWORD may be RW1C or may not tolerate
being written, e.g. PCI_EXP_DEVCTL and PCI_EXP_DEVSTA share a DWORD.

The series is ordered so that struct pci_saved_state describes a
device's complete saved state at every commit. pci_store_saved_state()
is the only way for a driver to hold a device's pristine state across a
reset, and a load that is missing registers fails silently, so a bisect
landing in the middle of the series must not produce a partial blob.
Patch 3 therefore lands before the first conversion, and for as long as
the two representations coexist the blob carries the DWORD array
followed by the records of whatever has not been converted yet. Patch
15 drops the records.

One subtle change in this series is that PCIe capability registers are
now always read from the device during save, instead of using
pcie_capability_read_word() (which returns 0 for registers the device
does not implement). However, reads of PCI config space have no
side-effects, and the restore side still properly skips writing to
unimplemented registers by using pcie_capability_write_word().

Memory overhead
---------------

Embedding struct pci_saved_caps grows struct pci_dev by 136 bytes on
x86_64, from 2424 to 2560 bytes in a non-debug build. Both sizes fall in
the same kmalloc-4k bucket, so a device costs no more slab memory than
it did before.

What the series removes is larger. Every saved capability used to get
its own allocation, and each one paid a 24-byte struct
pci_cap_saved_state header for a payload of 2 to 20 bytes, which then
rounded up to the next slab bucket:

  - A PCIe endpoint with AER, LTR, L1SS and PTM had five allocations
    occupying 224 bytes. It now has one of 64 bytes.

  - A root port that also has DPC had six occupying 256 bytes. It now
    has one of 96 bytes.

  - An SR-IOV VF had one of 64 bytes. It now has one of 32 bytes.

That is 32 to 160 bytes less per device, roughly 80 KB on a machine with
512 devices, and one allocation per device rather than one per
capability.

struct pci_saved_state goes the other way. It now carries the 128-byte
DWORD bitmap in place of a packed list of records, so a blob for the
endpoint above grows from 192 to 256 bytes, and one for the root port
from 192 to 512 bytes. Only the drivers that call
pci_store_saved_state() allocate one, and only while they are holding a
device's state. If that ever matters, the blob could carry only the
bitmap words covering the device's configuration space rather than all
128 bytes.

Cleanups that fell out
----------------------

  - quirk_intel_qat_vf_cap() no longer builds a PCIe save buffer by hand,
    since the reservation keys off pci_is_pcie() rather than off the
    capability list.

  - pci_update_aspm_saved_state() no longer has to know that cap[1] of
    the PCIe save buffer is the Link Control register.

  - pci_vc_do_save_buffer() loses its dual size/save/restore return
    value, its running length, its buffer cursor, and the check that
    compared the two against each other. Patch 14 then drops its save
    mode entirely.

  - AER, PTM and TPH report a failure to reserve. They ignored the
    allocation return value entirely.

  - pci_store_saved_state() used to build a packed array of struct
    pci_cap_saved_data whose entries can become misaligned, after which
    pci_load_saved_state() could perform unaligned 32-bit reads of
    cap->size, which can cause faults on some architectures. This minor
    bug is eliminated by this series.

Future work
-----------

  - Support struct pci_saved_state being preserved and restored across
    a Live Update kexec by VFIO. This will be mostly mechanical (e.g.,
    defining a serialized version in include/linux/kho/abi/ and
    implementing trivial serialization/deserialization routines).

  - Make the one remaining save-state allocation failure fatal to device
    setup. pci_device_add() returns void today, so a device whose saved
    state could not be allocated is added anyway.


David Matlack (15):
  PCI/DPC: Allocate the DPC save buffer during device setup
  PCI: Add an offset-indexed store for saved capability registers
  PCI: Lay out struct pci_saved_state by configuration space offset
  PCI: Save PCIe state in the saved capability store
  PCI: Save PCI-X state in the saved capability store
  PCI/ASPM: Save LTR state in the saved capability store
  PCI/ASPM: Save L1SS state in the saved capability store
  PCI/AER: Save AER state in the saved capability store
  PCI/PTM: Save PTM state in the saved capability store
  PCI/TPH: Save TPH state in the saved capability store
  PCI/DPC: Save DPC state in the saved capability store
  PCI/VC: Split the VC Resource Control restore into a helper
  PCI/VC: Save VC state in the saved capability store
  PCI: Save reserved capability registers in a single pass
  PCI: Remove the per-capability save buffers

 drivers/pci/Makefile     |   3 +-
 drivers/pci/pci.c        | 304 +++++++++++++-------------------------
 drivers/pci/pci.h        |  49 +++----
 drivers/pci/pcie/aer.c   |  74 ++++------
 drivers/pci/pcie/aspm.c  | 102 ++++---------
 drivers/pci/pcie/dpc.c   |  32 +---
 drivers/pci/pcie/ptm.c   |  33 +----
 drivers/pci/probe.c      |   9 +-
 drivers/pci/quirks.c     |  30 +---
 drivers/pci/saved-caps.c | 305 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/tph.c        |  62 ++------
 drivers/pci/vc.c         | 267 +++++++++++++++++-----------------
 include/linux/pci.h      |  31 +++-
 13 files changed, 680 insertions(+), 621 deletions(-)
 create mode 100644 drivers/pci/saved-caps.c


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

