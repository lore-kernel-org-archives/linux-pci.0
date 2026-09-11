Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462736196E;
	Fri, 11 Sep 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144019; cv=none; b=gWDJd4qRUpyKuoNUaesw4LLdJTHfiWMTgtUa2VFy3DdNQjNPrUfhQWTNMOF2FP35tB7aq7gSjiORgw/CjWpcu4+1JJZPlsIIf1ZaScpg3HZhf7IQvF3kFcffSlobZLWcJJjLchUqZOUqi0mXtjD9lty5FD+eG52uHObH4ZIIhyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144019; c=relaxed/simple;
	bh=Bua493IqMPbOF43aFZb3vkUelrfR/9oxge1jMM2EmmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUcEKJwxIpRMQabI0yFPr9Fyqys26TWEm0hWol8OtfcyzhhItN81tZTTcEq/A3iEUnIDbRM07B4QITq7XqcjThNPgNLG+F8PGduEv0PyOqjyVJdG0uIUgKfDrqYJ7quV4eng7v2Io9jZn8DRfGJh42phkB6hb8UwetC3vmA1nok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PAw6h70X; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PAw6h70X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2N
	k0vDbW8nS5kYgocrElJ7R98oQE2CWqYVPeodJnZJo=; b=PAw6h70XtVazbhr4ia
	aXwxBRWP4w2kLauSCfWpTjoQv9w2WZR5hAouK5/nvsxeYR/DUc0gC09DW7NJ9YUV
	e3fWE+mnCETTr3fFv5N2E2IJl/4SSQobasNJhtUKTkQidlX89M1a/VdUQUnGMlhz
	8f9Sck5Wod6gjJI3Ucdfkatl8=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnDy6JK6RqMNRdAA--.33660S2;
	Sat, 12 Sep 2026 00:25:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	heiko@sntech.de,
	mani@kernel.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] PCI: dwc: Clean up DWC PCIe register macros
Date: Sat, 12 Sep 2026 00:25:35 +0800
Message-Id: <20260911162537.469018-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnDy6JK6RqMNRdAA--.33660S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyUAry8uw48Gr1DKFW7Jwb_yoW5Wry5pa
	45KayavF1ktF45ua13Z3WDAF1aq3Z7AFWUK39rWw12g3W3uFW0qr1rKFyFqF9rJrWxJr42
	kF4aqa4xGr43AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEFAp5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wuwVGqkK4vNsQAA3W

This series cleans up the DWC PCIe controller register macros to better
match the Synopsys DesignWare PCIe Controller Reference Manual, and
removes an unused set of iATU unroll register definitions.

Patch 1 renames various register and field macros, dropping redundant
PCIE_ prefixes and using documented base names.  Field macros are
renamed consistently so their register association is clear.  No
functional change intended.

Patch 2 removes the unused PCIE_ATU_UNR_* macros.  These have no
remaining users now that the driver uses the ATU_* macros and
ATU_UNROLL_BASE() for unrolled iATU register access.

The series was build-tested with defconfig and allmodconfig.

---
Changes in v2:
- Rename Port Link Control register to PORT_LINK_CTRL instead of
  PORT_LINK_CTRL_OFF, as suggested by Bjorn.  The _OFF suffix is
  ambiguous and unnecessary.
- Extend the cleanup to more DWC PCIe register macros, dropping the
  redundant PCIE_ prefix and using documented base names, such as
  PORT_FORCE_LINK, PORT_AFAC, PORT_LANE_SKEW, TIMER_CTRL_MAX_FUNC_NUM,
  PORT_LINK_DEBUG0/1, LINK_WIDTH_SPEED_CTRL, GEN3_CTRL, GEN3_EQ_CTRL,
  MULTI_LANE_CTRL, MISC_CONTROL_1, MSIX_DOORBELL, and the ATU_*
  registers.
- Include the register name in field macros, e.g. PORT_LINK_CTRL_DLE,
  PORT_LINK_CTRL_FLM, PORT_LINK_CTRL_LC_*.
- Fix PORT_AFAC L1 field names (PORT_AFAC_L1_*).
- Unify COHERENCY_CTRL1/2/3 and RAS_DES_EVENT_COUNTER_* naming.
- Drop the _OFF suffix from MISC_CONTROL_1.
- Add a patch to remove unused PCIE_ATU_UNR_* definitions.

v1:
https://patchwork.kernel.org/project/linux-pci/patch/20260904061823.592216-1-18255117159@163.com/
---

Hans Zhang (2):
  PCI: dwc: Align register macros with Synopsys documentation
  PCI: dwc: Remove unused PCIE_ATU_UNR_* register definitions

 drivers/pci/controller/dwc/pci-imx6.c         |  26 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   4 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  10 +-
 .../pci/controller/dwc/pcie-designware-host.c |  18 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 176 +++++------
 drivers/pci/controller/dwc/pcie-designware.h  | 275 +++++++++---------
 drivers/pci/controller/dwc/pcie-fu740.c       |   6 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  18 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c |  28 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   6 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  26 +-
 .../pci/controller/dwc/pcie-tegra194-acpi.c   |  22 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  86 +++---
 drivers/pci/controller/dwc/pcie-ultrarisc.c   |  10 +-
 14 files changed, 349 insertions(+), 362 deletions(-)


base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
-- 
2.34.1

