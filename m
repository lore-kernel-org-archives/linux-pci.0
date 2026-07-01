Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366523BFACF;
	Wed,  1 Jul 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891356; cv=none; b=lZ4e6Vem6lxGLHC37nxvtHnwp/ZVujHHqDZGCZ9wSpAgYcUyVyQjL7OqVogXD4QxCNe3agZ5jWayxTeGbtcwf5SeAJNMvgAYTnnokIw6rA/YFjcR2GSAwGNVOiEwqfzsA0VekzygJ5V1TJXxPRjjPjPO9432MDQv5x1OyOI1R0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891356; c=relaxed/simple;
	bh=nEcbDL5+R1Ky+HN98dCnkSsmb3CZu8ROqlwp9ri9cpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKmQFe/JTlJl3rP+LxRmpc/3/2ibG86JPMJbEURw6BVDs9p4CwTwcnufBQRuFBPAIbWY05KYCydttu6ZnMwFbSISjM2MTRI5go4quR9uGSs5APpw+y/U13AywPJI+BndBoyPTpmME+jOHFRG9ohCBKalpnpjmSk5ao5gYuMxvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZDybGoIu; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZDybGoIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=po
	o8qomocNxHKDGuNXHIcGmEUQFDeBpJGPwLFlNJM6Y=; b=ZDybGoIu/f2A8ZgUxw
	kC5Huu0MgF5hvJBqvNbUXIHJndhlAbs6M1IkIJZruqgX20xwdmQ3Aknz4ptNS6YE
	XKqC1QhklWZ8abMTdyWMznDllNkJTpiLUaMhySviZ7WFAz/5Wj25km1Px+R0wrXF
	ED9zE16lGbowTt0UVx2WcgibY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3+cszw0Rq5RxDGQ--.47462S2;
	Wed, 01 Jul 2026 15:35:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	mpillai@cadence.com,
	a-garg7@ti.com,
	s-vadapalli@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v8 0/3] PCI: cadence: Add LTSSM debugfs
Date: Wed,  1 Jul 2026 15:35:09 +0800
Message-ID: <20260701073513.1101559-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3+cszw0Rq5RxDGQ--.47462S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyxGF4kWw1rGw1DZw1fWFg_yoW7XrW7pa
	ykWFWfGr4xZrW5Aan3C3W7WF93tF93AayxJwsakw17ZFy3CryDXFn7KFW5ZrZrGrWq9r17
	tr9Iywn2gr4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUxhdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BWpTWpEwzXaPwAA3g

Hi,

This series adds debugfs support to the Cadence PCIe controller driver,
allowing users to read the current LTSSM state of the link for debugging
purposes.

Patch 1 introduces a new flag 'is_hpa' in the cdns_pcie structure to
distinguish HPA (High Performance Architecture) IP platforms from LGA
(Legacy Architecture) IP platforms, as they have different register
layouts for LTSSM status.

Patch 2 implements the debugfs file "ltssm_status" for HPA IP under a
per-device directory. It reads the LTSSM state from the appropriate
hardware register based on the 'is_hpa' flag and displays both a
descriptive string and the raw value.

Patch 3 adds LTSSM debugfs support for LGA IP, utilizing a new callback
'get_lga_ltssm' in cdns_pcie_ops to read the LTSSM state from the LGA
register. The debugfs interface now supports both IP types seamlessly.

=====================
Test:
root@orangepi6plus:~# ls -l /sys/kernel/debug/cdns_pcie_a0*
/sys/kernel/debug/cdns_pcie_a010000.pcie:
total 0
-r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status

/sys/kernel/debug/cdns_pcie_a0c0000.pcie:
total 0
-r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status

/sys/kernel/debug/cdns_pcie_a0e0000.pcie:
total 0
-r--r--r-- 1 root root 0 Jan  1  1970 ltssm_status
root@orangepi6plus:~# 
root@orangepi6plus:~# 
root@orangepi6plus:~# cat /sys/kernel/debug/cdns_pcie_a0*/ltss*
L0_STATE (0x29)
L0_STATE (0x29)
L0_STATE (0x29)
root@orangepi6plus:~# 
root@orangepi6plus:~# uname -a
Linux orangepi6plus 7.2.0-rc1-00011-g6cd225cbbadd #69 SMP PREEMPT Wed Jul  1 15:26:53 CST 2026 aarch64 aarch64 aarch64 GNUx
=====================

---
Changes for v8:
- Rebase to v7.2-rc1.
- patch 0002   s/tristate "Cadence PCIe debugfs entries"/bool "Cadence PCIe debugfs entries"/ (Mani & Sashiko)
  debugfs-cdns-pcie: s/March 2026/July 2026/

Changes for v7:
- patch 0002 add MODULE_LICENSE and MODULE_DESCRIPTION (Sashiko and Aksh)
- s/#ifdef CONFIG_PCIE_CADENCE_DEBUGFS/#if IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)/ (Aksh)
- base on branch: controller/rescan_lock

Changes for v6:
- The LTSSM status of the LGA IP no longer contains the "LTSSM_" character. (Aksh)

Changes for v5:
- Split LGA and HPA LTSSM debugfs support into separate patches as they
  have different register definitions and access methods. (Aksh, Manikandan)
- Add cdns_pcie_hpa_host_disable() to properly clean up debugfs on
  removal (Mani)
- Remove redundant copyright email address (Mani)

Changes for v4:
- Remove the copyright email address of the author of pcie-cadence-debugfs.c (Mani)
- Add cdns_pcie_hpa_host_disable() (Mani)
- Use DEFINE_SHOW_ATTRIBUTE() (Mani & Sashiko)

Changes for v3:
- Export cdns_pcie_debugfs_deinit (Mani)
- pcie-cadence-ep.c pcie-cadence-host.c pci-sky1.c call cdns_pcie_debugfs_deinit

Changes for v2:
- s/DW_PCIE_LTSSM_NAME/CDNS_PCIE_LTSSM_NAME/
- S/January 2026/March 2026/
- EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_init); // Resolve the following error issues.
  >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-host-mod.ko] undefined!
  >> ERROR: modpost: "cdns_pcie_debugfs_init" [drivers/pci/controller/cadence/pcie-cadence-ep-mod.ko] undefined!

v7:
https://patchwork.kernel.org/project/linux-pci/cover/20260611165933.20071-1-18255117159@163.com/
v6:
https://patchwork.kernel.org/project/linux-pci/cover/20260519123609.1595280-1-18255117159@163.com/
v5:
https://patchwork.kernel.org/project/linux-pci/patch/20260515145747.129635-1-18255117159@163.com/
v4:
https://patchwork.kernel.org/project/linux-pci/patch/20260508034101.1910036-1-18255117159@163.com/
v3:
https://patchwork.kernel.org/project/linux-pci/patch/20260406103237.1203127-1-18255117159@163.com/
v2:
https://patchwork.kernel.org/project/linux-pci/patch/20260321033035.3008585-3-18255117159@163.com/
v1:
https://patchwork.kernel.org/project/linux-pci/cover/20260315155514.127255-1-18255117159@163.com/

Hans Zhang (3):
  PCI: cadence: Add HPA architecture flag
  PCI: cadence: Add HPA IP debugfs for LTSSM status
  PCI: cadence: Add LGA IP debugfs for LTSSM status

 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   5 +
 .../controller/cadence/pcie-cadence-debugfs.c | 266 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
 .../cadence/pcie-cadence-host-hpa.c           |  21 +-
 .../controller/cadence/pcie-cadence-host.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 198 +++++++++++++
 9 files changed, 515 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
-- 
2.43.0

