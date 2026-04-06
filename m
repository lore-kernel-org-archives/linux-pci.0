Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F06330330;
	Mon,  6 Apr 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775471606; cv=none; b=tQqrW5oRNBWT1AKkM475z8ZuG4EkrcwtrWTeZ4UxIjAvwj/8A+Re1mk3f2njeQ5ix+RA0HxUVnVeNv5skgGAoDven6FA/ZcE3i6TV+GStUmuwjFOTm+hPqR8sJPf2X079WFRJ0MQ/SeZZ2iWxxst6xx4FCnaBj01syjq7vqBaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775471606; c=relaxed/simple;
	bh=qUOQE+9RmzChpZsDmkWFXmZRdnTeJOlCZlOKCP+Je8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cMd+vfYJGm1ZFj4ybJ2A9x0Pq3f3BC6GRsj2dTFS/tWdRd7EfGI//se85VWqsdEWAnvQXWX+ZJ1/kOzjLpAYVcZpskldySucLhFn43nptF64m1S59blPAiynMtoQB+R1y+WXb99DvwPsCnIrpW2B5ME4ZP6Q/10jpxWPiaLRLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a/Kw02SF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a/Kw02SF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QR
	klyE92/++5ay+6Wu0lmX7bnfg+iz/Yf042yUwUxMY=; b=a/Kw02SFomUvn9H6ve
	NyNBTWj5cvb1yqCO32Z63VmBBq5VEho6zCrv/ubjyQUGZaC0MygL6Hh8las9XgOE
	cLRxF3pnTsOemIqK+ebGIVl7kbaGuM8IPhAdyIfQl3R3/QAHYVgILqG5S76jhkCn
	VmVJv31M8ZPksMjw0/JCPzV9M=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAHyuPNi9NplrBRDg--.19284S2;
	Mon, 06 Apr 2026 18:32:46 +0800 (CST)
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
Subject: [PATCH v3 0/2] PCI: cadence: Add LTSSM debugfs
Date: Mon,  6 Apr 2026 18:32:35 +0800
Message-Id: <20260406103237.1203127-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHyuPNi9NplrBRDg--.19284S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4Uur4xJw43Zr17ZryUtrb_yoW8KFyUpa
	yDGrWfAF1xZrW3Zan3Z3WUXFyftF93Aa97JwsF9w1xZF13CryDXF4IqF4rXrW7GrZFqr17
	tr15twnrKr1ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUxhdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBBmCmnTi9CINAAA3l

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
Changes for v3:
- Export cdns_pcie_debugfs_deinit (Mani)
- pcie-cadence-ep.c pcie-cadence-host.c pci-sky1.c call cdns_pcie_debugfs_deinit

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20260321033035.3008585-3-18255117159@163.com/

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
 drivers/pci/controller/cadence/pci-sky1.c     |   4 +
 .../controller/cadence/pcie-cadence-debugfs.c | 215 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
 .../cadence/pcie-cadence-host-hpa.c           |   8 +-
 .../controller/cadence/pcie-cadence-host.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 147 ++++++++++++
 9 files changed, 399 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44
-- 
2.34.1

