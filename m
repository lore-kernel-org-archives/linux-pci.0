Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B604DC53C;
	Tue, 19 May 2026 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194232; cv=none; b=iL2Y32T3GfDto/C4BGVnIJ+qC4n+sAANPa50sBygg+56u5nsEiIc07PdKjEW5QLcbIs9wUncLYEoqY4WpnaUKA78SJtHaN8vOtAeB+GZvJPLTZOjje9JwyE/JuOKVEYRZThfINW4Q8F2KVhWQhnMRg684g6ymX1gZHRgpF48l4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194232; c=relaxed/simple;
	bh=HaGAwOD/UWx12S6GDgJ6NSBMnXL5uI7erpOTW4CW3/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiRk5IsWDjn9D2gt+k9pOOtKjl/+LROPy481CuNkJfugb6Sc639U7ocTuZCpaoAZOiaqBAv3F8uSVxpcJSHf4yFEsk34UTjIKMY31SbnLLkzi8y4aN9vs/1P8/gTu/YVa1ti1rrs3iBpAA96YRv9Cv8EDTsSiN0Dqn20lWA/txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hTV7SR2Z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hTV7SR2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DZ
	uqMErX8kTdYqliIw4fLnIGnoTb/25V685fPu5s3gc=; b=hTV7SR2Z/sbY9IiYC8
	E98Mp/QH09qmgBzs8/Ev0gHQTiJMO6X9y0pB6HcmK9fe7QfoTz7UYsl+JEd5b20l
	hs3W0po1LlSuIpkspYMRSvp7o/gDEHBUqvgC/zjKKOAtmlAirDX9NIIU8ntQrdvv
	jENCDDRygOEtuwPWw3WuUU+GU=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDX4hY8WQxqQIRSEQ--.27887S2;
	Tue, 19 May 2026 20:36:15 +0800 (CST)
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
Subject: [PATCH v6 0/3] PCI: cadence: Add LTSSM debugfs
Date: Tue, 19 May 2026 20:36:06 +0800
Message-ID: <20260519123609.1595280-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDX4hY8WQxqQIRSEQ--.27887S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1xGrWxXrWfXF43GF1Utrb_yoWrZFW5pa
	4kWFWfGF4xZrW3Zan3C3W7WFyftF93A3yxtwsakw1xuF13CryDXrn3KFW5ZrW3GrZ7ur17
	Ar90ywn2gr1YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjhF7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AEEp2oMWUG+CQAA3H

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
Linux orangepi6plus 7.1.0-rc3-00007-ge3963f3f4e31 #62 SMP PREEMPT Tue May 19 20:28:24 CST 2026 aarch64 aarch64 aarch64 GNUx
=====================

---
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
 .../controller/cadence/pcie-cadence-debugfs.c | 263 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
 .../cadence/pcie-cadence-host-hpa.c           |  19 +-
 .../controller/cadence/pcie-cadence-host.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 198 +++++++++++++
 9 files changed, 510 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c


base-commit: 50897c955902c93ae71c38698abb910525ebdc89
-- 
2.43.0

