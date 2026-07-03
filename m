Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE33264EA;
	Fri,  3 Jul 2026 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051709; cv=fail; b=lKgU4MwJodnHx2cZoU4ji31NrfSVutWfU6clMxlBsF+E5RkfwGYHPekXoV0Egi5HJSwFbapRagL1hLuUilxslZ7ZTQ7rPIiZSii9FScXKwZdjeXVXmg+k1STCrfsfipN6g33ukVvWzPj8SgGyEv5UjKywkGjne6D+jl+CJaLdgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051709; c=relaxed/simple;
	bh=u55F4xxbqDfYWg3kWmWa94Si8f1C3AFkgDpOxLKoxGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR1SYvNXCfqbqRjRdDde2xJipL1qIZgL+2AkzDwbMg9lnmjjx+F8qKH9jEc70Ux3sX9idbkB7Aoapy+karSE+8cYNizv/18rEYwVmxTWDidkcNGya4MY456xlyYbEuipO9VjUAJs+JbzsuDY0MjqpStYOG4tlhdSrO1lqSTraRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORdjuojM; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORdjuojM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVwNUxt9mvVbQF0l222wN2+i0B/h/mLUsG83t/VYywrFNrp8T8Q/JqZndLAVqdusFw9dVUX472pDsCx1oqfLNK5EK1CfqQtw39dWQ1XiDciSFLsvZlQr8UJ+7rPbn3aSRXsIFb/wASj31RoQ903HtPufqmTa/lhbVLK82fOw2VIVxf8awjdmNWNornlX4w8CY54Rc6tQCYrMmSIG3PSMe4HvObiIzqL1ZhCojdMNZYImwWAvewCM7j4qQYL3EXhiKK7lTLElzCNWEipBQ0VrOn1hHEU4v0Hio+7hafS2u3fDlCvderpcOHd2+NcOLcTd8V+bsmqLuQ0ungjksrQygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pglpLtUaVLpciWfBNgQ1/2hzLSI9wfZ8t2qaUtAIW2c=;
 b=EOcK0tU1brPOpBPIRpVl48Qu8Fjx673sE383yqyJhxIsW0I4MoFrSARUf+y4ZEQdehJtwqojYBB2Or/uTJTJSzupCfR/z/QXKC9t3TXrV+bm5WBpy04Cd/tIhtN0qjw7JB0NBOd+IhssiWq26i+4svWXrKHCuIbHxNfhUT82FGDPBu6F5/WQRk7OTZHfzoZM7iQQ11oHu/6UIYJT34btjQ4SIfMJbUEoYxGz9dMxjzOfJTuGNxMASIaDoC0umjjo7gRXUlpJWoukHnSHznQLHqAtU7YGR79kS7fjfj/+MLv1DDo/NUb/xayipstWMuWndnmtQmG+TtDUsL2YFiyuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pglpLtUaVLpciWfBNgQ1/2hzLSI9wfZ8t2qaUtAIW2c=;
 b=ORdjuojMxnsxWRZanKi1xEpBshnzEWinrcfv7NlK/5Arx2b56AEG1oBDiyiJQ2wcPvn3fSbJxmerIBoJBpjxon0ep+o3/ES3WYECjOXvm33QldPEDh1/AoK9H2dkI63vnerbzdDYTfZLFbXG42EDQcyqxC4IEkFs9023VojFous/YV0be4m1gxtwvHgrrgW0gEgE1sUfOiZ7a8S4danEIR8RPlwjMJg+Faf9IA3O6B8VZUx07QAZmQ29fiwTOGaNxlUIjF+/J0X0braKtxvUztZs9Zs9Vr5mjXDcjgKKn6oBVvG0+BKIxCq6NcOO3T07bt3F/HmuAYbg27wZPN5nZw==
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 04:08:03 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::aa) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:46 -0700
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
Subject: [PATCH v5 11/18] iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
Date: Thu, 2 Jul 2026 21:06:36 -0700
Message-ID: <2ce44672e51a136c220d9c5f325ea20d850a249e.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ec6d98-7fb3-48d1-0c71-08ded8b8ada0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6x0nluppNNDstTmiyjnY32IwMRW799QKHAU36KNjAe6gp4GmOaxU6CaLuLctkqGymbgjVNoCiO/RqkYv4TfsvD6Yp+dcUVy4BdbXG1tlqylz95LvAxjxgrDy80PJQQZG9+/QW31kOyZVn1NEuCNx+vf9VKgGQOtZ83qYnnlCstaJNbkJ4RsFQlctqq9cu/ECKeEiz+spp3TgW8JHUio/iI5BWIuBbncryEoSyoodEvCfxL5hes6jxP/kPUXbxa7dwz1AqHrzUWQSd9985o5A/gJfpkcwNJPTUNdePW0D98n42jCc3jcPjX190GfGEBD4rzJLDEQR/93iWD9QJzKY6woK48TGTK89P82rOIdu/Fjx+dHCRL9Q7TK6XjBgbpwyLfMw6UKrhV7W53ggud6RrOrmqqdzkLJTvTCRZOgQxWrQyRzaDiFi/Uhsp8KlKSzp1/Fz6TS7NkeIsmvvXd3UNhVrn5JEghcgR4A3gZnRcWQdviLZXN8w2JwEHagfUE8Y0OIIpA2/9oGqJREeRl+sdxp82qK6MGyZezJblLA2HJfNlzHr32lBX0jn01aNrjDg8yYV3yG+0Z2HwOBLIk37u+DItHmFlMwiyD6/gpKSuumI/7ZUc2qkzBGRPXK7mSJLma6vwPhSiS8Wvxkn04gVnQ2umXRyYc+McnNosP9WU2fLtg+JZwHSmrogksaiYOWRQJyAsipTf6aAPYexPIqeJA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aniqf2cjYOKYh6LmrkkvTGf2foLCKihgUQpqVuO3A4OVLoU7WEJMv68EsVA6wcBGpkcjgni5GrFpyQegiwsTJ5E/NfyPDz9cFy7rgov2UIAE9EuAxgo+n/h3QUtjhD34YkQJtC3vdmZ8eO6pUl8atWhSCBem2QIhxjfokK9CnSYNG6kjfxgnlnQLhTcZ2G0bCMZ1yMq2W4gxBTljnEe0UgyRSozzADGWGaOoTPz7YZl4VEIirHjLj9OlxoJeKCMNV0pe6hM3a8AYelIFVcgcXi3lWRjQit7yCgNXsMIe/wIKZknUnbIGrYtjNQ0eGmveybJ4Y3aYMuNoRcH2cIAQia+hSwldHiRT9GA2i37uoneLfvjb0SdTrLTH7EYQ1Mxojs/11gSG1kzs2pyr1yQE2Hhm1wbnrgQCBZTezZEKFMG4bKLm550H8UOQ4RoFZU6q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:03.0190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ec6d98-7fb3-48d1-0c71-08ded8b8ada0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1

Once arm_smmu_cmdq_poll_until_sync() returns, arm_smmu_cmdq_issue_cmdlist()
tests its CMD_SYNC slot in atc_sync_timeouts to decide whether there was an
ATC_INV timeout.

On the other hand, when that poll timed out, the GERROR ISR might have been
delayed past the poll deadline, so the atc_sync_timeouts test could miss an
ATC_INV timeout, classifying it as a generic CMD_SYNC timeout and bypassing
the per-device quarantine.

Add two cmdq_err_handler impl functions:
 - arm_smmu_cmdq_err_handler() reads SMMU GERROR/GERRORN.
 - tegra241_vcmdq_handle_cmdq_err() reads VCMDQ GERROR/GERRORN.

Co-clear any pending CMDQ_ERR in the issuer, when the polling on a CMD_SYNC
times out. Each cmdq impl serializes the synchronous drain against its own
IRQ handler with cmdq->cmdq_err_lock.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 31 ++++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 24 +++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c6e3d1be23403..4b4e8108d5944 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -813,6 +813,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		sync_prod = llq.prod;
 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 
+		/*
+		 * When the poll above timed out, the GERROR ISR might have been
+		 * delayed past the poll deadline, so the atc_sync_timeouts test
+		 * below could miss our ATC_INV timeout. Thus, drain any pending
+		 * CMDQ_ERR synchronously first via the per-cmdq callback.
+		 */
+		if (ret && cmdq->cmdq_err_handler)
+			cmdq->cmdq_err_handler(smmu, cmdq);
+
 		/*
 		 * Ensure that the read in __arm_smmu_cmdq_poll_until_msi() or
 		 * __arm_smmu_cmdq_poll_until_consumed() are completed, before
@@ -2298,6 +2307,26 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
+/* Drain a pending CMDQ_ERR, used by arm_smmu_cmdq_issue_cmdlist() */
+static void arm_smmu_cmdq_err_handler(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq *cmdq)
+{
+	u32 gerror, gerrorn;
+
+	guard(raw_spinlock_irqsave)(&cmdq->cmdq_err_lock);
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+	if (!((gerror ^ gerrorn) & GERROR_CMDQ_ERR))
+		return;
+
+	__arm_smmu_cmdq_skip_err(smmu, cmdq);
+
+	/* Toggle only the CMDQ_ERR bit; other bits are left for the ISR. */
+	writel(gerrorn ^ GERROR_CMDQ_ERR, smmu->base + ARM_SMMU_GERRORN);
+}
+
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	u32 gerror, gerrorn, active;
@@ -4500,7 +4529,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, arm_smmu_cmdq_err_handler);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 666dd23b0c7ca..628a3a7cc0335 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -337,6 +337,28 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 	}
 }
 
+/* Drain a pending CMDQ_ERR, used by arm_smmu_cmdq_issue_cmdlist() */
+static void tegra241_vcmdq_handle_cmdq_err(struct arm_smmu_device *smmu,
+					   struct arm_smmu_cmdq *cmdq)
+{
+	struct tegra241_vcmdq *vcmdq =
+		container_of(cmdq, struct tegra241_vcmdq, cmdq);
+	u32 gerror, gerrorn;
+
+	guard(raw_spinlock_irqsave)(&cmdq->cmdq_err_lock);
+
+	gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+	gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+
+	if (!((gerror ^ gerrorn) & GERROR_CMDQ_ERR))
+		return;
+
+	__arm_smmu_cmdq_skip_err(smmu, cmdq);
+
+	/* Toggle only the CMDQ_ERR bit on this VCMDQ's GERRORN */
+	writel(gerrorn ^ GERROR_CMDQ_ERR, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+}
+
 static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 {
 	struct tegra241_cmdqv *cmdqv = (struct tegra241_cmdqv *)devid;
@@ -655,7 +677,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
+	return arm_smmu_cmdq_init(smmu, cmdq, tegra241_vcmdq_handle_cmdq_err);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

