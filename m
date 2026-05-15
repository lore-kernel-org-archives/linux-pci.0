Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C63932D1;
	Fri, 15 May 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857145; cv=none; b=YPQpwSup21mwGebf4GOvbYLnoJIdjtHDThZNfC+HIRsgzQvcys3gaPrUTgyif6aJ+UDaWy9NBWGl+zN2sdJvf5AGf/jhzKHCXH7VSsBoXp1J7efNOy5AeST/ETGIiz0vH4CxMj81MNfx0D1l1EI6wpfTF9zoepLSKpGPren9nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857145; c=relaxed/simple;
	bh=9Vy8tZau/w21We3UT53ECNxqaYNIRQDga1vDPd+cKVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7tH6Hn0jWqmiLMbNoqBvIqLUkwl81ZJMny2JH62mU8jIxDb1mdZ1EFkHeMljvOpmzfuFmd1tKFpidzVY30I8nKFBcnpk2OqR0zG16c7QkyCv3f5/KoFk/5prF4t0If98YOgP66Cp/XozceCnFQFBedcdysDfM1v7W5xgUNJfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=a6uyuPQs; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="a6uyuPQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9t
	MNX6CaLZSxIphCfq8rcjLstsBi6UZHOsOLsMhTUzs=; b=a6uyuPQs9oWkNBWX5k
	tC5vHE7qNX1hzFvg52bCfRs9NgsY9QTP7FQ5CwyBIyGuVuTYhiicLHsBGJIpl4Db
	q/Udn1V5AqROdxnKtpMJu1Vm8MzGHegbvLSdsnZgxaIaelnwgNm48OT5LHNFAAGU
	I3z8a3lKM4GTqxNBbTU4QP59k=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXnwt1NAdqXv4hBg--.54079S5;
	Fri, 15 May 2026 22:58:00 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	mpillai@cadence.com,
	a-garg7@ti.com,
	s-vadapalli@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM status
Date: Fri, 15 May 2026 22:57:47 +0800
Message-Id: <20260515145747.129635-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515145747.129635-1-18255117159@163.com>
References: <20260515145747.129635-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnwt1NAdqXv4hBg--.54079S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1rGryxJF1kuryxXrW5ZFb_yoWftrW8pF
	1kCFWvyF4Iv3ZIva1jy3WqvF45JFs2ya9rGr4kArW0k3ZxA3WUWr4UJF4kCrs5tFsrXr17
	X3WYyFnrGay3J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMMKZUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xiHK2oHNHhOSQAA35

Extend debugfs support to LGA-based Cadence PCIe controllers. The
'ltssm_status' file now works for both HPA and LGA IP by selecting the
appropriate register access based on the 'is_hpa' flag.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Hi Aksh

Could you please assist in checking whether the ltssm_status of LGA is
correct? If there are any inaccuracies, please point them out.
---
 .../controller/cadence/pcie-cadence-debugfs.c | 61 ++++++++++++++++++-
 .../pci/controller/cadence/pcie-cadence-ep.c  |  3 +
 .../controller/cadence/pcie-cadence-host.c    |  9 ++-
 drivers/pci/controller/cadence/pcie-cadence.h | 43 +++++++++++++
 4 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
index 97c5deef2b1a..ac985699b974 100644
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
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_QUIET);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DETECT_ACTIVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_ACTIVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_COMPLIANCE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_POLLING_CONFIGURATION);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_START);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_ACCEPT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_ACCEPT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_LANENUM_WAIT);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_COMPLETE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_CONFIGURATION_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRLOCK);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_SPEED);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_RCVRCFG);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L0);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RX_L0S_FTS);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_TX_L0S_FTS);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_ENTRY);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L1_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_IDLE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L2_TRANSMITWAKE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_DISABLED);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_MASTER);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ENTRY_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_ACTIVE_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_LOOPBACK_EXIT_SLAVE);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_HOT_RESET);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_0);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_1);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_2);
+	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_3);
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
index 0bc9e6e90e0e..8105bb625eb7 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -364,6 +364,7 @@ void cdns_pcie_host_disable(struct cdns_pcie_rc *rc)
 {
 	struct pci_host_bridge *bridge;
 
+	cdns_pcie_debugfs_deinit(&rc->pcie);
 	bridge = pci_host_bridge_from_priv(rc);
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
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
index 2320319af83b..a69e5ee9e8b5 100644
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
+	CDNS_PCIE_LGA_DETECT_QUIET			= 0x00,
+	CDNS_PCIE_LGA_DETECT_ACTIVE			= 0x01,
+	CDNS_PCIE_LGA_POLLING_ACTIVE			= 0x02,
+	CDNS_PCIE_LGA_POLLING_COMPLIANCE		= 0x03,
+	CDNS_PCIE_LGA_POLLING_CONFIGURATION		= 0x04,
+	CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_START	= 0x05,
+	CDNS_PCIE_LGA_CONFIGURATION_LINKWIDTH_ACCEPT	= 0x06,
+	CDNS_PCIE_LGA_CONFIGURATION_LANENUM_ACCEPT	= 0x07,
+	CDNS_PCIE_LGA_CONFIGURATION_LANENUM_WAIT	= 0x08,
+	CDNS_PCIE_LGA_CONFIGURATION_COMPLETE		= 0x09,
+	CDNS_PCIE_LGA_CONFIGURATION_IDLE		= 0x0A,
+	CDNS_PCIE_LGA_RECOVERY_RCVRLOCK			= 0x0B,
+	CDNS_PCIE_LGA_RECOVERY_SPEED			= 0x0C,
+	CDNS_PCIE_LGA_RECOVERY_RCVRCFG			= 0x0D,
+	CDNS_PCIE_LGA_RECOVERY_IDLE			= 0x0E,
+	CDNS_PCIE_LGA_L0				= 0x10,
+	CDNS_PCIE_LGA_RX_L0S_ENTRY			= 0x11,
+	CDNS_PCIE_LGA_RX_L0S_IDLE			= 0x12,
+	CDNS_PCIE_LGA_RX_L0S_FTS			= 0x13,
+	CDNS_PCIE_LGA_TX_L0S_ENTRY			= 0x14,
+	CDNS_PCIE_LGA_TX_L0S_IDLE			= 0x15,
+	CDNS_PCIE_LGA_TX_L0S_FTS			= 0x16,
+	CDNS_PCIE_LGA_L1_ENTRY				= 0x17,
+	CDNS_PCIE_LGA_L1_IDLE				= 0x18,
+	CDNS_PCIE_LGA_L2_IDLE				= 0x19,
+	CDNS_PCIE_LGA_L2_TRANSMITWAKE			= 0x1A,
+	CDNS_PCIE_LGA_DISABLED				= 0x20,
+	CDNS_PCIE_LGA_LOOPBACK_ENTRY_MASTER		= 0x21,
+	CDNS_PCIE_LGA_LOOPBACK_ACTIVE_MASTER		= 0x22,
+	CDNS_PCIE_LGA_LOOPBACK_EXIT_MASTER		= 0x23,
+	CDNS_PCIE_LGA_LOOPBACK_ENTRY_SLAVE		= 0x24,
+	CDNS_PCIE_LGA_LOOPBACK_ACTIVE_SLAVE		= 0x25,
+	CDNS_PCIE_LGA_LOOPBACK_EXIT_SLAVE		= 0x26,
+	CDNS_PCIE_LGA_HOT_RESET				= 0x27,
+	CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_0	= 0x28,
+	CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_1	= 0x29,
+	CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_2	= 0x2A,
+	CDNS_PCIE_LGA_RECOVERY_EQUALIZATION_PHASE_3	= 0x2B,
+	CDNS_PCIE_LGA_LTSSM_UNKNOWN			= 0xFFFFFFFF,
+};
+
 enum cdns_pcie_hpa_ltssm {
 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET		= 0,
 	CDNS_PCIE_HPA_LTSSM_DETECT_QUIET_ENTRY		= 1,
-- 
2.34.1

