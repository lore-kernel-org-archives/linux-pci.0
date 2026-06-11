Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD434403D;
	Thu, 11 Jun 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197210; cv=none; b=oUG2teck06lXyzDv4wu2vtKBvV213D+7W6xn3MONk9nmW4AnjviJeG4jmmgjwZcxNflpuz1atC7wcZeKes7SRCRNzneqNUay1atYqzn0zzat8aLdrJj57rHqz9P6lADXtJMqy+XUCRdatNZb0vQAOf9qF7g9MxSrdxB14ePKG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197210; c=relaxed/simple;
	bh=A4MGbRj/NGYRowDYj1+kKdUnRne4B7CPs0cXMnv9KMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LsTsRDon+aL5grIcnI/p5lwYDMxbUtzD9YiP2DYj6nA0Z+XLOXnAvLwYdVTOQXgt2rhct5UHq/sHZeyWkJ+tfDB/tQgM1sdng0EqjaZ3PErN04TIn97Bh7HnHqaV6POiyVuuA4+pUTZ8/B9nWMzA1WH8bIdeJ9Lanymyr/gIAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Q+YFC391; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q+YFC391"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qb
	TxoXO4EpXLwxSblJxz8PYIzkBdGWKbjTYCDndhxBM=; b=Q+YFC391E7gVlQb78J
	Qu/IukssMrMTAgIjJamBLEBTBkOfD5+SMwUeAmQFWoTzbr03jf9/lo242sYBmz5s
	VDyvdJ8of9ictKCrOO7QkT5Eg7LEIqmCxMW4clWb+1g5AA8+Gf0XtIBDpYswtz2d
	iPkZ9jDuDY1jal+5Nqf1L+50w=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXxPp36SpqDeA0Bw--.8139S5;
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
Subject: [PATCH v7 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
Date: Fri, 12 Jun 2026 00:59:33 +0800
Message-Id: <20260611165933.20071-4-18255117159@163.com>
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
X-CM-TRANSID:PigvCgCXxPp36SpqDeA0Bw--.8139S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1UKr17tFyUJr1UGw4kZwb_yoWDGF4DpF
	ykCayvyF4IvwnFva1jy3WkZF45JFsayFZrCrs7ArW0k3ZxA3WDWr45Jr4vkrZ5tFsrWr12
	qwn0yrnrGayfJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMVbkUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBu9YWoq6XvrBgAA38

Extend debugfs support to LGA-based Cadence PCIe controllers. The
'ltssm_status' file now works for both HPA and LGA IP by selecting the
appropriate register access based on the 'is_hpa' flag.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
 .../controller/cadence/pcie-cadence-host.c    |  9 ++-
 drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
index 61960840ba67..6e34138e165b 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
@@ -13,6 +13,58 @@
 
 #define CDNS_DEBUGFS_BUF_MAX		128
 
+static const char *cdns_pcie_lga_ltssm_status_string(enum cdns_pcie_lga_ltssm ltssm)
+{
+	const char *str;
+
+	switch (ltssm) {
+#define CDNS_PCIE_LGA_LTSSM_NAME(n) case n: str = #n; break
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DETECT_QUIET);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DETECT_ACTIVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_ACTIVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_COMPLIANCE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_POLLING_CONFIGURATION);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_START);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_ACCEPT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_ACCEPT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_WAIT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_COMPLETE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_CONFIGURATION_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRLOCK);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_SPEED);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRCFG);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L0);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RX_L0S_FTS);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_TX_L0S_FTS);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L1_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L1_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L2_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_L2_TRANSMITWAKE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_DISABLED);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_HOT_RESET);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_0);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_1);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_2);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_3);
+	default:
+		str = "CDNS_PCIE_LGA_LTSSM_UNKNOWN";
+		break;
+	}
+
+	return str + strlen("CDNS_PCIE_LGA_LTSSM_");
+}
+
 static const char *cdns_pcie_hpa_ltssm_status_string(enum cdns_pcie_hpa_ltssm ltssm)
 {
 	const char *str;
@@ -158,6 +210,7 @@ static const char *cdns_pcie_hpa_ltssm_status_string(enum cdns_pcie_hpa_ltssm lt
 static int ltssm_status_show(struct seq_file *s, void *v)
 {
 	struct cdns_pcie *pci = s->private;
+	enum cdns_pcie_lga_ltssm lga_ltssm;
 	enum cdns_pcie_hpa_ltssm hpa_ltssm;
 	const char *str_ltssm;
 	u32 val;
@@ -168,11 +221,13 @@ static int ltssm_status_show(struct seq_file *s, void *v)
 		hpa_ltssm = FIELD_GET(CDNS_PCIE_HPA_LTSSM_STATUS_MASK, val);
 		str_ltssm = cdns_pcie_hpa_ltssm_status_string(hpa_ltssm);
 	} else {
-		/* TODO: LGA IP*/
-		return 0;
+		val = cdns_pcie_readl(pci, CDNS_PCIE_LM_BASE);
+		lga_ltssm = FIELD_GET(CDNS_PCIE_LGA_LTSSM_STATUS_MASK, val);
+		str_ltssm = cdns_pcie_lga_ltssm_status_string(lga_ltssm);
 	}
 
-	seq_printf(s, "%s (0x%02x)\n", str_ltssm, hpa_ltssm);
+	seq_printf(s, "%s (0x%02x)\n", str_ltssm,
+		   pci->is_hpa ? hpa_ltssm : lga_ltssm);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index c0e1194a936b..370b19f4d38f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -655,6 +655,7 @@ void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
 	struct device *dev = ep->pcie.dev;
 	struct pci_epc *epc = to_pci_epc(dev);
 
+	cdns_pcie_debugfs_deinit(&ep->pcie);
 	pci_epc_deinit_notify(epc);
 	pci_epc_mem_free_addr(epc, ep->irq_phys_addr, ep->irq_cpu_addr,
 			      SZ_128K);
@@ -761,6 +762,8 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 
 	pci_epc_init_notify(epc);
 
+	cdns_pcie_debugfs_init(pcie);
+
 	return 0;
 
  free_epc_mem:
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 87fd8afa301b..2ab8d8ac0595 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -364,6 +364,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 	struct pci_host_bridge *bridge;
 
+	cdns_pcie_debugfs_deinit(&rc->pcie);
 	bridge = pci_host_bridge_from_priv(rc);
 	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
@@ -425,7 +426,13 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
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
index 8de292405765..195c42140f29 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -14,6 +14,7 @@
 #include "pcie-cadence-lga-regs.h"
 #include "pcie-cadence-hpa-regs.h"
 
+#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
 #define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
 
 enum cdns_pcie_rp_bar {
@@ -44,6 +45,48 @@ enum cdns_pcie_reg_bank {
 	REG_BANKS_MAX,
 };
 
+enum cdns_pcie_lga_ltssm {
+	CDNS_PCIE_LGA_LTSSM_DETECT_QUIET			= 0x00,
+	CDNS_PCIE_LGA_LTSSM_DETECT_ACTIVE			= 0x01,
+	CDNS_PCIE_LGA_LTSSM_POLLING_ACTIVE			= 0x02,
+	CDNS_PCIE_LGA_LTSSM_POLLING_COMPLIANCE			= 0x03,
+	CDNS_PCIE_LGA_LTSSM_POLLING_CONFIGURATION		= 0x04,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_START	= 0x05,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LINKWIDTH_ACCEPT	= 0x06,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_ACCEPT	= 0x07,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_LANENUM_WAIT		= 0x08,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_COMPLETE		= 0x09,
+	CDNS_PCIE_LGA_LTSSM_CONFIGURATION_IDLE			= 0x0A,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRLOCK			= 0x0B,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_SPEED			= 0x0C,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_RCVRCFG			= 0x0D,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_IDLE			= 0x0E,
+	CDNS_PCIE_LGA_LTSSM_L0					= 0x10,
+	CDNS_PCIE_LGA_LTSSM_RX_L0S_ENTRY			= 0x11,
+	CDNS_PCIE_LGA_LTSSM_RX_L0S_IDLE				= 0x12,
+	CDNS_PCIE_LGA_LTSSM_RX_L0S_FTS				= 0x13,
+	CDNS_PCIE_LGA_LTSSM_TX_L0S_ENTRY			= 0x14,
+	CDNS_PCIE_LGA_LTSSM_TX_L0S_IDLE				= 0x15,
+	CDNS_PCIE_LGA_LTSSM_TX_L0S_FTS				= 0x16,
+	CDNS_PCIE_LGA_LTSSM_L1_ENTRY				= 0x17,
+	CDNS_PCIE_LGA_LTSSM_L1_IDLE				= 0x18,
+	CDNS_PCIE_LGA_LTSSM_L2_IDLE				= 0x19,
+	CDNS_PCIE_LGA_LTSSM_L2_TRANSMITWAKE			= 0x1A,
+	CDNS_PCIE_LGA_LTSSM_DISABLED				= 0x20,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_MASTER		= 0x21,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_MASTER		= 0x22,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_MASTER		= 0x23,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ENTRY_SLAVE		= 0x24,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_ACTIVE_SLAVE		= 0x25,
+	CDNS_PCIE_LGA_LTSSM_LOOPBACK_EXIT_SLAVE			= 0x26,
+	CDNS_PCIE_LGA_LTSSM_HOT_RESET				= 0x27,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_0	= 0x28,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_1	= 0x29,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_2	= 0x2A,
+	CDNS_PCIE_LGA_LTSSM_RECOVERY_EQUALIZATION_PHASE_3	= 0x2B,
+	CDNS_PCIE_LGA_LTSSM_UNKNOWN				= 0xFFFFFFFF,
+};
+
 enum cdns_pcie_hpa_ltssm {
 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET		= 0,
 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET_ENTRY		= 1,
-- 
2.34.1

