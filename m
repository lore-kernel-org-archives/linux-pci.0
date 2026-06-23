Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E652328611;
	Tue, 23 Jun 2026 03:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185131; cv=fail; b=t36zuceeqzPpUEZPVgkXk+5XzHgTGQBQsnb81MN1o2eFK8Ed6U6TvafWRtZwiq8R68s9QfUmuVbROKTc8hIBrtJrzXZ7ljc+YD4bo1yjCPoVJnbwBMiSXB+DpwOj7hpwRFKk9sge9LL5nrVtsxG0/NCMHkwSgbmjrphvGpdmJjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185131; c=relaxed/simple;
	bh=VV6IpK7swUS9qE/AuB2nZAZO/vaCmuWX/w5sAQoOEQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MteqdPeKFgNvV3lp2OkjPxpqlEOfweN0xzIEcm+GK6KlW7SkudDcGFSSwY2Y78aszV/KdAvzcLDxq3y2L+UanmZ8OdxeWgciYt7owEAI0yKRb7m2OS7jw8ehFiHDxvHAD4zlWcPojiYJI/+EWfSRpQnho7XHilLw9qRtLYvIw9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkCmHMkj; arc=fail smtp.client-ip=40.107.209.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkCmHMkj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT4fnlDv2f6h31hLq6URVuiyilUZ8RBPXBglk60QoBv5k/R5XYoRU/Y7ZWnhoDgf0DfdYFeDuhTKnBZsTPf5GvTHeJpNYvo0UmP1gXMH1yfm1WB2X+jfTDapEDa54Khq7WK1Q74EWvO2DdgqDrPBkgum/nXSj2ksMr8FshxHJtq5u5gF7FbQr7C+HFYD2amJdJV0GA2XflLSvW8AvQNgSr2Ju3C0vRAkjZOca6t8HjQ+SVMi3lKabQM7IlNnZYwE4ObQa/SscagnmcpBCr7VMKy5ZXIW24f6vj5oqJRfjhy64KQFAALANjrhoPuGvvLFLFW7uNTMfQAw3MUCG1HN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJOmp/+srub3g7AK6Oi9pBJlJWuPtF1gnOU7JV8sQRU=;
 b=KNMP+tAv2+4UxwBySiN5tbTTXmR7/n+eonGGyKE5iP589vHEHiTXoG4RA009v1fcaU94vTzd30otVWSntKkU3wSb4e/GwCKMgp1s0GMhoG9bjqIJDXmP1olwH4cBW3O2FViT3OgnwyMe6kgCVhWJXDHpRrjEFywnHS9sCaWgwDbbMybyxa95RfsSCo/43typff6Kzj4nmZ/Ehihujm1ooYLci3ObAvVhI8xUCxmSS5hInW0MqXDzGj4qwzV+0WdcBCDOyePBAFU5x25sFh9bXnvv7Rm4Ut1uz1dM9ElUwiRydJNNHwCgRairKWAHAINo0gSGD62xSWBulJV6oKl7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJOmp/+srub3g7AK6Oi9pBJlJWuPtF1gnOU7JV8sQRU=;
 b=VkCmHMkjXcHSzq8MyRz1H/44LFh/NCbbfy4hrDKGiQje6VvM7cO+qg2ftjmICVXudVgpJRnUJfz1It7ds+DzzpzAnS1NLtVp7GG2pGbuCX7JnnJpZSTUaVEsAcJZVXrlnYPuFHUS33FmQIGouo1cgnv60CvmEwFsQtxuVSdLMcb+hm5HpKwCGczz7NgrUjLEybIbLuAjZ8eLx8RKnutSc1bK6whoVaNeMod4o/km+SnlTxsgOj2JbIxyLM/OFnHoyof6liyuNV28cHl80gSLXnVsJbHleof/s13iiMVbEuENbZ5q5uPmTBX8vJlFkVi7eRdko6vQxSfGbw+MIBhaOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 03:25:18 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 03:25:18 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Dan Williams <danwilliams@nvidia.com>,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v7 09/11] cxl: Restore CXL HDM state after PCI reset
Date: Tue, 23 Jun 2026 03:24:51 +0000
Message-ID: <20260623032453.3404772-10-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623032453.3404772-1-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: d02caad1-b0e7-4671-091c-08ded0d70cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	47D2PJ7lKdm1xexagGS6b130hYw+5G97iDfYPlCVKZ/uU58bGHLVWL8Ej9D1bGgWuZdUBrlVl7qwrHFLWaxN75PtvQjjjNg6YcoGfQtaxwFdkVBbTOqr6tcmVHT+RDgdYXAu8b8zsutrAdu/7EPN0VVYwHu4kaLWnbKXMCTg8umZ6I6rskzZNpA7fok8ew75mRQSv/bpivCt+Llu2oWbTBPvjYgssvX/ve+YxSq0WK2zlNRENsz8dmK9eMdcEReS/n5oVbuHO9WGYnD+lxe/yKpel3UYxN4KY5C2+SaLwZF+lW5pTBhbeH/ZTUnYUSj8/mcEHvwCk07Ph9dpu9b+bOfydCPpfz5kLazoyfNQh3ZPoP3TqxCJJxqBs2Re6Q0x48iotLxNPXtGHl9VnKsieymYh59wm5wIGi14m/Ib3nEiS1z+WcvmRip4ftY60b/aj9SGS4NlP8SA4VugEHpp3EUOOlDmrIBlQ6eVeW3HF6k9VJRLBnmd/+dteo+SKNaYE2/u5Z/8c9vRySiiDsvgXEWShtxoeaseNaJROUazGJ32gn6BIoo4XuNQWrCFo/+EaRyGchgha0RcPJD0vCy6f6O2ShluQl+f3tCbn6Zc0fTQMHRyOZziWNhVpjuwePUud8M+WYoTXzlpMfW0MuoyTNruZwHqCbKtZ7bDEFydAUWrC1ZePAWedkDV+oXpOOhaCTMZzUtgB6Co3ZJYC95iUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HUShIrY2xmoyOAr4kNLR9aRLd5q8ZOtlOIoBuPjxWt+7EaLyW+PFtamgUUIC?=
 =?us-ascii?Q?63kpaY3P+ENrqMtE5CWjOz9EtaQLeyMD8dvTL3p1v2ldCW9aanUKDLWZGXHF?=
 =?us-ascii?Q?hef22VmNHml7W4jymsBTBL1c+3nwAdOyJmaGmhW3HwgrK5qKbQhlaffVDDku?=
 =?us-ascii?Q?yIt68YYG0AFaPU6fuB5DRxjXclxHAwvDbDca/wAn8ZzNwQwN0AfgUS/CyT4w?=
 =?us-ascii?Q?iY6W2Bxu0lTPjmpTlgHXsWwwntcQsXJ2MiUkohMpYX4YQmi1wI0OJsc72GoK?=
 =?us-ascii?Q?Rv8cQrJJdnZMn649J0j1s4TxG167/rx6O3lv0VkQr9LnkA7uGDxU1sh7V9RI?=
 =?us-ascii?Q?FmWEZlDFXX4m/u2pSoHyLhFOBisJaYmjvJwpIfiQ8pXCPkm8BGGILccwXBIi?=
 =?us-ascii?Q?D30132l0IEV4c9NFW6001wMpCuEQAAYjTg7ilG6Rzs/Axy3V3Fd2nf8adMja?=
 =?us-ascii?Q?3imk76HartPUoBoAnkevAxcxLsB+TIURhk1MCeRUGiwz4UoZLWuJbi9P5IZ5?=
 =?us-ascii?Q?bU6TdNPQiZbfh/SBWrUx/w/2TmCNrCUK3D5ZS8N31zau7q5QAIfylCclmPBb?=
 =?us-ascii?Q?eWOG+mJ+Onws95jPp62jpDO1gZ7e1/bz85QIinOEcBOrZ1oMQUPXxxhZMRbv?=
 =?us-ascii?Q?HqbhNGqJ8MrswBM9CqiWFfCqpfZFiTwDZGsU9stHc5sAqJTHa3Jb0XJGoKPN?=
 =?us-ascii?Q?wQf/XwULuKMX9GU5KOJU5NOQ/xKtP1vpgRBc8jZ+8q8qCAApYMAE+dwThqo1?=
 =?us-ascii?Q?ZWoV242JJ7XIHGzGKgXp9JtQhxG0NXabtApaVdvBBayq3jG8t2yFHEZuoVxF?=
 =?us-ascii?Q?BdnhDFVHBUpqyolW1D409GN/+bu3t/H8SvUZg3raEvtKLHp7tRFt0wxymgLp?=
 =?us-ascii?Q?CI8sPecl4bunfruU38HM0wvBO1vDnVzWJMkJuox1UYHXKcnC+jchhh1NOWQJ?=
 =?us-ascii?Q?+0XwLRCZFgzXuW/wO1w2GBlK0iF0Cg+f/SDH/sCYwYH9WxVopvEcVt9yAHfW?=
 =?us-ascii?Q?2zNPq4Ka1oAYqVkYDd4jqxNoDe2W4/BjOkvpeZ/C56cszj8ssW0wVAG6xShV?=
 =?us-ascii?Q?9TawHCK+t07IICrpNUQ5kRcnDeAc+rX4iZtAgHqi6JqlAEcAN2wmK6jnWoz6?=
 =?us-ascii?Q?kgKqrgs4McDkk8cve/g6PhxkCTYJzSJ+16870I2nZv3EseskL/2OI/s4uXUu?=
 =?us-ascii?Q?o//HUftD8Nv8bCYuZXDyjSkobrzXP2KE4uCetOy7LmFlFjR3P8gVWwzskeTb?=
 =?us-ascii?Q?WURrUTiXQdLYMEE0bqKyseQ8G92EgJ5PxyBljAQ2aN0AsaKH+wkqPd8RNAM5?=
 =?us-ascii?Q?UXUpZQFKIicWFHRyZd1HOy+d8k4HJwBciV12V3gPC3z9RdOPvdp00utDBpe0?=
 =?us-ascii?Q?TQ3k013EyD6pkM37DE26fZgcbfj2zt9r011C9/t8Txgf+PA6KwGdyFtBnsgz?=
 =?us-ascii?Q?X9KlNQsvkWE9rGgBdw4gqF37LwCRdt3Ke7oLzXVIsIfHtX61zMCcIfiY4ukB?=
 =?us-ascii?Q?p7VdRAyldpVB+0+mgCyc2A+VfcIIVDJf05GOOwxJQDgI8JuNufw66sInMhyY?=
 =?us-ascii?Q?Q7QzqflQ6N83AQ0bUkO+ltBOx2ZtiXV8HEgix4veV+Oe3LNFqS12CNGgl3BC?=
 =?us-ascii?Q?/kepM65FnMi5UC4JZasHaa+7wnWPXiGQ69V5s38IT9vml895Xle6W8FTXHWH?=
 =?us-ascii?Q?rxi3qdw2p+FsBKVeWySzTSrfSTgHWpX3nEAtXBAJnZ+GG59TLV6H+dJq4o65?=
 =?us-ascii?Q?iH52RLvZ2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d02caad1-b0e7-4671-091c-08ded0d70cda
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:25:18.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iykrmx2R1QCgFiMcLZnB6JGNMEKZfwCAl19xs7rkN317Y3/WD9fOlU+MX6VxjDbKnOGZ1GBjQCnN1IvhjHzAHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

After CXL reset, restore PCI config state enough to reach HDM MMIO,
restore cached global and per-decoder HDM state, and then run the normal
PCI restore callbacks.

Keep target and sibling IOMMU reset blocks active until HDM restore
completes so Bus Master Enable cannot reopen DMA before decoder state is
valid.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/hdm.c   |   4 +
 drivers/cxl/core/reset.c | 195 ++++++++++++++++++++++++++++++++++++---
 include/cxl/cxl.h        |   2 +
 3 files changed, 190 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0230ebfada42..095cc13e5d00 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -152,6 +152,10 @@ static void cxl_hdm_info_set_decoder(struct cxl_hdm *cxlhdm,
 	if (!info || cxld->id >= info->decoder_count)
 		return;
 
+	if (cxlhdm->regs.hdm_decoder)
+		info->global_ctrl = readl(cxlhdm->regs.hdm_decoder +
+					  CXL_HDM_DECODER_CTRL_OFFSET);
+
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		info->settings[cxld->id] = cxld->settings;
 	else
diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
index 69bcfab89858..d801c91a5cbf 100644
--- a/drivers/cxl/core/reset.c
+++ b/drivers/cxl/core/reset.c
@@ -83,6 +83,21 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static int cxld_await_uncommit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static void setup_hw_decoder(struct cxl_decoder_settings *settings,
 			     void __iomem *hdm)
 {
@@ -92,6 +107,8 @@ static void setup_hw_decoder(struct cxl_decoder_settings *settings,
 	u32 ctrl;
 
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	ctrl &= ~(CXL_HDM_DECODER0_CTRL_COMMIT |
+		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
 	cxld_set_interleave(settings, &ctrl);
 	cxld_set_type(settings, &ctrl);
 	base = settings->hpa_range.start;
@@ -300,6 +317,8 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
 
 	info->decoder_count = decoder_count;
 	info->regs = regs;
+	info->global_ctrl = readl(regs.hdm_decoder +
+				  CXL_HDM_DECODER_CTRL_OFFSET);
 
 	settings = info->settings;
 	for (int i = 0; i < info->decoder_count; i++) {
@@ -324,6 +343,100 @@ int pci_cxl_hdm_init(struct pci_dev *pdev)
 	return rc;
 }
 
+static int cxl_hdm_decoder_uncommit(struct pci_dev *pdev, void __iomem *hdm,
+				    int id, bool *locked_committed)
+{
+	u32 ctrl;
+	int rc;
+
+	*locked_committed = false;
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK) {
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+			pci_dbg(pdev,
+				"CXL HDM decoder %d retained locked committed state\n",
+				id);
+			*locked_committed = true;
+			return 0;
+		}
+
+		pci_err(pdev, "CXL HDM decoder %d is locked\n", id);
+		return -EBUSY;
+	}
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		return 0;
+
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	rc = cxld_await_uncommit(hdm, id);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d uncommit failed: %d\n",
+			id, rc);
+
+	return rc;
+}
+
+static int cxl_restore_hdm_decoder(struct pci_dev *pdev,
+				   struct cxl_decoder_settings *settings,
+				   void __iomem *hdm)
+{
+	bool locked_committed;
+	int rc;
+
+	if (!(settings->flags & CXL_DECODER_F_ENABLE))
+		return 0;
+
+	rc = cxl_hdm_decoder_uncommit(pdev, hdm, settings->id,
+				      &locked_committed);
+	if (rc)
+		return rc;
+	if (locked_committed)
+		return 0;
+
+	rc = cxl_commit(settings, hdm);
+	if (rc)
+		pci_err(pdev, "CXL HDM decoder %d restore failed: %d\n",
+			settings->id, rc);
+
+	return rc;
+}
+
+static int cxl_restore_hdm(struct pci_dev *pdev)
+{
+	struct cxl_hdm_info *info = READ_ONCE(pdev->hdm);
+	void __iomem *hdm;
+	int first_rc = 0;
+
+	if (!info)
+		return 0;
+
+	hdm = info->regs.hdm_decoder;
+	if (!hdm) {
+		pci_err(pdev, "CXL HDM decoder registers unavailable\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Restore global HDM control before per-decoder commit. PCI config
+	 * state has been restored for MMIO access, but IOMMU reset blocks
+	 * remain active until HDM restore completes.
+	 */
+	writel(info->global_ctrl, hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	for (int i = 0; i < info->decoder_count; i++) {
+		struct cxl_decoder_settings *settings = &info->settings[i];
+		int rc;
+
+		rc = cxl_restore_hdm_decoder(pdev, settings, hdm);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	return first_rc;
+}
+
 /*
  * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
  * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
@@ -355,6 +468,7 @@ struct cxl_reset_context {
 	int nr_siblings;
 	int nr_siblings_locked;
 	int nr_siblings_prepared;
+	bool target_prepared;
 	int sibling_capacity;
 };
 
@@ -609,6 +723,68 @@ static int cxl_pci_functions_reset_prepare(struct cxl_reset_context *ctx)
 	return 0;
 }
 
+static void cxl_pci_target_reset_done(struct cxl_reset_context *ctx)
+{
+	if (!ctx->target_prepared)
+		return;
+
+	pci_dev_reset_iommu_done(ctx->target);
+	ctx->target_prepared = false;
+}
+
+static int cxl_pci_target_reset_prepare(struct cxl_reset_context *ctx)
+{
+	struct pci_dev *pdev = ctx->target;
+	int rc;
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	ctx->target_prepared = true;
+	return 0;
+}
+
+static void cxl_pci_functions_restore_state(struct cxl_reset_context *ctx)
+{
+	/*
+	 * Restore PCI config state first so HDM MMIO is reachable. The final
+	 * pci_dev_restore() pass deliberately replays pci_restore_state()
+	 * before invoking driver reset_done() callbacks.
+	 */
+	pci_restore_state(ctx->target);
+
+	for (int i = 0; i < ctx->nr_siblings_prepared; i++)
+		pci_restore_state(ctx->siblings[i].pdev);
+}
+
+static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
+{
+	int first_rc = 0;
+	int rc;
+
+	cxl_pci_functions_restore_state(ctx);
+
+	rc = cxl_restore_hdm(ctx->target);
+	if (rc && !first_rc)
+		first_rc = rc;
+
+	for (int i = 0; i < ctx->nr_siblings_prepared; i++) {
+		struct pci_dev *sibling = ctx->siblings[i].pdev;
+
+		rc = cxl_restore_hdm(sibling);
+		if (rc && !first_rc)
+			first_rc = rc;
+	}
+
+	return first_rc;
+}
+
 static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
 {
 	INIT_LIST_HEAD(&ctx->ranges);
@@ -985,18 +1161,9 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 	if (rc)
 		return pcibios_err_to_errno(rc);
 
-	if (!pci_wait_for_pending_transaction(pdev))
-		pci_err(pdev, "timed out waiting for pending transactions\n");
-
-	rc = pci_dev_reset_iommu_prepare(pdev);
-	if (rc) {
-		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
-		return rc;
-	}
-
 	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
 	if (rc)
-		goto out;
+		return rc;
 	cache_disabled = true;
 
 	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
@@ -1020,7 +1187,6 @@ static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
 			rc = rc2;
 	}
 
-	pci_dev_reset_iommu_done(pdev);
 	return rc;
 }
 
@@ -1053,12 +1219,19 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
 	if (rc)
 		goto out_functions_done;
 
+	rc = cxl_pci_target_reset_prepare(&ctx);
+	if (rc)
+		goto out_functions_done;
+
 	scoped_guard(rwsem_write, &cxl_rwsem.region) {
 		rc = cxl_hdm_ranges_prepare(&range_ctx, &ctx);
 		if (!rc)
 			rc = cxl_reset_execute(pdev, dvsec);
+		if (!rc)
+			rc = cxl_restore_hdm_decoders(&ctx);
 	}
 
+	cxl_pci_target_reset_done(&ctx);
 out_functions_done:
 	cxl_pci_functions_reset_done(&ctx);
 out_unlock:
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1fe606f15733..eddc48f1fa49 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -127,11 +127,13 @@ struct cxl_regs {
  * struct cxl_hdm_info - PCI device HDM decoder programming cache
  * @decoder_count: number of decoder settings entries
  * @regs: mapped CXL component registers for this HDM decoder block
+ * @global_ctrl: cached HDM decoder global control register
  * @settings: cached per-decoder programming state
  */
 struct cxl_hdm_info {
 	int decoder_count;
 	struct cxl_component_regs regs;
+	u32 global_ctrl;
 	struct cxl_decoder_settings settings[] __counted_by(decoder_count);
 };
 
-- 
2.43.0

