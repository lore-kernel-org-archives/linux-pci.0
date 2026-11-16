Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827392;
	b=kr0PW2ivpXz179/sLzgKa4qQTKxmnXmumw+hqp0XLCBybRF5MEdnVZpqwsW/K7+ejQig
	 CKaFZ6DJXrNZVlXjRNQjHamuW/OdCLTFYOqgWwGhw9PSr1rxKtsbsqd3xLHwO3gpJyDBE
	 TCY4Je0xISBrrop7JRspbLFHrKfj02YN1+gIjgbLIgk/qrrsleTMj3464UaTA+FSKzjco
	 Io/qgAMPocpPjP067rYaHHwDh308KSmuci8kVFNgg5SPy4jimo0RF7cff250y9eeyTbOG
	 Xg7iHE6yZrOlGI6F/vL/8ZcU4LM7NB3ETFVmxYHjsMtX/jVX3gC1P/qkElfufl5XlzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827392;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6JE3ezNpre7PvCafHO7wBh2leIssf/Pub7wCkgud8Ws=;
	b=bucqEwaGUZzsdLwEXczcEJpzJuHjVR0sM/g5WjCyhsxKXI+wcQbDUcTe/Nb8UH42Jn/8
	 eK1dDfvGtfJYFDefLsLv9H3SdilJ9jk3SK8kU1r/LhP1IUhN2K6c4qkpBYbzVVooabLPM
	 UO1bOTVd+/SuiII2pRHW3d8RgmntFq2Y0QiACuG4AsLzrLsjtOgyZ2eNRYcqeYa/tRNqi
	 DI7YppFV95duTBu8uHWoFD+2cJl67sVoDsO/64jy0hvPGcvgUFkDiH16CwIMRR8fZ3Glr
	 3KxPt3UO33DOErvi7VnpTOFX9wgq44ij7go8YvMgRq+4BWM4W6a9LkrOphvuOXVt7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oBUExuUa;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6F607BDA8;
	Mon, 16 Nov 2026 11:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B6F607BDA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oBUExuUa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827392; x=1826363392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rksEBsctxS5+pBQx28Yn4C2YEUM13RYYmc1Ab7GCG9E=;
  b=oBUExuUa2bNWoPbqKKmF7Mlx7lyCLzHHRRZuAA4Fc7Lw0jTc/EiyyrOi
   JdkaQHlRhernZpfxI6NAmiFZKm+UmMReRU1mPuLeUGt2AH7PfDMRjknJ+
   IvYTQ+bSVvYS4EYKtI+9lMulqZZNqRJQdTHhqgRr/G12vnxuA2Alvfozw
   P0cHj5vrwN9oBKGMt8NPPMgESYGCgJ03lDfJrSR89E7VZ/aeUFLsIm3ap
   Hiyi3geFUl1v9Xp+2mXsiqRPVCDzdgW3kOerAboN4xhIQcOD0yMI7XS8f
   BkFXxmvgxDMozxMH+Vmrxz+zdxYt1IpuagcW9IIMkNZahsQnRj05TGLqB
   A==;
X-CSE-ConnectionGUID: PiH0yrj7RB6ciLZZMrmBWw==
X-CSE-MsgGUID: 00GZSHFXQbeiBgOdbwWa3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429593"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:51 -0800
X-CSE-ConnectionGUID: Nfekq6HIRXSdxBOKkXSS5g==
X-CSE-MsgGUID: ZLCkwydlSViBT75NqwCb0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848116"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:51 -0800
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kevin.tian@intel.com,
	yilun.xu@intel.com,
	chao.p.peng@intel.com,
	baolu.lu@linux.intel.com,
	chao.gao@intel.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 0/7] TDX: Enable PCIe link encryption for trusted I/O
Date: Mon, 16 Nov 2026 03:10:18 -0800
Message-ID: <20261116111037.3478844-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series adds PCIe link encryption on TDX hosts. Yilun previously
posted one large series with all the changes needed for this [1]. That
series has been split up, and the parts are being posted separately.
This RFC is posted for early review. It is not yet seeking review from
the x86 maintainers.

The SEAMCALL wrappers this series uses are in a separate series, not
yet posted. So, their names and parameters may still change.

Today, userspace sets up link encryption by writing to the PCI/TSM
"connect" sysfs attribute. A proposal under discussion [2] adds CTLV
attestation commands [3] to this flow, so that userspace can select and
verify the device's certificates before the IDE stream is set up. This
series uses only the "connect" attribute. I will convert it to the new
flow once the discussion settles.

== Background ==

With shared I/O, devices cannot access a confidential VM's private
memory, so the VM bounces I/O data through memory it shares with the
host. With trusted I/O, the VM establishes trust in a device and then
lets it access private memory directly, which avoids the bouncing.

The device's MMIO and DMA traffic then carries private data across PCIe
links and switches. A physical attacker on a link, or a malicious
switch, could read, modify or replay that traffic. PCIe link encryption
protects the traffic between the root port and the device against these
attacks, which keeps switches out of the VM's TCB.

Link encryption builds on:

  - Integrity and Data Encryption (IDE) [4], the PCIe feature that
    encrypts and integrity-protects data exchanged between the root port
    (part of the CPU's root complex) and the device.

  - The Security Protocol and Data Model (SPDM) [5], a protocol for
    authenticating a device and setting up a secure session with it.

  - Data Object Exchange (DOE) [6], a PCIe feature that provides a
    mailbox in the device's config space.

At a high level, setting up link encryption means opening an SPDM
session with the device through its DOE mailbox, configuring an IDE
stream on both the root port and the device, and programming the
stream's keys into the root port and sending them to the device over
the SPDM session.

The TEE Security Manager (TSM) is a trusted platform component, such as
the TDX module or AMD's Secure Processor firmware. The work is split
between the TSM and the host kernel. The TSM runs the SPDM session and
handles the keys. It doesn't own the device, so the host kernel configures
the device's IDE settings and relays SPDM messages between the TSM and
the device.

== This series ==

This series adds a TDX-TSM driver to the TDX host services module
(tdx-host.ko). The driver registers the TDX module as a TSM with the
PCI/TSM framework [7] and implements its connect and disconnect
operations. PCI/TSM calls them when userspace writes to a device's
"connect" and "disconnect" sysfs attributes.

Connect sets up the SPDM session, the IDE stream and its keys through
SEAMCALLs, and disconnect tears them down.

During some SEAMCALLs, the TDX module may need to exchange several SPDM
messages with the device. The kernel calls such a SEAMCALL in a loop.
Each time it returns an SPDM message with a dedicated status code, the
kernel sends the message through the device's DOE mailbox and calls the
SEAMCALL again with the device's reply, until the SEAMCALL completes.

== Points for discussion ==

1. Raw DOE frames (See patch 3)

The TDX module produces and consumes whole DOE objects, header included,
but the PCI DOE API takes payloads only. The TDX-TSM driver therefore
strips and rebuilds the DOE header itself. The code is small, but it
puts DOE format details in a TSM driver, while the DOE core already
handles them. A PCI DOE API that takes whole objects would keep them in
the core, but the TDX-TSM driver would be its only user. Is such an API
worth adding, or can we live with the DOE format handling in the
TDX-TSM driver?

2. Default IDE Stream (See patch 5)

TDISP requires each device to have one default IDE stream [8]. The PCI
core does not set Default Stream, so each TSM driver sets it itself, by
looking up the device's IDE settings with pci_ide_to_settings() and
setting default_stream. AMD's driver already does this, and the TDX-TSM
driver does the same. Since the requirement is shared, the PCI core
could instead set Default Stream on the device's TC0 stream, which is
what TDISP expects. Should this move into the PCI core now, or can it be
a later cleanup?

== Limitations ==

The TDX module configures the root port's IDE settings and accepts
only one address range for the stream. The root port therefore encrypts
only traffic to the device's prefetchable MMIO range, and a device with
no prefetchable range cannot be connected. We are evaluating whether
this can be lifted.

Link encryption needs the root complex to enter a TDX mode, in which
only the TDX module can configure the root port's IDE settings. The
kernel opts in to this mode with TDH.IOMMU.SETUP. As its name suggests,
this SEAMCALL also puts the IOMMU into TDX mode, which changes the
IOMMU's behavior. Unfortunately, the two cannot be enabled separately,
even though link encryption does not need IOMMU TDX mode.

== Dependencies ==

The series depends on the following series:

  - TDX module extensions [9]
  - IOMMU TDX mode [10]
  - SEAMCALL wrappers for PCIe Link Encryption [not yet posted]

The full stack is available at:

  https://github.com/gaochaointel/linux-dev/tree/link-encryption-rfc-v1

== Testing ==

Tested that link encryption can be enabled and disabled through PCI/TSM:

  # echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/connect
  # echo tsm0 > /sys/bus/pci/devices/$DEVICE/tsm/disconnect

Note that I disabled DPAMT for this testing as this series does not yet
install DPAMT for the SPDM metadata, which will be added later.

== Changes since Yilun's version ==
  - Rebased onto the latest tip/x86/tdx branch.
  - Rewrote the cover letter and commit messages
  - Took over the patches from Zhenzhong and Yilun, and credited them
    in the changelogs.
  - Dropped the Reviewed-by tags collected as patches are changed
    significantly.
  - Allocated struct spdm_config_info_t with kzalloc_obj() and added a
    static_assert() on its size, which removes the casts on allocation
    and free.
  - Fixed a leak of the SPDM message buffers (tlink->in_msg and
    tlink->out_msg), and moved their allocation into tdx_spdm_create(),
    next to the SPDM metadata.
  - Dropped the SPDM session key update patch.
  - Made TDX_HOST_SERVICES depend on PCI and select PCI_TSM directly.
    Otherwise tdx-host fails to build with CONFIG_PCI=n. A TDX host
    without PCI support is not a realistic configuration
  - Replaced the bit operations and endian conversions in the DOE
    header handling with struct pci_doe_header and struct pci_doe_msg.
  - Returned -EIO instead of -EFAULT when TDH.IDE.STREAM.CREATE fails.
  - Reworded changelog to describe the TDX module's limit on concurrent
    TDH.SPDM.CONNECT. i.e., why tdx_spdm_lock.
  - Clarified that having an IDE default stream is required by TDISP spec.
  - Fixed checkpatch warnings

== AI Usage ==

AI was used under supervision to review code, refine logs and explore ways
to improve readability. I wrote the first draft of this cover letter, which
then changed significantly over several rounds of review with AI and was
trimmed a lot for brevity. The idea for simplifying the DOE format
handling in patch 3 came from AI.

== References ==

[1]: https://lore.kernel.org/all/20260327160132.2946114-1-yilun.xu@linux.intel.com/
[2]: https://lore.kernel.org/all/20261028152618.1356860-1-aneesh.kumar@kernel.org/
[3]: https://lore.kernel.org/all/20261015145053.3664509-1-jiri@resnulli.us/
[4]: PCIe Specification r7.0, section 6.33 "Integrity & Data Encryption (IDE)"
[5]: https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pdf
[6]: PCIe Specification r7.0, section 6.30 "Data Object Exchange (DOE)"
[7]: https://lwn.net/Articles/1043262/
[8]: Intel TDX Connect Architecture Specification
     https://cdrdv2-public.intel.com/773614/intel-tdx-connect-architecture-specification.pdf
[9]: https://lore.kernel.org/all/20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com/
[10]: https://lore.kernel.org/kvm/20261112043054.2664857-1-baolu.lu@linux.intel.com/

Chao Gao (7):
  coco/tdx-host: Create metadata for an SPDM session
  coco/tdx-host: Establish an SPDM session with the device
  coco/tdx-host: Exchange SPDM messages through DOE
  coco/tdx-host: Pass a device info buffer to tdh_spdm_connect()
  coco/tdx-host: Configure an IDE stream
  coco/tdx-host: Program IDE keys and enable the IDE stream
  x86/virt/tdx: Enable PCIe link encryption

 arch/x86/include/asm/shared/tdx_errno.h     |   1 +
 arch/x86/include/asm/tdx.h                  |   2 +-
 arch/x86/include/asm/tdx_global_metadata.h  |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 |   2 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  12 +
 drivers/pci/ide.c                           |   5 +-
 drivers/virt/coco/tdx-host/main.c           | 496 +++++++++++++++++++-
 include/linux/pci-ide.h                     |   2 +
 8 files changed, 516 insertions(+), 6 deletions(-)

-- 
2.52.0

