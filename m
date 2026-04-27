Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923738654F;
	Mon, 27 Apr 2026 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280339; cv=none; b=nZpjXeBviArNtrhvIftU7KxpWHO5XCGyNP5bDPWKD1suThfbtQ7fXSBNGZ3zvtXwv4sBVPpwGCqX8AEMXNV8/J34U+lCIeaXpQj/1OgjBhB7sRllZO0qVbuVwwbkdgJri4c5xZFecQ7I8iSotr/ZbHUXjvmuq+eANT2s5MJDpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280339; c=relaxed/simple;
	bh=U5I2lOxhR/uvUbAAhvbOHs0fxgmmmOqxtp9v+KLJkJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RiZhKHOfE4LiWDo4DgAiTTy/pqXl8RI0+suEy7XjKR6O87iD+m2Cm37pgaW0UgdN+JKC85aGt4ciGWdLKpFrlMdAVKeQFUTU5Kp6XtDC1K3M3eV9P6j17CVCOr9Sq7Yzzs+H+ACizH017U6rWEMTrcjHW4r88O049lGlcmX6EaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KMHzT1QO; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KMHzT1QO"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hTAZghKuuU3LCLcD5E+/LHxeKNzJlo4Cwk6KSNCyhJs=;
	b=KMHzT1QO946AJ8tOpjMM64Ap6c5U50l4iWbMTbpQ+TDkj3ivcVtWdRegXvpm0+Iv1ZQ2M6FLl
	6FvEfK9T7HKS12k4SAcOORYJ7u6LQ0hPGHi5uyBv2+TZIMMv8Gk9RubGy1UOkF2S3+65TPo6jWV
	c4D1Q1Xiu8vwJfKdWQM1Mw8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g3y4P1TwBz1prLd;
	Mon, 27 Apr 2026 16:52:21 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AF4B40576;
	Mon, 27 Apr 2026 16:58:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:58:49 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v5 0/6] vfio/pci: Add PCIe TPH support
Date: Mon, 27 Apr 2026 16:58:37 +0800
Message-ID: <20260427085843.42460-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Based on earlier RFC work by Wathsala Vithanage.

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

 drivers/pci/tph.c                |  21 +--
 drivers/vfio/pci/vfio_pci.c      |  13 +-
 drivers/vfio/pci/vfio_pci_core.c | 228 ++++++++++++++++++++++++++++++-
 include/linux/pci-tph.h          |   7 +
 include/linux/vfio_pci_core.h    |   3 +-
 include/uapi/linux/vfio.h        | 131 ++++++++++++++++++
 6 files changed, 391 insertions(+), 12 deletions(-)

-- 
2.17.1

