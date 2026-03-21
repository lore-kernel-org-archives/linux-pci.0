Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2A282F2B;
	Sat, 21 Mar 2026 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063777; cv=none; b=kX+yQ86xMZ9QxaYTT5AKzHIrFUciWXZyw6iuIQWsBRu1YptDlc2Jpp7HIWM8+IYTNzWxaIA+ovDK8LY3m4hmL4yCYJoXDWGojIBB+YSz4ynP8o/J1Ma6SaLpOb8PqCs/b4QIAi4UGa2Pa3Ec+kWbVGl+C6NpoCIpS7LlEzz+zIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063777; c=relaxed/simple;
	bh=slC3mdsDqffwAfHCYKYACSkngWI5jmOuKo1d6bFpBV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7qqXSbdeD+KOFAvI1Aodmq0+4kPc7wurvyJ2HNJO8qgJD8iL7VzSwdAzroc+9RxTV3gzVXfWB++6ar0s6VAa/35zuHVAwQliV/zgJPRLGFW4p55MCS2ycu4qhaoGQimW6jne7SVnpUAHlhNfXfCMw6TwFUjlkQoDsQOcH7El2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OJz0Rc9X; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OJz0Rc9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gH
	3UlZCCA32wzqcEC68qeE4zbrTNYQbhhoo0Ek2yBxA=; b=OJz0Rc9XJxgKIxG2jb
	ZMfOcVunt5+Ob8x9k9Mvstrp9MylPJKfigfFSeBl6AJEvOag+8Y+mTipZTLkmN+m
	6C/2iuypmY1BBheM3Op/8yAwxHEh7Sazz1/rm/oEV1ps6kUYLfiQJNeiM8NL+7dt
	kuqaTi0mEUqea/CHSAMhP/8Jo=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnh7l6EL5pi1oMAg--.45947S2;
	Sat, 21 Mar 2026 11:28:59 +0800 (CST)
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
Date: Sat, 21 Mar 2026 11:28:52 +0800
Message-Id: <20260321032852.3007448-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnh7l6EL5pi1oMAg--.45947S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4Uur4xJw43Zr17ZryUtrb_yoW8urWfpa
	ykGrWfA3WxArW3Zan3Z3WUXFyftF97Aas7JwsF9w1xu3W3CryDJr4ftFWrXrW7GrZFqr17
	Ar15twnrKF1SyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUU73gUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBwt0Gm+EHwGMwAA3r

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

