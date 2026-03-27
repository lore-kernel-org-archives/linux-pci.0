Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC8347525;
	Fri, 27 Mar 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774628556; cv=none; b=BuWhMrKE2acMSkrlzh8Gk5Q2b7A4Baj4Ahgob2ijKjpVY7RpWB4Rf1FBBhyzM2dd2QKh5hsWwUBBU74RP8oideSZX1lkyxJnoCgqSA5sQ7M6MfWOVRP0p/fyyJsWBFGrKYH4m9AQ+xChBiL5fVelXOVxah613mKNmoZLH6u9WUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774628556; c=relaxed/simple;
	bh=Dpc5ajG0cpPMRfGSQYtwGoqlsNmZJIl2iPLJGtGNLoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aDYm8yKdNfmIOPsgaMd+6qdJXlK0SDEXEs4iNIhBE8OPTeKcVMN3AajGon0wdN8UpIE6RHvoJb7fPKdquwr8fPpUpAeBHFcd90c6mKJK6ZS9W2e3rpKBOjQGjcuyH5GTNfvVbKTTBkqysYn1xE0NyMFC+/gidK5K9aa3rMjV/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lc4VH80t; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lc4VH80t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774628554; x=1806164554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dpc5ajG0cpPMRfGSQYtwGoqlsNmZJIl2iPLJGtGNLoE=;
  b=Lc4VH80tRTef8mGmrlv/Lp9GHUDoc08LReuDTE/o/SALoxvxyq1ufUEZ
   sCUWCSIYrbhkNAcKyaeA2VzqChF40kznTF1YqnxNGlnUyazBwTxa9tWCC
   yEdMKahVyISCIelAa463+re2H1CilukniF5DbLzJy2/Odh5fhvQCHbzr5
   /7ChRUfws1CCSuLm/FIziVfTtnrSJdkyJwzLt6cEWqPUkAkWhC2qBY6C2
   AVLyAt3X0gY2jwHe6tWyjCmHn1HWoH/2LFDcxMKEKGCQR9T+rBuwe72ce
   g/3Sw35bEzhU1x56AivmgNRZ3mLWAljJ36IVAF02u64EHhS11cumcABtE
   A==;
X-CSE-ConnectionGUID: kdZgef1YS/q/cV4RmqMcgA==
X-CSE-MsgGUID: P5RYNBDURWCPaxhzMz3diA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79565483"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79565483"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:22:33 -0700
X-CSE-ConnectionGUID: tR+Io45vSYuS88IP1jfBmA==
X-CSE-MsgGUID: KaNlKWGERvGU+ZdObMcuzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220516105"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 27 Mar 2026 09:22:30 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dan.j.williams@intel.com,
	x86@kernel.org
Cc: chao.gao@intel.com,
	dave.jiang@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	zhenzhong.duan@intel.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	dave.hansen@linux.intel.com,
	kas@kernel.org,
	xiaoyao.li@intel.com,
	vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/31] PCI/TSM: PCIe Link Encryption Establishment via TDX platform services
Date: Sat, 28 Mar 2026 00:01:01 +0800
Message-Id: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is based on mainline v7.0-rc2 and targets v7.1 (quite
aggressive though). The merge path will be through tsm.git with tip.git
acks where needed. I know there are several parallel series on the fly,
so Dave you can wait for Dan to review, or ack/nak as you have time,
thanks.  No KVM change, no acks from kvm.git is needed.

== Overview ==

This series adds a PCI/TSM low-level driver implementation for TDX
Connect (the TEE I/O architecture for Intel platforms). PCI/TSM is the
Linux PCI core subsystem [1][2] that supports Link Encryption & trust
establishment between CoCo-VM and assigned devices, allowing CoCo-VM to
accept devices for private memory access (private DMA). This series
only implements Link Encryption. It is a pre-requisite for trusted
device assignment in TDX system.

Two protocols, SPDM (Security Protocol and Data Model) and PCI
IDE (Integrity and Data Encryption) work together to establish the Link
Encryption. SPDM creates trust on untrusted transit for key exchanging.
IDE performs the actual real-time encryption for data traffic. In TSM
world, they are managed by secure firmwares, e.g. TDX Module.

To manage these protocols, TDX Module introduces Extensions to support
long running / hard-irq preemptible flows inside. Host invokes these
flows via Extension-SEAMCALLs.

This series has 2 distinct parts:

  Patches  1-13: TDX core cleanups and TDX Module Extensions enabling
  Patches 14-31: tdx_host TSM driver for PCIe Link Encryption

[1]: https://lore.kernel.org/linux-coco/20251031212902.2256310-1-dan.j.williams@intel.com/
[2]: https://lore.kernel.org/linux-coco/20251105040055.2832866-1-dan.j.williams@intel.com/

== Merge notes ==

 - Merge conflicts with parallel series:
   Sean's VMXON: https://lore.kernel.org/all/20260214012702.2368778-1-seanjc@google.com/
   Chao's runtime update: https://lore.kernel.org/all/20260326084448.29947-1-chao.gao@intel.com/

 - Picked several patches from parallel series:
   Patch  1: https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-1-87a36409e051@intel.com/
   Patch 14: https://lore.kernel.org/all/20260303000207.1836586-2-dan.j.williams@intel.com/
   Patch 15: https://lore.kernel.org/all/20260326084448.29947-3-chao.gao@intel.com/

== Changelog ==
v2:
- Subject change. previously it was:
  "PCI/TSM: TDX Connect: SPDM Session and IDE Establishment"
- Remove __free() for core TDX and refactor all tdx_ext functions
- Use kzalloc(PAGE_SIZE, ...) instead of alloc_page() in TDX core
- Check feature0 support before reading optional global metadata
- Split the TDX Module Extensions enabling into small patches
- Enable TDX Module Extensions along with Basic TDX enabling
- Refactor SEAMCALL version handling
- For tdx_page_array, make page allocation method configurable
  - For TDX Module Extensions, use contiguous page allocation
  - For IOMMU_MT, use a custom page allocation
- Print TDX Extensions memory usage
- Various Changelog & comments refine

v1: https://lore.kernel.org/all/20251117022311.2443900-1-yilun.xu@linux.intel.com/
- No tdx_enable() needed in tdx-host
- Simplify tdx_page_array kAPI, no singleton mode input
- Refactor the handling of TDX_INTERRUPTED_RESUMABLE
- Refine the usage of scope-based cleanup in tdx-host
- Set nr_stream_id in tdx-host, not in PCI ACPI initialization
- Use KEYP table + ECAP bit50 to decide Domain ID reservation
- Refactor IDE Address Association Register setup
- Remove prototype patches
- Refactor tdx_enable_ext() locking because of Sean's change
- Pick ACPICA KEYP patch from ACPICA repo
- Select TDX Connect feature for TDH.SYS.CONFIG, remove temporary
  solution for TDH.SYS.INIT
- Use Rick's tdx_errno.h movement patch [6]
- Factor out scope-based cleanup patches in mm
- Remove redunant header files, add header files only when first used
- Use dev_err_probe() when possible
- keyp_info_match() refactor
- Use bitfield.h macros for PAGE_LIST_INFO & HPA_ARRAY_T raw value
- Remove reserved fields for spdm_config_info_t
- Simplify return for tdh_ide_stream_block()
- Other small fixes for Jonathan's comments

RFC: https://lore.kernel.org/linux-coco/20250919142237.418648-1-dan.j.williams@intel.com/


Chao Gao (1):
  coco/tdx-host: Introduce a "tdx_host" device

Dan Williams (1):
  PCI/TSM: Report active IDE streams per host bridge

Dave Jiang (1):
  acpi: Add KEYP support to fw_table parsing

Kiryl Shutsemau (1):
  x86/tdx: Move all TDX error defines into <asm/shared/tdx_errno.h>

Lu Baolu (2):
  iommu/vt-d: Cache max domain ID to avoid redundant calculation
  iommu/vt-d: Reserve the MSB domain ID bit for the TDX module

Xu Yilun (21):
  x86/virt/tdx: Move bit definitions of TDX_FEATURES0 to public header
  x86/virt/tdx: Add tdx_page_array helpers for new TDX Module objects
  x86/virt/tdx: Support allocating contiguous pages for tdx_page_array
  x86/virt/tdx: Extend tdx_page_array to support IOMMU_MT
  x86/virt/tdx: Read global metadata for TDX Module Extensions/Connect
  x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
  x86/virt/tdx: Configure TDX Module with optional TDX Connect feature
  x86/virt/tdx: Move tdx_clflush_page() up in the file
  x86/virt/tdx: Add extra memory to TDX Module for Extensions
  x86/virt/tdx: Make TDX Module initialize Extensions
  x86/virt/tdx: Enable the Extensions after basic TDX Module init
  x86/virt/tdx: Extend tdx_clflush_page() to handle compound pages
  coco/tdx-host: Support Link TSM for TDX host
  x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
  iommu/vt-d: Export a helper to do function for each dmar_drhd_unit
  coco/tdx-host: Setup all trusted IOMMUs on TDX Connect init
  mm: Add __free() support for __free_page()
  coco/tdx-host: Parse ACPI KEYP table to init IDE for PCI host bridges
  x86/virt/tdx: Add SEAMCALL wrappers for IDE stream management
  coco/tdx-host: Implement IDE stream setup/teardown
  coco/tdx-host: Finally enable SPDM session and IDE Establishment

Zhenzhong Duan (4):
  x86/virt/tdx: Add SEAMCALL wrappers for trusted IOMMU setup and clear
  coco/tdx-host: Add a helper to exchange SPDM messages through DOE
  x86/virt/tdx: Add SEAMCALL wrappers for SPDM management
  coco/tdx-host: Implement SPDM session setup

 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/tdx-host/Kconfig            |  16 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tdx-host/Makefile           |   1 +
 Documentation/ABI/testing/sysfs-class-tsm     |  13 +
 arch/x86/include/asm/shared/tdx.h             |   1 +
 .../vmx => include/asm/shared}/tdx_errno.h    |  30 +-
 arch/x86/include/asm/tdx.h                    |  95 +-
 arch/x86/include/asm/tdx_global_metadata.h    |  14 +
 arch/x86/kvm/vmx/tdx.h                        |   1 -
 arch/x86/virt/vmx/tdx/tdx.h                   |  42 +-
 drivers/iommu/intel/iommu.h                   |   2 +
 include/linux/acpi.h                          |   3 +
 include/linux/dmar.h                          |   2 +
 include/linux/fw_table.h                      |   1 +
 include/linux/gfp.h                           |   1 +
 include/linux/pci-ide.h                       |   4 +
 include/linux/tsm.h                           |   3 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 839 ++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  36 +
 drivers/acpi/tables.c                         |  12 +-
 drivers/iommu/intel/dmar.c                    |  67 ++
 drivers/iommu/intel/iommu.c                   |  10 +-
 drivers/pci/ide.c                             |   9 +-
 drivers/virt/coco/tdx-host/tdx-host.c         | 952 ++++++++++++++++++
 drivers/virt/coco/tsm-core.c                  |  97 ++
 lib/fw_table.c                                |   9 +
 27 files changed, 2202 insertions(+), 61 deletions(-)
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 rename arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h (61%)
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c


base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.25.1

