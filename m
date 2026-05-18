Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA353D1712;
	Mon, 18 May 2026 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088638; cv=none; b=IDsIyXYo+iIBTwQJYDcyRz0dbqW7Fg90X+xmjmOwZqyTGAxHjeyfbA4rGevg8yI+HCw4BemZeARAgDnkEdeddyiv95Ac2S3cI8xHfeP6uPwYmKmPziZjYA6YhN3gcTzucKqerhqUFP7Nqa+dmwQbAbNUOeX0o6g0VhnhNy+LlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088638; c=relaxed/simple;
	bh=UBBrPH10FCDZwj/2WCd42KyDPP9N9e8ZafuvTDTZORs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUOgowHM+4G5rjw6MbK0WBb3RI9W09gThTHEo9nGQ2l6kCAEOQZ7fsTOz3TLewMXApaPY/drcm4nNYOlYZGxFd1bfo3uNNuVljGccQKWU3kPPAkG0igf52fmIx976zRIO5sweEezHeKto1i+/tODjZi0Ox4zGa8fDr2a0ky/vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=E06t7f7D; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="E06t7f7D"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nIVEN50krsX31dFjSDcw3i3MrxK9EZKjdxq7KhkAhWg=;
	b=E06t7f7DQZfK+1kxfvAdcF6XfYk/pYYbh/uHnOf7SgejEf38gHZeXo4rdim/xYgw+1GpMQs05
	ZJBLyx36ykvKN1ah8FBatqce9yMgo9dZ5avFPE2cZIKvTgjUxTkxGP/SzofaUN7cl3lNs0lstS7
	YY0Ub3LEo766AcvBgKSPrRc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gJpp946Fqzcb14;
	Mon, 18 May 2026 15:09:37 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C5B0340561;
	Mon, 18 May 2026 15:17:07 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 May 2026 15:17:07 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v11 0/5] vfio/pci: Add PCIe TPH support
Date: Mon, 18 May 2026 15:16:56 +0800
Message-ID: <20260518071701.25177-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

v11:
- Fix Sashiko review comments:
  Add tph_lock for protect all tph operations from vfio user
  Fix memory-leak when copy_to_user failed
v10:
- Fix Sashiko review comments:
  - Fix TPH virtualization write return negetive val of 4/5 commit
  - Fix don't support probe feature of 5/5 commit
  - Fix return positive val if copy_to_user fail of 5/5 commit
v9:
- Address Alex's comment on VFIO part: adopt device feature scheme
- Remove pcie_tph_get_st_table_size and add pcie_tph_is_enabled
  depending on the implementation requirements

Chengwen Feng (5):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  PCI/TPH: Add pcie_tph_enabled_mode() helper
  vfio/pci: Add PCIe TPH configuration space virtualization
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

 drivers/pci/tph.c                  |  38 +++++++---
 drivers/vfio/pci/vfio_pci.c        |  13 +++-
 drivers/vfio/pci/vfio_pci_config.c |  28 ++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 107 ++++++++++++++++++++++++++++-
 include/linux/pci-tph.h            |  10 +++
 include/linux/vfio_pci_core.h      |   4 +-
 include/uapi/linux/vfio.h          |  41 +++++++++++
 7 files changed, 230 insertions(+), 11 deletions(-)

-- 
2.17.1

