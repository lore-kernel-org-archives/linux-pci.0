Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B538F247;
	Thu, 16 Apr 2026 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331852; cv=none; b=j4RSUm5cPwTmTPYKVnXnQXPmsknS6LLfT5AaW/WeFJeMTg4AJ5527blMqMoHMnmfaM5LaVhm33LMwAHpgwO5+TEpDkDYXKYF4cazS2eklikeily2c1U2CXzCUOoZmXsQmXfyF4PWKf36ZoTIcnOtHlBrGX3QU06Ue4MP5oVkYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331852; c=relaxed/simple;
	bh=eqLbjKpHvJJASnMNfj1/EGNkoZ7XXA9AM3aXkMF78Sk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dg8a0BzqV0LluR+eMZvkPH8kRqlDTd0nCO5P2DC5ZXzbSCCr1XNCUPNBoXzEAgig6wOq0e9vlVNGJKEowKq7k/m0aso5bzDdCMJDcswIOKTJXOuyM9oUpdn5A6HhvxQWTbVcVZ+j3U8MINGDlczfdSsybaZakJpiwQBz8lXGSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ltzoepqt; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ltzoepqt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bAVowK7Q9YFx+myHaiGCXgYsB7sBEgPGL+pKIOE34z4=;
	b=ltzoepqtRnEVkr8VlwAD9cfTNSHBjH+fBi/kTP5+N4c3t7EcqDcAKNEhBgIfPWoY1D6LTAfOf
	9VO18U89KiMgdA6js0EEUNGYVGhNvgI5lSjnvAp15aZ3/I33kAv9MClYBc2xrMqjv5bfFV7vIkh
	Uj3931mLqpAiuVux0hdVvp8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fxCJX21YTzRhTx;
	Thu, 16 Apr 2026 17:24:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AB0740538;
	Thu, 16 Apr 2026 17:30:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 17:30:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2 RESEND 0/5] vfio/pci: Add PCIe TPH support
Date: Thu, 16 Apr 2026 17:30:36 +0800
Message-ID: <20260416093041.42070-1-fengchengwen@huawei.com>
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
- Patch 1: Export pcie_tph_get_st_modes()
- Patch 2: Introduce UAPI ABI and implement capability query to
  let userspace discover supported TPH modes, ST table presence
  and size.
- Patch 3: Add TPH enable/disable with mode selection.
- Patch 4: Add interface to batch get per-CPU steering tags for
  device-specific mode without standard ST table.
- Patch 5: Add interface to batch program steering tag table
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

