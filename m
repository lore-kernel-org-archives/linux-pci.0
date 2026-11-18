Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993171;
	b=C97y3UbGa/q6AEUFKntaOKLpqcsfqIPHheGaWBi2zODqx3AS29o9bHHKKfmXk62DIbvV
	 jcHvaNzbM0NRIjtkSEIV45SxvuAKbU0Q0uphbO8pLO+BwV4O6RYiCohYE4Z7J3VytakDo
	 1XXDngFwEvA2X2YvD2OeuS3bXo7DT8x6yit8RnYYi3Bilha0BIqiXIPsT/foZvXcCxKRP
	 hchJasLDePTxLsExQ0tZ/o+XlzND8RYua6tFhZ6MudS9Ff50R4+Hc5+C5qRlFPBqXOHdW
	 Up19C4/V0KUTQ26QkPOkeweNi+ccnY11Cp1v5j7sgss4U1qi4E2Af1uTE8M9BW8KA5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993171;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=hxZae7thxNn4Ge1NRQ4mgxhL1DmIRz4CPRg9U0Ksnb8=;
	b=AtuNIE+uh+jeJXzlpRsoKtIwuRAsD2CGDBoMTw933gKvC4l9RngTEjf2UiZwX+sfKnFj
	 wPzKj3kI4IiSpDc+QFOWVyNOu/PUc82v3YCqovXzP6vWltELBoXuNEyx/THtE/DPYYsht
	 SRHXK1aWKHFz1V4Eqt+H1ku7XL/H2867FporT0ofsBcDPsDSjZr/mSkaPIbpb7pyKpMUL
	 OsP/R8V6OYlBd8SsIxyUmFZOdaWMqsmyRb00kL04qWigGNzrQ5Hzaj/ozjmcrBUCWzNiK
	 cFUSfMfmFv25PxDjkNahkPnCcwWChqUuYnYaw3557ck61cg9S7W2ILKGM6OcjwzbtmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hm3b6B53;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C42606A31C;
	Wed, 18 Nov 2026 09:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hm3b6B53
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hxZae7thxNn4Ge1NRQ4mgxhL1DmIRz4CPRg9U0Ksnb8=;
	b=hm3b6B53TLLJZbl0Mpf4IVnoa3fRxug8B2+n60FwqIixAHhwhPFnolnHHH/VkbXXN1pKJDLiy
	0qhHQLSXEUr2WR1KuJbcVQH1Njs7wgm2/gVQoTC8PZqS3E393W4H3fD1/EGiCdqxxq+StS24iyv
	hwNyteilv4NT17T5p2h/gxk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpb3lwWz1T4J5;
	Wed, 18 Nov 2026 17:12:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C07740561;
	Wed, 18 Nov 2026 17:12:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 04/13] PCI/TPH: Refactor pcie_enable_tph and add requester variant
Date: Wed, 18 Nov 2026 17:12:29 +0800
Message-ID: <20261118091238.45992-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Refactor the core TPH enable logic by renaming the original function to
pcie_enable_tph_ext(), which accepts an explicit requester type argument.

- Keep the original pcie_enable_tph() as a compatibility wrapper; it uses
  the pre-cached tph_max_type negotiated capability automatically, so
  existing drivers calling pcie_enable_tph() require no modification.
- Export new pcie_enable_tph_ext() to support explicit requester type
  selection, intended for use by the upcoming VFIO TPH series.
- Add requester type validation to reject values out of hardware negotiated
  range or invalid reserved types.

Update pci-tph.h header and CONFIG_PCIE_TPH stub inline definitions
to match the new function signatures.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 41 ++++++++++++++++++++++++++++++-----------
 include/linux/pci-tph.h |  8 ++++++--
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 58f7ba41e1f7..875c381e094f 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -366,21 +366,18 @@ void pcie_disable_tph(struct pci_dev *pdev)
 EXPORT_SYMBOL(pcie_disable_tph);
 
 /**
- * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * pcie_enable_tph_ext - Enable TPH support with specific ST mode and
+ * requester type
  * @pdev: PCI device
- * @mode: ST mode to enable. Current supported modes include:
- *
- *   - PCI_TPH_ST_NS_MODE: NO ST Mode
- *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
- *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
+ * @mode: ST mode to enable: PCI_TPH_ST_(NS_MODE / IV_MODE / DS_MODE)
+ * @req_type: Requester type to enable: PCI_TPH_REQ_(TPH_ONLY / EXT_TPH)
  *
- * Check whether the mode is actually supported by the device before enabling
- * and return an error if not. Automatically uses the pre-cached tph_max_type
- * value, the negotiated maximum requester type between device and root port.
+ * Check whether the mode and requester type is actually supported by the
+ * device before enabling and return an error if not.
  *
  * Return: 0 on success, otherwise negative value (-errno)
  */
-int pcie_enable_tph(struct pci_dev *pdev, int mode)
+int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type)
 {
 	u32 reg;
 	u8 dev_modes;
@@ -398,6 +395,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	if (pdev->tph_max_type == PCI_TPH_REQ_DISABLE)
 		return -EINVAL;
 
+	/* Sanitize and check TPH requester type compatibility */
+	if (req_type == PCI_TPH_REQ_DISABLE || req_type == 2 ||
+		req_type > pdev->tph_max_type)
+		return -EINVAL;
+
 	/* Sanitize and check ST mode compatibility */
 	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
 	dev_modes = get_st_modes(pdev);
@@ -406,7 +408,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	pdev->tph_mode = mode;
 
-	pdev->tph_req_type = pdev->tph_max_type;
+	pdev->tph_req_type = req_type;
 
 	/* Write them into TPH control register */
 	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
@@ -420,6 +422,23 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 
 	return 0;
 }
+EXPORT_SYMBOL(pcie_enable_tph_ext);
+
+/**
+ * pcie_enable_tph - Enable TPH support for device using a specific ST mode
+ * @pdev: PCI device
+ * @mode: ST mode to enable: PCI_TPH_ST_(NS_MODE / IV_MODE / DS_MODE)
+ *
+ * Wrapper for pcie_enable_tph_ext(), automatically uses the pre-cached
+ * tph_max_type value (negotiated maximum requester type between device and
+ * root port).
+ *
+ * Return: 0 on success, otherwise negative value (-errno)
+ */
+int pcie_enable_tph(struct pci_dev *pdev, u8 mode)
+{
+	return pcie_enable_tph_ext(pdev, mode, pdev->tph_max_type);
+}
 EXPORT_SYMBOL(pcie_enable_tph);
 
 void pci_restore_tph_state(struct pci_dev *pdev)
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 159ffb82b34e..d3ff4ccfcc6b 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -27,7 +27,8 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
 			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
-int pcie_enable_tph(struct pci_dev *pdev, int mode);
+int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type);
+int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
@@ -39,7 +40,10 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
-static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
+static inline int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode,
+				      u8 req_type)
+{ return -EINVAL; }
+static inline int pcie_enable_tph(struct pci_dev *pdev, u8 mode)
 { return -EINVAL; }
 static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
-- 
2.17.1

