Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017173815DC;
	Thu, 16 Apr 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331277; cv=none; b=HtZF9tXz38Mi2Eql+Ev8xUPRmrQmSnFi8h4yllMbzarihaqNdzy9Z74WBhiSr40ySQDEj6qUsrih4C+QtNOOdXzWzqP6RHsZJpLz9yBQuwq2MHTn7AEh5gx6CyAWo8JOWbj8wuuyIY+TE/UyPO7hWe4TeIpFGmN78HMlmoGNKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331277; c=relaxed/simple;
	bh=9rrxkJGcfvheNH3ZjThzxRyJRY6JnbKPAWOjKCR3WRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRWKuvL0E+7ukNV3HffUfOgWnm9qf+b21p1QwERIiKZLz/rKAto0yPLRH7hBsv5vDhU0fFH/UbYHRchdOgpXdWJZgYDVsfMFnK1f82XeVvp2sYwyoDR76pbljYKrYAJtwnDF6DZdLx5gP9UaG7svagD4TOOjqEy+ZG+MyGn9KIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JkoOOMnI; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JkoOOMnI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3Fvqqj6W6niUat7EKNlM1LJN9IyI47YUEGrMTafBpVk=;
	b=JkoOOMnI9EuVIRzgjFgAL6Fy+zCwJafwIFnACmKmuO3LGGFpjmfWVuV5rS7zZX224Olub3cHQ
	MBgvAd6JsoBrWLToWu9O583a0nqRmKKfydrEaTDM24LH1xjrGQjqSQNEKits8DSDbXSsfaUsLx+
	FUBeWf/iTwQTLhDo1A/RGGo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fxC5R2ZPMzmVBt;
	Thu, 16 Apr 2026 17:14:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C189540561;
	Thu, 16 Apr 2026 17:21:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:21:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 0/5] vfio/pci: Add PCIe TPH support
Date: Thu, 16 Apr 2026 17:21:00 +0800
Message-ID: <20260416092105.41439-1-fengchengwen@huawei.com>
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

This series adds support for PCIe TLP Processing Hints (TPH) to
vfio-pci, allowing userspace to manage device steering tags for
improved performance and QoS in virtualized deployments.

The implementation follows a clean incremental structure:
- Patch 1: Introduce UAPI ABI and implement capability query to
  let userspace discover supported TPH modes, ST table presence
  and size.
- Patch 2: Add TPH enable/disable with mode selection.
- Patch 3: Add interface to batch get per-CPU steering tags for
  device-specific mode.
- Patch 4: Add interface to batch program steering tag table
  entries for standard TPH modes.

All user API definitions are finalized in the first patch and
remain stable across the series. The design follows existing
VFIO conventions and relies on kernel pcie-tph infrastructure.

This series addresses the TPH management requirements discussed
in the RFC "Proposal: Add sysfs interface for PCIe TPH Steering
Tag retrieval and configuration".

Instead of introducing a sysfs interface, we choose to implement
TPH management via a VFIO-specific ioctl for these reasons:
1. VFIO is the standard userspace interface for PCI devices.
2. An ioctl approach provides better type safety, batch support
   and stable ABI compared to sysfs for configuration.
3. VFIO properly isolates TPH operations to the assigned device,
   avoiding conflicts with other kernel management paths.

Based on earlier RFC work by Wathsala Vithanage.

v2:
- Export pcie_tph_get_st_modes()
- Add detailed comment for UAPI structures and operations
- Add batch entry limit VFIO_TPH_MAX_ENTRIES
- Improve robustness and error handling

Chengwen Feng (5):
  pci/tph: Export pcie_tph_get_st_modes() for external use
  vfio/pci: Add PCIe TPH interface with capability query
  vfio/pci: Add PCIe TPH enable/disable support
  vfio/pci: Add PCIe TPH GET_ST interface
  vfio/pci: Add PCIe TPH SET_ST interface

 drivers/pci/tph.c                |  13 +-
 drivers/vfio/pci/vfio_pci_core.c | 213 +++++++++++++++++++++++++++++++
 include/linux/pci-tph.h          |   7 +
 include/uapi/linux/vfio.h        | 131 +++++++++++++++++++
 4 files changed, 362 insertions(+), 2 deletions(-)

-- 
2.17.1

