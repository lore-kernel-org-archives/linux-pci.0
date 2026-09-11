Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7473F4DE6;
	Fri, 11 Sep 2026 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128697; cv=none; b=GtJzJv+lXhqgdLKLOg4o8AWO3bRQg9byaFg4gO4V+qPJrtDFOm4wfV+Gc95z9quSbGeisVCD5EWJ26Q1csOSFkOxzMDRtkpSKY70KwlhDeUk3buRj+6279v0XMfcU8Y5mSnFpUlU+ksp4IKqCBeFEKf5WNxcsrKK9pAJcfkILsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128697; c=relaxed/simple;
	bh=hAGzdeCICz/hqlln58VD/WylGhGFeaSINGQlhilggrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFioaI/ZfAEWro8E20QYCOUuPRcbTi3rJ1RnkZcLndv33HnJInWtIst9X4K3vkfknJaNakYjWrB65TRMjjr8IQqxS34CUm4k5VQ7R4MfZpwbdM5YILrXqBZA2RvcXLqnfi9JLhDscy09OO/b5xdJY/Q4ql1l7dwbQ3rcCDaoVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QO7OIzkN; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QO7OIzkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789128695; x=1820664695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ml2JWjYntelWabTiBlCGxkKliemYNE3sdK+c2VYPaA0=;
  b=QO7OIzkNawmfUo6wYiMg9Dg5/sMjKty4RgRq+3Q62H7HJ+skmGBTNi/N
   /SbV6WMsAWBysr/sTF2Hs0ag/P+xY+18VULELToHucIcueo6uSJf8Ibgd
   u4uLLeAq7k+1Xe9Dx5ayoo9FjKROaPn8KauNWQG2C7d3ZDHTUAIt7U+8s
   rKYK9mHr5seR0sjWkmmWZJWB3onM88mTPCHCfmMe6fFoKPM89tbvt2tRg
   61XKxMED3S1PqrGSXiXPqefZvDsatI+0eMoDgLYuiIZ8riQjEnG/JfnzP
   1odpovZEIcgho4tB+qsgtIz+fYjWwwPAQ5mhR9gz0kAHOoKtPqGB05ya5
   w==;
X-CSE-ConnectionGUID: spETKBKOR1+n5MPsEfCwHQ==
X-CSE-MsgGUID: aREx7AWGQfGT3DpWEAxfcw==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28292838"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:11:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:31083]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.113:2525] with esmtp (Farcaster)
 id d36685e2-4f05-4292-b5fc-d844b9844549; Fri, 11 Sep 2026 12:11:32 +0000 (UTC)
X-Farcaster-Flow-ID: d36685e2-4f05-4292-b5fc-d844b9844549
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:11:32 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:11:29 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Matlack
	<dmatlack@google.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kees Cook <kees@kernel.org>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, "Ionut
 Nechita" <ionut.nechita@windriver.com>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 0/8] PCI/IOV: Initialize virtual functions in parallel
Date: Fri, 11 Sep 2026 14:11:13 +0200
Message-ID: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In the context of kexec-based live update (LUO) used with
datacenter-level hardware for hosting virtualized instances, once
SR-IOV enablement is put in the hot path it becomes a downtime
bottleneck on modern hardware with 100s-1000s of VFs per PF, and begs
for optimization.

This series (S1) introduces parallel VF initialization to put stress on
all participating subsystems; the 4 subsequent series then attack and
optimize the serialization bottlenecks one by one, with the primary
objective of reducing initialization time to a minimum.

On real hardware - a large dual-socket arm64 Neoverse V2 server with
thousands of VFs - the five series together cut SR-IOV initialization
by 65%. Due to HW/SW combination, the iommu_probe_device_lock residual
is not present. This series alone accounts for less than 5% of that,
so the reduction comes from the four series that follow removing the
serialization that keeps the parallelism from paying off.

Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each)
enabled serially, using the public reproducer described below:

  lock_stat:
  Lock                     wait: Before     After   contentions: Before   After
  iommu_probe_device_lock          0 ms  25507 ms                     0    1143
  &root->kernfs_rwsem             18 ms    942 ms                  3117   93208
  &vfio.group_lock                 0 ms    425 ms                     0     497

  Stage                 SR-IOV init time:
  S0 (baseline)         3027 ms
  S1 (this series)       999 ms

Reproducer:

Runs an x86_64 QEMU/KVM guest with all PCI config space accesses routed
through ECAM, avoiding pci_config_lock, which otherwise serializes the
legacy port-I/O (0xCF8/0xCFC) accesses used for config offsets below
0x100. Guest topology: 48 vCPUs (2 sockets x 24 cores, one thread per
core, pinned 1:1 to host physical cores) and 2 NUMA nodes. After boot it
enables SR-IOV on 4 PFs sequentially (sriov_numvfs, 255 VFs each) and
measures init time on a kernel built without CONFIG_LOCK_STAT, then
separately collects /proc/lock_stat data on a kernel built with
CONFIG_LOCK_STAT=y.

In all series, I lean primarily on lock_stat numbers to defend the
improvements. In the reproducer, the residual iommu_probe_device_lock
dominates the window and masks the later series' wall-time gains;
reducing that lock further is out of scope for this set, but the
dominant residual source is named in S2 and can be followed up in the
future.

Looking for feedback on the overall design shape of the optimizations.

The full set of series building on top of this one:
- S2 iommu_probe_device_lock optimization:
  https://lore.kernel.org/r/20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de
- S3 driver core: cut per-node lock traffic in bulk device
  registration (kernfs_rwsem write-taken once per node instead of
  twice, batched inode IDs, indexed glue dirs):
  https://lore.kernel.org/r/20260911-vfopt-s3-v1-0-66e3602f76f7@amazon.de
- S4 vfio: create the group chardev outside vfio.group_lock,
  eliminating its contention:
  https://lore.kernel.org/r/20260911-vfopt-s4-v1-0-98ba1d2ef7ab@amazon.de
- S5 remove the kernfs_rwsem bottleneck by staged sysfs registration:
  an opted-in device's whole subtree is published in one write hold
  instead of one per node:
  https://lore.kernel.org/r/20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de

This set of series replaces a previous attempt to optimize VF init:
https://lore.kernel.org/lkml/20260702174033.32116-1-sakacpav@amazon.de/

The reproducer is available as a docker image that orchestrates
builds in a QEMU guest and prints results as a table (x86_64 Linux
host with /dev/kvm assumed):

  docker run --device /dev/kvm ghcr.io/pavsa/linux-parallel-sriov-vf-init-bench:7.3-base

Pavol Sakac (8):
  PCI/IOV: Split virtfn bus handling out of pci_iov_add_virtfn()
  PCI/IOV: Create virtfn buses up front in sriov_add_vfs()
  PCI/PM: Convert pci_bridge_d3_update() recursion to iteration
  PCI/PM: Serialize pci_bridge_d3_update()
  powerpc/pci: Serialize pcibios_bus_add_device()
  PCI/IOV: Let sriov_add_vfs() own the failure unwind
  PCI/IOV: Initialize virtual functions in parallel
  PCI: Probe inline from node-local workqueue workers

 arch/powerpc/kernel/pci-common.c |  14 ++-
 drivers/pci/iov.c                | 189 +++++++++++++++++++++++++++----
 drivers/pci/pci-driver.c         |  18 ++-
 drivers/pci/pci.c                |  87 +++++++++-----
 4 files changed, 252 insertions(+), 56 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3

