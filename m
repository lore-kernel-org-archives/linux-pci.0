Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA31340A52;
	Tue, 23 Jun 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204666; cv=none; b=nGT/b0qOwvJbT+HcDPmgAMdTALKlKuEbbBwBftSpXzSB2ny/gLzOcBhXhY54wRIzPRZ/ZDz2Vg5eShln8U1/6A/+wbIhD8AGlFHBFCs2tboff4qXeEHrGGxQyLl2FUqF2NqWsX4O026/5LZn4b4BCAPhQK/429+hgzS+dzuALBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204666; c=relaxed/simple;
	bh=KYeEE91rLiyv7CXROgWjcMWihOr+tKLA6sbvsv7Fw9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bHM949Br3iPN1L5rt3+4QhGEwRwVYA1ZF7lrfZtjTX27cLnQRE9qo9qEMBGMcwSW2GB4rNn8ZwIrUkY3cf2o5TtO+mXNf+ZG8yTAyFg923aEcXHlIyx/hnZnl53YhO9/JypmKEKL+iXt92wmIlUDuJ4T2Ax63ERqMGUvehxEWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=IVHz8Yhl; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="IVHz8Yhl"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i5YlO2sN5/eW4EP5aTViV8os2OGP3kKENfSj96kT8YM=;
	b=IVHz8YhluvXeczleUX8xaLxvPD72hhQ77O1VY7vtP6mQk0nI4BZw1UKXMcysuLlw/FcJgpP02
	948oRFD3KLzEel7mSWJiIpz7anqbwtPoC3VdXquFQhlfRp22XOBirxGa5M1gCWxUXUc3mTFMnRK
	p3jrHXcslJm+cA/6oiy5EPE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkz8L5RgnznTXQ;
	Tue, 23 Jun 2026 16:42:10 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 4122B40572;
	Tue, 23 Jun 2026 16:50:55 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 16:50:54 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RESEND v18 00/12] vfio/pci: Add PCIe TPH support
Date: Tue, 23 Jun 2026 16:50:36 +0800
Message-ID: <20260623085048.51139-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

This patchset enables full userspace configurable PCIe TPH support for
VFIO, which brings performance benefits for userspace workloads such as
DPDK and SPDK.

Currently VFIO only exposes read-only TPH capability registers to
userspace, while all write operations are silently discarded. This
prevents userspace from enabling and configuring TPH, limiting performance
optimization opportunities.

Per PCIe spec 7.5.3.15: TPH Completer support is applicable to Root Ports
and Endpoints, allowing Steering Tags to target host CPUs or peer devices
for P2P transactions.

TPH usage model can be divided into three fundamental parts:
1. Retrieve Steering Tag:
   - Tags targeting host CPUs are obtained via platform methods (ACPI _DSM)
     wrapped in pcie_tph_get_cpu_st(). Userspace requires a generic
     interface to query these CPU-associated ST values.
   - Tags targeting peer devices are managed by userspace drivers.
2. Program Steering Tag table:
   - For devices with standard ST table structures (in capability space or
     MSI-X table), userspace needs a unified interface to configure ST
     entries.
   - Devices without standard ST tables are handled by userspace itself.
3. Toggle device TPH Requester enable/disable state.

To support the above scenarios, this series extends PCI and VFIO with
complete TPH virtualization features:
- [*PCI*] Support sysfs binary file [under root-port which support TPH
  completor and _DSM] to export CPU to steering-tag mapping, so that
  userspace could retrieve CPU's ST by read.
- [*VFIO*] New device feature TPH_ST_CONFIG: Batch configure interface for
  device ST table entries, with shadow cache and atomic rollback support.
- [*VFIO*] Full TPH capability register virtualization: allow userspace to
  toggle TPH Requester state via TPH_CTRL register writes.

To guarantee isolation and security, this patchset adopts a two-level
safety gate design with careful ABI considerations:
1. Global unsafe gate:
   TPH caching behavior may cross isolation domains and impact shared
   platform resources. A new module parameter `enable_unsafe_tph` is
   introduced (default off) to globally gate all VFIO TPH functionalities.
2. Per-device opt-in gate:
   To preserve strict ABI compatibility and avoid unexpected hardware
   state changes for existing users, a new VFIO device feature TPH_ENABLE
   is added. TPH capabilities are only available after userspace explicitly
   enables it per-device.

Because Kernel PCI TPH implementation requires TPH Requester to be enabled
before programming ST entries. To support userspace configuring ST table
in arbitrary order, a shadow ST table is introduced to buffer ST writes
before TPH is enabled. All cached entries are flushed to hardware when
TPH Requester turns on. This also provides atomic batch rollback capability
for reliable configuration.

The patchset is split into two logical parts: the first eight patches fix
and refactor core PCI/TPH kernel code to export required helper interfaces
and CPU to ST mapping, the remaining four patches implement corresponding
VFIO TPH virtualization layer step by step.

Based on earlier RFC work by Wathsala Vithanage

---
v18-resend:
- Fix apply failed only
v18:
- Address all comments of [08/12] commit from Alex
  - Add document in sysfs-bus-pci
  - Place the new field at the root port
  - Add new filed only when root port support TPH completer and _DSM
    method
  - Support random offset read, return zero if cpu is offline
  - Zero-initialize the buffer rather than memset and reserved = 0
- Fix git am fail for [10/12] commit
- Fix folloing Sashiko review comments of [11/12] commit:
  - Add __GFP_ACCOUNT in thp_st_shadow allocation
  - Move reset tph_permit in vfio_pci_tph_init/deinit
  - Refine feature PROBE for `TPH_ST_CONFIG`, make sure probe OK when
    enable_unsafe_tph is set
  - Add commit-log about why TPH ST shadow table is not cleared when the
    VFIO device is reset
-
v17:
- Move retrieve CPU to ST mapping logic from VFIO to PCI subsystem
- Remove tph_lock which seemed not use
- Fix Sashiko review comment of v16:
  - tph_permit is bit field which has concurrent problem
  - Fix tph_permit not reset when re-open device
  - TPH capability virtualization write has concurrent, don't rollback
    original value problems.
  - Missing virtualization of TPH Capability Header leaks the physical
    Next Capability Pointer to the guest

Chengwen Feng (11):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
  PCI/TPH: Cache TPH requester capability at probe time
  PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
  PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
  PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
    attributes
  PCI/TPH: Add sysfs binary file to export CPU to steering-tag mapping
  vfio/pci: Hide TPH capability when TPH is unsupported
  vfio/pci: Add TPH_ENABLE feature skeleton and unsafe module parameter
  vfio/pci: Add TPH_ST_CONFIG for PCIe TPH ST configuration
  vfio/pci: Virtualize PCIe TPH capability registers

Zhiping Zhang (1):
  PCI/TPH: Expose the enabled TPH requester type

 Documentation/ABI/testing/sysfs-bus-pci |  24 ++
 drivers/pci/pci-sysfs.c                 |   3 +
 drivers/pci/pci.h                       |   4 +
 drivers/pci/tph.c                       | 361 +++++++++++++++++++-----
 drivers/vfio/pci/vfio_pci.c             |  13 +-
 drivers/vfio/pci/vfio_pci_config.c      | 120 ++++++++
 drivers/vfio/pci/vfio_pci_core.c        | 157 ++++++++++-
 include/linux/pci-tph.h                 |  22 ++
 include/linux/pci.h                     |   6 +-
 include/linux/vfio_pci_core.h           |   6 +-
 include/uapi/linux/pci.h                |  16 ++
 include/uapi/linux/vfio.h               |  29 ++
 12 files changed, 684 insertions(+), 77 deletions(-)

-- 
2.17.1

