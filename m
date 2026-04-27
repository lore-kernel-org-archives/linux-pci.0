Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2126CE2D;
	Mon, 27 Apr 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267072; cv=fail; b=n5/7+giwjck8vbwo70D2mNBG/1CiEkq/5szArXj535MhjNECANuYbA1gwaEgG2kN8CZhVzDzT9rVigX17BgZKFONbrv1AkMoqQra1QMxQV5HYYlSWJyo85AKvowwxQbovon8HRcSxHsEapJlvmneoEl5S2jfhuSpl9qO28L8Cso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267072; c=relaxed/simple;
	bh=ZPCdTi9KexAG4sHuBnefFlDZHa+6mtZxdu7D0xrb4Ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgPjISb/cvOTns9HkZXG0+uu5J0mvRE27uIL3mMKNSdz2Z1tCTBU5OtGiCRipwzufzZwvPHNs/gXplNvmPRci14wV7EetrDiNPTWwXYguHZcPIUlkDYnCRLZQ+ESwOsrYnEtW/NviW4yqS4sarphFCNeXtJfNcWdX3/r3W6WzPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uo1dMd4R; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uo1dMd4R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM+BCeFQSn0eWVyjea0YuG8zEG7Hs2TBp6wTxlOIAfO5x3FcfVWqQ89kqejLRM6ExBjEEzfefJTxAk6ZbxXdIUjIzTdf01JzJjqXfS4XFwNwfjgY+1zflCEN2vkViezsRh1UZxGeU8pVu2NbZQijrjrjOmwygp0LZA4mMA1YvEGvkQyZS4NO0Eg/snzb5294UZ2UNcKAKluxOj/Tzi5iXkugWdRamK2s3gVRQayffGw704/XTvutaDFC+JYLFNMzOnhbBqbb1d3mj6yXfkAblU/dWTosfWvklR3wHuDBQjPAT2/FCstv/moGgVIA/4+3m6ni6o2erNWK6PdQN2vYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fuqq3/Mi3FfDpI+mHogcjjHZGwTGRcls+QTmiw1GL6A=;
 b=bRGzqYjkYG2l7gwL3mhnDoqPufhzh4lCjLygTSEa7xhOMu9oZzsRI60Qt18xC6jIQxAtm/wRAdeivvm26XKKPMv2GgoEkeJuqD0SW6y3KqldXPVd/+XqDzh+NH6tdGR/6hneVGz3zDcIn0VJkU/6lVL0ZE/2/lMbApUlW3Xrnn83YGAeXy0xfX7/QKeDcuLpFYOGhjmgD0D+FsoLjIJIgnEZRUrMNFL+R43pE8ahW1FYWESwwRKngXgEM5IgwrD4GZzO9SAbJV3OppbSogkYLvTh43GCo7ZLFQ1wBSGqam6lI53oJ8dSpQm9BYNdLZupwGSbFiJWrs3g91NZOsHe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuqq3/Mi3FfDpI+mHogcjjHZGwTGRcls+QTmiw1GL6A=;
 b=uo1dMd4RG2t5Rv1UXzm+iUtBb2GIUIRILN2jXHQ6f5fZ5f7HM/y588Mwqbl+DgA8N5mrFbgscg9CKy7U+Z0pKSOT3DHWAJAmxc8vUDaY1SFwjKT1SjHrL2OBKG44kX2BUedii0TYhq3BnnoUfM8KGnVJB7PJtx0eTl7lOxHwm/k=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by CH3PR10MB7807.namprd10.prod.outlook.com (2603:10b6:610:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:17:48 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::90) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:17:47 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:47 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 00:17:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 00:17:47 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63R5HQUq2543740;
	Mon, 27 Apr 2026 00:17:42 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v3 3/4] PCI: endpoint: Add API for DOE initialization and setup in EPC core
Date: Mon, 27 Apr 2026 10:47:24 +0530
Message-ID: <20260427051725.223704-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427051725.223704-1-a-garg7@ti.com>
References: <20260427051725.223704-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CH3PR10MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 51158bba-b39d-4fbc-f226-08dea41c5259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	ndFExLBRCq4r8WSYn6jP9rMK4f+OBayC8o2mdqpsMnYAEzItoJgRgMPw7qvU1nBSzXqUDqgx11tdEwi63rSHhXURhzHf/kHh8cAzqdgcq4O482asbPD+sup9fE+sfPQRTyPWvFwAEW3i2S3FHY3C2Yc2mwSZhWVxVbEemW2Rci1swDECPufgTkbWtd1QWpcgfJJTwg6oXMCbkZo6VQB20itMq7mvcZlefVdNJZnrOjokKKa72GlTQOcKadoHfFXSVMFkMaiTTPyPteu0qvl3bdEuv47vFI1aMpAQUdLvht0JFZSgKqgufaIG8OYwVjv6uAdwEALL1Q2qIxrYrxVD+E2Y/VDnSFLXiJ0FyzBUyXr35FeBmQa9+cm39WV9PVxkt9fHOYo0IGbitql5o/g1khov1K19hYVbJWLSUelQe3No1D7iCrvZUy4X2Q40r5nOpCm0lKiIne3rRD1fJPLLG9Y4dprghLeU6wQP/s11q6sOPWmAvWMo+cOLy0L32TR0iijh1Noru3dqLT6hRz/k8dVRxUbZ1WEQsJExtI2wRqtdDd8UFj3EWBTLIMpiGZWSVxPKSaa+m0NsJMaXsH8xccOTDTKO72tJ3/RAAxxvMAIegiRI3tCSMSm62SFPDVNLcAmcpZN7Wedq8kLEBARMs8GzzpylPzaE1oXoPvUyQRiVAfZ1vRpIqOIh0P+AoCvZbXo/3vtWLOO7BaUTfB/xuUFdS8gPAbUiBoazc7w2PyZrhTQAZyfW4bv+NjlKzhCbf8CFB+jP1XkWpmnKNeKamro53hQ7BTAA4VfERVCiSvWA+RTNjo8cCXPG6evNrsIMoTzbbj0BnfDJHQiTDEi2PQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qz7ezKlSKb2SdRxet9llzDyQ0SeHjIOjSQA8+YG1gQfIsHv52NGsGpozS5rCOclE/2WGLann7LH22J4+qKGIJfyv6g8YLPSfNCbcRXY4y/uyBFa3k1W6qktnMcqhE8WckNiVg9vXc6KYo16oGThG3I3svcB2YjwxGoJd+oJOT1RJQHCtwdaxHzpLEqRKwutC1JHTLHsfRLyq4scYVBFNma5FO1IT0Bb7YUHO+L/x2RzlXepxbFfYL79uOLBiF2scxFPIhucm59k33CyJwNFNJ0o0Tuk8nV7lYQL74uTQ4V9YjqFC2SeFgwcaKq4Uz/CW3qVWrCH+gw5yG9gXwbypzFfZ8s4Mnx3yxS2A7A40lTuqxrk4xh+GLv9FXdWG53nR3h7A7/Ua8VLIgJG62fRxoXVlOpgySez/28t6fP3GRoqnjkofOsWaqlG7EtPpas5h
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:17:47.9542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51158bba-b39d-4fbc-f226-08dea41c5259
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7807

Add pci_epc_setup_doe() API in EPC core driver to initialize and setup
the DOE framework for an endpoint controller. The API discovers the DOE
capabilities (extended capability ID 0x2E), and registers each discovered
DOE mailbox for all the functions in the endpoint controller. This API
should be invoked by the controller driver during probe based on the
doe_capable feature.

Add pci_epc_destroy_doe() API in EPC core driver for cleanup of DOE
resources, which should be invoked by the controller driver during
controller cleanup based on the doe_capable feature.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- New patch added to v2 (not present in v1)

v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/

This patch is introduced based on the feedback provided by Manivannan
Sadhasivam at [1].

[1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/

 drivers/pci/endpoint/pci-epc-core.c | 71 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 21 +++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..5a95a07b7d3a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -14,6 +14,8 @@
 #include <linux/pci-epf.h>
 #include <linux/pci-ep-cfs.h>
 
+#include "../pci.h"
+
 static const struct class pci_epc_class = {
 	.name = "pci_epc",
 };
@@ -548,6 +550,75 @@ void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
 
+/**
+ * pci_epc_doe_setup() - Setup and discover DOE mailboxes for all functions
+ * @epc: the EPC device on which DOE mailboxes has to be setup
+ *
+ * Discover DOE (Data Object Exchange) capabilities for all physical functions
+ * in the endpoint controller and register DOE mailboxes.
+ *
+ * This API should be called by the controller driver during initialization
+ * if DOE support is available (indicated by doe_capable in pci_epc_features).
+ *
+ * RETURNS: 0 on success, -errno on failure
+ */
+int pci_epc_doe_setup(struct pci_epc *epc)
+{
+	u16 cap_offset = 0;
+	u8 func_no;
+	int ret;
+
+	if (!epc || !epc->ops || !epc->ops->find_ext_capability)
+		return -EINVAL;
+
+	/* Initialize DOE framework for this controller */
+	ret = pci_ep_doe_init(epc);
+	if (ret)
+		return ret;
+
+	/* Discover DOE capabilities for all functions */
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+		while ((cap_offset = epc->ops->find_ext_capability(epc, func_no, 0,
+								   cap_offset,
+								   PCI_EXT_CAP_ID_DOE))) {
+			/* Register this DOE mailbox */
+			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
+			if (ret) {
+				dev_err(&epc->dev,
+					"[pf%d:offset %x] failed to add DOE mailbox\n",
+					func_no, cap_offset);
+			}
+		}
+	}
+
+	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_doe_setup);
+
+/**
+ * pci_epc_doe_destroy() - Destroy and cleanup DOE mailboxes
+ * @epc: the EPC device on which DOE mailboxes has to be destroyed
+ *
+ * Destroy all DOE mailboxes registered on this endpoint controller and
+ * free associated resources.
+ *
+ * This API should be called by the controller driver during controller cleanup
+ * if DOE support is available (indicated by doe_capable in pci_epc_features).
+ *
+ * RETURNS: 0 on success, -errno on failure
+ */
+int pci_epc_doe_destroy(struct pci_epc *epc)
+{
+	if (!epc)
+		return -EINVAL;
+
+	pci_ep_doe_destroy(epc);
+	dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_doe_destroy);
+
 /**
  * pci_epc_clear_bar() - reset the BAR
  * @epc: the EPC device for which the BAR has to be cleared
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dd26294c8175..7b0f258ef330 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -84,6 +84,8 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @find_ext_capability: ops to find extended capability offset for a function
+ *			 in endpoint controller
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +117,8 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	u16	(*find_ext_capability)(struct pci_epc *epc, u8 func_no,
+				       u8 vfunc_no, u16 start, u8 cap);
 	struct module *owner;
 };
 
@@ -270,6 +274,7 @@ struct pci_epc_bar_desc {
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @intx_capable: indicate if the endpoint can raise INTx interrupts
+ * @doe_capable: indicate if the endpoint function has DOE capability
  * @bar: array specifying the hardware description for each BAR
  * @align: alignment size required for BAR buffer allocation
  */
@@ -280,6 +285,7 @@ struct pci_epc_features {
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	unsigned int	intx_capable : 1;
+	unsigned int	doe_capable : 1;
 	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
 	size_t	align;
 };
@@ -368,6 +374,21 @@ int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epc_map *map);
 
+#ifdef CONFIG_PCI_ENDPOINT_DOE
+int pci_epc_doe_setup(struct pci_epc *epc);
+int pci_epc_doe_destroy(struct pci_epc *epc);
+#else
+static inline int pci_epc_doe_setup(struct pci_epc *epc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int pci_epc_doe_destroy(struct pci_epc *epc)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #else
 static inline void pci_epc_init_notify(struct pci_epc *epc)
 {
-- 
2.34.1

