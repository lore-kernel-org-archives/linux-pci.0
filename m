Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60633E63AC;
	Wed, 10 Jun 2026 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085805; cv=fail; b=rcOFgJqHRCY1k1daMmf9qWKpLPVYFA4GnWqa1w1gDzykYmTLabJUeKFCMTn+8a3uYWoXXrZsW6XdYENHzIiNgD/TIs0X1i/2LlvkxyEvuxA9mXJiG97oxQAKQZnfjdJRkPfV4JnFXPuKhJozPohVNyg+DImE96U/4PZhGtFrT3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085805; c=relaxed/simple;
	bh=dTk1jc41kVUgQmhf7rniluzKuDHYuxtnG1aTx/Ypl64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TC3tpWzwy7DutZ8XWatzKADfGsoaSKl/IC0s4VhdLrgu6VeJyYqRXdoOcEBqm1LJNBbnqlISvzRuUvErkvhYr/YVASOuuTDLzoIOcSNbNfdc/wJ4Coz93HA8vjqMyBEQcDh7kXOS5HopjSxX2GvstKVVX380oBmOxEHpO+DEsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G7VZuGfm; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G7VZuGfm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2+B9zPWLZh1ZAidjKHE89rgXvyu+Uol8+1X/i20rkiCvWZf9ej7dBUEM1u6WoGvAo7dsP5tpH/fnvulduL0zy27ppGkUJ6B804uqinAwb7yPjr4P56XlMtuRutWLi6HDgXsP9vaMDCniCL4tY0MkHOpeQ0FawNJ5huCy8glZv/CSLuRHRFH/a4EeNHG9ibFR4OZBQMGq/K7YOucNNzrkz3RV8uogbgKfBDVTx5VBO2anI0z3ot8Cyv9rRVn2n62T6AKneVRiKLPuQE/eprzD94n8GHNJ/lksOdThkBoBSF3lhpeIyU+l3fT4ev4F+l0txZ7gg7vQughbWJB1iaenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvYeu3iulw4CHHdVVhj7LxyktHCmlqzWt38QZvtjWDM=;
 b=MhI3Ivcm1fLqd2HQapKMFNdP7J0L21vE+TbXEBE9nKxul+04TioOFDIxMGHqHpoam2NiD9GiDejRgW9NMKBHlO0n64xWrtkI21yBREqeCsAhCg1OMXRHeo5ZoFhxzFr2RgSuEF2Ckh6lHAtzzDVZvdEVlXdiUs1xZDwVNQPE9kEnXhAu0XBX0Ivd32hyipaZ4L0iN8BjmvLsflodF2gjDQrdXfkm61miyPhUL+o6Uzc5CLprYG2seQHdI7Rgyyk3kVgL1c3/LENsmuZwjZ3rQcbRcH0muHtvPASC3mmFbZmYhqwBTZ7VGOFIluLTbSoRQr4KsWSHYhU4ZKQP9ohZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvYeu3iulw4CHHdVVhj7LxyktHCmlqzWt38QZvtjWDM=;
 b=G7VZuGfmTiSQsSL3W8HfLoTDOFUU8YOb+ovvAX2duJnrfIy+DrFL6xWJsLFLEbZ6Pdhf9hqOFMzluonH1MZB3LXbF/OdNCwcW7h0rLHIf9+NeC1OzlhGRDnSFxmgK0KTfQ15KILrKIlXkNYrmz19WRf7dSoeiL9daBwi1ePmksc=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by DM3PR10MB7925.namprd10.prod.outlook.com (2603:10b6:0:46::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:03:18 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a1) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 10:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 10:03:17 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 05:03:17 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 05:03:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 05:03:16 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65AA2u8x3620198;
	Wed, 10 Jun 2026 05:03:12 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v5 3/4] PCI: endpoint: Add support for DOE initialization and setup in EPC core
Date: Wed, 10 Jun 2026 15:32:55 +0530
Message-ID: <20260610100256.1889111-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610100256.1889111-1-a-garg7@ti.com>
References: <20260610100256.1889111-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DM3PR10MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 92242449-ef82-4f32-ab88-08dec6d77e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|921020|56012099006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BShPVud06RN+og8hwF0l0j0EoH8bhshbyxGQDtFwbtp72e/sKflfWaEaPn48/b6hUTgpjExrj7pE0xmou2e4CGovB1s6qZUXeShTtmzQi6mBNySUPtZXjLkw5K6oj4zn2pZZUdvXQjXj5pvjIviLlqIKzFnUpG6VoM9DS0bzDy91ueTF3UQA5l7xZ/3t5I1zRj+pLiRvc0qJRrmW/12/o6303NMspRWH+hm1ZCSWaTZP08s1+hZOquOKdJHrQGvKSdsq532Bo7sLhyA0v4pAHIhbPjM/kQvSnoTN8FfFD0HNNwzTsJnnSBPe4BZIkJlFbkP6W6yGZ/P29W0Z1oR1KcEWz2ksvt95udgv6PWzJY5yPd6jLE32jUEp+XCfbnoBwMJWzrlWscHKZyvwX4/ii3km/pofWDc3mpzuJrOKmnNUzjfes6xurIK3sqoqyxYrcaTpIWV7ggrh50NAxCu1b8EfqPWwfdbvkR6jV8ogwIwIz4+3JFHXHL0OGO+oxJFy7/yr2RpxSTDI2daUkXEFb6/Tp+XzQUGewAgO772McS2tXMyboynNLIj+TRoViaA2PrS8E3BaEzyQMNp5USij7Ehtmy+VqX5y1/G1Tk2Rcrmj5xS9EkS7NQu24JVl/H46SDID4zec3KJM5i8s+U++oLwx3DI8cPW8GfDFNpxIbWviOnv+Nk7iOgPvngQ2+phs0sdbSdgGCP7IHhMNV1um3HKBXKP9F42FzYCj9eA7ktQ4sCJiT3APA6nc8ZWfecNTWs5NhwSddWeK4yHCcr/3dw6lDUervxlrdoTDJgRS6Wg=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(921020)(56012099006)(5023799004)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bdx11cOq0OIYQhQs2EXRsLpJCZiye3xnBpfoXkhk+oMcmQFpBftpc2meb+mv00/pW8vq5o626UCceTESUPIdwbD03tzCeNO52yPTMu7LpUrpxKMJA9XwLEsOGhvqXrSIgAwggccXmXsLssNJvIfSN6P2N6juZvQ8o0UaU75q0iLxGD6qcP2J45Wsv9bZDMY/feI1DQFae3jrhvEN3lAviZHOdW77y1cXQX6envfECHVgjnSAH3YJAhaY7vMPT8FN212fA8B4+45OxXtKS+qhfKnq5hQ5rAKNPdQiaUzPOvHtPDS5f8Me9/n714GqbYQTMsJTNzJv4vzO0Rmoi2dhWxC3H+BgBPh4ohZKZlQDyEEuRnHH8xivoLRcwBddxgyXEkLJ+nTlxwuHs6RF4frDVySNLjk8GZTvq2mKyDyrumiRyEbSIInXDH29bvwUkfD9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:03:17.5593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92242449-ef82-4f32-ab88-08dec6d77e91
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7925

Add pci_epc_init_capabilities() in EPC core driver to initialize and
setup the capabilities supported by the EPC driver. This calls
pci_epc_doe_setup() to setup the DOE framework for an endpoint controller,
which discovers the DOE capabilities (extended capability ID 0x2E), and
registers each discovered DOE mailbox for all the functions in the
endpoint controller.

Add pci_epc_deinit_capabilities() in EPC core driver for cleanup of the
resources used by the capabilities of the EPC driver. This calls
pci_ep_doe_destroy() to destroy all DOE mailboxes and free associated
resources.

Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Changes from v4 to v5:
- Addressed the review comments by Sashiko

Changes from v3 to v4:
- Call DOE setup and destroy APIs directly within the EPC core, instead of
  relying on the EPC drivers to call them individually. EPC drivers do not
  need to explicitly handle DOE setup, rather the EPC core manages this
  transparently. (Suggested by Manivannan Sadhasivam).
- Removed pci_epc_doe_destroy() API, which was just calling pci_ep_doe_destroy().
  Instead, called pci_ep_doe_destroy() directly during cleanup.
- Called pci_ep_doe_init() before the "!epc->ops->find_ext_capability" check,
  because if doe-capable=1 and find_ext_capability() op is undefined, this
  would not initialize the epc->doe_mbs xarray. However during cleanup, the
  check "!epc->ops->find_ext_capability" would be unnecessary, and it will
  try to destroy the epc->doe_mbs xarray even when it was not initialized.

Changes from v2 to v3:
- Rebased on 7.1-rc1.

Changes since v1:
- New patch added to v2 (not present in v1)

v4: https://lore.kernel.org/all/20260522052434.802034-4-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-4-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-4-a-garg7@ti.com/

This patch is introduced based on the feedback provided by Manivannan
Sadhasivam at [1].

[1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/


 drivers/pci/endpoint/pci-epc-core.c | 104 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6c3c58185fc5..e48f40eeed29 100644
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
@@ -842,6 +844,81 @@ void pci_epc_linkdown(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_linkdown);
 
+/**
+ * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functions
+ * @epc: the EPC device on which DOE mailboxes has to be setup
+ *
+ * Discover DOE (Data Object Exchange) capabilities for all physical functions
+ * in the endpoint controller and register DOE mailboxes.
+ *
+ * Returns: 0 on success, -errno on failure
+ */
+static int pci_epc_doe_setup(struct pci_epc *epc)
+{
+	u8 func_no, vfunc_no = 0;
+	u16 cap_offset;
+	int ret;
+
+	if (!epc->ops || !epc->ops->find_ext_capability)
+		return -EINVAL;
+
+	/* Discover DOE capabilities for all functions */
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+		mutex_lock(&epc->lock);
+		cap_offset = epc->ops->find_ext_capability(epc, func_no,
+							   vfunc_no, 0,
+							   PCI_EXT_CAP_ID_DOE);
+		mutex_unlock(&epc->lock);
+
+		while (cap_offset) {
+			/* Register this DOE mailbox */
+			ret = pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
+			if (ret) {
+				dev_warn(&epc->dev,
+					 "[pf%d:offset %x] failed to add DOE mailbox\n",
+					 func_no, cap_offset);
+			}
+
+			mutex_lock(&epc->lock);
+			cap_offset = epc->ops->find_ext_capability(epc, func_no,
+								   vfunc_no, cap_offset,
+								   PCI_EXT_CAP_ID_DOE);
+			mutex_unlock(&epc->lock);
+		}
+	}
+
+	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
+	return 0;
+}
+
+/**
+ * pci_epc_init_capabilities() - Initialize EPC capabilities
+ * @epc: the EPC device whose capabilities need to be initialized
+ *
+ * Invoke to initialize capabilities supported by the EPC device.
+ */
+static void pci_epc_init_capabilities(struct pci_epc *epc)
+{
+	const struct pci_epc_features *epc_features;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, 0, 0);
+	if (!epc_features)
+		return;
+
+	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
+		ret = pci_ep_doe_init(epc);
+		if (ret) {
+			dev_warn(&epc->dev, "DOE initialization failed: %d\n", ret);
+			return;
+		}
+
+		ret = pci_epc_doe_setup(epc);
+		if (ret)
+			dev_warn(&epc->dev, "DOE setup failed: %d\n", ret);
+	}
+}
+
 /**
  * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
  *                         is completed.
@@ -857,6 +934,9 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	if (IS_ERR_OR_NULL(epc))
 		return;
 
+	if (!epc->init_complete)
+		pci_epc_init_capabilities(epc);
+
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
@@ -890,6 +970,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 }
 EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
 
+/**
+ * pci_epc_deinit_capabilities() - Cleanup EPC capabilities
+ * @epc: the EPC device whose capabilities need to be cleaned up
+ *
+ * Invoke to cleanup capabilities supported by the EPC device,
+ * and free the associated resources.
+ */
+static void pci_epc_deinit_capabilities(struct pci_epc *epc)
+{
+	const struct pci_epc_features *epc_features;
+
+	epc_features = pci_epc_get_features(epc, 0, 0);
+	if (!epc_features)
+		return;
+
+	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
+		pci_ep_doe_destroy(epc);
+		dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
+	}
+}
+
 /**
  * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
  * @epc: the EPC device whose deinitialization is completed
@@ -903,6 +1004,9 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
 	if (IS_ERR_OR_NULL(epc))
 		return;
 
+	if (epc->init_complete)
+		pci_epc_deinit_capabilities(epc);
+
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index dd26294c8175..11474e337db3 100644
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
-- 
2.34.1

