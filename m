Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0427BF6C;
	Thu, 23 Apr 2026 01:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906547; cv=none; b=md1YiCHLBPOi6cFuAhYUj+4PagVP0fiTcfufZlCtcIZVVJWfWsHhu/wR3isOcadmNNZM090DkcYE5Z5HqSs+0k5TTNZvMpKr/w8cOid+nREA+1tOdMpHMA30OVQW597MI0/lhkeXy8wa+amva7ZUFNvPq5bn/44+LJpcArR0FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906547; c=relaxed/simple;
	bh=228AgdFS86IQi0odGn+xgFovd83zQNrMJcJLhl5+KC8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O8SBnR1jjet08ipHxu43VpXQLAPRxFmeLpOhGNU1Tsk/AElaH2AdN+WxyDfEMpHnuCCtVRTHgrcEY50z96uNloUtiXnz11MGgiN5toEJAmyH/w2d2kEVgk8vymKaUrJQf7ug41TLaKjyzMKVqD4kdCD3fFV1IixlW2SD6gSd2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=SEMcAhvW; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="SEMcAhvW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lEKCag3ENTTr/YOurag2RZ8Vm850IdPfjTBjeHiUWFU=;
	b=SEMcAhvWhrPrnAQQeVlmSgHWb1hjzXHLVLKeDCnYgcyivIeR3XCUCqxqdAoUlgJx7zXjv052m
	xs//kTp7b9QlKP/e247Sk2EpxWcDWYRmK2MJurErYobK4O/lOBFQTbn5vx7rpiOF4oOJlBN/xvV
	9Dgv2kgsDMom9u4Owf6DepA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g1HrM4GMvz12LDP;
	Thu, 23 Apr 2026 09:02:43 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 236D140561;
	Thu, 23 Apr 2026 09:08:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Apr 2026 09:08:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
Date: Thu, 23 Apr 2026 09:08:46 +0800
Message-ID: <20260423010851.46737-1-fengchengwen@huawei.com>
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

This series adds support for PCIe TLP Processing Hints (TPH) to
vfio-pci, allowing userspace to manage device steering tags for
improved performance and QoS in virtualized deployments.

The implementation follows a clean incremental structure:
- Patch 1: Export pcie_tph_get_st_modes()
- Patch 2: Introduce UAPI ABI and implement capability query to
  let userspace discover supported TPH modes, ST table presence
  and size. Also add module parameter enable_unsafe_tph_ds to
  guard unsafe usage of TPH Device-Specific mode with no ST table.
- Patch 3: Add TPH enable/disable with mode selection. Restrict
  unsafe Device-Specific mode without ST table to be allowed only
  when the module parameter is enabled.
- Patch 4: Add interface to batch get per-CPU steering tags for
  device-specific mode without standard ST table. This interface
  is only available when the unsafe module parameter is enabled.
- Patch 5: Add interface to batch program steering tag table
  entries for standard TPH modes.

All user API definitions are finalized in the first patch and
remain stable across the series. The design follows existing
VFIO conventions and relies on kernel pcie-tph infrastructure.

To avoid potential security risks in virtualization environments,
TPH Device-Specific mode without a standard ST table is blocked
by default. It can only be enabled by administrators via the
enable_unsafe_tph_ds module parameter for trusted bare-metal
userspace.

This series addresses the TPH management requirements discussed
in the RFC "Proposal: Add sysfs interface for PCIe TPH Steering
Tag retrieval and configuration".

Instead of introducing a sysfs interface, we choose to implement
TPH management via a VFIO-specific ioctl for these reasons:
- VFIO is the standard userspace interface for PCI devices.
- An ioctl approach provides better type safety, batch support
  and stable ABI compared to sysfs for configuration.
- VFIO properly isolates TPH operations to the assigned device,
  avoiding conflicts with other kernel management paths.

Based on earlier RFC work by Wathsala Vithanage.

v3:
- Add module param enable_unsafe_tph_ds to guard unsafe usage
  of TPH device-specific mode with no ST table
v2:
- Export pcie_tph_get_st_modes()
- Add detailed comment for UAPI structures and operations
- Add batch entry limit VFIO_TPH_MAX_ENTRIES
- Improve robustness and error handling

Chengwen Feng (5):
  PCI/TPH: Export pcie_tph_get_st_modes() for external use
  vfio/pci: Add PCIe TPH interface with capability query
  vfio/pci: Add PCIe TPH enable/disable support
  vfio/pci: Add PCIe TPH GET_ST interface
  vfio/pci: Add PCIe TPH SET_ST interface

 drivers/pci/tph.c                |  13 +-
 drivers/vfio/pci/vfio_pci.c      |  13 +-
 drivers/vfio/pci/vfio_pci_core.c | 225 ++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h          |   7 +
 include/linux/vfio_pci_core.h    |   3 +-
 include/uapi/linux/vfio.h        | 131 ++++++++++++++++++
 6 files changed, 387 insertions(+), 5 deletions(-)

-- 
2.17.1

