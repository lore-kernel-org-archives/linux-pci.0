Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837F2C375E;
	Tue,  2 Jun 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411257; cv=none; b=agpUadFaLzMTr4a2vNveGQ3zQfz6wsfNBwxsrOKz+hvO3hppqlbohC/rnWase6HEYXBcFssJWQCAkTHLRHNsMeKC6MRYIy43L2RDYRzfL+eBgcZOHIfvwwThVwWUDA7vLdgQxdvglkiKDkq+vX0L9g1L+UcCA8oYefFbgd1nw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411257; c=relaxed/simple;
	bh=OWdlbWTcrXbNvG+vLlHDc5i7emdv2GEJBZs2CE8x0CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyWhAUlVnT6ThfphaijYTIJlTJ8rNk3lzuHsYu5TJzbsRC6GXLAGE0Nd1k0aw+MR12opbHPmz61uO4qH91ZkA+YmAV+RHU0abXJY3KvNKQr7lIo5LbMoAJQDtZWxYyAb1Mb9xNxMYXq1vzTn25vtl+79lpRXsk4joRzFEca7OEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mxQlYB/j; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mxQlYB/j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9O/XptNaQo64ycn8HW0UjiYV2ZBk3O6GD/AwNJO08lo=;
	b=mxQlYB/jjT+jwIwHKXJF7y8IIt9Zqan6p6CbxQmGRPuwWlJirNdv5h4lLx292DVzl13pzVp40
	Y3irbYsGFkpt5oAkPDIXmHMueodf+xwZ8k/wwISh7uqzUKoeLQ0uHI3NWCv+StpHog8CHW34s6r
	2YPj2uGMWZpi1kcC7ADRRU0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gVCwm1Cs9z1prk2;
	Tue,  2 Jun 2026 22:32:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2457740561;
	Tue,  2 Jun 2026 22:40:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:47 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 00/10] vfio/pci: Add PCIe TPH support
Date: Tue, 2 Jun 2026 22:40:13 +0800
Message-ID: <20260602144023.25254-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
v15: Address Alex's comments:
- Drop TPH capability when tph_cap=0
- Use _explicit postfix other than add policy parameter for enable
  TPH and get tph st.
- Make sure set st entry under D0
- Reimpl virtualize TPH capability register
- Other fix
v14:
- Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's comment
- Fix Sashiko comments:
  - Clear ST shadow state across user session
  - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
v13:
- Fix Alex's comments:
  - Add virtualize of TPH request type
  - Adopt two feature

Chengwen Feng (9):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Cache TPH requester capability at probe time
  PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
  PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
  PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant
  PCI/TPH: Add pcie_tph_supported() helper to check TPH capability
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST_CONFIG for PCIe TPH ST
    configuration
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_CPU_ST to query TPH steering tag
  vfio/pci: Virtualize PCIe TPH capability registers

Zhiping Zhang (1):
  PCI/TPH: expose the enabled TPH requester type

 drivers/pci/tph.c                  | 213 ++++++++++++++++++++---------
 drivers/vfio/pci/vfio_pci.c        |  13 +-
 drivers/vfio/pci/vfio_pci_config.c | 106 ++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 204 ++++++++++++++++++++++++++-
 include/linux/pci-tph.h            |  22 +++
 include/linux/pci.h                |   5 +-
 include/linux/vfio_pci_core.h      |   6 +-
 include/uapi/linux/vfio.h          |  49 +++++++
 8 files changed, 551 insertions(+), 67 deletions(-)

-- 
2.17.1

