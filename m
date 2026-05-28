Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DB3F0744;
	Thu, 28 May 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972423; cv=none; b=CIJbBqp/CF8W0A18eq2tC+Ixb/ST6SqbZvlVjfyXT527DO9YB4knbLDuBeDcYKrsst/s0sodp33AEWVtAxc5ilqiWlWtDOE0tXyDk70Q1/74Qnt4KrTddVgIa+zpeE1elhfLzFtoaTqOYISBMZN56atP2nXx8dQQeTVAQTJ/kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972423; c=relaxed/simple;
	bh=cLSUQ8odGvDIjotBKoTlIHMgziXgulLQ3/e9izCqBPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGhlSYGhIcamRibSTiGxLfnKRbA4xjw8d1ZFAqnTS2cOEI5BMzMrXhVB52Hv+Q4XAz4soB4dizexrfLJ7ObW/ehKm0b16/EPfHCX4WX/gqT2wyUvuGHiXyXIHkYSMLeyxk77BzNUoWc/E5YcASWluZ9qzd4wGMdzWytgBGA3PBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vf1guT2U; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vf1guT2U"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bTSN8WFmKno0uTpzH2z6EVz9iZuw+Qr2QHdgNgSxuIw=;
	b=Vf1guT2U7zTmehaPy3g2C9NgU9iEUVX8ipz6HuwLwumh2r03ZEVyCMYVg7mIql1bKk734RavH
	zba3X3BmKlKQIxD/YWJeoEAKWOrCxYi5t2mAlSl2vd003djC5FpnfJ7HaCCXdetALenXzzx/p1d
	BWpXfhLH+NJ2MZtBBEVwh+U=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gR5dk6d7PzKmXd;
	Thu, 28 May 2026 20:39:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B931740562;
	Thu, 28 May 2026 20:46:55 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 May 2026 20:46:55 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Date: Thu, 28 May 2026 20:46:41 +0800
Message-ID: <20260528124649.14732-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
v14:
- Return PCI_TPH_LOC_NONE when !CONFIG_PCIE_TPH accord Alex's comment
- Fix Sashiko comments:
  - Clear ST shadow state across user session
  - Fix out-of-bounds byte masking in vfio_pci_tph_config_read
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

 Documentation/PCI/tph.rst                     |  22 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |   5 +-
 drivers/pci/tph.c                             | 116 +++++++---
 drivers/vfio/pci/vfio_pci.c                   |  13 +-
 drivers/vfio/pci/vfio_pci_config.c            |  78 +++++++
 drivers/vfio/pci/vfio_pci_core.c              | 199 +++++++++++++++++-
 include/linux/pci-tph.h                       |  29 ++-
 include/linux/pci.h                           |   1 +
 include/linux/vfio_pci_core.h                 |   6 +-
 include/uapi/linux/vfio.h                     |  49 +++++
 11 files changed, 477 insertions(+), 45 deletions(-)

-- 
2.17.1

