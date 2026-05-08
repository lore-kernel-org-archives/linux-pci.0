Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24E308F07;
	Fri,  8 May 2026 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211714; cv=none; b=N6bcI3v2XJcYYIQWtLNImnJdv8AjrfHg11QZCo+OMUxFQIrGDPwMb/+cinHpHAjpIKWLuZUgxVE7jUKMergnh6W9OpKV+TTRfL/xkdrSp4DDZqM70evf6vKfjHOTKYcUsKDr42J5R3xaxFgIOtDNG1nul/Q/wnYcz2pif97RWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211714; c=relaxed/simple;
	bh=KICesCCQX6wosIlisvaoROEi28d7lAu4NKv1zdXsVWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwGmWtSqVSHu0++jBjXVaFu3UtyzMB3kn+O6VA81QPgNVzFOvjJqSmEvYRbdDrzgiwpxHInTlz4QAjDRIc47U088Dn3B25zSeZo985jUxTERSmX1gXyizvIn0ERZKDecWElM0EvCtcO8Ndiq1lNCsquNzeU4+DXTzoEz37C94io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B1Gre08A; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B1Gre08A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Iw
	6wlibgv4zTVY4nd032FYQetNXAlRDXpLJ4j29fdWE=; b=B1Gre08Aet+l+N1SvQ
	cDZryejbMzYHZFPC0ODrZo2B/uvdhvTj2HYLZY3mYZaNZKyWBrSd73tPR6BFXtgw
	WwOUg5LvMYiVK3qcwzPgmSg4D8/oMzp5vOuTcIOgu+HJTT9tu4LCeI/+aIrrJ8T5
	ilf9W4x+i+q7E36xbwCs6Hizg=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCX5jJYW_1pUkipCw--.764S4;
	Fri, 08 May 2026 11:41:18 +0800 (CST)
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
Subject: [PATCH v4 2/2] PCI: cadence: Add debugfs property to provide LTSSM status of the PCIe link
Date: Fri,  8 May 2026 11:41:01 +0800
Message-Id: <20260508034101.1910036-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508034101.1910036-1-18255117159@163.com>
References: <20260508034101.1910036-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCX5jJYW_1pUkipCw--.764S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfXr43Jr43tFyxXr48ZF4UCFg_yoW5GryDJo
	W3Gw4fW3WxZa4DAas3W3ZrGFyxXr1293W7ta18KF1rGFsFkFnrtrWUXr18ta1Fgr18ArW5
	Ar1DZ3W2kr4xWwsrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iNVy7UUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B7Ha2n9W17BBAAA3K

Add the debugfs property to provide a view of the current link's LTSSM
status from the Root Port device.

Test example:
  # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
  L0_STATE (0x29)

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   3 +
 .../controller/cadence/pcie-cadence-debugfs.c | 208 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |   3 +
 .../cadence/pcie-cadence-host-hpa.c           |  20 +-
 .../controller/cadence/pcie-cadence-host.c    |   9 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 150 +++++++++++++
 9 files changed, 406 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
new file mode 100644
index 000000000000..659ad2ab70e4
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cdns-pcie
@@ -0,0 +1,5 @@
+What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
+Date:		March 2026
+Contact:	Hans Zhang <18255117159@163.com>
+Description:	(RO) Read will return the current PCIe LTSSM state in both
+		string and raw value.
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 9e651d545973..cb010bc97aad 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
 config PCIE_CADENCE
 	tristate
 
+config PCIE_CADENCE_DEBUGFS
+	tristate "Cadence PCIe debugfs entries"
+	depends on DEBUG_FS
+	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
+	help
+	  Say Y here to enable debugfs entries for the PCIe controller. These
+	  entries provide various debug features related to the controller and
+	  the LTSSM status of link can be displayed.
+
 config PCIE_CADENCE_HOST
 	tristate
 	depends on OF
diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
index b8ec1cecfaa8..2cdc4617e0c2 100644
--- a/drivers/pci/controller/cadence/Makefile
+++ b/drivers/pci/controller/cadence/Makefile
@@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
 pcie-cadence-ep-mod-y := pcie-cadence-ep.o
 
 obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
+obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
 obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
index e1f4a98e2ab6..56147ba33c9c 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -221,7 +221,10 @@ MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);
 static void sky1_pcie_remove(struct platform_device *pdev)
 {
 	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie_rc *rc;
 
+	rc = container_of(pcie->cdns_pcie, struct cdns_pcie_rc, pcie);
+	cdns_pcie_hpa_host_disable(rc);
 	pci_ecam_free(pcie->cfg);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
new file mode 100644
index 000000000000..a4f0c4f6f98f
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe controller debugfs driver
+ *
+ * Copyright (C) 2026 Hans Zhang <18255117159@163.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "pcie-cadence.h"
+
+#define CDNS_DEBUGFS_BUF_MAX		128
+#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
+#define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
+
+static const char *cdns_pcie_ltssm_status_string(enum cdns_pcie_ltssm ltssm)
+{
+	const char *str;
+
+	switch (ltssm) {
+#define CDNS_PCIE_LTSSM_NAME(n) case n: str = #n; break
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DETECT_ACTIVE_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_ST);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RCVR_DETECTED_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_ACTIVE_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_CONFIG_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_CONFIG_IDLE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DUMMY_STATE_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0_STATE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_IDLE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_6);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_DISABLE_LINK_7);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_HOT_RESET_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L0S_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_FTS_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_SPEED_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_IDLE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L1_EXIT);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_L2_IDLE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1);
+	CDNS_PCIE_LTSSM_NAME(CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2);
+	default:
+		str = "CDNS_PCIE_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("CDNS_PCIE_LTSSM_");
+}
+
+static int ltssm_status_show(struct seq_file *s, void *v)
+{
+	struct cdns_pcie *pci = s->private;
+	enum cdns_pcie_ltssm ltssm;
+	u32 reg;
+
+	if (pci->is_hpa) {
+		reg = cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
+					CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
+		ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, reg);
+	} else {
+		reg = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
+		ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, reg);
+	}
+
+	seq_printf(s, "%s (0x%02x)\n", cdns_pcie_ltssm_status_string(ltssm), ltssm);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(ltssm_status);
+
+static void cdns_pcie_ltssm_debugfs_init(struct cdns_pcie *pci, struct dentry *dir)
+{
+	debugfs_create_file("ltssm_status", 0444, dir, pci,
+			    &ltssm_status_fops);
+}
+
+void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
+{
+	if (!pci->debug_dir)
+		return;
+
+	debugfs_remove_recursive(pci->debug_dir);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_deinit);
+
+void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
+{
+	char dirname[CDNS_DEBUGFS_BUF_MAX];
+	struct device *dev = pci->dev;
+
+	/* Create main directory for each platform driver. */
+	snprintf(dirname, CDNS_DEBUGFS_BUF_MAX, "cdns_pcie_%s", dev_name(dev));
+	pci->debug_dir = debugfs_create_dir(dirname, NULL);
+
+	cdns_pcie_ltssm_debugfs_init(pci, pci->debug_dir);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_debugfs_init);
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index c0e1194a936b..38a0157b60dc 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -659,6 +659,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
 			      SZ_128K);
 	pci_epc_mem_exit(epc);
+	cdns_pcie_debugfs_deinit(&ep->pcie);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_ep_disable);
 
@@ -761,6 +762,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	pci_epc_init_notify(epc);
 
+	cdns_pcie_debugfs_init(pcie);
+
 	return 0;
 
  free_epc_mem:
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..8bf7cc106413 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -309,6 +309,18 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
 
+void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
+{
+	struct pci_host_bridge *bridge;
+
+	bridge = pci_host_bridge_from_priv(rc);
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+
+	cdns_pcie_debugfs_deinit(&rc->pcie);
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_disable);
+
 int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -360,7 +372,13 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 	if (!bridge->ops)
 		bridge->ops = &cdns_pcie_hpa_host_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		return ret;
+
+	cdns_pcie_debugfs_init(pcie);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_setup);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 0bc9e6e90e0e..873d496c440f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -370,6 +370,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 
 	cdns_pcie_host_deinit(rc);
 	cdns_pcie_host_link_disable(rc);
+	cdns_pcie_debugfs_deinit(&rc->pcie);
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_disable);
 
@@ -423,7 +424,13 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (!bridge->ops)
 		bridge->ops = &cdns_pcie_host_ops;
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		return ret;
+
+	cdns_pcie_debugfs_init(pcie);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_setup);
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 9a464cbaf073..a1c531fd2061 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -42,6 +42,137 @@ enum cdns_pcie_reg_bank {
 	REG_BANKS_MAX,
 };
 
+enum cdns_pcie_ltssm {
+	CDNS_PCIE_LTSSM_DETECT_QUIET		= 0,
+	CDNS_PCIE_LTSSM_DETECT_QUIET_ENTRY	= 1,
+	CDNS_PCIE_LTSSM_DETECT_ACTIVE		= 2,
+	CDNS_PCIE_LTSSM_DETECT_ACTIVE_1		= 3,
+	CDNS_PCIE_LTSSM_DETECT_ACTIVE_2		= 4,
+	CDNS_PCIE_LTSSM_DETECT_ACTIVE_3		= 5,
+	CDNS_PCIE_LTSSM_RCVR_DETECTED_ST	= 6,
+	CDNS_PCIE_LTSSM_RCVR_DETECTED_1		= 7,
+	CDNS_PCIE_LTSSM_POLLING_ACTIVE		= 8,
+	CDNS_PCIE_LTSSM_POLLING_ACTIVE_1	= 9,
+	CDNS_PCIE_LTSSM_POLLING_ACTIVE_2	= 10,
+	CDNS_PCIE_LTSSM_POLLING_ACTIVE_3	= 11,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE	= 12,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_1	= 13,
+	CDNS_PCIE_LTSSM_POLLING_CONFIG		= 14,
+	CDNS_PCIE_LTSSM_POLLING_CONFIG_1	= 15,
+	CDNS_PCIE_LTSSM_POLLING_CONFIG_2	= 16,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC	= 17,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_1	= 18,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_RC_2	= 19,
+	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_RC	= 20,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_RC_1 = 22,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP	= 24,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_1	= 25,
+	CDNS_PCIE_LTSSM_CONFIG_LW_START_EP_2	= 26,
+	CDNS_PCIE_LTSSM_CONFIG_LW_ACC_EP	= 27,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_WAIT_EP_1 = 29,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
+	CDNS_PCIE_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
+	CDNS_PCIE_LTSSM_DUMMY_STATE_1		= 32,
+	CDNS_PCIE_LTSSM_CONFIG_COMPLETE		= 33,
+	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_1	= 34,
+	CDNS_PCIE_LTSSM_CONFIG_COMPLETE_2	= 35,
+	CDNS_PCIE_LTSSM_CONFIG_IDLE		= 36,
+	CDNS_PCIE_LTSSM_CONFIG_IDLE_1		= 37,
+	CDNS_PCIE_LTSSM_DUMMY_STATE_2		= 38,
+	CDNS_PCIE_LTSSM_DUMMY_STATE_3		= 39,
+	CDNS_PCIE_LTSSM_DUMMY_STATE_4		= 40,
+	CDNS_PCIE_LTSSM_L0_STATE		= 41,
+	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK	= 42,
+	CDNS_PCIE_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
+	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG	= 44,
+	CDNS_PCIE_LTSSM_RECOVERY_RCVR_CFG_1	= 45,
+	CDNS_PCIE_LTSSM_RECOVERY_IDLE		= 46,
+	CDNS_PCIE_LTSSM_RECOVERY_IDLE_1		= 47,
+	CDNS_PCIE_LTSSM_DISABLE_LINK		= 48,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_1		= 49,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_2		= 50,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_3		= 51,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_4		= 52,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_5		= 53,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_6		= 54,
+	CDNS_PCIE_LTSSM_DISABLE_LINK_7		= 55,
+	CDNS_PCIE_LTSSM_HOT_RESET		= 56,
+	CDNS_PCIE_LTSSM_HOT_RESET_1		= 57,
+	CDNS_PCIE_LTSSM_HOT_RESET_2		= 58,
+	CDNS_PCIE_LTSSM_HOT_RESET_3		= 59,
+	CDNS_PCIE_LTSSM_L0S_ENTRY		= 60,
+	CDNS_PCIE_LTSSM_L0S_1			= 61,
+	CDNS_PCIE_LTSSM_L0S_2			= 62,
+	CDNS_PCIE_LTSSM_L0S_3			= 63,
+	CDNS_PCIE_LTSSM_L0S_4			= 64,
+	CDNS_PCIE_LTSSM_L0S_5			= 65,
+	CDNS_PCIE_LTSSM_WAIT_FOR_LINK_TX	= 66,
+	CDNS_PCIE_LTSSM_TX_FTS_ENTRY		= 67,
+	CDNS_PCIE_LTSSM_TX_FTS_1		= 68,
+	CDNS_PCIE_LTSSM_TX_FTS_2		= 69,
+	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_ST		= 70,
+	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_1		= 71,
+	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_2		= 72,
+	CDNS_PCIE_LTSSM_TX_ELEC_IDLE_3		= 73,
+	CDNS_PCIE_LTSSM_RECOVERY_SPEED		= 74,
+	CDNS_PCIE_LTSSM_RECOVERY_SPEED_1	= 75,
+	CDNS_PCIE_LTSSM_RECOVERY_SPEED_2	= 76,
+	CDNS_PCIE_LTSSM_RECOVERY_SPEED_3	= 77,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23 = 78,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_1 = 79,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_2 = 80,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_3 = 81,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_4 = 82,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_5 = 83,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_6 = 84,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_7 = 85,
+	CDNS_PCIE_LTSSM_POLLING_COMPLIANCE_GEN23_8 = 86,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_EXIT	= 90,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
+	CDNS_PCIE_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
+	CDNS_PCIE_LTSSM_L1_ENTRY		= 97,
+	CDNS_PCIE_LTSSM_L1_1			= 98,
+	CDNS_PCIE_LTSSM_L1_2			= 99,
+	CDNS_PCIE_LTSSM_L1_3			= 100,
+	CDNS_PCIE_LTSSM_L1_4			= 101,
+	CDNS_PCIE_LTSSM_L1_IDLE			= 102,
+	CDNS_PCIE_LTSSM_L1_EXIT			= 103,
+	CDNS_PCIE_LTSSM_L2_ENTRY		= 104,
+	CDNS_PCIE_LTSSM_L2_1			= 105,
+	CDNS_PCIE_LTSSM_L2_2			= 106,
+	CDNS_PCIE_LTSSM_L2_3			= 107,
+	CDNS_PCIE_LTSSM_L2_4			= 108,
+	CDNS_PCIE_LTSSM_L2_5			= 109,
+	CDNS_PCIE_LTSSM_L2_IDLE			= 110,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY = 117,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
+	CDNS_PCIE_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
+	CDNS_PCIE_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
+};
+
 struct cdns_pcie_ops {
 	int     (*start_link)(struct cdns_pcie *pcie);
 	void    (*stop_link)(struct cdns_pcie *pcie);
@@ -87,6 +218,7 @@ struct cdns_plat_pcie_of_data {
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
+ * @debug_dir: debugfs node
  */
 struct cdns_pcie {
 	void __iomem		             *reg_base;
@@ -100,6 +232,7 @@ struct cdns_pcie {
 	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
+	struct dentry			     *debug_dir;
 };
 
 /**
@@ -447,6 +580,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
+void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -472,6 +606,10 @@ static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 }
 
+static inline void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
+{
+}
+
 static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 					     int where)
 {
@@ -535,4 +673,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
 
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
+#ifdef CONFIG_PCIE_CADENCE_DEBUGFS
+void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci);
+void cdns_pcie_debugfs_init(struct cdns_pcie *pci);
+#else
+static inline void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
+{
+}
+static inline void cdns_pcie_debugfs_init(struct cdns_pcie *pci)
+{
+}
+#endif
+
 #endif /* _PCIE_CADENCE_H */
-- 
2.34.1

