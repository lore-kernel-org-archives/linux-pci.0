Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925778;
	b=HZGvoMz6wTmXfWLz9XnD5EPuEzAc250TZbks/a6PX09qOCR+p0YOo9WDcyQazY49EuSg
	 ecC4aHkEEhbMhLxfFtoaZ45U5ncHy53Q4Fscw8xUwggNWbeW+iNFDkT5WVaw2dba0z/n9
	 8VyQDw6D617h6GCG3euxAlLGERgdFEyMJEgT9LsX3618O1JHTIq7Zc3mOQRisbuJV2yTB
	 tfatr/zATfmTRHew9v05OFp9VYMA3GYzoez6L3rS9TC9Ewhy+cwgfwbI3aZkUm3B9t7wm
	 XZRQGb1rzeh2HesdMdmG8F/5cMRLght3soswtd2v8sprS1gUySi/TyV4tnGL6Ztq38A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=;
	b=V+huwc9F64nWWa6li+cyGwMdsUiikKhrRU/LAbXDj4O3JKRQXAHlm2e2JxUSIPchINSj
	 8Ne1GP2YqX2Aw0+a/ogL3NJT64sSGDUmI7pnGJDpu8ozA53CBUtwTiE3+Q8Wm40fNy4PD
	 RdlbLQZnarUZXmNJSjaUPU+xWv2cl9QzFejoQS7ZM8xYgooJqmKEShgiwGIlc28jfTjim
	 6V+idom4jQpvBA8AO1Np1HRPOSktjDB709Ffjo/roRDwtkf4UpG9AMnQtGUrsLDqyk42M
	 MhlCopbpsuae6Upa3USPNwCjH++Jeydepahmi8t5ShU8BYIFDumP/JeXhRvVLa28rAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="hIhm9N/a";
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86271606A31B
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86271606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hIhm9N/a
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-823d73ffca1so265225a34.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 16:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925776; x=1794530576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=;
        b=hIhm9N/aAW5eoDmq7Lh+66rWad9C2Y/yanhFRthBpH+FxJOk3Anrcf4Ikn9EdqX+37
         QkBPCxiyj27NaWLe9GkMgw32gdGK4OhRxRD3/cUsG+Cmqy1Hzd3LeE0jz8MOBxu4cO0o
         xQ7xuJuexvRhukDdaNp/qsbRbRVgIH0aMb0MLiMV+gPIeciIRr6jS4sKzfiwzl2VuIqm
         bKn4dGwe8IqZwTiL0Pkju3zFhfSjTyG9BFs2y73iOrxtgejq3M73bkxeuPRKDPOUqsGt
         e9DMG9Obt/9QjwWOz1msy5IFqwJlnBwY8gPPFfFfjS/kF8QoY5uU6+iDV6eAbJYGwlmi
         yVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925776; x=1794530576;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3QnOqT1bd63wcrV6KvOAip3wCLe11FN2NBTadJaa9M=;
        b=KPpv1DNvkCap+rCwTMX0ypolZFxeFrVpZzoVi5DDKF8QJY5vvQF6kPGF9E1LBe8Btf
         TMVjcAKWJm3puilYGReGEhItIi7bdbaxXzmBKaf57NDsjlN3bVmtldCcCPM4ryVutPGR
         zz5mxxeyKR1K/ipKJacvWrTMFjeLJH2nxPuXOZQxNEd6b5990W/KxrHAzXf9RQUC1nhV
         ZXHXJQ6VFovq4ysdKoVA6TRy+O06JEYlZMtRThZsVHoUKqSyuI1MgK56BGE4KbpoGJqa
         LQzwCHiSNZ16L7dOEvOLp0DhyHv6YLofPpNKMeR+BsXdImpHQSX6NE6OrhE8tvZ0Br2k
         nj7w==
X-Forwarded-Encrypted: i=1; AKwUvBziU2lZmQSA9bVwDZPxFWhateJbwXNjJfaBUU9G8D1LS10o65/6KZru9Wy/YazmjBLFIwVWTxXc6TQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZpurvAvw3KzKtcQZxZMZqNhBuoLaalAW69rKMSw3aJpnfX6vT
	hZrQiszd0GOPFkSdsxa36dOmNjhQQewbjVy5Wsck5ApGGcMIwIvTYK4DklRMkYaDbg4/+96WLiz
	Ce6ISyuO7eA01pw==
X-Received: from ilmt14.prod.google.com ([2002:a05:6e02:10e:b0:50d:9814:cccb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3a0d:b0:540:5827:6d8a with SMTP id 5614622812f47-567e185afd4mr616724b6e.66.1793925776141;
 Thu, 05 Nov 2026 16:42:56 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-1-dmatlack@google.com>
Subject: [PATCH v2 00/17] PCI: Index saved capability state by configuration
 space offset
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/savedstate/v2

This series replaces the per-capability save buffers with a single
per-device store indexed by configuration space offset, lays out struct
pci_saved_state the same way, and adds helpers for drivers to preserve
struct pci_saved_state across a Live Update.

The main motivation here is Live Update. VFIO snapshots a device's state
with pci_store_saved_state() when the device is first opened and
restores it with pci_load_and_free_saved_state() when it is last closed.
A Live Update can happen in between, so VFIO needs to pass this state to
the next kernel.

This is not safe today because the layout of struct pci_saved_state is
defined by the kernel that produced it: which capabilities get a record,
how large each record is, and what each word in it means.  Nothing ties
a saved value back to the register it came from, so preserving it as is
would turn the private layout of every capability save buffer into Live
Update ABI [1]. Indexing saved values by configuration space offset
makes the layout a property of the hardware rather than of the kernel
version, so it can be preserved as a bitmap of saved DWORDs plus their
values, and the next kernel can decide per register what to restore.

[1] https://lore.kernel.org/linux-pci/aukvTvnfyAvahb51@google.com/

The same change also makes saving and restoring capabilities simpler
and more robust:

  - Capability save buffers were allocated at ten sites (plus one
    hand-built by a quirk) across three phases of a device's life, and
    four of them (AER, DPC, PTM, TPH) ignored allocation failure, so the
    capability silently went unsaved (patch 1 fixes DPC). Now each
    device has exactly one allocation, and its failure is reported.

  - Each capability's save and restore routines had to walk the same
    registers in the same order through a buffer cursor, and code
    elsewhere had to know which slot held which register. Now saving is
    a single pass over a bitmap of reserved registers, each restore
    routine names its registers by offset, and the common logic lives
    in one small helper library (drivers/pci/saved-caps.c).

Patches 1-16 are roughly net-neutral in size. Outside of the new helper
library (half of which is comments), this series removes about 250
lines from the PCI core.

Series Overview
---------------

This series implements the following:

  1. Allocate the DPC save buffer during device setup instead of when
     the portdrv DPC service binds, so that every capability is set up
     in the same phase, and a reset before the service binds no longer
     loses the DPC Control register (patch 1).

  2. Add the per-device store. Capabilities reserve registers by offset
     during device setup, and the values are allocated in one array once
     every capability has been initialized (patch 2).

  3. Lay out struct pci_saved_state as a bitmap of saved DWORDs plus
     their values (patch 3).

  4. Convert PCIe, PCI-X, LTR, L1SS, AER, PTM, TPH, DPC, ACS and VC to
     the store, one capability at a time (patches 4-14).

  5. Replace the per-capability save functions with a single pass over
     the reservation bitmap (patch 15).

  6. Remove struct pci_cap_saved_state and the code that managed it
     (patch 16).

  7. Add helpers that preserve a struct pci_saved_state in KHO memory
     for the next kernel, which callers reference by its physical
     address (patch 17).

Design Notes
------------

  - The store only covers capability registers. The configuration space
    header is still saved in pci_dev.saved_config_space.

  - Registers are saved a DWORD at a time, since configuration space
    reads have no side effects, but restored at their own width, since a
    neighbouring register in the same DWORD may be RW1C (e.g.
    PCI_EXP_DEVCTL and PCI_EXP_DEVSTA).

  - struct pci_saved_state describes a device's complete saved state at
    every commit, so a bisect landing in the middle of the series does
    not silently lose state in pci_load_saved_state().

  - PCIe capability registers are now saved with raw DWORD reads instead
    of pcie_capability_read_word(), which returns 0 for registers the
    device does not implement. Restore still goes through
    pcie_capability_write_word(), which skips them.

  - The reservation bitmap is embedded in struct pci_dev so that
    reserving cannot fail. This grows struct pci_dev by 136 bytes on
    x86_64 (2448 to 2584), which stays in the same kmalloc-4k bucket.
    Removing the per-capability allocations, each with a 24-byte header,
    saves 32 to 160 bytes of slab per device. The blob from
    pci_store_saved_state() grows (e.g. from 192 to 256 bytes for a
    typical endpoint), since it now carries a 128-byte bitmap.

  - Along the way, quirk_intel_qat_vf_cap() no longer builds a PCIe save
    buffer by hand, and pci_load_saved_state() no longer performs
    potentially unaligned 32-bit reads of packed records.

Merge Plan
----------

This series applies on top of v10 of the PCI core support for Live
Update series [2], which is targeting Linux 7.5. This series is
targeting Linux 7.5 as well.

Both series will be merged through liveupdate.git, matching the
agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

[2] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/

Testing
-------

All patches were build-tested individually. The series was tested
using the VFIO selftests, which reset devices many times and so exercise
the PCI core's save and restore paths. The tests were run in a QEMU VM
using an emulated igb device, and on bare metal using an Intel DSA
device on an Intel server.

To check that the series does not change what gets restored, every PCI
config write made by the kernel with and without this series was traced
in QEMU (pci_cfg_write trace event) while performing FLR, PM and VF
resets, runtime suspend/resume under vfio-pci, and the VFIO selftests on
an igb device below a PCIe Root Port, and while resetting a PCIe switch
Downstream Port. The writes to all of these devices were identical. Of
the capabilities this series touches, that setup covers PCIe and AER.

The series was also build-tested on x86_64, i386, arm64 and ppc64le,
with gcc and clang at W=1, with sparse, with CONFIG_PCI_LIVEUPDATE
enabled and disabled, and with each of CONFIG_PCIEAER, CONFIG_PCIE_DPC,
CONFIG_PCIE_PTM, CONFIG_PCIEASPM and CONFIG_PCI_IOV disabled.

The helpers in patch 17 were tested across a Live Update selftests (not
yet posted), extended so that the test driver preserves each device's
struct pci_saved_state along with the device. On x86_64 and arm64 in
QEMU, for every tested topology, the next kernel got back the state that
was preserved, dropped a saved DWORD that it does not reserve, and
restoring the state wrote back a register that had been changed before
the Live Update. The full set of patches used for testing can be found
on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/savedstate/v2-test

Future Work
-----------

The next version of the VFIO PCI Live Update series will use the new
helpers to preserve the state that VFIO captures with
pci_store_saved_state(), in place of [PATCH v6 05/27] [3]. Please see
the PCI core Live Update Roadmap for the rest of the planned work:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

[3] https://lore.kernel.org/linux-pci/20261102153656.1431701-6-vipinsh@google.com/

Separately, the one remaining saved state allocation could be made fatal
to device setup. pci_device_add() returns void today, so a device whose
saved state could not be allocated is still added.

AI Assistance
-------------

This series was developed with the help of an LLM-based coding
assistant, which was used to draft code and commit messages and to
review the series. I reviewed every change and take full responsibility
for all of it.

Changelog
---------

v2:
 - Rebase onto v10 of the PCI core support for Live Update series, and
   target liveupdate.git.
 - Add patch 12 to convert the ACS save buffer added by the PCI core
   support for Live Update series to the store.
 - Add patch 17 with helpers to preserve struct pci_saved_state across
   Live Update, replacing [PATCH v6 05/27] of the VFIO PCI Live Update
   series [3] (Vipin, Bjorn).
 - Drop the Assisted-by tags, which upstream no longer asks for, and
   describe the use of AI tools in the cover letter instead.
 - Add pci_saved_cap_shift() so the code reading and writing 16-bit
   saved registers shares one shift calculation (Josh).
 - Move the rename of pci_allocate_cap_save_buffers() to
   pci_reserve_saved_caps() from patch 16 to patch 14, where it stops
   allocating, and mention ACS and VC in the comment at its call site
   (Josh).
 - Fix inaccuracies in the commit messages of patches 2, 7 and 15
   (Josh).

v1: https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/


David Matlack (17):
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
  PCI: Save ACS state in the saved capability store
  PCI/VC: Split the VC Resource Control restore into a helper
  PCI/VC: Save VC state in the saved capability store
  PCI: Save reserved capability registers in a single pass
  PCI: Remove the per-capability save buffers
  PCI: liveupdate: Add helpers to preserve struct pci_saved_state

 Documentation/PCI/liveupdate.rst |   3 +
 drivers/pci/Makefile             |   3 +-
 drivers/pci/liveupdate.c         | 133 ++++++++++-
 drivers/pci/pci.c                | 383 +++++++++++--------------------
 drivers/pci/pci.h                |  59 ++---
 drivers/pci/pcie/aer.c           |  80 +++----
 drivers/pci/pcie/aspm.c          | 111 ++++-----
 drivers/pci/pcie/dpc.c           |  41 ++--
 drivers/pci/pcie/ptm.c           |  42 ++--
 drivers/pci/probe.c              |   9 +-
 drivers/pci/quirks.c             |  30 +--
 drivers/pci/saved-caps.c         | 308 +++++++++++++++++++++++++
 drivers/pci/tph.c                |  68 ++----
 drivers/pci/vc.c                 | 272 +++++++++++-----------
 include/linux/kho/abi/pci.h      |  32 +++
 include/linux/pci.h              |  31 ++-
 include/linux/pci_liveupdate.h   |  23 ++
 17 files changed, 959 insertions(+), 669 deletions(-)
 create mode 100644 drivers/pci/saved-caps.c


base-commit: 312200e9211ede3f9a03cc17d094805e06e4674e
-- 
2.56.0.455.g6c5a503b38-goog

