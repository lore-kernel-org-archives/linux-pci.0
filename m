Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8225782A
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496056; cv=none; b=N2sPZnP7KFS455wEHRIL6BrKZQUSJ9i5bvlUNTFW1ZbU6gLr6X8OQGgJK0M3ppty/gj1SfKdnjQHIlA14Pm10VYM4yPBVVOcIZ6yMOoLkWTCJax1BjKZaDaAnSxo0aQgczphaMvvQW+Eniea/DcuODGDuXwfvOQJKh+SCRrFLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496056; c=relaxed/simple;
	bh=oZ1kBmIOYJuRNvIMXrGgP68C5ANgVzOr6VypJOgj7Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6AjNJorEVdwZstZ9v4oiZM6lHuiYwaKx88xGFcxs/ui4PGlmxAoDmSqSV8gpIUNi1PiJ3BT84NcJEnqoA1tb19RIuDvo3fWRP2IdeWLsB45CiedAhviJnXpnm4OLbolVx7CtmiV368N3ecFttD0gtb2LZQs6JuAUFLHdwL1Bvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iu3oTq+g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iu3oTq+g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496054; x=1804032054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oZ1kBmIOYJuRNvIMXrGgP68C5ANgVzOr6VypJOgj7Ow=;
  b=iu3oTq+goncO4DXx4k1+hrermIspMTBpkQQMwUIs+kLEca3SQpTzEaza
   8GwA9Bo0wMWgLmU+WzE8+zleMPFZ9Tq9f5f5ivJRDwoyLnB2stBneo6gP
   2tMn0vPUSelWStwwaJJhqGdml8N+bGe6yJXVByB/bAKTZtmi6ZH+V6SPo
   C/o25JkjXoHECRmOSi6XXrl0dXw4PEM23C7XDru9O+Xgrw5vZoNvF0jhM
   vMOH9mDolVLh5xKqjkPMHnM4BRI11H6SSwaEf0MgHWlbz4qacHVx738ip
   QtfRd6FjnZARmFTPAhTZFAEObF5aWgGxEulZc5/6PD19NAhhv0Ko8OJge
   w==;
X-CSE-ConnectionGUID: 1EYOVrRGTpqeVbtEtgIO/Q==
X-CSE-MsgGUID: BE8/zgiaQrmQa49OllLg7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73482811"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73482811"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:00:53 -0800
X-CSE-ConnectionGUID: LtBE7ckCT0GbV4MNVyRlCw==
X-CSE-MsgGUID: i0qq0h7oT/6akiH9/fuyOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="214967065"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa006.fm.intel.com with ESMTP; 02 Mar 2026 16:00:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	aik@amd.com,
	aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com,
	bhelgaas@google.com,
	alistair23@gmail.com,
	lukas@wunner.de,
	jgg@nvidia.com,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure
Date: Mon,  2 Mar 2026 16:01:48 -0800
Message-ID: <20260303000207.1836586-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [1]:
- Add a netlink ABI for conveying device attestation evidence and
  interface reports
- Add a module autoprobe policy proposal
- Add simulated device evidence support to samples/devsec/
- Add MMIO resource evaluation from a TDISP device interface report
- Include device_cc_accepted() proposals for DMA setup
- Restore a lookup mechanism from tsm class device to all established
  streams
- Clarify TEE vs Confidential vs Private in drivers/base/coco.c (Greg)
- Move 'cc_accepted' to an additional bitfield next to 'dead' (Greg)
- Drop device_cc_probe() proposal (Jason)

[1]: http://lore.kernel.org/20250827035259.1356758-1-dan.j.williams@intel.com

---

Overview
========

TEE I/O starts with the premise that devices are adversarial. That
threat model needs a series of new ABIs and mechanisms. The x86 changes
and the samples/devsec/ implementation in this set serve to have a
consumer for all of these proposed mechanisms.

1/ Userspace needs to be able to intercept driver attach. If a relying
   party does not endorse the system talking to a given device then
   userspace needs a control point to decline device operation. Module
   policy is suitable for that policy mechanism. See "device core:
   Autoprobe considered harmful?"

2/ Userspace needs to be able to gather evidence that validates the
   device's identity, configuration, and active mappings of MMIO and DMA.
   See "PCI/TSM: Add 'evidence' support"

3/ To gather and act on device evidence a device needs a "lock"
   mechanism to hold a stable configuration, and an "accept" mechanism to
   bring the device into operation after relying party validation. See
   "PCI/TSM: Add Device Security (TVM Guest) LOCK operation support" and
   "PCI/TSM: Add Device Security (TVM Guest) ACCEPT operation support".

4/ Drivers must be unmodified (1): ioremap() requests must automatically
   determine whether a resource range is mapped as encrypted or not. See
   "x86, ioremap, resource: Support IORES_DESC_ENCRYPTED for encrypted PCI
   MMIO". TODO: test unencrypted ranges in the middle of a PCI device BAR
   that is otherwise encrypted (MSI-X table case).

5/ Drivers must be unmodified (2): dma_alloc_coherent() and dma_map()
   need to bypass swiotlb and potentially modify DMA handles when a device
   is accepted to DMA direct to private memory. See "x86, swiotlb: Teach
   swiotlb to skip 'accepted' devices" and "x86, dma: Allow accepted
   devices to map private memory".

Note an example SEV-TIO implementation of the lock+accept operations is
out for review here [2] (based on older baseline of tsm.git#staging).

[2]: http://lore.kernel.org/20260225053806.3311234-1-aik@amd.com

On PCI/TSM Netlink and Rust SPDM
================================

The PCI/TSM netlink proposal is a result of the discussion from the Rust
SPDM proposal [3]. That thread discussed the merits of an SPDM netlink
ABI that multicasts signature events and a ".cma" keyring to
authenticate PCI devices. The PCI/TSM netlink proposal diverges
significantly based on the following assumptions:

1/ Device acceptance decisions are based on evidence material beyond
   whether the device publishes a valid root certificate (kernel SPDM
   library proposal).

2/ Automatic device identity revalidation after reset is secondary to
   initial device acceptance. It is follow-on work that can be achieved
   without a ".cma" ring. For example, cache a hash of the device
   certificate chain and / or measurements. Otherwise, mere identity
   revalidation is insufficient for PCI TDISP.

3/ Device evidence mutates based on userspace taking action on the
   device state. For example, the device interface report is not available
   until post "lock". The result, the netlink interface must be on demand,
   not implicit multicast. PCI/TSM evidence conveyance is a netlink
   "dump" request.

The proposal for how the native kernel SPDM support would interact with
the PCI/TSM implementation is via an "spdm-tsm" driver. An "spdm-tsm"
driver allows for userspace policy to select between a kernel native
"spdm-tsm" and "$platform-tsm" as only one TSM can have a session
established at a time.

[3]: http://lore.kernel.org/20260211032935.2705841-1-alistair.francis@wdc.com

On PCI/TSM Netlink and guest request
====================================

One of the open questions is whether pci_tsm_guest_req() should be used
to convey device evidence to guests.  In other words, if the core kernel
understands 'struct pci_tsm_evidence' in a common way across
architectures, why not implement a common transport and save
pci_tsm_guest_req() for other ancillary messages that are indeed
implementation specific?


This all passes a tools/testing/devsec/devsec.sh run. It wants a rebase
on v7.0-rc2. It is pushed out as new tag, devsec-20260302, in the
tsm.git#staging tree. The Maturity Map [4] has been updated accordingly.

[4]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/tree/Documentation/driver-api/pci/tsm.rst?h=staging

Dan Williams (19):
  PCI/TSM: Report active IDE streams per host bridge
  device core: Fix kernel-doc warnings in base.h
  device core: Introduce confidential device acceptance
  modules: Document the global async_probe parameter
  device core: Autoprobe considered harmful?
  PCI/TSM: Add Device Security (TVM Guest) LOCK operation support
  PCI/TSM: Add Device Security (TVM Guest) ACCEPT operation support
  PCI/TSM: Add "evidence" support
  PCI/TSM: Support creating encrypted MMIO descriptors via TDISP Report
  x86, swiotlb: Teach swiotlb to skip "accepted" devices
  x86, dma: Allow accepted devices to map private memory
  x86, ioremap, resource: Support IORES_DESC_ENCRYPTED for encrypted PCI
    MMIO
  samples/devsec: Introduce a PCI device-security bus + endpoint sample
  samples/devsec: Add sample IDE establishment
  samples/devsec: Add sample TSM bind and guest_request flows
  samples/devsec: Introduce a "Device Security TSM" sample driver
  tools/testing/devsec: Add a script to exercise samples/devsec/
  samples/devsec: Add evidence support
  tools/testing/devsec: Add basic evidence retrieval validation

 drivers/base/Kconfig                        |  28 +
 drivers/pci/Kconfig                         |   2 +
 samples/Kconfig                             |  19 +
 drivers/base/Makefile                       |   1 +
 drivers/pci/Makefile                        |   2 +-
 drivers/pci/tsm/Makefile                    |   9 +
 samples/Makefile                            |   1 +
 samples/devsec/Makefile                     |  16 +
 Documentation/ABI/stable/sysfs-module       |  20 +
 Documentation/ABI/testing/sysfs-bus-pci     |  47 +-
 Documentation/ABI/testing/sysfs-class-tsm   |  32 +
 Documentation/ABI/testing/sysfs-faux-devsec |  15 +
 Documentation/driver-api/pci/tsm.rst        |  44 ++
 Documentation/netlink/specs/pci-tsm.yaml    | 151 ++++
 drivers/base/base.h                         |  89 ++-
 drivers/pci/tsm/netlink.h                   |  23 +
 include/linux/device.h                      |  23 +
 include/linux/ioport.h                      |   2 +
 include/linux/module.h                      |  14 +
 include/linux/pci-ide.h                     |   2 +
 include/linux/pci-tsm.h                     | 121 ++-
 include/linux/swiotlb.h                     |  15 +-
 include/linux/tsm.h                         |   3 +
 include/uapi/linux/pci-tsm-netlink.h        | 101 +++
 samples/devsec/devsec.h                     |  48 ++
 arch/x86/kernel/pci-dma.c                   |   2 +-
 arch/x86/mm/ioremap.c                       |  49 +-
 arch/x86/mm/mem_encrypt.c                   |   5 +-
 drivers/base/bus.c                          |   7 +-
 drivers/base/coco.c                         |  58 ++
 drivers/base/dd.c                           |  26 +-
 drivers/pci/ide.c                           |   4 +
 drivers/pci/{tsm.c => tsm/core.c}           | 532 ++++++++++++-
 drivers/pci/tsm/evidence.c                  | 274 +++++++
 drivers/pci/tsm/netlink.c                   |  43 ++
 drivers/virt/coco/tsm-core.c                | 138 ++++
 kernel/dma/swiotlb.c                        |   1 +
 kernel/module/main.c                        |  13 +
 samples/devsec/bus.c                        | 784 ++++++++++++++++++++
 samples/devsec/common.c                     | 160 ++++
 samples/devsec/link_tsm.c                   | 432 +++++++++++
 samples/devsec/pci.c                        |  39 +
 samples/devsec/tsm.c                        | 131 ++++
 tools/testing/devsec/devsec.sh              | 280 +++++++
 MAINTAINERS                                 |   6 +-
 45 files changed, 3736 insertions(+), 76 deletions(-)
 create mode 100644 drivers/pci/tsm/Makefile
 create mode 100644 samples/devsec/Makefile
 create mode 100644 Documentation/ABI/testing/sysfs-faux-devsec
 create mode 100644 Documentation/netlink/specs/pci-tsm.yaml
 create mode 100644 drivers/pci/tsm/netlink.h
 create mode 100644 include/uapi/linux/pci-tsm-netlink.h
 create mode 100644 samples/devsec/devsec.h
 create mode 100644 drivers/base/coco.c
 rename drivers/pci/{tsm.c => tsm/core.c} (63%)
 create mode 100644 drivers/pci/tsm/evidence.c
 create mode 100644 drivers/pci/tsm/netlink.c
 create mode 100644 samples/devsec/bus.c
 create mode 100644 samples/devsec/common.c
 create mode 100644 samples/devsec/link_tsm.c
 create mode 100644 samples/devsec/pci.c
 create mode 100644 samples/devsec/tsm.c
 create mode 100755 tools/testing/devsec/devsec.sh


base-commit: c2012263047689e495e81c96d7d5b0586299578d
-- 
2.52.0

