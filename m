Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401404;
	b=AfpUJ8g5pzYgcwtQo0zbrNQJvjmy3CfnEiGJ9vi9X0LGg0s+lcT0GIJU673Oq2t5R+QH
	 IFmqaz8smX3Zbxa4bBXbiMZx3MI0BqCoZhsYwhHAAZXxYK+pKiZtR3zlhhiyCY9eKi8oN
	 /3bBtBU6EibDzX2GndNrqs8ypjCZD7Vo6BCz0g/iygGA+DmDl7REWIpx3WwNUNEfQNyNQ
	 RUEWDLuSkhx6ilYAjh5s8cxHyDItBDGwpr2IS9SQxYaxVgPnldmxnvYGqz8DdYcuyo9Oo
	 /qR/kendeJ/tWPXkikAhRnrB+6MfPUgptlrDzkSJaJ2ABD9PPKF1y7S5AZYZTLYr/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401404;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=hTIujUG09qqEbt6z46VwupsZ99zxvwOCcZTb8rfDhuE=;
	b=CYgcQE2h8aMMm2WDmDUtvZlhpYzntfr4w4xU2akVWaxzSsGbyHkCBkI+P+vF60PK55mi
	 CyRABgXNmvru6ZAPJEtP+eFz5LPPbQ/D97s/qKl4erwgUWYJbIFlCXVRngHWN9Pg18cNX
	 Orpg4VgYOVUl3sXT8vxCsdxT6YwWE1QjLnjeY+e6a56kPWY9KnYpK0TiLm3UOU8kceppo
	 17fYUoo+qAj7uiJmu8TIuMgXJwv7htvvDZRcYZ7IR3rZgXLlGpW+dQPY1m6DidtCtjDMw
	 hhTa4zC4DWi+88ZHTfI7lW5f9m8oCA6tFx2k5gzpZVlPtESQKVH4BscerBxVY7wNOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IfnbuFKL;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF52606A31A;
	Mon, 23 Nov 2026 02:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IfnbuFKL
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hTIujUG09qqEbt6z46VwupsZ99zxvwOCcZTb8rfDhuE=;
	b=IfnbuFKL9qn4NPmSqkGXOpTFsUx+pfsL/aj8kTX1rXzZWZbwPPt1Ubqk4ZTlVIjqgUiDqdS9k
	nwIKLqfLrSUM0dVULnMbpLEPWVH0ZRXfkvHqIlNYCwDorJbf6N1fG9PR/Dwcmau2uMOqMD0BYcI
	nKDNrgqi6wEATtP7wg/T9vA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnZ2Qjtz1K9c7;
	Mon, 23 Nov 2026 10:36:18 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id E096440561;
	Mon, 23 Nov 2026 10:36:34 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:34 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 00/13] vfio/pci: Add PCIe TPH support
Date: Mon, 23 Nov 2026 10:36:15 +0800
Message-ID: <20261123023628.7728-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)

This patchset enables userspace-configurable PCIe TPH support for VFIO in
the **device-to-host (D2H)** scenario, bringing performance benefits for
userspace workloads such as DPDK and SPDK.

The patchset is split into two logical parts:
1. The first eight patches fix and refactor core PCI/TPH kernel code to
   export the required helper interfaces.
2. The second five patches implement the corresponding VFIO TPH
   virtualization and uAPI step by step.


Since TLP TPH ST values are not validated by the IOMMU like TLP address
fields, there exists risk of cross-tenant cache interference if untrusted
VM can program arbitrary ST tags. We introduce two-level security
gating:

The first is the VFIO-PCI module parameter tph_policy, defined as:
   Global TPH policy level (0 = default No-ST):
   0 = No-ST mode: ST programming unavailable
   1 = Add IV-ST mode: ST programming supports NONE / CPU sources
   2 = Add DS-ST mode: RESOLVE returns ST for CPU sources;
                       ST programming supports NONE / CPU sources
       Note: In this 'Add DS-ST mode', device-specific ST tables are not
             preserved across PCI resets, userspace must re-establish ST
             state after reset. The kernel cannot validate these ST
             entries, so this mode is not recommended for general
             virtualization usecases.

Note: IV-ST mode is considered safe for VM use because the ST table is
programmed exclusively via the kernel VFIO uAPI. VM cannot directly
write the architected ST table in MSI-X or config space. The hypervisor
(e.g. QEMU) will verify ST, and also when a target CPU transitions from
online to offline, the kernel automatically (add in this patchset) clears
all ST table entries mapped to that CPU, setting those ST values to zero.

The second gate is per-device opt-in. TPH programming is only permitted
after userspace successfully opt-in via the VFIO TPH feature.


Three VFIO device features are introduced in this series:
1. VFIO_DEVICE_FEATURE_TPH: control and query VFIO TPH feature
   capabilities.
2. VFIO_DEVICE_FEATURE_TPH_PROGRAM: batch program architected steering tag
   table entries.
3. VFIO_DEVICE_FEATURE_TPH_RESOLVE: resolve TPH attributes for a given CPU
   source.

The intended userspace programming model is:
1. Read the virtualized PCI TPH capability via VFIO config space access to
   discover underlying hardware TPH support.
2. Invoke VFIO_DEVICE_FEATURE_TPH SET to opt-in and obtain TPH permission.
3. Invoke VFIO_DEVICE_FEATURE_TPH GET to retrieve available TPH
   capabilities; GET returns an error if opt-in has not been performed.
4. Write the TPH control register through VFIO config space to activate
   hardware TPH.
5. Program architected ST table entries via
   VFIO_DEVICE_FEATURE_TPH_PROGRAM if the device exposes architected ST
   table.
6. Query the ST value for a given CPU ID via
   VFIO_DEVICE_FEATURE_TPH_RESOLVE for DS-ST capable devices, userspace
   may then configure the ST through device MMIO or firmware interfaces.


Key implementation details for capability virtualization:
1. The TPH capability register is virtualized according to the active
   tph_policy:
   a. No-ST policy: IV/DS mode bits, ST location and ST size fields are
      masked. Only NO-ST capability is visible to userspace.
   b. IV-ST policy: DS mode bits are masked. Userspace sees NO-ST and
      IV-ST capabilities (if hardware supports IV-ST).
   c. DS-ST policy: capability register is passed through unmodified.
2. Capability bits returned by VFIO_DEVICE_FEATURE_TPH GET follow these
   rules:
   a. If virtualized TPH exposes architected ST table:
      VFIO_DEVICE_TPH_CAP_PROG_ST_NONE and VFIO_DEVICE_TPH_CAP_PROG_ST_CPU
      are reported. These indicate userspace may use TPH_PROGRAM to update
      ST.
   b. If virtualized TPH supports DS mode:
      VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST is reported. This indicates
      userspace can resolve CPU-ID associated ST values via TPH_RESOLVE.


Future P2P / DMABUF extension:
The uAPI is designed to easy extend to support device-to-device (P2P) and
DMABUF-backed scenarios on top of Zhiping's P2P TPH patchset:
1. Return VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_PH in all tph_policy in
   VFIO_DEVICE_FEATURE_TPH GET, so that userspace could resolve DMABUF's
   TPH PH info
2. Return VFIO_DEVICE_TPH_CAP_PROG_ST_DMABUF if virtualized TPH has the
   architect ST, so that userspace could program ST entries which
   associated to DMABUFs' fd
3. Return VFIO_DEVICE_TPH_CAP_RESOLVE_DMABUF_ST if virtualized TPH
   supports DS mode, so that userspace could retrieve ST value which
   associated to DMABUF's fd
   
---
v22:
- Rebase latest linux-next to resolve uAPI conflict
- Reorder patch sequence: move core tph disable fixes ahead of vfio patches
- Fix Sashiko comments:
  - Fix TPH config write path: disable existing TPH before re-enable to
    keep state coherent
  - Fix cpuhp race/UAF: reorder TPH teardown before cpuhp removal
  - Add cpu_online() check in ST resolve routine
  - Gate IV/DS capability exposure on TPH _DSM presence; hide IV/DS when
    DSM unavailable
  - Fix kernel-doc and redundant check in pcie_tph_dsm_supported() helper
v21:
- Focus only device-to-host (D2H) scenario
- Implement steering-tag to cpuid map to tracking cpu offline
- Refactor the implementation
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
  PCI/TPH: Add helpers to check standard and extended TPH support
  PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming
    helper
  PCI/TPH: Add pcie_tph_dsm_supported() helper to detect device TPH ST
    _DSM
  vfio/pci: Reset PCIe TPH state on device open and close
  vfio/pci: Add basic NO-ST TPH VFIO device feature support
  vfio/pci: Add IV-ST TPH policy and TPH_PROGRAM batch programming
    support
  vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capability
  vfio/pci: Expose per-device TPH state via debugfs

 drivers/pci/tph.c                  | 240 ++++++++++++-----
 drivers/vfio/pci/vfio_pci.c        |  24 ++
 drivers/vfio/pci/vfio_pci_config.c | 188 +++++++++++--
 drivers/vfio/pci/vfio_pci_core.c   | 412 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   |   6 +
 include/linux/pci-tph.h            |  55 +++-
 include/linux/pci.h                |   6 +-
 include/linux/vfio_pci_core.h      |   7 +
 include/uapi/linux/vfio.h          | 129 +++++++++
 9 files changed, 967 insertions(+), 100 deletions(-)

-- 
2.17.1

