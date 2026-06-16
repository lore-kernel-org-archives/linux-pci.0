Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A8438FF3;
	Tue, 16 Jun 2026 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606801; cv=none; b=f4q2mfLlnb/IAjDKw7Te98sBXYjRhcco04y1nqh3S78ArHTtl9RfaLegCzRQG1vifTtX1asvabVU75JXffpWADQUCLkOJp8Sk+xCsDcqjAAsasWaYftqvzkUE6NH9N8kGIGVMNlk7VLanFhpDaeKhnhSRN0Em3E1tEUkH6dVWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606801; c=relaxed/simple;
	bh=8S5OiJAVsoSR2J68Tf9hB+DNSlizhvgXxlRWyoSdhnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7a+5xEf3CxKzHA2cZdNz/vsmKvXYDly6I1ThWHlwpoQNTqPLCW3xFWCKJqnFdDQ/3b9gJfcZqOQElZxxNR0XebTGqPQMNEl+Qzr+QRaT7rsbH5A+AelYaFd+u7t29FYsNe01hyKSN05kg9u5QHXZ7ell2SN2jzBksSi22b7LMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TXUlSn1k; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TXUlSn1k; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TXUlSn1k";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TXUlSn1k"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bD/NYvwAMS9Reg9KdRuDyOhN6n0LjIPsJg6cIZzHjFw=;
	b=TXUlSn1ko0AxQhl3uPEks1KEl4z3gHtrY22b9TcnFE9JCgxAd8+fPxWCqq7upZWi3IlwmRuPJ
	F32NyFpz6DIYUNFDjtodpctX/WOv5jXyJFzMzx7wRD3UD+9Jr1KPEGtrqxkQS6HIriw7B0DWfYq
	3xw10SA3U+4rqE2hssGq4/M=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3L4VKmzcZyX;
	Tue, 16 Jun 2026 18:38:06 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bD/NYvwAMS9Reg9KdRuDyOhN6n0LjIPsJg6cIZzHjFw=;
	b=TXUlSn1ko0AxQhl3uPEks1KEl4z3gHtrY22b9TcnFE9JCgxAd8+fPxWCqq7upZWi3IlwmRuPJ
	F32NyFpz6DIYUNFDjtodpctX/WOv5jXyJFzMzx7wRD3UD+9Jr1KPEGtrqxkQS6HIriw7B0DWfYq
	3xw10SA3U+4rqE2hssGq4/M=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gfk3C5S0Rz1T4ht;
	Tue, 16 Jun 2026 18:37:59 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 48C4E40571;
	Tue, 16 Jun 2026 18:46:29 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jun 2026 18:46:28 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v17 04/12] PCI/TPH: Refactor pcie_enable_tph & add explicit requester variant
Date: Tue, 16 Jun 2026 18:46:13 +0800
Message-ID: <20260616104621.41915-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260616104621.41915-1-fengchengwen@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

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
 drivers/pci/tph.c       | 70 ++++++++++++++++++++++++++++-------------
 include/linux/pci-tph.h |  4 +++
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 951f0a33ff66..51009ac9b379 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -364,23 +364,7 @@ void pcie_disable_tph(struct pci_dev *pdev)
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
@@ -401,10 +385,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
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
@@ -413,7 +398,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
 
 	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
-	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
+	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
 
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
 
@@ -421,8 +406,51 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
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

