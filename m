Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB33254A0;
	Fri,  3 Jul 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051707; cv=fail; b=QZKO/0KEvMnlU7jGPf7e9CehQDrkf5/jzLGlo/JUZpvSpZKg4wwGqq69d38hVPJQ3/zO+xvTNkVAjXQj3w6Ej3jHCDO0ZznUApNXP89RHHV7LtNscFBOe9VGFIXtb3k3L5f7uxeWu969viZQCVtXyYU3ZJvgfoLEchhqvfDWckY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051707; c=relaxed/simple;
	bh=KBw1BKl7+FQtyXNMErj8eA7S2gYstfcF7W9L0ED4OZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEXQEubLhlF3tB5FTqs6QTVCS4iCY0ezrx73SpZOVbme/FgJLaW/5XXnnjtSkSX4Q/oPbQ8C2Fmpp/jNK37Qcwh2lagN/XWNMzQXWeOYOaQOlZTBzocIf97qdsbaogSYMch5+6o8c4Ww1i4CgXAv8tA5/3Imi7ZSxyH5JuHGVbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MEDc5RnK; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MEDc5RnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRGza2UcDC6dfXcOanCKI/v2nfVnXiCTpsodei2VMfAyGb0zH8LHlmAX+IjZU1VwXdXkW0k0N95Mdf9sczg/Glgxtsd7e1jxODhX1MsPJfqDxC5RicH46j19WQwDLkwR6sjT2b+GY6XAF62CSyGeZeNR3Q8g/I44RO4Q7MAieihTcCIApJFTa6V4JWoUmd8nVGXrHxpe1JJ8v39VQXk4wOKE75BcM+ptS+vPR7no++qcKHPyS1nplputOwLw4c/97BdEoYKM78Q1ZCzjkmZ4gbZKl9PiLDgUE5G5xZjLt8kjL3LIk0r4TtjkFEAF2CJpTkiJUT3EzCgvP4Gdy6CVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXgNeW4iwluYAelPvH+svWQLaqr3xugOur95JnzgsPA=;
 b=cnwsZ9dZNMxRGnjb0hg6aTlavHUsKU38qNkwQMjiYw92Q/EY4mU44zu4m0U3Tpf4vAjh/2NfQDlSAyZSU/91G8ftwvmIdfh+uSHvNmIgRoruym1R5LTeC5lTU5RPNrYLVg6N3FPDdRRQ3PtybEu7du8jhLkPockc6XOukKuNLUn/WCDAjsjJK0hajz9e4qukIM1VKwcOP/XDfQeYhzBV1L8Tlw72zP3/2fA+OiTrdHsSzXhecMK2cf/agurBXZnWEi9GZYofpZuv17TiQZuFbwGuWNcTD9X3c4Mr2AwED9Vb9HrOg7zht7vbFcKKEhF5hZ17EGDWfwroKfqgxLOa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXgNeW4iwluYAelPvH+svWQLaqr3xugOur95JnzgsPA=;
 b=MEDc5RnKIDA/w+si5MFu6RCTE1xbD8N19bI0Zmh2ESjPOEoKHkYLNCVjo+ElgCEIYUh8qKCmyULWHOJfYFx5g33By5tWeCC6Epk1V1oa1fylDlHu/Q1uLV177x31coxlWPgoK9aLRGbmYmNyX/zbjNGsPcbjWQ8naJ11WRFfFmND+iNKVvbi+zT1SzWBFc/a/nJmvP1iGu7r/ExkJUzfBo+CYLSh81WlJTonSgieu8+X2qS30/LbjOCO4Mf9LSZtjAbWb4oRlLvdFi7tk/+/qL0jy+zvg6x6BP2CuGHokA3fNPJe9BVa4zQjIaqBY1yBeBYPo0rUdyvjglfIHRtD0Q==
Received: from CY5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:930:16::6)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 3 Jul
 2026 04:07:59 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::70) by CY5PR22CA0023.outlook.office365.com
 (2603:10b6:930:16::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 04:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vsethi@nvidia.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>
Subject: [PATCH v5 09/18] iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
Date: Thu, 2 Jul 2026 21:06:34 -0700
Message-ID: <df41122bd28b74dbe2de09d6cbe6c636e647c93b.1783044582.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bba037-3d68-4250-32d2-08ded8b8ab77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|23010399003|82310400026|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	woAVE4HqeDDAK4GxLGXIgDeiJWJdoWQ52yGTdtK0qfQVWW4s4qSY4Na2RVq2uOT2GWbm55UI4hNnoFHtTB5yBdDfIs2M6acDZOPNS7KyMGtsLfQNbjV61YR/WObhSwjLFnMhRKQrO5HTeaXpJmxBlBRnOOWktQsFykvSpC46Hx6UjYwIzIj0RVu/qeHZeX3NdJh6J2kM3BVmYvmj2X7nxKs4hhT/mwkZzD7+v4k8JbeFbUlmzkEthFQtSU82mKXx4X8pJ9j11M1k2j8nh6bIAXsKqwOHh/p4cKcXRg2IRrYvZCewk8xWVzvVhdG5p6iQ4YnTsA+QSwPyZkGFap4JFzmqzAcsdoQCz9PhhXOATdymFOEKtKyhijfREgW6UnxfFcxu+EeN0tmaff8cR2aRMhf0rj4S0MAKNGpHBrZW3A7/kJrACRNNlcoeN3kqerX+GhGtu6qaUS/im/PwDQ1nO4U1842Ll48N2LcqFrIlqDl/ra07MODNTJhFufFfw2GVmphLr+wtmHbwemHwb4FhGXODtHAkWQrbCVEF5MUTWUjlE6AQfY7JzLKTRZmFsv3WScwm1TE7oPE7JWdHHgX+jHo64ZLyjixmkOgS9Ji3wQT0j2zxsCYeueCNJOk+y2Vej5WLxey/hrcmTWhF9YutUa4Kopd0/7DRrWPlxfDFNvf2TFxEhWxRpI3EfLTAZ9SPpPm+E82u6uvd0wjQnbpAkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KJxQqwmiao+6TP2YRwG87x0mDCeDtd/tkH8tMlEXVpazDsvK1f/cMwGW9AkXlFbiWveqPSXxBoVYLZS2cc/42cTR6q/ASchnTV+fUe2SY2gXTI82cbLqQJnsgwFviPWJvVud690hPHUasJc84aSv13pTSh4HVIcfy3DbSDn788tzWZ7QJi3hiwSAcWUg+XYGUd0Jd4ZzDs3unvBCLwXZ3p0gHEaF6B9c0yPd8SfkHYc0GEWj7zESjp/pIzAmwbYa4F2aEE31cfreccLvjhpcrN2zgDxKsXIwfq0wbhLDYlTlKS15zAALdLmW/00lxfbY9BFBnX+J1JiPog1Bz6sW4E8VS3VU6hQJ00sypJ2VJSBl/wrasrsyw3za4S0PyxR68VEE/Hyp/4zbGtLMDR7RysMiwx2AVR60ShXop6fYHlS/h3BaMnIiKQZqv8Y3uB0u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:59.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bba037-3d68-4250-32d2-08ded8b8ab77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

A subsequent change will need arm_smmu_cmdq_issue_cmdlist() to co-clear a
pending CMDQ_ERR after a CMD_SYNC poll timeout. And this needs to be done
for both smmu->cmdq and tegra241-cmdq.

Add a cmdq_err_handler and a paired cmdq_err_lock to struct arm_smmu_cmdq.
arm_smmu_gerror_handler() now takes the per-cmdq cmdq_err_lock when acking
CMDQ_ERR. It already covers a concurrent ack from cmdq_err_handler via its
existing early-exit on no-active-bits.

Impl functions and caller will be added in the subsequent change.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    | 12 ++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  2 +-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 56e872e59afeb..86e934d046eaa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,6 +695,10 @@ struct arm_smmu_queue_poll {
 	bool				wfe;
 };
 
+struct arm_smmu_cmdq;
+typedef void (*arm_smmu_cmdq_err_fn)(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq *cmdq);
+
 struct arm_smmu_cmdq {
 	struct arm_smmu_queue		q;
 	atomic_long_t			*valid_map;
@@ -702,6 +706,10 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmd *cmd);
+
+	/* Drain a pending CMDQ_ERR; will hold cmdq_err_lock with irqsave */
+	arm_smmu_cmdq_err_fn		cmdq_err_handler;
+	raw_spinlock_t			cmdq_err_lock;
 };
 
 static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
@@ -1164,8 +1172,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
 			    size_t dwords, const char *name);
-int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
-		       struct arm_smmu_cmdq *cmdq);
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu, struct arm_smmu_cmdq *cmdq,
+		       arm_smmu_cmdq_err_fn cmdq_err_handler);
 
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a4edefeec770..c6e3d1be23403 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2302,13 +2302,18 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	u32 gerror, gerrorn, active;
 	struct arm_smmu_device *smmu = dev;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&smmu->cmdq.cmdq_err_lock, flags);
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
 	active = gerror ^ gerrorn;
-	if (!(active & GERROR_ERR_MASK))
+	if (!(active & GERROR_ERR_MASK)) {
+		raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 		return IRQ_NONE; /* No errors pending */
+	}
 
 	dev_warn(smmu->dev,
 		 "unexpected global error reported (0x%08x), this could be serious\n",
@@ -2317,6 +2322,8 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_SFM_ERR) {
 		/* SMMU is being disabled, so other errors don't matter */
 		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+		/* Release before arm_smmu_device_disable() that sleeps */
+		raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
 		return IRQ_HANDLED;
@@ -2344,6 +2351,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -4458,13 +4466,15 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
-		       struct arm_smmu_cmdq *cmdq)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu, struct arm_smmu_cmdq *cmdq,
+		       arm_smmu_cmdq_err_fn cmdq_err_handler)
 {
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
+	raw_spin_lock_init(&cmdq->cmdq_err_lock);
+	cmdq->cmdq_err_handler = cmdq_err_handler;
 
 	cmdq->valid_map = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
 							      GFP_KERNEL);
@@ -4490,7 +4500,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a6e7640..9012ab584d1dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -643,7 +643,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq);
+	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

