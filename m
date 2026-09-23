Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B2446BFA;
	Wed, 23 Sep 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194391; cv=fail; b=BlIywixas5KKaENdnPeGu60Ypm5a8HXsnRaTRwY6Nc782ojxRAZHmskXhN0juIoyA0K5QdaqyGkZ4vf7wqiEKHZWIPNmRpUbe9rj+XLjX0bcZhDo4Lfzp0qlKu8pEt60Uz1FQUo29CegspfCN8p6mwTTmhViBUQFeZMo/iyzW3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194391; c=relaxed/simple;
	bh=+0oGXueJbsBFaaq5YJMYXvIQM6zLQZcqlecoc55csNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9HChqqDTsOXQzVwcQuYc83uKjzDWYNxuWJjDtobwfAEJxfhFz6gbqttUPLFCmuymWZgKD+sVyjvT+UE1Z1YhT3OzXXs5aMedsqiIxUkkLdk+7CAi6LWJv3W10v63Atr6p548WjmDc4VSiWfOo4x9gmk+8rhF6/TwjrcRu/3mWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5ifhpIs; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5ifhpIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX330km2ZZgKFcmwbw72x4+4DGCdWHwjXpFh8k/RB2fA8+lFEessqHyvSQzA18eXtJu22FLYlmk8MU5wBSoH7pJj/uuxNm/2GlL62H/r9xdj6h+Ikpwj+iWgZWdC0dsJKJj402ZmtRrW4nX4xd0ykNNrnvTKLTD39l7p73oIARM2FEcGYBp6XrR/rHb3Lf8gLuY425v/a8PNSRklIoS6JxIPShXfzIS6CN9UXypwiL+8aQroXgAgGejXmuOODQLkMiSPaeJ/CVHO0NXVZk2fDTrGnqiUc8FhMtmxzFhIJql1/8Risn8P/Ptifon/7y2eFfi2NytA2pdmqDoZkZi8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE+Cqx51KxT1Y9/yfJp4e4uT3sPWrmZ06X6Al8YIfF8=;
 b=imUIVXtwnV0B2nVyxP4dcLAKzXdBeZrbhp/5kp4FCR2BzqeleXai5HaNxKHbFBj6LgsYLtXD8sEZp7kYvtB1+0FCMU7EMAuPTJJTzZw/Qcs/NZUZfphq1ctwl8XyuuxRhuHmhGJceTRC+5cyyC/W07wnqlTdJ5ImOQEsHrdsPJLIhdwdgCCyHnO5Kwhwcfitu2jzZwaH1CMO+TWmaqRzhQ+bH3QpPEGt5sGyhAQGXsgu0yeqXG0kzv4vEFA+VGZMEQEykvx3+wNwkclCKxPLTPOrVpYY+Thoo1Qs/1nQKrI9iV5i7c2e0sFqXU+88D2NCq+vo8am6ykBPX6PXBRT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE+Cqx51KxT1Y9/yfJp4e4uT3sPWrmZ06X6Al8YIfF8=;
 b=W5ifhpIsNLGp0wn9smXlZ3mGAwjJ7Wbp6Z26fcOla2TDbAA5o0xe263SIaVZ0+Uxc/UZGavnBPCrMA0lQZSRCxvzmOrjQjb0ilh8Mbvdn5I8//ZXZqwBqUIPtGBuTAtD3UyZaLSh6p3o5FqWS50sdjcJkW98w+5UsobAQhIo4SpgnXzbtGvsQu0rKHh0ftQkItpbOYL6+9ewN1NpXYI946RJovlEdy063unQgMmVU+27EcHDb98IduOc9BcTfcbfY/aiVtus2ynBgFh0OvX/4WltonqxKlLDtY2ZUB6E63jy9wjt7NJqgCObgxiipI1+FJ4pXgxaT+aq7sNWQiJVDg==
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:12:29 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a1) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Wed, 23
 Sep 2026 20:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<vsethi@nvidia.com>, Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v6 11/17] iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
Date: Wed, 23 Sep 2026 13:11:30 -0700
Message-ID: <16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: e5809f7c-4d54-4269-993e-08df19aefe94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xgSc5jzVrWJM2Vtcuh7YAK7eyLyq/ax2UU3rARrM40rt/Z9ZOiFU71Idj5+AfO2dkGAFPj89hTre+31T2mmAqj4ptiWmrI2cxhAvJF/PP9mu2ljpTTmUC32JpdRfSXhPwX7jKEuXFDd4zH7A8KQxePIF1gieVvaehfQEe8orRtYhM03qzUeBf69fX2hPfEaqfBItzrUPsH9p+HC3y/KzmaYjFX/pGT5T+IBS6neBVDSGABq+/XTY0ruMxSfJV6DhD/YgPKumU7jUrpOgrbTz3gBGm98UkcwdGy6PYXD6tgr8eg/ZepcPGGdJmacu19aLPix77XAQa02xDxH3Uf5yEKtC5CvDiQ1NewrbalcYNQuLEZGE7mfmgESRQvTcH5AkpzrpW+SN9Nn6S9+hQ2VaPvuF7ZqB5IphfthorU9pBKV9gMGNjAWe3bcHWzZM6H+kzYZWSvVp+SKi9LY5cgIop2KQ0F+XYnGh0UH1E2bHAqTCRTD5a5ueHZiGGOytGgKifBIqVRPgOpmXsu/mds9ivwnPrUJASq5yDjPFhF+TgBMw1jn3vAN+rS7KGjkNgK6PWhq9txqx/1cBGtyCf+5pMgHLV3+lFAtMvTjtdgQaHGqEmgwkLwJqVrAkuHKY5lFO7UeVSrmtqxEYwj24eZ1zWxtvJ4/WYfKvE0vyNdQ66lB+XTJRmewzS/FSdqgw8U+RmNz3lpq6qyhQVPQ+cent7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PuGYehryNeOuc42xGhUDSvKOyYdmsQhWhku0qTaJnz8WranoKHNLnKi/LQju/wVTOQPZC+o8zFa/SBcE/Lj5VaXxQJ9NexXV4+1dJW+t93YI668OvNq9umV+uBWM49sNIGdUkkA/doo0Er5U6fB/LaHLRLmryc73oqTqiPZgidhjvSDjS4d9pprwR//JulBexmNQJgGBhP6UvGWDuB3hOrb0/0zYaqZ6KYtwZfg2aN7Axz/PQGTgbIPOb78NX9Fconz9Z/Ynw1bj5z2lIg311utQ13fS+veLBRa7FBQNZojytvQXPY9ZMnG6Xv7h1MhAz+in2FCS5Mh8i1yCfh1BrrANtkogCX0On6MtyWAGof2suwCpqHEr36lpnJ2d4XNYMITLt3wPSo6lWengNxc1oooWcrMCeHP+6mpRyb9O/tM6/rqyWUipDp1tPBVjYvGm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:29.4216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5809f7c-4d54-4269-993e-08df19aefe94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

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

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 31 ++++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 24 +++++++++++++-
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 409ee1be76815..3081ef407fd69 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -822,6 +822,15 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -2363,6 +2372,26 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
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
@@ -4584,7 +4613,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, arm_smmu_cmdq_err_handler);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index cf008bee213c4..690de008f4dcc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -350,6 +350,28 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
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
 /*
  * The CMDQV error interrupt is edge-triggered, so a pending VINTF error fires
  * this ISR once and does not re-assert. An unacked guest therefore cannot
@@ -687,7 +709,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
+	return arm_smmu_cmdq_init(smmu, cmdq, tegra241_vcmdq_handle_cmdq_err);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

