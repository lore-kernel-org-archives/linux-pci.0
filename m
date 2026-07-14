Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CE36F419;
	Tue, 14 Jul 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025819; cv=none; b=omO8M7jQETaayJcU0EwIJ7b/AiG8H55Afegd0gf6kSOczwMVDm/mCzIoNWArGewhE86m7/TLIJ4p3y5GucUKseKtV82/UGRACYnPZKFvI2iM2bwFMLCJllVM7jfp7TN+dEHindOUq8dRNNe9kUHCDU3epagUuUaEaa//VFhFcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025819; c=relaxed/simple;
	bh=epahLDyQsz/tAJ4k/xd7headGLS2WRYATzGyf6xNxVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MVtXmkdXT2PxlHvhIqJx2EosFrHvP1QgFDHaDplQO8ClgwT5sIFfRUnDT3/YAmCJxF4Ghx+CtEgpvozkM/25UJGwoA1AXcEgo/NzLAzWs41ENR4b0NIMAUxRg+8/MMunXaEeRN+PLD5xiPgQju3SbWUr9P/z5Gj/CrTMYm7ZiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2SgpRN/n; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2SgpRN/n"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wXsq1iPHhMb7w/8o0UmRx1HAAIKZniLBNFjGH84Zle4=;
	b=2SgpRN/nS2oSLxXmtA2nIJXy3k1gAT9IMmKiP6GaEEK92vJyvHLwKCR8PqjFEe5kzUtX0T5Uj
	kdKN3nY2hlhK5f+C9RzNTI7FadrZ6X69+2QlvvM3FpuMPPdoVuSbvmuFMh4p1G1S1w1l6Hyd1Su
	eGecJTTza7rKtm9/Nz103wQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gzwdy1xNvzLlTk;
	Tue, 14 Jul 2026 18:34:14 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 059DD4048B;
	Tue, 14 Jul 2026 18:43:32 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:31 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 00/16] vfio/pci: Add PCIe TPH support
Date: Tue, 14 Jul 2026 18:43:09 +0800
Message-ID: <20260714104325.54444-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

This patchset enables full userspace configurable PCIe TPH support for
VFIO, which brings performance benefits for userspace workloads such as
DPDK and SPDK.

Currently VFIO only exposes read-only TPH capability registers to
userspace, while all write operations are silently discarded. This
prevents userspace from enabling and configuring TPH, limiting performance
optimization opportunities.

Per PCIe spec 7.5.3.15: TPH Completer support is applicable to Root Ports
and Endpoints, allowing Steering Tags to target host CPUs or peer devices
for P2P transactions.

TPH usage model can be divided into three fundamental parts:
1. Retrieve Steering Tag:
   - Tags targeting host CPUs are obtained via platform methods (ACPI _DSM)
     wrapped in pcie_tph_get_cpu_st(). Userspace requires a generic
     interface to query these CPU-associated ST values.
   - Tags targeting peer devices are managed by userspace drivers, and set
     to kernel by dmabuf ioctl which address by zhiping's patchset.
2. Program Steering Tag table:
   - For devices with standard ST table structures (in capability space or
     MSI-X table), userspace needs a unified interface to configure ST
     entries.
   - Devices without standard ST tables are handled by userspace itself.
3. Toggle device TPH Requester enable/disable state.

The patchset builds a complete, secure, staged TPH feature stack with core
design objectives:
1. Refactor & fix upstream PCI/TPH core implementation to provide clean,
   safe, extendable helper APIs for VFIO consumption;
2. Introduce configurable per-device TPH policy for staged feature
   enablement, supporting progressive enabling of No-ST/IV/DS/LITERAL
   modes;
3. Fully virtualize PCIe TPH config space: read-only capability header,
   virtually writable TPH_CTRL, silent discard invalid writes;
4. Implement unified VFIO user feature uAPI (TPH / TPH_RESOLVE / TPH_ST)
   for TPH enablement, tag resolution and batch ST table programming;

The patchset is split into three logical parts:
1. The first three patches is Zhiping's patchset of add TPH support for
   p2p access (based on v11), because this patchset support query dmabuf's
   ST/PH
2. The second eight patches fix and refactor core PCI/TPH kernel code to
   export required helper interfaces
3. The last five patches implement corresponding VFIO TPH virtualization
   and uAPI step by step.

Based on earlier RFC work by Wathsala Vithanage

---
v20:
- Address almost all comments from Alex about v19, not within Alex's
  scope:
  - Drop LITERAL policy support
  - uAPI changes: cap have been split into fine-grained
  - TPH config access: still based on perm mechanism, but restrict the
    readable and writable length
  - Debugfs add more fields
v19:
- Address all comments from Alex
  - Drop CPU-to-ST translation of PCI/TPH
  - Re-implement vfio part, please refer:
    https://lore.kernel.org/linux-pci/20260626092232.53ed3a7c@shazbot.org/
- Add expose tph_policy via debugfs

Chengwen Feng (13):
  PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction
  PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
  PCI/TPH: Cache negotiated max requester type at probe time
  PCI/TPH: Refactor pcie_enable_tph and add requester variant
  PCI/TPH: Refactor pcie_tph_get_cpu_st & add requester variant
  PCI/TPH: Add macros to check standard and extended TPH support
  PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming
    helper
  PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH ST
    _DSM
  vfio/pci: Add basic NO-ST TPH VFIO device feature support
  vfio/pci: Add IV-ST TPH policy and VFIO TPH_ST batch programming
    support
  vfio/pci: Add DS-ST TPH policy and extend TPH_RESOLVE capabilities
  vfio/pci: Sync core PCI TPH software state across device lifecycle and
    resets
  vfio/pci: Expose per-device TPH state via debugfs

Zhiping Zhang (3):
  PCI/TPH: Add requester/completer type helpers
  dma-buf: add optional get_pci_tph() callback
  vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature

 drivers/dma-buf/dma-buf.c          |  32 +++
 drivers/pci/tph.c                  | 282 ++++++++++++++++++------
 drivers/vfio/pci/vfio_pci.c        |  23 ++
 drivers/vfio/pci/vfio_pci_config.c | 164 ++++++++++++--
 drivers/vfio/pci/vfio_pci_core.c   | 341 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c | 102 ++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |  18 ++
 include/linux/dma-buf.h            |  25 +++
 include/linux/pci-tph.h            |  53 ++++-
 include/linux/pci.h                |   6 +-
 include/linux/vfio_pci_core.h      |   3 +
 include/uapi/linux/vfio.h          | 144 ++++++++++++
 12 files changed, 1090 insertions(+), 103 deletions(-)

-- 
2.17.1

