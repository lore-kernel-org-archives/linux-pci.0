Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A90346791;
	Tue, 26 May 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768536; cv=none; b=seA/wZeJZYNbZeljFJQrjC/jKlGFtwEN8m+dx+yM3MzN1hmWS4cJ98AKsFnYNho3GUmk4Tb3h/tctTPhulQ9/t9rlz+MuAStUFoQ/T6yW7QMMZ1irftTvr2r6KiLvwTNr9FsT7t+7dmVIh0+uuUrFFQGWdG/sXWiO/tTdYT0yn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768536; c=relaxed/simple;
	bh=ZkfSaPdX2yj8urIyKcFChobn9pOu3isLIcpUpyQApOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VX/V6+P+9CgdWTl85tOiC4n7vrgIz8/4vToZMne2QDIDbaQddMR3IYkXaZvarazA3HMaQIrG4BBqNrvWrKYMukIHQUv6k36PFYc22Hf3LMFmTXUUbaXAqyj5ktzQuGUt/IvWrGf/rpMsTDWjc6GOzqIA1BagDQHEVdKInSoQW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QyXINWyX; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QyXINWyX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HhOIHHg4fVfI3Jz96jjLVN33qCgyVKl71SJ0AdjG99U=;
	b=QyXINWyX5MnTfZtg/etiC5NKgBvhBMLIeSLFM3J1auh007zSAk2W3xC0Y1Lnt3+uHdYJEZoYb
	KXtPaMT4WVuqjoAIIQQgqB0HlF9lflBhpOyVbeoPcjozGxkyJI60nGkhk38nsI2L3mF0eSSsjqL
	Q91Isdl/HCN08fmI917m25o=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gPfDg2w9QzKm4h;
	Tue, 26 May 2026 12:00:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C0125402AB;
	Tue, 26 May 2026 12:08:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 12:08:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v12 0/6] vfio/pci: Add PCIe TPH support
Date: Tue, 26 May 2026 12:08:24 +0800
Message-ID: <20260526040830.52854-1-fengchengwen@huawei.com>
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
v10:
- Fix Sashiko review comments:
  - Fix TPH virtualization write return negetive val of 4/5 commit
  - Fix don't support probe feature of 5/5 commit
  - Fix return positive val if copy_to_user fail of 5/5 commit

Chengwen Feng (6):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  PCI/TPH: Add pcie_tph_enabled_mode() helper
  PCI/TPH: Move tph_req_type initialization into pci_tph_init
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for PCIe TPH steering tag
    management
  vfio/pci: Add PCIe TPH control register virtualization

 drivers/pci/tph.c                  |  77 +++++++-----
 drivers/vfio/pci/vfio_pci.c        |  13 ++-
 drivers/vfio/pci/vfio_pci_config.c |  38 ++++++
 drivers/vfio/pci/vfio_pci_core.c   | 182 ++++++++++++++++++++++++++++-
 include/linux/pci-tph.h            |  10 ++
 include/linux/vfio_pci_core.h      |   6 +-
 include/uapi/linux/vfio.h          |  49 ++++++++
 7 files changed, 344 insertions(+), 31 deletions(-)

-- 
2.17.1

