Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9E36CDFE;
	Thu,  7 May 2026 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159410; cv=none; b=Zdp7MFWuNqrjG+CFGD9IRGjKTf9s3panpLKBQLFIR00zOAx3igMkyE5z3sAju1hoKh1YzAICLyh1LgLgjiLG0RPM4wXM5QPWKDBz7kpgIomO3FQIhHLKcWNMtWz1XVs4MQQHlXf9E41zYIQMoU18DgR9T6vVtPSxHc5OJGBuWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159410; c=relaxed/simple;
	bh=7a7vQfQ6lzTtJHY1EQoPWt4LHQQ8wnQjBLXBUbEGjls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+GaPhtc/vizBd4//3KMXkRN7h1pNjQOUqXp6JTtdkurtyw++SSFUc25qaFzp0Q2ga99c+ASKr+c5+Bd5C1UUuD6KeXR1uDWtK8ZBGcdmmZj89HLBlJ8vH/Z4/8CdLUmskAmzNOjUx2YvcSYDDXmhsfk8Cr1XeauSsygfoJHZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kJdjxynh; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kJdjxynh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Sixmsk+HVoyoSFiyyDd0fBahO6caxF8ZaHIkupIc1W8=;
	b=kJdjxynhSYbkzJWndCLuUNDFMDGmTBMOyi1kVugJE6ORThJGYOZ8rA0lwqldl1O48So2hQN/b
	e840wwDIEfF/kiM9dZvdBFsKaw5bzAguXubzZhErAAgbETN49BiCelFJnBD4/hYHcZryoWo58Sj
	YvRA3l0WGk7TXXNLObm+pHk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gBC8P6q4Mz1T4Fx;
	Thu,  7 May 2026 21:02:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D0594056D;
	Thu,  7 May 2026 21:10:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 21:10:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v7 0/6] vfio/pci: Add PCIe TPH support
Date: Thu, 7 May 2026 21:09:50 +0800
Message-ID: <20260507130956.34441-1-fengchengwen@huawei.com>
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
  
TPH supports both IV and DS modes. Since device-specific (DS) TPH mode
introduces cross-VM isolation risks such as untrusted guests programming
arbitrary steering tags to impact other domains, so a new module parameter
`enable_unsafe_tph_ds_mode` is added. It defaults to off, and blocks all
unsafe DS-mode TPH operations when disabled.

To restrict abuse of SET_ST and prevent arbitrary steering tag programming
from userspace, the interface only accepts explicit CPU ID, memory type
and index inputs. The kernel resolves the corresponding steering tag
internally before programming, limiting userspace to controlled,
index-based configuration.

Based on earlier RFC work by Wathsala Vithanage

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
v6:
- Address Alex's comment on [1/6] commit.
- Fix Sashiko review comments:
  Add tph_cap validation for pcie_tph_get_st_modes/st_table_loc.
  Add argsz validation for each op cmd.
  Move disable tph from ioctl-reset to register.
  Verify reserved field for get/set ST op.
  Fix ABI mismatch due to pointer arithmetic of get/st ST op.
v5:
- Fix pcie_tph_get_st_table_loc() field extraction bug
- Add disable TPH in vfio_pci_ioctl_reset() to clean software state
v4:
- Address Jason's comment of restrict device-specific mode under module
  param control.
- Rename module param to enable_unsafe_tph_ds_mode
v3:
- Add module param enable_unsafe_tph_ds to guard unsafe usage
  of TPH device-specific mode with no ST table
v2:
- Export pcie_tph_get_st_modes()
- Add detailed comment for UAPI structures and operations
- Add batch entry limit VFIO_TPH_MAX_ENTRIES
- Improve robustness and error handling

Chengwen Feng (6):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  vfio/pci: Add PCIe TPH interface with capability query
  vfio/pci: Add PCIe TPH enable/disable support
  vfio/pci: Add PCIe TPH GET_ST interface
  vfio/pci: Add PCIe TPH SET_ST interface

 drivers/pci/tph.c                |  26 ++-
 drivers/vfio/pci/vfio_pci.c      |  13 +-
 drivers/vfio/pci/vfio_pci_core.c | 264 ++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h          |   7 +
 include/linux/vfio_pci_core.h    |   3 +-
 include/uapi/linux/vfio.h        | 131 +++++++++++++++
 6 files changed, 433 insertions(+), 11 deletions(-)

-- 
2.17.1

