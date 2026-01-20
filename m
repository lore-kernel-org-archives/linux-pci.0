Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD82E7162;
	Tue, 20 Jan 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948058; cv=fail; b=PpbvgHskjRswqgbaVxqKYnrolqidCkGrdA5L1YtJcvgHrJpMysyiOAxb6XuD72ri0A2ATTFKJDIeftU4f0M/61kudG2dfiBtB+t/8c9y/Ojtix6PW9nLiWmqRfEQCeNpgyDRaNmtYkoWgrWwlSAdRtv+5CMQTn2id5K0MElNVu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948058; c=relaxed/simple;
	bh=u7SfxMf/IQc7J4/80qK74Hw1Gr/RvbhfnEopq/SMYR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoqnkJlhxhkEq62Msnpau286nmcc3fZPbWUUxNIOc3CKh7Th2CNYd+2FqLcy244WzYScgX26voOFwkRRHQqYBYRbJp5FnraVdlsxpEPZd7Q7xs7dZ0/XZZeccJRM5eON0xLcVONtBmQCrYKykEKTrTxbTZ3c9fwVtq4rXnjWHEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YqntpdQV; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YqntpdQV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwKbTVTYYGwI31o3Hff6ud4CaPjbFrt9RYGLWlz4/uGx1KJzXWdvBrxAy6fuD74Qp3DQKbMupAbHtCwxz808+4xaGiwFn49EsSOhhVbSWK2AtqgfGZ2RMjYU426eFpZhLY9oDIgztj3mXoxY81jcUw0rF0OtEFoIFpo1MzC4WFLvDXlz/o7rQalJkLWr1aP8nImOXdVbILZdmZAj5AkmcCN50zhxu3iHdM1iegfg82Gj1YrDO4v4wuzvpi8PvwdGcCQfrlfqm3+UMeKpRvg2tDE73Yo5JaLWXi5axv2P7Q+izlp3YaQbZ48umbfDhJSaPDOzkoaqAC/AudGbDIDjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfEwrrN/JZK8V9LZ9TcOph5XZzU44/rMyCe33Vujhfw=;
 b=bVeEzSg5Sv4q9pqW77lj5sRLT+Fwr6DQRybJw+nxnfobM9t6bnkt5bAK27xZU3dKfu5vD6oLtySq4bPSBBSsX9XI3W1FiFhGp7fK1IXWc3RY19QW3C6JI/cZWxLvNr7TrNV9tYw1oGmO8Yp5CH6Q6fW8o23fz3khSxJAKtD2UMiZtlAcmgxgla3CURWGm1RP0K4sorqHSZbpFdXBZN0bvRrG2i7zXMobeg7etQ54aNnI3k/yqpTfurtTmuYaD7kBkhjZCvs8EYCUAEFMYpLNou0emkzOUFNC1ns3mkTnyEx6Qe5+KQTDj3UOr9ALUJcWsBVgVghp4bucpBYHSK9RTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfEwrrN/JZK8V9LZ9TcOph5XZzU44/rMyCe33Vujhfw=;
 b=YqntpdQVKOPqpCWTSKjXyFxburaS8NGkJW2xyY3orICWxehQ/OK/sOrZQ3IpkeZ2zXOKXfHCdNwRAhoB24yQ6g3yKKBCEB8apczk1++FMLHPntvDv5shE4cJk1xUCvSOLoi2P5ihYq+Wu/e8g85K1nrnd8G5zF3nL0U+GZTUf7zxPZsFV2QiydvtakiVZYX3bCuZeNUMC41qq0pnm1hgEJQm897IOGeky/uXJmxqjc4uf/3OIUgr4+fjvmsbI/yNUEkhCRu5CWloGzGuqK4GTrl6EGPF0eptoNGizeo1RPX9JCvGKUNONehX1HR1Wt2V3rte83XYFHUZxQE58XDuaA==
Received: from PH8PR02CA0051.namprd02.prod.outlook.com (2603:10b6:510:2da::21)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 22:27:11 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:2da:cafe::ce) by PH8PR02CA0051.outlook.office365.com
 (2603:10b6:510:2da::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 22:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 22:27:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 14:26:43 -0800
Received: from build-smadhavan-jammy-20251112.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 20 Jan 2026 14:26:42 -0800
From: <smadhavan@nvidia.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: <smadhavan@nvidia.com>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>
Subject: [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore
Date: Tue, 20 Jan 2026 22:26:10 +0000
Message-ID: <20260120222610.2227109-11-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cea009-a64e-492e-0988-08de58730df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sR/ptOFfaDK2cXBLC9g1wyr65NGz28kF7EwLjGCbhxFSG15CxYL10SXtid+Z?=
 =?us-ascii?Q?qYNngUp0CFrGXz2sVVZlW6czOuGYa62lb4OzY96kqecz65GyzMGw7VyuCha5?=
 =?us-ascii?Q?8ftcft/nBizXJQMjKeu3F5y2U6rxULVAMCQwD0lJuzjDEA12DbO5hdHTzILZ?=
 =?us-ascii?Q?75zawsHbXOYDcsQf8t4355qiO9UPcx9nKzglLq1cACRtx1C3e1ExWexdbyle?=
 =?us-ascii?Q?y3f4+WMNH9I6hxI4u8ZNZ4+YseZjcqzDlvo4cycjlAW7rQlyaVnZfX+eQO86?=
 =?us-ascii?Q?/wzVbMXaZN1fwN/OUMxsBwAH55fiCb3yxT6VbyULd+kel+0Psjo4djjuwOnE?=
 =?us-ascii?Q?++XBXMlu0aCguU3bGJg8jfRDrQMGPmJ8MyXS7MCtiXBTHIB1bZ0dkGdjGYr1?=
 =?us-ascii?Q?hhldCxrNIOf0qa4njz9q3NtTMllK3+97J8xRCgeoRnyo/JVj709hBVOKH1Rp?=
 =?us-ascii?Q?DBx56IcmdPhkdksngNmPAFfNWe0FK+JwqW926TQGLv1UxqnNh4mh5Uyfda0h?=
 =?us-ascii?Q?LRNFWeWC0YycGwSWpsFfZxmcjKZ7SOZ+U6CYj/7L8EHLdHSc1yk6pK57Kp2S?=
 =?us-ascii?Q?Iw8ThgifKuE28fl9nhNUdEeoxAiHU9RLrzet6TT1PI2NR0kobWdZYQiu8rf5?=
 =?us-ascii?Q?IEjWOYO8Vk/hQB6AJEn3OOUltIVeQNaV0xn9pzIECv/Gyq+fd3k+qIdztDoy?=
 =?us-ascii?Q?VyxSef1rT+PIHVMhTTCVG3MZqkPTN6+DuzUq2GMW8tc7SEOcsh2akozNc9aF?=
 =?us-ascii?Q?RjPe9QENhk620cg5U0/2fwIIALEStbiFWa8JFfbzdqoCUFwRXaP1mNb9Rran?=
 =?us-ascii?Q?YNmbaBStGspbR9e9xrD5vzNgR1aEUryms4lH1IIgoO582rNDGwYkIg0mKfxM?=
 =?us-ascii?Q?k4SgpSQps12xDQZcedrC5Ai4qsGtWInxn4nr2X3q9N/14BDJ7zUUQ0F9U1iQ?=
 =?us-ascii?Q?i9rkNmU6KAdZ0bsc3bTE9I+yWaPbFRU4UL2xSoaUKnCRmHm6XV/Dg11F3kKD?=
 =?us-ascii?Q?S54NncDL1sRmGUbEqmps5WeLOTjnJuv6zsZnfkbAhx/wkkE8qvi38Cj3rP6N?=
 =?us-ascii?Q?4S4LQ/esMFkZp7LMzo+9yUadCHCPLETLWpUVw0OCH7XN5xkoI5JRYlVq24JM?=
 =?us-ascii?Q?BJb1HUWbnCQg8xVZufpjYF1GmIXvImyqe1JrWbH2ioPm5lBVlROCfhPvdm7I?=
 =?us-ascii?Q?VivQGPDVG/eV7XZ4436FfUnWZh9+DC1imWokwv5zVflX4Ts1Er6pFRuy0JbL?=
 =?us-ascii?Q?L7SM8rht0sg5OHJLNeh1e44BFqdY2TvNurFzi7kOuSVDb318i8At0CjC/4/K?=
 =?us-ascii?Q?H5LPVfWbO0STw3Qh9SpAvqW6nbCRcOoVPek5J8LTwudeDSA/8iwcLxSnbPLP?=
 =?us-ascii?Q?uIeTlD2pp2kwYXsH2MMKjN2VP2wVB5gpHXlcETRV6E7OsirXxA+5tbwASfhn?=
 =?us-ascii?Q?2T809t8qufqT5bgYA0IodzXLMuikEehKEfqnuMCm09gZMzOLGHykN9c8MuIy?=
 =?us-ascii?Q?CDxosDJ4J2s+RYTLjH8o69fDY7lB5wvRFtk/Ax4z7w9YdlYZKEYjNWpsh0E9?=
 =?us-ascii?Q?GxzGJqF404Sxq7EDgGaYnaeDTESjHK41Yjxjo0XxMaeh/xG3ABiK0AO6gbWn?=
 =?us-ascii?Q?I88G7E0MkykO+/0iDavb1hCu04vhaJ6efmbCMGdXMXiU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 22:27:11.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cea009-a64e-492e-0988-08de58730df8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

From: Srirangan Madhavan <smadhavan@nvidia.com>

Extend state save/restore to HDM decoder and IDE registers for Type 2
devices. The HDM/IDE blocks are located via the component register map,
then preserved across reset to retain decoder configuration and IDE
policy. This avoids losing HDM/IDE programming when cxl_reset is issued.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/cxl/core/regs.c |   7 ++
 drivers/cxl/cxl.h       |   4 ++
 drivers/cxl/pci.c       | 153 ++++++++++++++++++++++++++++++++++++++--
 include/cxl/pci.h       |  43 +++++++++++
 4 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ecdb22ae6952..76d6869d82ea 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -93,6 +93,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_IDE:
+			dev_dbg(dev, "found IDE capability (0x%x)\n",
+				offset);
+			length = CXL_IDE_CAPABILITY_LENGTH;
+			rmap = &map->ide;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -212,6 +218,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.ide, &regs->ide },
 	};
 	int i;

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..a7a6b79755b3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -39,8 +39,10 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)

 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
+#define   CXL_CM_CAP_CAP_ID_IDE 0x4
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
+#define   CXL_IDE_CAPABILITY_LENGTH 0x20

 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
@@ -214,6 +216,7 @@ struct cxl_regs {
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *ide;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -256,6 +259,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map ide;
 };

 struct cxl_device_reg_map {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7d6a0ef70b2d..eb735d0ae175 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -956,7 +956,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");

 	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
-				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+				    BIT(CXL_CM_CAP_CAP_ID_RAS) |
+				    BIT(CXL_CM_CAP_CAP_ID_IDE));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");

@@ -1203,18 +1204,126 @@ static int cxl_restore_dvsec_state(struct pci_dev *pdev,
 	return rc;
 }

+/*
+ * CXL HDM Decoder register save/restore
+ */
+static int cxl_save_hdm_state(struct cxl_dev_state *cxlds,
+			      struct cxl_type2_saved_state *state)
+{
+	void __iomem *hdm = cxlds->regs.hdm_decoder;
+	u32 cap, ctrl;
+	int i, count;
+
+	if (!hdm)
+		return 0;
+
+	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
+	count = cap & CXL_HDM_DECODER_COUNT_MASK;
+	count = min(count, CXL_MAX_DECODERS);
+
+	state->hdm_decoder_count = count;
+	state->hdm_global_ctrl = readl(hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
+
+	for (i = 0; i < count; i++) {
+		struct cxl_hdm_decoder_state *d = &state->decoders[i];
+		u32 base_low, base_high, size_low, size_high;
+		u32 dpa_skip_low, dpa_skip_high;
+
+		base_low = readl(hdm + CXL_HDM_DECODER_BASE_LOW(i));
+		base_high = readl(hdm + CXL_HDM_DECODER_BASE_HIGH(i));
+		size_low = readl(hdm + CXL_HDM_DECODER_SIZE_LOW(i));
+		size_high = readl(hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
+		ctrl = readl(hdm + CXL_HDM_DECODER_CTRL(i));
+		dpa_skip_low = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
+		dpa_skip_high = readl(hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
+
+		d->base = ((u64)base_high << 32) | base_low;
+		d->size = ((u64)size_high << 32) | size_low;
+		d->ctrl = ctrl;
+		d->dpa_skip = ((u64)dpa_skip_high << 32) | dpa_skip_low;
+		d->enabled = !!(ctrl & CXL_HDM_DECODER_ENABLE);
+	}
+
+	return 0;
+}
+
+static int cxl_restore_hdm_state(struct cxl_dev_state *cxlds,
+				 const struct cxl_type2_saved_state *state)
+{
+	void __iomem *hdm = cxlds->regs.hdm_decoder;
+	int i;
+
+	if (!hdm || state->hdm_decoder_count == 0)
+		return 0;
+
+	writel(state->hdm_global_ctrl, hdm + CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET);
+
+	for (i = 0; i < state->hdm_decoder_count; i++) {
+		const struct cxl_hdm_decoder_state *d = &state->decoders[i];
+
+		writel((u32)d->base, hdm + CXL_HDM_DECODER_BASE_LOW(i));
+		writel((u32)(d->base >> 32), hdm + CXL_HDM_DECODER_BASE_HIGH(i));
+		writel((u32)d->size, hdm + CXL_HDM_DECODER_SIZE_LOW(i));
+		writel((u32)(d->size >> 32), hdm + CXL_HDM_DECODER_SIZE_HIGH(i));
+		writel(d->ctrl, hdm + CXL_HDM_DECODER_CTRL(i));
+		writel((u32)d->dpa_skip, hdm + CXL_HDM_DECODER_DPA_SKIP_LOW(i));
+		writel((u32)(d->dpa_skip >> 32), hdm + CXL_HDM_DECODER_DPA_SKIP_HIGH(i));
+	}
+
+	return 0;
+}
+
+/*
+ * CXL IDE register save/restore
+ */
+static int cxl_save_ide_state(struct cxl_dev_state *cxlds,
+			      struct cxl_type2_saved_state *state)
+{
+	void __iomem *ide = cxlds->regs.ide;
+	u32 cap;
+
+	if (!ide)
+		return 0;
+
+	cap = readl(ide + CXL_IDE_CAP_OFFSET);
+	if (!(cap & CXL_IDE_CAP_CAPABLE))
+		return 0;
+
+	state->ide_cap = cap;
+	state->ide_ctrl = readl(ide + CXL_IDE_CTRL_OFFSET);
+	state->ide_key_refresh_time = readl(ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
+	state->ide_truncation_delay = readl(ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
+
+	return 0;
+}
+
+static int cxl_restore_ide_state(struct cxl_dev_state *cxlds,
+				 const struct cxl_type2_saved_state *state)
+{
+	void __iomem *ide = cxlds->regs.ide;
+
+	if (!ide || !(state->ide_cap & CXL_IDE_CAP_CAPABLE))
+		return 0;
+
+	writel(state->ide_ctrl, ide + CXL_IDE_CTRL_OFFSET);
+	writel(state->ide_key_refresh_time, ide + CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET);
+	writel(state->ide_truncation_delay, ide + CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET);
+
+	return 0;
+}
+
 /**
  * cxl_config_save_state - Save CXL configuration state
  * @pdev: PCI device
  * @state: Structure to store saved state
  *
- * Saves CXL DVSEC state before reset.
+ * Saves CXL DVSEC, HDM decoder, and IDE state before reset.
  */
 int cxl_config_save_state(struct pci_dev *pdev,
 			  struct cxl_type2_saved_state *state)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	int dvsec;
+	int rc, dvsec;

 	if (!cxlds || !state)
 		return -EINVAL;
@@ -1225,7 +1334,23 @@ int cxl_config_save_state(struct pci_dev *pdev,
 	if (!dvsec)
 		return -ENODEV;

-	return cxl_save_dvsec_state(pdev, state, dvsec);
+	rc = cxl_save_dvsec_state(pdev, state, dvsec);
+	if (rc)
+		return rc;
+
+	if (cxlds->regs.hdm_decoder) {
+		rc = cxl_save_hdm_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to save HDM state: %d\n", rc);
+	}
+
+	if (cxlds->regs.ide) {
+		rc = cxl_save_ide_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to save IDE state: %d\n", rc);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");

@@ -1234,7 +1359,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_config_save_state, "CXL");
  * @pdev: PCI device
  * @state: Previously saved state
  *
- * Restores CXL DVSEC state after reset.
+ * Restores CXL DVSEC, HDM decoder, and IDE state after reset.
  */
 int cxl_config_restore_state(struct pci_dev *pdev,
 			     const struct cxl_type2_saved_state *state)
@@ -1257,7 +1382,23 @@ int cxl_config_restore_state(struct pci_dev *pdev,

 	config_locked = !!(lock_reg & CXL_DVSEC_LOCK_CONFIG_LOCK);

-	return cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+	rc = cxl_restore_dvsec_state(pdev, state, dvsec, config_locked);
+	if (rc)
+		return rc;
+
+	if (cxlds->regs.hdm_decoder && state->hdm_decoder_count > 0) {
+		rc = cxl_restore_hdm_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to restore HDM state: %d\n", rc);
+	}
+
+	if (cxlds->regs.ide && (state->ide_cap & CXL_IDE_CAP_CAPABLE)) {
+		rc = cxl_restore_ide_state(cxlds, state);
+		if (rc)
+			pci_warn(pdev, "Failed to restore IDE state: %d\n", rc);
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_config_restore_state, "CXL");

diff --git a/include/cxl/pci.h b/include/cxl/pci.h
index 2c629ded73cc..9f2a9ad10d75 100644
--- a/include/cxl/pci.h
+++ b/include/cxl/pci.h
@@ -4,11 +4,33 @@
 #ifndef __CXL_ACCEL_PCI_H
 #define __CXL_ACCEL_PCI_H

+/* HDM Decoder state for save/restore */
+struct cxl_hdm_decoder_state {
+	u64 base;
+	u64 size;
+	u32 ctrl;
+	u64 dpa_skip;
+	bool enabled;
+};
+
+#define CXL_MAX_DECODERS 10
+
 /* CXL Type 2 device state for save/restore across reset */
 struct cxl_type2_saved_state {
 	/* DVSEC registers */
 	u16 dvsec_ctrl;
 	u16 dvsec_ctrl2;
+
+	/* HDM Decoder registers */
+	u32 hdm_decoder_count;
+	u32 hdm_global_ctrl;
+	struct cxl_hdm_decoder_state decoders[CXL_MAX_DECODERS];
+
+	/* IDE registers */
+	u32 ide_cap;
+	u32 ide_ctrl;
+	u32 ide_key_refresh_time;
+	u32 ide_truncation_delay;
 };

 int cxl_config_save_state(struct pci_dev *pdev,
@@ -58,6 +80,27 @@ int cxl_config_restore_state(struct pci_dev *pdev,

 #define CXL_DVSEC_RANGE_MAX		2

+/* CXL HDM Decoder Capability Structure (Section 8.2.4.20) */
+#define CXL_HDM_DECODER_CAP_OFFSET		0x0
+#define   CXL_HDM_DECODER_COUNT_MASK		GENMASK(3, 0)
+#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET	0x4
+#define   CXL_HDM_DECODER_ENABLE		BIT(1)
+/* CXL HDM Decoder n registers (Offset 20h*n + base) */
+#define CXL_HDM_DECODER_BASE_LOW(n)		(0x10 + ((n) * 0x20))
+#define CXL_HDM_DECODER_BASE_HIGH(n)		(0x14 + ((n) * 0x20))
+#define CXL_HDM_DECODER_SIZE_LOW(n)		(0x18 + ((n) * 0x20))
+#define CXL_HDM_DECODER_SIZE_HIGH(n)		(0x1C + ((n) * 0x20))
+#define CXL_HDM_DECODER_CTRL(n)			(0x20 + ((n) * 0x20))
+#define CXL_HDM_DECODER_DPA_SKIP_LOW(n)		(0x24 + ((n) * 0x20))
+#define CXL_HDM_DECODER_DPA_SKIP_HIGH(n)	(0x28 + ((n) * 0x20))
+
+/* CXL IDE Capability Structure (Section 8.2.4.22) */
+#define CXL_IDE_CAP_OFFSET			0x00
+#define   CXL_IDE_CAP_CAPABLE			BIT(0)
+#define CXL_IDE_CTRL_OFFSET			0x04
+#define CXL_IDE_KEY_REFRESH_TIME_CTRL_OFFSET	0x18
+#define CXL_IDE_TRUNCATION_DELAY_CTRL_OFFSET	0x1C
+
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2

--
2.34.1

