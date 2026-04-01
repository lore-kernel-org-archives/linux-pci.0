Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09288398904;
	Wed,  1 Apr 2026 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028656; cv=fail; b=FC0lkeSXW8U6BIoZ8cFO8Fa14q+baOQFrDj78sdQFa80IDifd18VJ2TOLQMboBFhZ8Lxark75hR1KcYObvuyoScmaUkspYGCiWhJLQWHpIAPfL/eRD3w0da3q2hoW+pyeEgk/a6e9z246cdZNqPfEmJzqHuUzOkuhL533imijlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028656; c=relaxed/simple;
	bh=qaGRda44yb7zWAtrGphW2mY1sqlvMrXAAeYvF4T2S7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DipoBRcT9BTbtnFTb5sT/OWScfPwGgVTE4zM8RIEBCVveO9/+Mdfsy31zSURXLOMbNQjc2JYrOf1Ds5bfr87w0Qf/4vaKeX/MghjZIHUhnj8XRhDP/pGtCVXF/UJCDzk3Os6gpyRd/qNXoL1+/z6T7y6eNiB4oU45BNe6guv+8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cqh+fBLI; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cqh+fBLI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKKAiO33B9rSJWSdQhT8l88jrc7N33ZJEocIUEwQgC5eujkybyAKVPCXSBh+Y5a0QxDniGsnrNxGHpTPTTY0xqZX+vU63VuKrmnb1aqShmfbsW1VgHYMcEiFYo3NyGdRHE9tzheQ/2Utvd8664yy4I2DOGvTV05SjpgIvq9KFhqQh/rXGLYCqKlyfdt9tLEM9OnIhAx1C4V01xRKWq7J21IQTcucUUQsBMX+T7Ffc84tpsG4exKP8qe2uGzdo/de7huxo81/S34EVk0/jbPT1V1LSU6Yio3RSs3oe/Kjjsi6+du24JeULcFU0lzJVFETRsm6NvJaeUvhzAp2LpwBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+2nVL+oNEhLJODV/d5g6MEA/ciHlVTCNd0iT3/WNeQ=;
 b=uHrHqiRPSFCk9YqtDbnaAUeaHcDr/z3zfQ8hRO/YRkM0Nkjpzy/aV1eIZOhorZCb0Y3CALfdy2ZTKIclcd1l4xgcuRcUwMONHK0C5gvHMGrVyUt2Q/1+dIcrCLGaASJ8mWAgaVFRt8oJMOsQtybc+Dsq/qLKeq8gG8OUPVBz8q+CiOKocnAT4dhK7TyJQYNzrDS7ZxM5B7vjr4V4c5S+rXP2VsWSbX8Z7Wm91bNvQp+dnuZsyg6AWzkqjTNeg69ZFVrb7mxe3mvUo+CkgCDpXQCsByelEryssOndYGUGH3Rk6C7urUeE1ohZW5KjL+FIzW/cBeuDdWUEq8/nMBFJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+2nVL+oNEhLJODV/d5g6MEA/ciHlVTCNd0iT3/WNeQ=;
 b=cqh+fBLI3lwEG3mawvx+RtFPUIZFcH9xV8c6rtzAkrOAvL5CSwWdcWRsO5g6jIbcHtkrbngQfix5y33vsd3Rp7/lpPsnKj4o4KwamDcgr3El0lK5cA+/jp2CPKrfzePatGc+nIzBU2xsbi80+Eg8/yMrE+ErE3b6fFukRvCJJ5s=
Received: from BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::6)
 by SJ0PR10MB5663.namprd10.prod.outlook.com (2603:10b6:a03:3db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 07:30:50 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::23) by BL1P223CA0001.outlook.office365.com
 (2603:10b6:208:2c4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 07:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 07:30:47 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:30:43 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:30:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 02:30:42 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6317UN3S3832504;
	Wed, 1 Apr 2026 02:30:38 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v2 3/4] PCI: endpoint: Add API for DOE initialization and setup in EPC core
Date: Wed, 1 Apr 2026 13:00:21 +0530
Message-ID: <20260401073022.215805-4-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401073022.215805-1-a-garg7@ti.com>
References: <20260401073022.215805-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR10MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: ff52b391-d837-4e75-77a0-08de8fc097fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d7qWoi4qjfygrTUtlRMgyRW0QDv7rNt+sM/KqzqEajxg93a8Ai4c7Mu8bXy6P9PpbkLeWpjXYFv+K2t2t7V3obntYutgsGFYueY4TafFFSVhm+FWA7bi67MrVce8R6+PCr2nHgbnoVQlWgdk89jId+PAVcGtpPCWlc7GbAdEI7kioH+276Ka/bmBBjKuWovwOnAyaKABpI9rLmPDZncVd+vokdaOwDHMt86phIDpm/NQlc4nFmpmoT4nzLGdzPLmUovQ/x56/4PwQJ9/f3LNYIwXEPQ3cgLvUJnghIJv4Jc3MKwRukW4dp6n9InLdyyegiajd4+wc+xDuDmz+fOhdbqmFuVGh57C92LSxCKH5uOcSECxCOcccQPs9UZQzLhU5B2BgzuY19d62rWHmwzH8wWxnUK+FrqjGxafmw8z3N4P/jZdwmu598MCGE3/1iw/l5PrAT0P3SWAhHOKXzcPjBca5TeJuirRfHkrglJsnaWnT4aPjIxq0oS/IqubP8Q/OhzSiWEWFT4NTwfuqhV72FTWz7bPgVyZsmlG79S+y5+rHrH99py/5l6giuOFvYl6XMt4CeTfrecB2cfBBvY0MLSZkydS6RaeU/kgnX88MWRu9lqL+GiO+26HBcvE8vM1w0tpIi93rd/kLCBoqPf2UTxwRxhGjnWvZJAT6F4jlgYK2bpdCU+Kav2FdEdhINzwI1mS8UziWJpvl1Ov7pE4r2AkMRD26PQCMTC6oXx7b04Fk5CjknIcZSkDtGCIwX1kzMpWGqWvYbhdc/PQvC/skOjlrx/ebLkoV1aEbgfZYrsFYOUHNV3gCg0Bzzd0afS0
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xlsUEPXZS7o3gmQ+21Zmpc3il7VohY29DugOeE1u19YspzMXPbwfizG9D8bmjqKIBqFrWSGGDidEN67cthcYm6f7xpIHZ36oAiMceAR+hsKI5p2tXrDeQmlwU37PtDmWCFGm7+biXcb0ndTQ3tFjMeN7NdWg2Iz3nc5WS64ql4lP5cnc2UIyrUQuYCe8AgApiqUVXgLKvE9x91x1oYVKDbyJL+kt38VxRvCGuxM7rDR7IAyMkhJB7Ima6QjWIuKZaH4Va4AE996gFl9FJ/evz8tnaJvM6mJoYd0sg+0EDA4XjJkCGFTcxm91jGP0t1hmSHoZFEiD4bkicdw030sT36PnV4ja6dvIsiRLuinxCnqpwMCQvaWdWsnFsXoU9nlsLBTugRPO6xm4jxHhmalKR/tSpIdP7SCFwqTN1lHPE3vPzNbzAis3QpKqVd8rnJ3E
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:30:47.8566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff52b391-d837-4e75-77a0-08de8fc097fe
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5663

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

Changes since v1:
- New patch added to v2 (not in v1)

This patch is introduced based on the feedback provided by Manivannan
Sadhasivam at [1].

[1]: https://lore.kernel.org/all/p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d/

 drivers/pci/endpoint/pci-epc-core.c | 71 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 21 +++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index e546b3dbb240..14f77dd0877b 100644
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
@@ -547,6 +549,75 @@ void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
index cfe74585be4c..07fa41a8e466 100644
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
 
@@ -236,6 +240,7 @@ struct pci_epc_bar_desc {
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @intx_capable: indicate if the endpoint can raise INTx interrupts
+ * @doe_capable: indicate if the endpoint function has DOE capability
  * @bar: array specifying the hardware description for each BAR
  * @align: alignment size required for BAR buffer allocation
  */
@@ -246,6 +251,7 @@ struct pci_epc_features {
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	unsigned int	intx_capable : 1;
+	unsigned int	doe_capable : 1;
 	struct	pci_epc_bar_desc bar[PCI_STD_NUM_BARS];
 	size_t	align;
 };
@@ -334,6 +340,21 @@ int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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

