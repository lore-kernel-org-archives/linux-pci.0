Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5C27442;
	Thu, 11 Jun 2026 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197221; cv=none; b=SmGT7DOV+bupE7mOWMhVndOSkZ9Sr9GWiXP27+fyO3kni12pI/5T7WZHNQzfTfUakxqVGLnkGdTHHrkpj9g9HagsauFkUUDNk88evE9jfbOFyveYVGG2gp/lARV8g1MMce/Ztrn3VaOdra03I3srFD674iirMQy+hhUzDsRqSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197221; c=relaxed/simple;
	bh=CXyrB9/YXFWLblxXs21Q7gN4U+LzG8RMloJx1fST26c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plds2hc7gZXQOdAPHKbf9DJhRa9/oU4uZia0fzcZQOStf1zDl+Io0NxNWORwZnpvq1ZW+VpenXloTmSNNtgIGUBaqpbDcTw3oerI8NF5hx4kr8syRP8d0zD15//z2jwknMO368zRNG3zViPsDy4ynjWkQnWv5iTSqUL6/YDDtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=buyxHV9F; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="buyxHV9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CX
	8ZcAd0Vjt69B0nFUqTQd+L80Oht5pLvPTELdp6DdA=; b=buyxHV9FuKfsOvqKw2
	ANB5kbRA2IB2eYbnqEEEL0LibiUxNFH4VSCk8/RpNlAu1wgMozFgtV6nNURPA/aL
	SZ1sLaQyRC54yhJVXjhRZ0jxwvMH9Z64S6HfoSh2xS03Dj7OkmeJ2mPmSkHa4835
	M+PfeX0EIQaxJD/3U1147ymlI=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXxPp36SpqDeA0Bw--.8139S4;
	Fri, 12 Jun 2026 00:59:38 +0800 (CST)
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
Subject: [PATCH v7 2/3] PCI: cadence: Add HPA IP debugfs for LTSSM status
Date: Fri, 12 Jun 2026 00:59:32 +0800
Message-Id: <20260611165933.20071-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611165933.20071-1-18255117159@163.com>
References: <20260611165933.20071-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCXxPp36SpqDeA0Bw--.8139S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfXr43Jr43tFyxXr48WF1xKrg_yoW5GFy7Wo
	ZxGrn3K3WxZ34qyas3J3ZrGF97Xr1S93W3tFy8Kr1rGFsIgFnrtrWUXr18ta1rW34DtrW3
	AryDX3W2yr4xW39rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRGbyCUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xq9YWoq6XqpmAAA3P

Add debugfs support for HPA-based Cadence PCIe controllers. A new file
'ltssm_status' is created under debugfs, allowing users to read the
current LTSSM state as a string and raw value.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
 drivers/pci/controller/cadence/Kconfig        |   9 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-sky1.c     |   4 +
 .../controller/cadence/pcie-cadence-debugfs.c | 211 ++++++++++++++++++
 .../cadence/pcie-cadence-host-hpa.c           |  21 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 153 +++++++++++++
 7 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
 create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
new file mode 100644
index 000000000000..c1104e28e4ee
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-cdns-pcie
@@ -0,0 +1,5 @@
+What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
+Date:		March 2026
+Contact:	Hans Zhang <18255117159@163.com>
+Description:	(RO) Read will return the current PCIe LTSSM state in both
+		string and raw value.
\ No newline at end of file
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
index e1f4a98e2ab6..b8632f1d3156 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -221,6 +221,10 @@ MODULE_DEVICE_TABLE(of, of_sky1_pcie_match);
 static void sky1_pcie_remove(struct platform_device *pdev)
 {
 	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
+	struct cdns_pcie_rc *rc;
+
+	rc = container_of(pcie->cdns_pcie, struct cdns_pcie_rc, pcie);
+	cdns_pcie_hpa_host_disable(rc);
 
 	pci_ecam_free(pcie->cfg);
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
new file mode 100644
index 000000000000..61960840ba67
--- /dev/null
+++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
@@ -0,0 +1,211 @@
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
+
+static const char *cdns_pcie_hpa_ltssm_status_string(enum cdns_pcie_hpa_ltssm ltssm)
+{
+	const char *str;
+
+	switch (ltssm) {
+#define CDNS_PCIE_HPA_LTSSM_NAME(n) case n: str = #n; break
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_QUIET);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_QUIET_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RCVR_DETECTED_ST);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RCVR_DETECTED_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_ACC_RC);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_RC);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_RC_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_RC);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LW_ACC_EP);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_EP);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_EP_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_EP);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_EP_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_IDLE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_CONFIG_IDLE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0_STATE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_LOCK);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_LOCK_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_CFG);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_CFG_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_IDLE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_IDLE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_6);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_7);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_HOT_RESET);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_HOT_RESET_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_HOT_RESET_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_HOT_RESET_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L0S_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_WAIT_FOR_LINK_TX);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_FTS_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_FTS_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_FTS_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_ST);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_6);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_7);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_8);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_EXIT_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_EXIT);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ACTIVE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_IDLE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L1_EXIT);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_L2_IDLE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_3);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_4);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_5);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ACTIVE);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE0);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1);
+	CDNS_PCIE_HPA_LTSSM_NAME(CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2);
+	default:
+		str = "CDNS_PCIE_HPA_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("CDNS_PCIE_HPA_LTSSM_");
+}
+
+static int ltssm_status_show(struct seq_file *s, void *v)
+{
+	struct cdns_pcie *pci = s->private;
+	enum cdns_pcie_hpa_ltssm hpa_ltssm;
+	const char *str_ltssm;
+	u32 val;
+
+	if (pci->is_hpa) {
+		val = cdns_pcie_hpa_readl(pci, REG_BANK_IP_REG,
+					  CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
+		hpa_ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, val);
+		str_ltssm = cdns_pcie_hpa_ltssm_status_string(hpa_ltssm);
+	} else {
+		/* TODO: LGA IP*/
+		return 0;
+	}
+
+	seq_printf(s, "%s (0x%02x)\n", str_ltssm, hpa_ltssm);
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
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Cadence PCIe debugfs driver");
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..89f1d75c2c38 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -309,6 +309,19 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_link_setup);
 
+void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
+{
+	struct pci_host_bridge *bridge;
+
+	cdns_pcie_debugfs_deinit(&rc->pcie);
+	bridge = pci_host_bridge_from_priv(rc);
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL_GPL(cdns_pcie_hpa_host_disable);
+
 int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
@@ -360,7 +373,13 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
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
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 9a464cbaf073..8de292405765 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -14,6 +14,8 @@
 #include "pcie-cadence-lga-regs.h"
 #include "pcie-cadence-hpa-regs.h"
 
+#define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED = -1,
 	RP_BAR0,
@@ -42,6 +44,138 @@ enum cdns_pcie_reg_bank {
 	REG_BANKS_MAX,
 };
 
+enum cdns_pcie_hpa_ltssm {
+	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET		= 0,
+	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET_ENTRY		= 1,
+	CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE		= 2,
+	CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_1		= 3,
+	CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_2		= 4,
+	CDNS_PCIE_HPA_LTSSM_DETECT_ACTIVE_3		= 5,
+	CDNS_PCIE_HPA_LTSSM_RCVR_DETECTED_ST		= 6,
+	CDNS_PCIE_HPA_LTSSM_RCVR_DETECTED_1		= 7,
+	CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE		= 8,
+	CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_1		= 9,
+	CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_2		= 10,
+	CDNS_PCIE_HPA_LTSSM_POLLING_ACTIVE_3		= 11,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE		= 12,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_1	= 13,
+	CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG		= 14,
+	CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG_1		= 15,
+	CDNS_PCIE_HPA_LTSSM_POLLING_CONFIG_2		= 16,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC		= 17,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC_1	= 18,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_RC_2	= 19,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_ACC_RC		= 20,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_RC	= 21,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_RC_1	= 22,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_RC	= 23,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP		= 24,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP_1	= 25,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_START_EP_2	= 26,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LW_ACC_EP		= 27,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_EP	= 28,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_WAIT_EP_1	= 29,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_EP	= 30,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_LANENUM_ACC_EP_1	= 31,
+	CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_1		= 32,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE		= 33,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE_1		= 34,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_COMPLETE_2		= 35,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_IDLE			= 36,
+	CDNS_PCIE_HPA_LTSSM_CONFIG_IDLE_1		= 37,
+	CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_2		= 38,
+	CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_3		= 39,
+	CDNS_PCIE_HPA_LTSSM_DUMMY_STATE_4		= 40,
+	CDNS_PCIE_HPA_LTSSM_L0_STATE			= 41,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_LOCK		= 42,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_LOCK_1	= 43,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_CFG		= 44,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_RCVR_CFG_1		= 45,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_IDLE		= 46,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_IDLE_1		= 47,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK		= 48,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_1		= 49,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_2		= 50,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_3		= 51,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_4		= 52,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_5		= 53,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_6		= 54,
+	CDNS_PCIE_HPA_LTSSM_DISABLE_LINK_7		= 55,
+	CDNS_PCIE_HPA_LTSSM_HOT_RESET			= 56,
+	CDNS_PCIE_HPA_LTSSM_HOT_RESET_1			= 57,
+	CDNS_PCIE_HPA_LTSSM_HOT_RESET_2			= 58,
+	CDNS_PCIE_HPA_LTSSM_HOT_RESET_3			= 59,
+	CDNS_PCIE_HPA_LTSSM_L0S_ENTRY			= 60,
+	CDNS_PCIE_HPA_LTSSM_L0S_1			= 61,
+	CDNS_PCIE_HPA_LTSSM_L0S_2			= 62,
+	CDNS_PCIE_HPA_LTSSM_L0S_3			= 63,
+	CDNS_PCIE_HPA_LTSSM_L0S_4			= 64,
+	CDNS_PCIE_HPA_LTSSM_L0S_5			= 65,
+	CDNS_PCIE_HPA_LTSSM_WAIT_FOR_LINK_TX		= 66,
+	CDNS_PCIE_HPA_LTSSM_TX_FTS_ENTRY		= 67,
+	CDNS_PCIE_HPA_LTSSM_TX_FTS_1			= 68,
+	CDNS_PCIE_HPA_LTSSM_TX_FTS_2			= 69,
+	CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_ST		= 70,
+	CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_1		= 71,
+	CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_2		= 72,
+	CDNS_PCIE_HPA_LTSSM_TX_ELEC_IDLE_3		= 73,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED		= 74,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_1		= 75,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_2		= 76,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_SPEED_3		= 77,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23	= 78,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_1	= 79,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_2	= 80,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_3	= 81,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_4	= 82,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_5	= 83,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_6	= 84,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_7	= 85,
+	CDNS_PCIE_HPA_LTSSM_POLLING_COMPLIANCE_GEN23_8	= 86,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ENTRY	= 87,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ENTRY_FROM_RECOVERY = 88,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_EXIT_1	= 89,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_EXIT		= 90,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_1	= 91,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_2	= 92,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_3	= 93,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_4	= 94,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_GEN2_5	= 95,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_SLAVE_ACTIVE	= 96,
+	CDNS_PCIE_HPA_LTSSM_L1_ENTRY			= 97,
+	CDNS_PCIE_HPA_LTSSM_L1_1			= 98,
+	CDNS_PCIE_HPA_LTSSM_L1_2			= 99,
+	CDNS_PCIE_HPA_LTSSM_L1_3			= 100,
+	CDNS_PCIE_HPA_LTSSM_L1_4			= 101,
+	CDNS_PCIE_HPA_LTSSM_L1_IDLE			= 102,
+	CDNS_PCIE_HPA_LTSSM_L1_EXIT			= 103,
+	CDNS_PCIE_HPA_LTSSM_L2_ENTRY			= 104,
+	CDNS_PCIE_HPA_LTSSM_L2_1			= 105,
+	CDNS_PCIE_HPA_LTSSM_L2_2			= 106,
+	CDNS_PCIE_HPA_LTSSM_L2_3			= 107,
+	CDNS_PCIE_HPA_LTSSM_L2_4			= 108,
+	CDNS_PCIE_HPA_LTSSM_L2_5			= 109,
+	CDNS_PCIE_HPA_LTSSM_L2_IDLE			= 110,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY	= 111,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_1	= 112,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_2	= 113,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_3	= 114,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_4	= 115,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_5	= 116,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ENTRY_FROM_RECOVERY = 117,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_ACTIVE	= 118,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT	= 119,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT_1	= 120,
+	CDNS_PCIE_HPA_LTSSM_LOOPBACK_MASTER_EXIT_2	= 121,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE0 = 122,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE1 = 123,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE2_1 = 124,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE2_2 = 125,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE3_1 = 126,
+	CDNS_PCIE_HPA_LTSSM_RECOVERY_EQUALIZATION_PHASE3_2 = 127,
+	CDNS_PCIE_HPA_LTSSM_UNKNOWN			= 0xFFFFFFFF,
+};
+
 struct cdns_pcie_ops {
 	int     (*start_link)(struct cdns_pcie *pcie);
 	void    (*stop_link)(struct cdns_pcie *pcie);
@@ -87,6 +221,7 @@ struct cdns_plat_pcie_of_data {
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
+ * @debug_dir: debugfs node
  */
 struct cdns_pcie {
 	void __iomem		             *reg_base;
@@ -100,6 +235,7 @@ struct cdns_pcie {
 	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
+	struct dentry			     *debug_dir;
 };
 
 /**
@@ -447,6 +583,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
 int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc);
+void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc);
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -472,6 +609,10 @@ static inline void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 }
 
+static inline void cdns_pcie_hpa_host_disable(struct cdns_pcie_rc *rc)
+{
+}
+
 static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 					     int where)
 {
@@ -535,4 +676,16 @@ bool cdns_pcie_hpa_link_up(struct cdns_pcie *pcie);
 
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
 
+#if IS_ENABLED(CONFIG_PCIE_CADENCE_DEBUGFS)
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

