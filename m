Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666833372A;
	Tue, 26 May 2026 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763904; cv=none; b=deN1llcfI5EE1Qy8x15G+g3xv+gMGBVD6c3AUC46BsVi02YJh+aeRRopC7JguBg0ZsfxnnriaMIreuqaTjEEU37PSixekrITlMri1t8OG8Jz1WGgjf+To1Ce4NxpbL8K/gF9NCPO9M4wc7NM7YWdpyNR52Yoelc77wBM7CrAcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763904; c=relaxed/simple;
	bh=0EtKyD/kblfplZ2ON/Zvk+WGZXMH5s0IffCgBNJEHgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKATw+0t/eznmuWqCKGzjnEdPfCvpbfK2KCbSbj5HIxJrxVh5BfMPyo8wHg1XTpuFSbHgt6BQn/HjozvWePuY1yYyY7dIzKmf+98jWLhzWs2T1bgiyK0RWSuTNCOs35LZg9aW1xh4pXMoe+Iahaowm5/Hg1+i5DfPTP0z55lARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FItRGxoI; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FItRGxoI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779763893; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=LxYuBwN9AXRSucCAjyvV+41WLYlKfeEQW/OlC6lobtE=;
	b=FItRGxoImaraFbsitFzSn8QW9sD3UmrrwECAOshTS8NC3KOCXEEr44iyOdBpMOFUuyE9kao8bedsvkuGJqasAtBVnaDoQTirS4nJh+Akp2EkA5t3zY7zhAPdxI7EvMF5rAqxlSi9UeO+Xjpch2R+ghnwYYkXX0Zg3fWUko//anY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X3egDpV_1779763887;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3egDpV_1779763887 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 10:51:32 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com,
	alison.schofield@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com,
	bhelgaas@google.com,
	rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 0/2] ACPI/PCI/CXL: Enforce _DEP ordering between ACPI0016 and ACPI0017
Date: Tue, 26 May 2026 10:51:16 +0800
Message-ID: <20260526025118.38935-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms whose ACPI namespace exposes a CXL host bridge (ACPI0016)
with an ACPI0017 CXL root device declaring _DEP on the host bridge,
cxl_acpi can probe before acpi_pci_root has attached the PCI root.
acpi_pci_find_root() then returns NULL, decoder targets read as 0,
and no port/endpoint device shows up under /sys/bus/cxl/devices/.

The root cause is twofold:

  1. acpi_pci_root_add() never calls acpi_dev_clear_dependencies(),
     so _DEP suppliers downstream of a PCI root are never released.

  2. ACPI0016 is not on acpi_honor_dep_ids[], so even when ACPI0017
     declares _DEP on it, acpi_dev_ready_for_enumeration() bypasses
     the dep_unmet check and lets cxl_acpi probe early.

On x86 the bug is usually masked by link order (acpi_pci_root is
built in and probed before cxl_acpi). On architectures like RISC-V
that ordering is not guaranteed, so the standard ACPI _DEP mechanism
must actually work.

This series fixes both sides and the two patches must be applied
together; applying only patch 2 would prevent cxl_acpi from ever
probing on ACPI0016 systems, because the supplier would never clear
the dependency.

  Patch 1 makes acpi_pci_root_add() clear _DEP on the supplier once
          the PCI root bus has been added.
  Patch 2 adds ACPI0016 to acpi_honor_dep_ids[] so the dependency
          declared by ACPI0017 is enforced.

The approach in this series follows the discussion of an earlier
posting:
https://lore.kernel.org/linux-cxl/20260514023238.49984-1-cp0613@linux.alibaba.com/

Chen Pei (2):
  ACPI: PCI: clear _DEP dependencies after PCI root bridge attach
  ACPI: scan: honor _DEP for ACPI0016 PCI/CXL host bridge

 drivers/acpi/pci_root.c | 4 ++++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 5 insertions(+)

-- 
2.50.1

