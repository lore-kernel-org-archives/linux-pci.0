Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87EE48C3EF;
	Tue, 12 May 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573032; cv=none; b=Rq8ATXl+/mV3zw5GrmkL58LIL5XYT+tHHGNMb5TpEeshQWJrtvgryCFC6+qcNLXgfwxhTZ/m7qK2sD78LKuBRi4tQcyjsJ6d8g2ZijOfv47tI3kSGC4fgCu0ca9gkMqyYow80LivkwGHmHXeX5fcxyHWoR/rriQwOQ2dyj2hkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573032; c=relaxed/simple;
	bh=QLzBNC9Lqx0E4M4ONH0PWSEMkUsJo2+rug2MGxOtGIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfgQw3GtHW7+UPgNIxFlTizJ7b2gl86WTThBY6INvOKl2y/41N6UInvdmWyMqLBlPqJUrjoXrv0JLKhlLpCX5inCmeLiDyry4ec2A0ITOLGPDYTjOXyPP31UnbKlUP25T1lLonKvYENpU3DpmTsIK3xQgPL/DMSZln5W7GuxesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EuGD6rjv; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EuGD6rjv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1UCKhfnlAGoU7RxVMEPPursC4FstE0Feft9iB5oshxM=;
	b=EuGD6rjvwtbOlSJLw3xqAUuAYA5n6+Ebxnh7SEiLbVC+GhkmYXG+6j2XawkuoAkec3aLoPpwq
	VfyJjOge/2jI8KKgY23TAjOsOwROuD0+IlRDH1BBLBYacAJJ2Ef+I9QmYBxzrExLf1yjk3ki/bW
	hyvaUV2+hhL4pwmUiDm7K4Q=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gF86T3NQ5zmV6x;
	Tue, 12 May 2026 15:56:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1407B402AB;
	Tue, 12 May 2026 16:03:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 16:03:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v9 0/5] vfio/pci: Add PCIe TPH support
Date: Tue, 12 May 2026 16:03:24 +0800
Message-ID: <20260512080329.42593-1-fengchengwen@huawei.com>
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

v9:
- Address Alex's comment on VFIO part: adopt device feature scheme
- Remove pcie_tph_get_st_table_size and add pcie_tph_is_enabled
  depending on the implementation requirements
v8:
- Make GET_ST op could retrieve CPU's steer tags for DS mode.
  note: the original impl could for DS mode + No ST Table, the
  background is that we found one netcard defined ST table with DS
  mode, but also need to config set ST by device-specific way.
- Support verify index when SET_ST.
- Fix Sashiko review comments:
  1. Add fix pcie_tph_get_st_table_size for msi-x table commit
  2. Add argsz validation for GET/SET_ST copy st
  3. Verify mem-type when SET_ST with cpu=U32_MAX
v7:
- Address Bjorn's comment on [1/6] commit.
- Don't report ds mode defaultly (enable_unsafe_tph_ds_mode=0)
- Fix Sashiko review comments:
  1. pcie_tph_get_st_table_loc()'s stub return 0
  2. Tph ioctl argsz validation wrong use offsetofend
  3. Disable TPH when device was taken-over/close to/by userspace
  4. Serialize all TPH operations under vdev->igate to prevent hardware
     control and bitfield races.
  5. Check unused ioctl field to be zero.

Chengwen Feng (5):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  PCI/TPH: Add pcie_tph_enabled_mode() helper
  vfio/pci: Add PCIe TPH configuration space virtualization
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

 drivers/pci/tph.c                  | 38 +++++++++---
 drivers/vfio/pci/vfio_pci.c        | 13 +++-
 drivers/vfio/pci/vfio_pci_config.c | 33 ++++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 99 +++++++++++++++++++++++++++++-
 include/linux/pci-tph.h            | 10 +++
 include/linux/vfio_pci_core.h      |  3 +-
 include/uapi/linux/vfio.h          | 41 +++++++++++++
 7 files changed, 226 insertions(+), 11 deletions(-)

-- 
2.17.1

