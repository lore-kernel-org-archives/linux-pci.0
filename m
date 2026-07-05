Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF630D405;
	Sun,  5 Jul 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289305; cv=none; b=Xe6VhETc1J0C5ujkJgktsdgolaysIaJ2RvUZoEhOzC7eEUtMa9KSP0UrqdjwsmGH5bT6rJkTjrIT9EkAHxvnkxHEB9b1W7vdZhZEhwzjrRnnk623vir28LU/Ie+3LGJA38wBQ5nOA214avzW7an0ZBkYI53sTDe3oSTJRGaZLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289305; c=relaxed/simple;
	bh=YoKIYSXqpnkM1bHU+01gM25AbhsAJcx32dbbqIjb1zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6l8dUQpeMMmziWajAfI/ZOhIOE4XI3XtiVMX1crb0EiUKe46bqJuCEpNoQiui77D1is5UvPEHUOGIUznHyw+R9mclnGFGGMvBIOwA/5yZIBCaT7tE8/6SUgwooSsTKvV0ruXFvoAtH6eH0N9WsIPTrmGhRckLzzc4/kFN4xXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRfgU7/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRfgU7/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113FF1F000E9;
	Sun,  5 Jul 2026 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289303;
	bh=KfzxR0AleekAcJiyL5teZZE+RnL15mrHLBNUPFKzbIE=;
	h=From:To:Cc:Subject:Date;
	b=HRfgU7/RXAcNJWWnx+xx+dngsiDNwCgjv4z5ZkY6e+jdtY58GXPsokQDSo9hiCRPv
	 9w6PgzntmbF4fr+8YVioZ4QOme5pdBo2bzO1WwNJ6MyjsvdGADbL4MrNIvdPoUQp0I
	 3Se54DZEDeHR5OlwjvdRYMM5bfSf93V0PG9o0402MsUpL/Kqw2PnPyeqk/53+yOaC1
	 b334gMwmkkS5CYq+mrCJ7GwaL0vq7WLYgZnnNhJYtaqcp7UL64yTnwKp87rLvOA3re
	 tcrbJrL2Ui/yXbtkyxpDBoEgjBP9FGEU7j61jfTCb1vz1yCdmrAehb9DczN+LFS++7
	 Sx5SeKHXC7ycw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2D2A2F40068;
	Sun,  5 Jul 2026 18:08:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 05 Jul 2026 18:08:21 -0400
X-ME-Sender: <xms:1dVKatb64XCmRJfDWJLJkZt5rk_W_8OrZTBNpbInM_uqFABymltWdA>
    <xme:1dVKar5o06B56y-r00th8VLxDdKiw_VRgjANrbs65bbHwtH95PSJSVJcAlAbXlgoN
    BTfQVTIPUPQ1p6HHzlOhJHhmuSSROLBXPd4hbGjGDjKjFo15egVvNU>
X-ME-Received: <xmr:1dVKamBj6kajwm2wJtTBM0a8GWSKWtlYThtlYcw_7RAXVh0kORww13hOEIj8pMebJ15mpzib9_sKNjV6xAC1rrRanQZLq116B-A>
X-ME-Proxy-Cause: dmFkZTEvGx/gkOz+BGnjuWiLxd8AvVU1sKyr9tpv0zA3+DcnGEfyUSh6NOjjzDbjf2g4vp
    4kU/FRppIQqfGSVbKGszXUXLA/uh0+rcfkHFcKSje1sWEvTb+j3XRnjSMnOWW91fiqUmwF
    WGwt9SrsTok1F729gNQubm2/uK/lgnqQ0wEHTLgfcSRwpcMHUz9kqfRAu9+EKC0tRyJWYY
    MUg43P+7DbcqLRRmL+dI48AbXLmem8iBrt0Ln9j2hdfoX0uVWyl68flMWvNgMFH27erKeg
    QbUUsf0/lK8RvrYGmPoxiAnCq9ORlu7xSmtP0Dvl/RKSWzd04s0MEyNtmowUZYRAqAsQF1
    NdVmmMGzGJSdTrxwITwf6h/aRV3vG0y2+CoQdQ+KSn/qdlRlPJXAvDP781COHklNXeV6ng
    Q4kbG/zsRWAQoFHWv8f2W0FA3c9+BCjp0bbXSk6TR/GhLCldvwh6YxE1NjURGBRBKTEOka
    MKxhQupx9nZaTtYbxGJ5kSauYJHtufVqHFfiS85U5QbFcsxMr+0cPNYCmDH6zh0SdbvupU
    /kd2n73CeS0IISgyn0bAjdzm/+sJJjQduXxTD+irANq6HmaoluaEjZNgEDuQFC4m4iHHSt
    l1ty0qEDBSQ/WbxYzNFtJwxy3C/iUURsAYa7cIj9LEatf15DFYjvW0WvGbxw
X-ME-Proxy: <xmx:1dVKapuZRfNvi72UOQvgc6jqPZnOWBcp9hHRrv2ThAUdFTFGDou0MA>
    <xmx:1dVKajuKNR9WWNjxT8-u85ye3CuGbg1_VYuFEQo84mF0658409ZrRA>
    <xmx:1dVKalowhDmUqXK4pfCZEZ3KEWiw4o2YnHGuRZxZTsfXxxS_FAn-ag>
    <xmx:1dVKanNcbMSyY8pYuorbIcFm2GEsQU58o_3d7p1h_iB04Ztn96039Q>
    <xmx:1dVKarkygm2XfYJenYryXLgEDBZUqGLY-dqN68rRNBRKnLce0_rmb4A8>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:20 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol (TDISP)
Date: Sun,  5 Jul 2026 15:08:04 -0700
Message-ID: <20260705220819.2472765-1-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Major changes since: "[PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure" [1]
- Implement a new netlink schema for dumping large SPDM blobs (Jakub,
  Lukas)
- Introduce a device core implementation for evidence gathering given
  SPDM is applicable to devices outside of PCI (Lukas)
- Replace the "CC acceptance" mechanism with "Device Trust" (Greg,
  Jason)
- Fix TDISP report parsing to use bytes instead of pfns for the start
  value of an MMIO report (PCI spec clarification)
- Support the CCA expectation that MMIO reports are BAR aligned (Aneesh)

[1]: http://lore.kernel.org/20260303000207.1836586-1-dan.j.williams@intel.com

[ Note, this series is back to a v1 posting given the new theme of
  "Evidence and Trust". It defers some of the lower level details, like
  touching arch-level ioremap implementations to consult encrypted_iomem,
  until the higher order details are settled ].

---
Summary:
A threat model wants to arrange for devices to not be operated until
they present evidence. Add device evidence gathering, device trust
levels, and hook those up for the PCI/TSM (PCI device security protocol)
implementation.
---

Confidential Computing and other use cases specify a threat model where
devices are potentially adversarial. To date the device core trusts
devices and their drivers, and only specific buses have local
"adversary" device mitigations. The task is define a general trust
concept to up-level existing trust mitigations, and allow for
incremental tightening of mitigations across bus types and IOMMU
drivers.

Goals:
* Create a mechanism for booting with a limited set
  devices + drivers and permit selectively enabling more devices +
  drivers at runtime.
* Up-level bus specific trust mitigations like PCI
  untrusted to a core concept.
* Let buses coordinate entry into the TCB via the existing
  ->dma_configure() callback

The proposal considers existing trust mitigation in various buses.  The
PCI device "untrusted" flags is an example of limiting but not fully
blocking operation of a device. The USB interface authorized flag is an
example of not trusting a device to operate at all. The implementation
starts with these trust level DEVICE_TRUST_NONE, no operation of the
device, and DEVICE_TRUST_ADVERSARY, limited operation of the device.
For example, the PCI "untrusted" flag turns off device translation
capabilities (ATS) and strictly enforces IOMMU mappings, but otherwise
allows operation of the device.

The proposal does not currently incorporate other bus specific security
mechanisms that are independent of individual device operational trust.
For example, USB device (not interface) authorization and Thunderbolt
switch authorization are transport gates to other devices.  PCIe Link
Encryption is also a transport security mechanism that informs a trust
decision, but it is still possible to distrust a device with Link
Encryption and conversely distrust a device protected by Link
Encryption. Those security mechanisms are orthogonal to trust policy for
driver bind, address space access, and acceleration feature enabling.

The result is device trust is an input to the driver core and IOMMU
layers. A bus can opt to sync its local bind policy, address space
access, and acceleration features to the trust level, or treat it as an
overriding second-stage policy from the bus's first stage mechanism.

The trust levels established at enumeration and enforced at driver
attach are DEVICE_TRUST_{NONE,ADVERSARY,AUTO,TCB}:

* NONE: no usage of the device unless the trust is explicitly overridden
  by user policy specified via a driver flag, module flag, or uapi (TBD).

* ADVERSARY: needs acknowledgement from the bus and IOMMU / DMA layers
  that the device is limited to strict IOMMU translation behavior. Drivers
  can use this as a signal to limit functionality. This designation
  implies follow-on IOMMU and bus enabling work for features like
  arranging for the device to attach to a blocked IOMMU domain when
  detached from a driver.

* AUTO: typical / historical Linux driver model.

* TCB: a trust level that only exists in Confidential Computing
  environments. When acked by the IOMMU / DMA layer it enables the device
  to issue direct-DMA to private/encrypted addresses or otherwise attach to
  a secure vIOMMU within the TCB.

Overview of changes:
Patches 1-6: Update netlink to be able to support large blob
transfers that the SPDM standard requires. SPDM can be associated with
any device type, so the implementation lands in the device core with
PCI/TSM as the first consumer.

Patches 7-9: Introduce DEVICE_TRUST_NONE and DEVICE_TRUST_ADVERSARY.
Support blocking driver bind by default, and allow either build policy
or module policy to override the the trust level.

Patches 10-12,14-15: Plumb the PCI/TSM support for the PCI device
security (TDISP) protocol to transition the device through
UNLOCKED->LOCKED->RUN.

Patch 13: Support access to private memory either by the bus either
coordinating with a TSM driver, or relying on the bus provider to have
already arranged access (paravisor case).

This passes basic checkout with the sample TSM driver and a sample
netlink client for the device evidence facility. Those patches are only
on the git tree for now [2].

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=devsec-phase2

Dan Williams (15):
  netlink: specs: Introduce multi-message blobs for SPDM
  tools: ynl: Teach pyynl to handle blobs
  tools: ynl: Teach ynl_gen_c to validate and dump 'blob' attributes
  device core: Introduce "device evidence" over netlink
  device core: Add "device evidence" 'validate' command
  PCI/TSM: Add device evidence support
  modules: Document the global async_probe parameter
  device core: Initial device trust infrastructure
  PCI, device core: Move "untrusted" concept to DEVICE_TRUST_ADVERSARY
  PCI/TSM: Add device interface security LOCKED support
  PCI/TSM: Add device interface security RUN support
  PCI/TSM: Add device interface security DMA enable/disable
  PCI, device core: Add private memory access for DEVICE_TRUST_TCB
  PCI/TSM: Create MMIO descriptors via TDISP Report
  PCI/TSM: Add relative MMIO offset support?

 drivers/base/Kconfig                          |  91 +++
 drivers/pci/Kconfig                           |   2 +
 drivers/base/Makefile                         |   2 +
 drivers/pci/Makefile                          |   2 +-
 drivers/pci/tsm/Makefile                      |   8 +
 Documentation/ABI/stable/sysfs-module         |  17 +
 Documentation/ABI/testing/sysfs-bus-pci       |  47 +-
 Documentation/ABI/testing/sysfs-class-tsm     |  19 +
 Documentation/driver-api/pci/tsm.rst          |  47 ++
 Documentation/netlink/genetlink-legacy.yaml   |   6 +
 Documentation/netlink/genetlink.yaml          |   7 +
 Documentation/netlink/netlink-raw.yaml        |   7 +
 .../netlink/specs/device-evidence.yaml        | 203 ++++++
 drivers/base/base.h                           |  15 +
 drivers/base/device-evidence-netlink.h        |  25 +
 include/linux/device.h                        |   3 +
 include/linux/device/evidence.h               |  88 +++
 include/linux/device/trust.h                  |  56 ++
 include/linux/ioport.h                        |   2 +
 include/linux/module.h                        |   6 +-
 include/linux/pci-tsm.h                       | 104 +++-
 include/linux/pci.h                           |  13 +-
 include/uapi/linux/device-evidence.h          | 111 ++++
 tools/net/ynl/lib/ynl-priv.h                  |   4 +
 tools/net/ynl/lib/ynl.h                       |  14 +
 drivers/base/core.c                           |   7 +
 drivers/base/dd.c                             |   5 +
 drivers/base/device-evidence-netlink.c        |  58 ++
 drivers/base/evidence.c                       | 495 +++++++++++++++
 drivers/base/trust.c                          | 103 ++++
 drivers/iommu/amd/iommu.c                     |   2 +-
 drivers/iommu/dma-iommu.c                     |  13 +-
 drivers/iommu/intel/iommu.c                   |   2 +-
 drivers/iommu/iommu.c                         |   2 +-
 drivers/pci/ats.c                             |   2 +-
 drivers/pci/pci-driver.c                      |  25 +-
 drivers/pci/pci.c                             |   2 +-
 drivers/pci/probe.c                           |  10 +-
 drivers/pci/quirks.c                          |   4 +-
 drivers/pci/{tsm.c => tsm/core.c}             | 579 +++++++++++++++++-
 drivers/pci/tsm/evidence.c                    | 110 ++++
 drivers/virt/coco/tsm-core.c                  |  43 +-
 kernel/module/main.c                          |  13 +
 kernel/resource.c                             |   8 +
 tools/net/ynl/lib/ynl.c                       |  33 +
 MAINTAINERS                                   |   6 +-
 tools/net/ynl/pyynl/lib/nlspec.py             |  12 +
 tools/net/ynl/pyynl/lib/ynl.py                |  62 +-
 tools/net/ynl/pyynl/ynl_gen_c.py              |  80 ++-
 49 files changed, 2509 insertions(+), 66 deletions(-)
 create mode 100644 drivers/pci/tsm/Makefile
 create mode 100644 Documentation/netlink/specs/device-evidence.yaml
 create mode 100644 drivers/base/device-evidence-netlink.h
 create mode 100644 include/linux/device/evidence.h
 create mode 100644 include/linux/device/trust.h
 create mode 100644 include/uapi/linux/device-evidence.h
 create mode 100644 drivers/base/device-evidence-netlink.c
 create mode 100644 drivers/base/evidence.c
 create mode 100644 drivers/base/trust.c
 rename drivers/pci/{tsm.c => tsm/core.c} (61%)
 create mode 100644 drivers/pci/tsm/evidence.c


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

