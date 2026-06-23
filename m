Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7C3CF1E4;
	Tue, 23 Jun 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204667; cv=none; b=t5TQ97g15sO2cYc8eyVyAgtTdYttmF+jhnRCxbJydfi7Wm9hHvRz1ghI48AMm2fsCM0f16luLlVOxkPDYhU9R9iIigUDDSPXMrAqc/kLOOcFtpUBusV0SZ496wIxiMS4AfQdx8tOLwiCF0vuTFYrraAL8hoVZruO4t71C330pf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204667; c=relaxed/simple;
	bh=hMEZE11em7VbrIXRt7omqbdleGid4WaWf8XPokAX2KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cISc2SFVmR4ZPTJmHTCH/lm4bwMwf71SMycOQvEwZohNlL1G8rQu9SPmy1ATQaUer/kTCmIXoByauHW4ah5bTdlDva+JRRgaZfqdnyFzKfYQTgbF7MoQXTF9mhFxyIAPykNVUSjfRJdQGRs7YmHrohXayijrWuwfQNy/AstfTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DELd1m2r; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DELd1m2r"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XatmuPSbqTqglxhW2Q1s7oMVJfQv9dONjXaDlcKTK2M=;
	b=DELd1m2rxJvzGyAiTnu9KJ8E5btnUFySa0wLFhe5FaVTukeWrsSOuk5F/g3UfBPZcEq/YF8r3
	yI7Y7oR+5jmmwhjpflNrfmLIRLRJYV2V82kVTwLR2Nf7LFE3+QvyhqP7gXmVP8u7YfvfzTsS2Aa
	YtWRpon/uLDJHsV7Qhz5hbQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gkz815dhvzRhT1;
	Tue, 23 Jun 2026 16:41:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C5A740561;
	Tue, 23 Jun 2026 16:50:57 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 16:50:56 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RESEND v18 04/12] PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
Date: Tue, 23 Jun 2026 16:50:40 +0800
Message-ID: <20260623085048.51139-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260623085048.51139-1-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Refactor pcie_enable_tph implementation: extract core logic into static
internal enable_tph() helper accepting explicit requester type.

- Preserve original pcie_enable_tph() unchanged as auto wrapper; it
  auto-selects EXT/standard TPH requester per device capability, existing
  bnxt/mlx5 callers require zero modification.
- Add exported pcie_enable_tph_explicit() with bool 'extended' parameter
  for explicit STD/EXT selection, used by upcoming VFIO TPH support.

Input validation for EXT_TPH availability is retained inside helper to
reject invalid explicit EXT request if hardware does not support extended
requester.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 68 +++++++++++++++++++++++++++++------------
 include/linux/pci-tph.h |  4 +++
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 4097787ea98a..c22eb7f4b0bd 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -363,23 +363,7 @@ void pcie_disable_tph(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_disable_tph);
 
-/**
- * pcie_enable_tph - Enable TPH support for device using a specific ST mode
- * @pdev: PCI device
- * @mode: ST mode to enable. Current supported modes include:
- *
- *   - PCI_TPH_ST_NS_MODE: NO ST Mode
- *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
- *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
- *
- * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Additionally determine what types of requests,
- * TPH or extended TPH, can be issued by the device based on its TPH requester
- * capability and the Root Port's completer capability.
- *
- * Return: 0 on success, otherwise negative value (-errno)
- */
-int pcie_enable_tph(struct pci_dev *pdev, int mode)
+static int enable_tph(struct pci_dev *pdev, int mode, u8 req_type)
 {
 	u32 reg;
 	u8 dev_modes;
@@ -400,10 +384,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (!((1 << mode) & dev_modes))
 		return -EINVAL;
 
-	pdev->tph_mode = mode;
+	if (req_type == PCI_TPH_REQ_EXT_TPH && !pdev->tph_ext_support)
+		return -EINVAL;
 
-	pdev->tph_req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
-						     PCI_TPH_REQ_TPH_ONLY;
+	pdev->tph_mode = mode;
+	pdev->tph_req_type = req_type;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -417,8 +402,51 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	return 0;
 }
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable. Current supported modes include:
+ *
+ *   - PCI_TPH_ST_NS_MODE: NO ST Mode
+ *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
+ *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
+ *
+ * Check whether the mode is actually supported by the device before enabling
+ * and return an error if not. Additionally determine what types of requests,
+ * TPH or extended TPH, can be issued by the device based on its TPH requester
+ * capability and the Root Port's completer capability.
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, int mode)
+{
+	u8 req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
+					      PCI_TPH_REQ_TPH_ONLY;
+	return enable_tph(pdev, mode, req_type);
+}
 EXPORT_SYMBOL(pcie_enable_tph);
 
+/**
+ * pcie_enable_tph_explicit - Enable TPH with explicit requester selection
+ * @pdev: PCI device to operate
+ * @mode: ST table operating mode (NS/IV/DS)
+ * @extended: true = EXT_TPH, false = standard TPH only
+ *
+ * Unlike auto-detecting pcie_enable_tph(), caller selects requester type
+ * manually instead of hardware auto-selection. Rejects EXT_TPH request
+ * if device lacks extended requester capability.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
+{
+	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
+
+	return enable_tph(pdev, mode, req_type);
+}
+EXPORT_SYMBOL(pcie_enable_tph_explicit);
+
 void pci_restore_tph_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 6f02b020d7d7..ca0faa98afac 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -42,6 +43,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
 { return -EINVAL; }
+static inline int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode,
+					   bool extended)
+{ return -EINVAL; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
-- 
2.17.1

