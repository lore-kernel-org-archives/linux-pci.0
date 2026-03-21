Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87062255F2D;
	Sat, 21 Mar 2026 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063876; cv=none; b=JSd9QeAUfUHc1MtTeZxjby6WJPtSwOghDRrJpkhq+m8bAdZ5ecvisj8h9JbRXkVGSW3K7i0Dj5hz4IbpU9QbIqnoX+agA6UDqUuIkiXTks6nQ5lASNUHDc5SS7M2w6q4HA+VGqIimNDWNfmYkVeoW4vhFns/wJcBiiNV10WQrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063876; c=relaxed/simple;
	bh=slC3mdsDqffwAfHCYKYACSkngWI5jmOuKo1d6bFpBV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ho5NmpzFP1y4krULvBWTceEWtvd3CH6RnE6JxgqtrPI7OkBnGviZHfsn/+N0VGMiN7LvpkW3V+nHl7zGds/W3EQPOyf2c3c2NCS1o/7zCKooaGfC47A7uKyjsn9dEXWe7b0/OshiZ9u4lI6bVzIYkqWSnMOn6cDb6rUzcd46rM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=joJaV/sv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="joJaV/sv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gH
	3UlZCCA32wzqcEC68qeE4zbrTNYQbhhoo0Ek2yBxA=; b=joJaV/svDzyp8PQu+V
	N/VSFqHfntNzbQaqGENTYW4okChgp0PS/DQoe5LB2zHwHLUAAVeegE+rrabTsdg1
	rxYJT9WYMBKOEzwOdMk37l9928LEapH7zycwRuD4IV0LHfLxIbB+UwnlowQA9uEI
	KshCGZcAVGCgyARtKfipAOdyM=
Received: from Precision-7960.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3GqPeEL5pv06sAQ--.26642S2;
	Sat, 21 Mar 2026 11:30:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	mpillai@cadence.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 0/2] PCI: cadence: Add LTSSM debugfs
Date: Sat, 21 Mar 2026 11:30:33 +0800
Message-Id: <20260321033035.3008585-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3GqPeEL5pv06sAQ--.26642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4Uur4xJw43Zr17ZryUtrb_yoW8urWfpa
	ykGrWfA3WxArW3Zan3Z3WUXFyftF97Aas7JwsF9w1xu3W3CryDJr4ftFWrXrW7GrZFqr17
	Ar15twnrKF1SyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjhF7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wNG6Wm+EONqEQAA3Y

Hi,

This series adds debugfs support to the Cadence PCIe controller driver,
allowing users to read the current LTSSM state of the link for debugging
purposes.

Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
distinguish HPA (High Performance Architecture IP) platforms, which
have a different register layout for LTSSM status.

Patch 2 implements the debugfs file "ltssm_status" under a per-device
directory. It reads the LTSSM state from the appropriate hardware register
based on the 'is_hpa' flag and displays both a descriptive string and the
raw value.

---
Changes for v2:
- s/DW_PCIE_LTSSM_NAME/CDNS_PCIE_LTSSM_NAME/
- S/January 2026/March 2026/
- EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_init); // Resolve the following error issues.
  >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-host-mod.ko] undefined!
  >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-ep-mod.ko] undefined!

v1:
https://patchwork.kernel.org/project/linux-pci/cover/20260315155514.127255-1-18255117159@163.com/
---

Hans Zhang (2):
  PCI: cadence: Add HPA architecture flag
  PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe
    link

 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   1 +
 .../controller/cadence/pcie-cadence-debugfs.c | 214 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
 .../cadence/pcie-cadence-host-hpa.c           |   8 +-
 .../controller/cadence/pcie-cadence-host.c    |   8 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 147 ++++++++++++
 9 files changed, 393 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
-- 
2.34.1

