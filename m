Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D2528433;
	Tue, 22 Sep 2026 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066393; cv=fail; b=huCihnD9gydAMBijWOxeZBqogI13Y8w/py9b5vDrz/dhGExUH7dL1ue4rjmpVEraSzoYt1MvkaKRERwvpWyFusqJ+nrt8kycsa96RVI1WjqKcriEq81wKV31L8axuni0HiHVfv4+nHodgN2+ZJdC9nfI3JhuX/MWnamgQ//GPFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066393; c=relaxed/simple;
	bh=KNTUxrlzBNBrYxvNPwniKy2YWwuHX1kAGco3KShVqeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uglOakMQ42+FwpdvynIlfyh8O1Odh9pfoRUHrP3WTzGZQXy7QGiacHZSsx1B3q8DKU3W6s7TJ+PyvtfuFVA3wv9mRqLxVowNWYvWiV4OxeGwWC5TNHoQCwx6LeYamd3ltbH4l2pl+esYWtgLB7fVw0sb6/17m4GivZ3BdfwGg/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ta9JUyRz; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ta9JUyRz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7LvA56EkqxRmo7VXR0HOIWxMHEMB3lTT+AEs3Tws8JP6Vzv1+Ci0SIVxHk7256V+I/K95YxelAiaoTU5W6FyZvusRp5Odl3kBMJY1UFkX/wqzWDLiUl8kQ7XWBICxcpdaNc+PHWu9mi5govFiq9ImNKBCzhpnIrx06nqI188g0KbXy/f9ScivSf9zvaHLWxlwwFltSSkV4Z810/I2OKroH8x8Q1Himm8oQkz4dKNgysxTu2BdpFeSKo4ql5PAlz21EYXhLBkyIXtPCAAepmT43TOGhJX5xZSNlkIRHLVJ1qibK8JU+ZfeIw/bdgxmpJmFLt42wwOd2pmOHt7fuM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcBr/ZvbiE4coSKsbOG0NmMyN//Gijgos+qkA5vExRw=;
 b=cqih5SiVBz/zYcmcvt0qa/4Er/ywGRu1CrPqA50ZEqm+WKD+aDDTt6uUmR4OL3FUbQUK6oJIV4phG7lYxi+ObpPOO+P5PO1Vp/yY5oYFNVAONhkBaTc7X71pknYLslXS9Fcb92s1sbrPz2YkN72z/JkZNETpo9FX397QFzW3h5f20cg2Llfv+KKrdNVjBcTmCaf7Quzr7Zblt8e4EKTX8uOj575q+5rWlgo6h/jbQwmcfLaT9aayY5LT2cfuGZl/09lAqAP+kF2k9QW7QmBO7+Hds6WENoSPufzKou7lDyP5CBLPsN+2ddcjF2lUQnDDhTFZHMWCyCEVQOP5sys34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcBr/ZvbiE4coSKsbOG0NmMyN//Gijgos+qkA5vExRw=;
 b=Ta9JUyRzIpO/RLvaDwZ/u3rPQ2wQVHUJKdZooRP1cg8yCuFcHP3Kq7XXGywrnwh8YlPQ9mQ0W5PHjjiORw8WnbfhrAuY/8Gw3XFcfGSUXZTbnLbJ+wae9Pvg//A1y0z8qCNuWfGA7FgJDZfpMFtxi9sdBU6xGHKn1nNdzoHbSwq/DOuLnp+l6/gSwaPNn41GR4ljnRSO/EE8oeiKxAOL/kFyDDBLI3Wqiv7n1JotIQP0sXDjZOIQ0A8SyMrfX92qhLMGTtwVFOdjzeNPdiCNdFSrR+OZl3vouOBbqxez/7LQRvLBUpb+oong0c8nR4M96g/ZGN1OpKyEbbhLZKm6tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by CHAPR12MB999223.namprd12.prod.outlook.com
 (2603:10b6:610:301::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:47 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:47 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v13 08/15] cxl: Refresh cached PCI HDM decoder settings
Date: Tue, 22 Sep 2026 08:39:17 +0000
Message-ID: <20260922083924.2451158-9-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922083924.2451158-1-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|CHAPR12MB999223:EE_
X-MS-Office365-Filtering-Correlation-Id: df847312-9c50-4306-bfca-08df18850f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gD9iROi0nd61FgEe3AlGuJBAmzH88CeSQXU9vSxiOXTPvHVznAlTUmPzH2DruV5YcgMmz6CtwaqmJ/yzzLjgC5p+lgp3AvHkB5Mh9UoJOkfiN1RnLkkzyucMjb+crWprlDIT+z85Jp6uAXgdtlaS0B9X1flvcfcUjbOO5nEHyP4jAz9tOZlyRsOkLL72F1ZnPgBVlofoW7777G9yEjiEqSAG0QxOH6cImow3eUP6yk5BrquVf5rjsmRXHJrk8cAbdZ8VMrMOeMNLwBMbrlM+6MB85TUC9S83IiRISSKb3FhUOD/j+K11tBRuLsbYsaFncTJ94dDFirTFV3tA+GxoNE8USBoeG8+b2AFk/t8SsNIHFhVMXSH4g4KzAIxmhC7cT2zSbuK0q2wd8ZeK4If9WfXBJ8CDfD9ffJftmprenBPSacFWZA+Uf2zMdz9ggE69WteRGzX38N0b41H60WkHJFwXSbqqJ8YHMvMQciXROF5oc3dcK3oOCj/yv9GErc8sr9dx7LS/OYbh3lWXTRSI6Jr3rUSqAasA7muO8xiV3S33cvQuJWoE4sVwF5ICiTd2PsknuN379kCxgVeoclkrMknnbkaKnmUkYdXayMuT9qs1WyZEyh7GT8hE9OeEE2JxxFxs2HtT+PgZxiI1HT6hdI2zBsOX47rYLSecdIxvicqGCHrrj1vWPzbEHa9bZL1HeDm4tcY2gWtyg5aAzyGNrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/WQUihMryg0HVSf2NumZLiFmzLQCZt2iX19iq+rhw0NNvjQn++XaWKZRuZxk?=
 =?us-ascii?Q?NJaqcnJDeNh8VOvvXsZo4mD3bZRcvsuJBSPSMiYT08/VotNT9SME5EjuTIgA?=
 =?us-ascii?Q?2LL9HbmMqcYT6fIVOgiu9kRNWLsmWp5YKh+Myvv7XtmMt66dDpLmOHF7f5Tb?=
 =?us-ascii?Q?wtw0tT7i7u3rAl/Ru7GPvgFHub/WUybnBSuiM1B/bTXf0LcW6mweuObCWs56?=
 =?us-ascii?Q?BuCI0NAz6Z9UivfaViezP2T6zMySpL8G6rMEJdhGy5+XtjA/eHq/fDwuLris?=
 =?us-ascii?Q?MoWZGZOk7TsuB/25mZH4KvnWuHaqrQDwQ4HtRMVqdSLXwy6LxpoOIM5t6hmK?=
 =?us-ascii?Q?TohE5Y23b03ZR+3P5Nc7jxtLWZVRuOxHbFUH8QlqQyO8uGvcLe28OCv8I8+b?=
 =?us-ascii?Q?bdM6ic9WcfqsWkS6h1oO2Ki3Pom59JmbhUb8Hi3m5uyUcSdIPwoxU+mtEZyj?=
 =?us-ascii?Q?w8CBYG2lPaUCtO6ys17N24w800mT9hkSsSJCvTCV2Akajwzl6bX33zBJ7APP?=
 =?us-ascii?Q?k2XyfUNYYiFfgQaHjgZZF8lEt13+umU8UXVn0XqB1/FJVufls164yzd73fVq?=
 =?us-ascii?Q?7p6Qj98kEOtueyT2/r6b8q6a7AY3GJjXpwsRnke5BvHZDuWeqsuqqiYgv6YR?=
 =?us-ascii?Q?HGspVwK5j/Mt0C6dj2cW5ToJLyJDcGGIo/jck9H1AdTUAVhKt1xeWdc4p28Q?=
 =?us-ascii?Q?7eMeC+c/6bIQ/OMKcIo/0s5gEHDRrIuL5nnahQhm3JtCrrFFnjSRwaoP7cN8?=
 =?us-ascii?Q?vLhU8J6otGzQYSGPReYuf6WI1/ak51W4avScnljgz9LzC3vmpS/G00xhTfmF?=
 =?us-ascii?Q?uIeMH6J6FbObDlwH3s+Y/rX0AkgnJpa80+wCpERvS29t2FT99vYm7jken0Cq?=
 =?us-ascii?Q?af3nHXXBI9BAnrKFNsiS7+9bQ1bLclnbChwXBzA/P0y+dRliCLNZqTJmbzBQ?=
 =?us-ascii?Q?+jt3lpDrnhWU0KdEal7Ju8v6UmZsSCmLX8YAGHsXWp7iHTWVKmLssvGm+8So?=
 =?us-ascii?Q?G8c9z0fsPgnY0y0/NXgjmpLRetyWgTNGYgyz48XpK1OGbYqel0vpbvz2XnUu?=
 =?us-ascii?Q?IZzybTttT/SJLghVoU1eoEdMdGXAwwbuY/adHs3sDTxjJ/lSrVXelKPrH37u?=
 =?us-ascii?Q?imU20eRySFTJieCi+tvzL6cIgZgNbRaWKoPcVlP+pPBy9kN65s0qcyuTR/Vb?=
 =?us-ascii?Q?AFyjquHTlqK0qNKxbGpfscdkq+7vcwy/OCm2BYi0Hu0L+qgXr3Jjt2u73j2H?=
 =?us-ascii?Q?+wmPhydzdEmHL9APrF4WTA0QTn7EVnjcmE/DYI6iTyTukfH76bam5Z47CZ9v?=
 =?us-ascii?Q?raCMi3uwgt3uv1rqPNUJO9bJ5vhKtB+IssDIWL/yMrpKqWXgqQ986uK1dD4o?=
 =?us-ascii?Q?NQD5ab+LMWa71fqhenc45F1WfperJ7rPEYIY7eLI3tKI4hwNdzK1FN06PeBV?=
 =?us-ascii?Q?4Q/3JLMZiaknhJbehr+Gz9berVPUysZBs1fQWrME7+xpgy9OcDlgAsfSPek8?=
 =?us-ascii?Q?Yg/4IxL6fQW5M/ul/uDh2odSR2LBC200v04YmbZQIDcwOBJOkun9q1e4LFKf?=
 =?us-ascii?Q?BCGlhj5jWHBHQjJdCR7G8xT3dkCqQ4UcQzrQorn6o1CPJmw/k5bWuhM4qQ1A?=
 =?us-ascii?Q?D5EXeFHUKZml/EGQ3P2fciDU/kKYYuhULCbR8wkJGsNcDKCsIl2MY/fDf81F?=
 =?us-ascii?Q?BXHkgURCc8T1FrnbJKZAsF/oo271mUbXdAJKVlfjZPFEd8/YodgfWe2jU5p+?=
 =?us-ascii?Q?CeBhbds3eg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df847312-9c50-4306-bfca-08df18850f1e
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:47.3870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck3fbxY1jgxOGpkencrHhqx1vp8yuJzWuDI+5lrwg1eK3wsXwsEq6avl3DGaxH4/pO8vpk1zzhO2AgT1HfELEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999223

Early PCI discovery creates the HDM cache, while later CXL enumeration and
decoder operations provide updated programming state.

Refresh the PCI snapshot when decoders are enumerated, committed, or reset
so reset recovery need not walk the CXL topology. Ignore updates when no
cache exists and reject decoder-count mismatches.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      | 22 ++++++++++++++
 include/linux/pci.h    |  6 ++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 98268e8e15b2..0ae250ea4ce3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -753,6 +753,51 @@ static void cxl_decoder_snapshot(struct cxl_decoder *cxld,
 	}
 }
 
+#ifdef CONFIG_CXL_RESET
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = cxlhdm->port;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
+	struct cxl_decoder_settings *settings;
+	struct cxl_hdm_info *info;
+
+	if (!pdev || !hdm)
+		return;
+
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	info = pdev->hdm;
+	if (!info)
+		return;
+	if (cxld->id < 0 || cxld->id >= info->decoder_count) {
+		pci_warn(pdev, "CXL HDM decoder %d exceeds cached count %d\n",
+			 cxld->id, info->decoder_count);
+		return;
+	}
+
+	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	settings = &info->settings[cxld->id];
+
+	/*
+	 * A disabled decoder's software object may retain its old range and
+	 * target state. Leave only the decoder id in the cached settings so stale
+	 * state is not restored as an enabled decode.
+	 */
+	*settings = (struct cxl_decoder_settings) {
+		.config.id = cxld->id,
+	};
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		cxl_decoder_snapshot(cxld, settings);
+}
+#else
+static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
+				    struct cxl_decoder *cxld)
+{
+}
+#endif
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -804,6 +849,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	return 0;
 }
@@ -876,6 +922,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxl_hdm_refresh_decoder(cxlhdm, cxld);
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -1089,9 +1136,27 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
+#ifdef CONFIG_CXL_RESET
+	struct pci_dev *pdev __free(pci_dev_put) =
+		cxl_port_get_uport_pci_dev(port);
+#endif
 	int i;
 	u64 dpa_base = 0;
 
+#ifdef CONFIG_CXL_RESET
+	if (is_cxl_endpoint(port) && pdev && hdm) {
+		guard(rwsem_read)(&cxl_rwsem.dpa);
+
+		if (pdev->hdm &&
+		    pdev->hdm->decoder_count != cxlhdm->decoder_count) {
+			pci_warn(pdev,
+				 "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
+				 pdev->hdm->decoder_count, cxlhdm->decoder_count);
+			return -ENXIO;
+		}
+	}
+#endif
+
 	cxl_settle_decoders(cxlhdm);
 
 	for (i = 0; i < cxlhdm->decoder_count; i++) {
@@ -1130,6 +1195,7 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 			put_device(&cxld->dev);
 			return rc;
 		}
+		cxl_hdm_refresh_decoder(cxlhdm, cxld);
 		rc = add_hdm_decoder(port, cxld);
 		if (rc) {
 			dev_warn(&port->dev,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1acdf537e4e9..005259e38f4b 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -77,6 +77,28 @@ struct cxl_decoder_settings {
 	u64 target_or_skip_reg_val;
 };
 
+/**
+ * struct cxl_hdm_info - cached CXL HDM state for a PCI device
+ * @decoder_count: number of entries in @settings
+ * @hdm_bar: PCI BAR containing the HDM decoder capability
+ * @hdm_offset: offset of the HDM decoder capability in @hdm_bar
+ * @hdm_size: size of the HDM decoder register block
+ * @global_ctrl: HDM decoder global control register
+ * @dvsec_ctrl: CXL DVSEC control register
+ * @dvsec_ctrl_valid: whether @dvsec_ctrl contains valid state
+ * @settings: per-decoder programming state
+ */
+struct cxl_hdm_info {
+	int decoder_count;
+	int hdm_bar;
+	resource_size_t hdm_offset;
+	resource_size_t hdm_size;
+	u32 global_ctrl;
+	u16 dvsec_ctrl;
+	bool dvsec_ctrl_valid;
+	struct cxl_decoder_settings settings[];
+};
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..7bb37fcb556d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_CXL_RESET
+struct cxl_hdm_info;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -566,6 +569,9 @@ struct pci_dev {
 #ifdef CONFIG_PCI_DOE
 	struct xarray	doe_mbs;	/* Data Object Exchange mailboxes */
 #endif
+#ifdef CONFIG_CXL_RESET
+	struct cxl_hdm_info *hdm;	/* CXL HDM decoder state */
+#endif
 #ifdef CONFIG_PCI_NPEM
 	struct npem	*npem;		/* Native PCIe Enclosure Management */
 #endif
-- 
2.43.0

