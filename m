Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC92F363F;
	Fri,  8 May 2026 03:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211713; cv=none; b=crBeQjV8U5JuMFGYMxZDP1SZFSB5kZjov5fea0SDCE2N6EEaMfmSBje2cIjKx1vdTCYPkig5cJl690E1xr0d73UOTIgiF8Jvvybe4NpJDKTt4/+mmaoHzu7HE6o4AUsTZTOD8DghfCxqjc/XM9spuTQrcHYGmJr5YkCRo+1hclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211713; c=relaxed/simple;
	bh=MEUWDC+gwIz+NhpCeCEaqZyh+heJsW4lr89gxGprlkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o/0brSyw3jflyEZY7LozDzsuhf6L8sPuFxArgrPejnLkWu9gIMULsdB+zlVeJ+f6gBOdP+UF0zoHPPqE4ahQHAdicO/TOwSI6x2unyHbSc03cwmn/MHNexlBbm1WqOL8sVSdsJGjw65xl7sZRi0kLwQEke/Lkzp4iwZLvJiYmKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SpXG226z; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SpXG226z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7d
	UHVsNE/6UVVlfOX223yJ9AwbYp6g3uturHQXczS2I=; b=SpXG226zCJBwHQiZad
	PWeBpayz+PXNyIONRc6dqixxVTPvSjzlmuTjLfPv3brDwGOQn2jCmTMyBPfKcKpw
	Qg86O9en0t/PfbeOjQ2enImOsUkjEJeh1pzcI9gVnSFFDsIUStl3c9ZRzM8JzgmH
	KaygBh7zQkot8oFWITC7h2ktc=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCX5jJYW_1pUkipCw--.764S2;
	Fri, 08 May 2026 11:41:15 +0800 (CST)
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
Subject: [PATCH v4 0/2] PCI: cadence: Add LTSSM debugfs
Date: Fri,  8 May 2026 11:40:59 +0800
Message-Id: <20260508034101.1910036-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCX5jJYW_1pUkipCw--.764S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4fCw47tw18Wr4DWw1kuFg_yoW5tw4fpa
	4kKFWfGr4xArW3Z3Z3Z3WUWryftFn3A3yxJwsa9w1xZ3W3CryDXr1IkFW5XrZxGrZrur17
	tr15twn7KryavFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUxhdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xzHa2n9W1yuXAAA36

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
Linux orangepi6plus 7.1.0-rc2-00377-gb898336dec53-dirty #43 SMP PREEMPT Fri May  8 11:15:00 CST 2026 aarch64 aarch64 aarch64 GNU/Linux
=====================

---
Changes for v4:
- Remove the copyright email address of the author of pcie-cadence-debugfs.c (Mani)
- Add cdns_pcie_hpa_host_disable() (Mani)
- Use DEFINE_SHOW_ATTRIBUTE() (Mani & Sashiko)

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20260406103237.1203127-1-18255117159@163.com/

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

Hans Zhang (2):
  PCI: cadence: Add HPA architecture flag
  PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe
    link

 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   4 +
 .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
 .../cadence/pcie-cadence-host-hpa.c           |  20 +-
 .../controller/cadence/pcie-cadence-host.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 152 +++++++++++++
 9 files changed, 409 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 917719c412c48687d4a176965d1fa35320ec457c
-- 
2.34.1

