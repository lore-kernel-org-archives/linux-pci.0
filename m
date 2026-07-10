Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8C3B95F8
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718785; cv=none; b=aVA7r3u9idSqXHU6VOuU6pb5JJ5MmSD3Tf5Z9YD1yweycboslddy312TU2GPIidMlWyvNUlacmIJNwiRqMbUw4KMbdx83KcKu+01bkv5UcQ0TnV0mCClFUsz0z7VOPl8l13bSfVnDTLMC4tPt2IEP7sOfWGVkBEuiiC3AyG3Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718785; c=relaxed/simple;
	bh=1aHgjBy7B5CxJBu4ZKVWz0/EFWhYHP/gU/x++i2l4Gs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T3NRjztVUwz4TuLN0cQVyuMsS5HdheXNeffhgCV3pcQufKlzyv/mtRji+SSO206pC/52pD0v1c6xDRCPGSJsAmO0qv7mKoqbt7BCgq7LUAywX0/FRn/eyAZoNzYIH36NnyT72H35ErjmFFD5r4x1s8G6bO/fQPHgIEvMC8ZXyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ38aPit; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ38aPit"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-848662cd2a1so1740495b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718783; x=1784323583; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=he4LlVclK6dw2y5zUcgVn+6YxGRxdITg+d/Le4uVaLE=;
        b=hZ38aPitmeqOJBbteG1aSNiMhcbmq/k0vyRSNG/G4qkMw59dBeTru1NizEu0G0zByh
         FNi43/mDatKbD6gwKzujOntTpIusDwk/wdzn2WHTVeG+/6H0yZKRC66zi04CiBi3wWmH
         eFRVUdRD4YNT15RTwlzClekqnWv8gNvQ6cnp+3XSv+xuWfoA3i/lUCS70w/KK4mrBxxq
         HbDtaE8iKiGSe1OP1tzzhyqUprrQTt1CaDrsR6dKWQerEIDEDavADPIJt1RDCckW4puP
         2LCAE+Ym7Os80N74iKRy9DWd5TfDGvelUx8+Q0zDOK6r2JWREstJI/uz9p0SkT4yIWi+
         aBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718783; x=1784323583;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=he4LlVclK6dw2y5zUcgVn+6YxGRxdITg+d/Le4uVaLE=;
        b=ccF/6n/smkTeh8L1aaftGrojv0484I1fC+/P36mo9pWMCog1WZfR0DwtED5FjM1KC2
         G7lyFqS4jBwadwISdQy7ehXL+WEX9f5UwgXXmMuSFzZWbboiN0W6hkv019JLY3VPS65U
         WBcEf0PUAr6LHGMA5z/nGOZlNt8m2rq1yDy2XTg85/hF2426n+mtZSGdAzQ/7CM6q9Wv
         bPgGFGh7oHE1qK0GokPxgU7unJiEYp29NZJhe3JV+F1HBMwYM91EGI461LRwdVrg9uMU
         gCJ5tA8IAMEq9O7XcLUJpMHgMIxYJv32VXnj08LiHpxD61w6v2vu5YhDG6j2UMwE109E
         3ftg==
X-Forwarded-Encrypted: i=1; AHgh+RoT4DIaq2Bci2Oqs03nR9h+qQK+ljglzJiV2fyJxM57yiam5yV/7PUq5wKezdby00YOMAU6C9XLXMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX671q02mv9TP6OT4VtIneb5bzoUzmr0Od+QaNJOPyqa+xJx6d
	SelEOsol3w5CmyKIHmyE1bk41Jejly6gSX/SiAK6VTIuloA+GQBlhUtK1DcdJ1qnEm2coB9+XId
	fNJGoP4hPvwYkog==
X-Received: from pfud15.prod.google.com ([2002:a05:6a00:10cf:b0:847:9be8:84d5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:228e:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-848896c39e2mr550236b3a.9.1783718783127;
 Fri, 10 Jul 2026 14:26:23 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:03 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-1-dmatlack@google.com>
Subject: [PATCH v7 00/12] PCI: liveupdate: PCI core support for Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7

This series introduces initial support in the PCI core for Live Update,
enabling drivers to preserve PCI devices across a kexec-based kernel
update without interrupting the device. This functionality is critical
for minimizing downtime in environments where PCI devices (e.g., those
assigned to VMs via VFIO) must continue operating or maintain state
across a host kernel upgrade.

Specifically, this series allows preserved PCI devices to perform
uninterrupted memory transactions (DMA) to/from system memory across a
Live Update. These devices can be behind a bridge but must not be VFs.
Support for P2P and VF preservation will be addressed in future series.

Series Overview
---------------

This series implements the following to support PCI device preservation
across Live Update:

  1. Set up a File-Lifecycle-Bound (FLB) handler to track and preserve
     PCI-specific state (struct pci_ser) across Live Update using Kexec
     Handover (KHO).

  2. Add APIs for drivers to register devices for preservation
     (outgoing) and for the PCI core to identify preserved devices
     during enumeration (incoming)

  3. Automatically preserve all upstream bridges for any preserved
     endpoint. Use reference counting to ensure bridges remain preserved
     as long as any downstream device is preserved.

  4. Guarantee that preserved devices retain the same RequesterID (bus,
     device, function) for the duration of their preservation by
     inheriting secondary bus numbers, subordinate bus numbers, and ARI
     Forwarding Enable on preserved bridges.

  5. Guarantee that memory transactions to/from preserved devices are
     routed consistently by inheriting Access Control Services (ACS)
     flags across a Live Update, from the endpoint up to the root port.

  6. Modify the PCI shutdown path to avoid disabling bus mastering on
     preserved devices, thereby allowing preserved devices to perform
     uninterrupted during kexec for Live Update.

  7. Provide comprehensive documentation for the FLB API, device
     tracking mechanisms, and the division of responsibilities between
     the PCI core, drivers, and userspace.

Dependencies
------------

This series is built on top of the next branch of the liveupdate.git
tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=next

Testing
-------

This series was tested in conjunction with v4 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub. Some
conflict resolution was required to rebase VFIO v4 patchs on top of the
7.2-rc1 base.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v7-with-vfio

Testing was performed using the new VFIO selftests:

  - vfio_pci_liveupdate_uapi_test
  - vfio_pci_liveupdate_kexec_test

Both tests were run in a QEMU-based VM environment (using a single
virtio-net PCIe device connected to a root port to exercise bridge
support) and on bare metal using an Intel EMR server with 8x Intel DSA
PCIe devices and 1x NVMe device.

Future Work
-----------

Following this series, we expect to make further improvements to the PCI
core support for Live Update:

  - Allow P2P across Live Update by avoiding resizing or moving
    preserved device BARs and preserving all upstream bridge windows.

  - Support preserving Virtual Functions by preserving SR-IOV
    configuration on PFs and enumerating VFs after Live Update.

Changelog
---------

v7:
 - Use kho_block_set for dynamic device preservation, redefining ABI struct
   pci_ser to use a physical address instead of a fixed-size flexible array
   (Pasha Tatashin)
 - Add kernel-doc comments for pci_liveupdate_scan_bridge_begin() and
   pci_liveupdate_scan_bridge_end() (Pasha Tatashin)
 - Move refcount to patch 1 and adjust KHO ABI versioning progression
   accordingly (Pasha Tatashin)
 - Sphinx documentation improvements: add _luo and _flb labels and use
   acronyms with :ref: links (Pasha Tatashin)
 - Panic on failure to retrieve incoming PCI FLB data to avoid ongoing
   DMA from preserved devices causing memory corruption (Sashiko,
   Samiullah Khawaja)
 - Clarify comment about device-specific ACS quirks in incoming kernel
   (Pranjal Shrivastava)
 - Sort includes alphabetically in liveupdate.c (Pasha Tatashin)

v6: https://lore.kernel.org/linux-pci/20260522202410.3104264-1-dmatlack@google.com/
v5: https://lore.kernel.org/linux-pci/20260512184846.119396-1-dmatlack@google.com/
v4: https://lore.kernel.org/linux-pci/20260423212316.3431746-1-dmatlack@google.com/
v3: https://lore.kernel.org/kvm/20260323235817.1960573-1-dmatlack@google.com/
v2: https://lore.kernel.org/kvm/20260129212510.967611-1-dmatlack@google.com/
v1: https://lore.kernel.org/kvm/20251126193608.2678510-1-dmatlack@google.com/
rfc: https://lore.kernel.org/kvm/20251018000713.677779-1-vipinsh@google.com/


David Matlack (12):
  PCI: liveupdate: Set up FLB handler for the PCI core
  PCI: liveupdate: Track outgoing preserved PCI devices
  PCI: liveupdate: Track incoming preserved PCI devices
  PCI: liveupdate: Document driver binding responsibilities
  PCI: liveupdate: Keep bus numbers constant during Live Update
  PCI: liveupdate: Auto-preserve upstream bridges across Live Update
  PCI: Refactor matching logic for pci_dev_acs_ops
  PCI: liveupdate: Inherit ACS flags in incoming preserved devices
  PCI: liveupdate: Inherit ARI Forwarding Enable on preserved bridges
  PCI: liveupdate: Freeze preservation status during shutdown
  PCI: liveupdate: Do not disable bus mastering on preserved devices
    during kexec
  Documentation: PCI: Add documentation for Live Update

 Documentation/PCI/index.rst                   |   1 +
 Documentation/PCI/liveupdate.rst              |  29 +
 .../admin-guide/kernel-parameters.txt         |   6 +-
 Documentation/core-api/liveupdate.rst         |   5 +
 MAINTAINERS                                   |  15 +
 drivers/pci/Kconfig                           |  15 +
 drivers/pci/Makefile                          |   1 +
 drivers/pci/liveupdate.c                      | 910 ++++++++++++++++++
 drivers/pci/liveupdate.h                      |  68 ++
 drivers/pci/pci-driver.c                      |   9 +-
 drivers/pci/pci.c                             |  14 +-
 drivers/pci/pci.h                             |   5 +
 drivers/pci/probe.c                           |  22 +-
 drivers/pci/quirks.c                          |  58 +-
 include/linux/kho/abi/pci.h                   |  59 ++
 include/linux/pci.h                           |   4 +
 include/linux/pci_liveupdate.h                |  77 ++
 17 files changed, 1260 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/PCI/liveupdate.rst
 create mode 100644 drivers/pci/liveupdate.c
 create mode 100644 drivers/pci/liveupdate.h
 create mode 100644 include/linux/kho/abi/pci.h
 create mode 100644 include/linux/pci_liveupdate.h


base-commit: 1354afac14579ad38279f12d660df961b5f20246
-- 
2.55.0.795.g602f6c329a-goog

