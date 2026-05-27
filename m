Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0AB3ED126;
	Wed, 27 May 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875252; cv=none; b=b17w0tc9etsVhlbX2GonIxrSm89n79vlH3VuFVm6qi8aivSTGZVy/KVWYX+2He5ifyBznOcnZAMSmFPu4mE03f+bfwQfOmVZmI6x2s5r419m7dDqL0ippYfsNbQxAvlLl8/W0YYF6WhAwk8+seuYtzGoDfQUOntKQS/QS632K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875252; c=relaxed/simple;
	bh=Pua11lTeVW99kuRHYwfkkEVMoxUXLnCbDb+uv4nFcP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyxHpO8fUUpU5oUfP0a1giSz7SNMpJ5PQ1hMDAVorftN9tXiu08JD9sGmsSJND0qVq7cgz+aBgmWW15bwcR+cn90Kqi8pGAXrpbImLf7l+zEd3Oo8jF7dXbAT/+FVPV54/mYEJKtiHRSIrloZU0F3iy1Vy7blbxZlHZVgFOgrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t675vKb6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t675vKb6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CZQ+eCtVy5SamcMiCrDlE82pHbBCUQZ0CkTsBVuMPKg=;
	b=t675vKb6alBO2eid41MuPldzgu4QVBDBpVpnu1B+IXCcbeR87G6SocsqgAtDsUY7iGpMm33bI
	nqmc/+zHBcHC6NPY6kXpOJo0D4y7bl1BXSQ8NZCcqiE1m65ZicjH/nI/CAmARKbHjRY64AuryBJ
	M8IlPVLK+OFW28hfAEXEXE4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gQPj74g6KzRhSh;
	Wed, 27 May 2026 17:39:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id EB34840572;
	Wed, 27 May 2026 17:47:24 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 May 2026 17:47:24 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v13 0/8] vfio/pci: Add PCIe TPH support
Date: Wed, 27 May 2026 17:47:11 +0800
Message-ID: <20260527094719.43886-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

This patchset enables userspace control over PCIe TPH steering tags,
motivated by the following considerations:

1. Why userspace needs the capability to control steering tags:
   When PCIe devices are fully owned by userspace workloads such as DPDK
   and SPDK, only userspace has full knowledge of core binding policies
   and traffic distribution strategies. Without this series, userspace
   cannot enable TPH or configure steering tags, leaving built-in PCIe
   performance optimizations unused in high-throughput polling I/O
   scenarios.

2. Why this interface must be implemented in VFIO:
   VFIO is the standard, secure community solution for granting full
   PCIe device ownership to userspace. Existing kernel TPH interfaces
   are designed purely for in-kernel drivers. For user-owned devices,
   VFIO provides the only isolated and correct path to expose per-device
   TPH management.

TPH supports both IV and DS modes. Since both modes could introduces
cross-VM isolation risks such as untrusted guests programming arbitrary
steering tags to impact other domains:
1. If ST location in MSI-X table, untrusted guests may program the
   MSI-X table.
2. If ST don't locate in MSI-X or CAP, untrusted guests may program the
   device-specific register.
So a new module parameter `enable_unsafe_tph` is added. It defaults to
off, and blocks all unsafe TPH operations when disabled.

Based on earlier RFC work by Wathsala Vithanage

---
v13:
- Fix Alex's comments:
  - Add virtualize of TPH request type
  - Adopt two feature
v12:
- Fix Alex's comments:
  - Support enable NS_MODE from userspace
  - Remove restriction of get/st operation must enable TPH by impl
    shadow ST table scheme
  - Refine uAPI definition
v11:
- Fix Sashiko review comments:
  Add tph_lock for protect all tph operations from vfio user
  Fix memory-leak when copy_to_user failed

Chengwen Feng (7):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Cache TPH requester capability at probe time
  PCI/TPH: Add requester selection policy to pcie_enable_tph()
  PCI/TPH: Add requester policy to pcie_tph_get_cpu_st()
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST
    configuration
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_CPU_ST to query TPH steering tag
  vfio/pci: Virtualize PCIe TPH capability registers

Zhiping Zhang (1):
  PCI/TPH: expose the enabled TPH requester type

 Documentation/PCI/tph.rst                     |  22 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |   5 +-
 drivers/pci/tph.c                             | 114 ++++++++---
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_config.c            |  68 +++++++
 drivers/vfio/pci/vfio_pci_core.c              | 178 +++++++++++++++++-
 include/linux/pci-tph.h                       |  26 ++-
 include/linux/pci.h                           |   1 +
 include/linux/vfio_pci_core.h                 |   6 +-
 include/uapi/linux/vfio.h                     |  49 +++++
 11 files changed, 441 insertions(+), 45 deletions(-)

-- 
2.17.1

