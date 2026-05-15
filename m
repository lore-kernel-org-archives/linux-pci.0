Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6E38425D;
	Fri, 15 May 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838051; cv=none; b=srdbDzlipvb6ReeD0okKhZHkjgqtVwh8a7HwUcdrrhqJyiiU0MCMcH4LZR1FsGPeyCB79fUzxbAiV6AGDVD4zU5ikmv2GttKk6Cwrq6Qs/WLyw55U+y6sCk+FbZzkgFXllGVjEORAmmfxA/4lxGCJwGcrW1NLhG2Xq6/fUe7mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838051; c=relaxed/simple;
	bh=q99zQIrIlObfiWoEEgi97UC/wlsiARIA353VLO+1Xq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=capVB3jpnBZ+tnO34IbIa8YO4RCVHTcnzG/04MajgNdGTk5g+DvKUjqgZcR0fbxDAwjzeycqEytCvxY88M/5oXLJKb5OBT6FfRnHz1DuqXJMIM0iy60J//CnfUr2NO4L5K2S7RWs9HDDiA6ixQpZMTPAW2u+iIWnup3JbRynSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3p98aDdL; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3p98aDdL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0XfJjo1/meNT94b8bXEXbgagMtQ4mZwRr9rrykaSRiY=;
	b=3p98aDdLM4R7Sv9pWUYl+SxKMx8O8EkBpSUKnDsglp44/FaP37oe9uspXyMUpZTM2XjaeDUNL
	PwfNEI88JSwJmK8sUgscUQv2Lxr2esEH0pSJsrvkZRtUNkgz50irRICCd57NaIrB9pcI/O2w23H
	jw4MUL+6TQDkgfB/l6f6fuU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gH2796QY7z1cyR0;
	Fri, 15 May 2026 17:33:09 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id ED9CE40563;
	Fri, 15 May 2026 17:40:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 May 2026 17:40:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v10 0/5] vfio/pci: Add PCIe TPH support
Date: Fri, 15 May 2026 17:40:35 +0800
Message-ID: <20260515094040.38496-1-fengchengwen@huawei.com>
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

v10:
- Fix Sashiko review comments:
  - Fix TPH virtualization write return negetive val of 4/5 commit
  - Fix don't support probe feature of 5/5 commit
  - Fix return positive val if copy_to_user fail of 5/5 commit
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

Chengwen Feng (5):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  PCI/TPH: Add pcie_tph_enabled_mode() helper
  vfio/pci: Add PCIe TPH configuration space virtualization
  vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for TPH ST entry management

 drivers/pci/tph.c                  |  38 ++++++++---
 drivers/vfio/pci/vfio_pci.c        |  13 +++-
 drivers/vfio/pci/vfio_pci_config.c |  29 +++++++++
 drivers/vfio/pci/vfio_pci_core.c   | 101 ++++++++++++++++++++++++++++-
 include/linux/pci-tph.h            |  10 +++
 include/linux/vfio_pci_core.h      |   3 +-
 include/uapi/linux/vfio.h          |  41 ++++++++++++
 7 files changed, 224 insertions(+), 11 deletions(-)

-- 
2.17.1

