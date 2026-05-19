Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AA8317148;
	Tue, 19 May 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162005; cv=fail; b=FrA++pUrkBi4gMBjOTb+hXznt7xt/J8sPrvjqdFdN++TGY0dd83eRW8EN3QeeAlm4OMqJKN/0piRBUvNlCUpcJguAS4AkTCVhSdT5y/PQs9m5Ytsb5lP2pclgUmcvwiH7JGa5mreXfarSZsRHnL4xnHr4EwXUL9SXJdHH1CxQOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162005; c=relaxed/simple;
	bh=al5weX8SAadvlEig1Zl3iQAxFe4tQEjYPK7CBCFMjgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s24BglDl/7GXlfclbs4RGqJP0/Ng/a3SP3Zn80JkriaWEC8ZcUqbvJ0zVNbiGYw4NZwjYvfmcLQ/tXcLTMizVfDrNRozYtAhtwisPO4AByvMqFNHRMkCR5xmPx3+MxQ9LqfWiY4PDL7hHa+B2AysQ9Yrichme6vjZX122pabgt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M+UuK5zN; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+UuK5zN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqAqilVlWxGFnQpI8NGAOCFtxseqMFvOQgALGOTGNFKgLPQcIu90q+qjk2bwQxaYBziH9P7v2lxRMPx0UlmHIkkSnC+SWKxxS3ykoBcmi0tdxfXir4mxRaHDQfupbT77lZaq9KZfdxBjUsnkznYziZWPWPiiLA+swiToV5DCeeAETS2WTeDJm8Vxj6jYckBxG/h8NS8I3fuVZTSkCNyJTwIy7xhH3/qwaOYK68q0GuD9w2au+pHrL8qAGQ0bmxEQgEmdow/2sKy97j4CF8oDPv2orvcRUClbHS0mn03EU3HO1KBJGaZrHFnzdtmwPcNm1HfMx7fElQnmvqlH/hy1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNmwF+YrzUkevdc2KMIwthzURV+lWnZu8Hgb8yhKxBU=;
 b=j8tAL2MhLZerHBv9hhzPpvNU6LCfq59nZJc6RoyiF5L/x/9y6Zg33oZ2vEsRy6y9fwAJoqxOD0jphLtA73BO3dquq7i6Gmm9vZOsOwXKTbd0UUtiEgpXadK/myo3anYZIXMTv3+X1UNAw5pc+37J1NQHPYkSlneadcwvjfQaMvJmxgutUcZghdVTfqlpFp7huZ2B8nf3dlrel9hPcMVzxeGFVx3YUmXVUbICUw4D74z9rPhwg5g3YkXcOaTs1aAcM7+jq+vqhL3k34UOYgohwKuPNUmnm9fvPxulzBwMNfEp3x/RQ6h1SsdGkfd77/+T5qqQv8rK77iOwboBG6t5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNmwF+YrzUkevdc2KMIwthzURV+lWnZu8Hgb8yhKxBU=;
 b=M+UuK5zNqyRC1HuL8jfw+LSHtOZ0WxptRmLDPfHbr0qjYrY6SkLBO5BehGKIt6TpU7sS7NzNSUGUO29nBihw7xE/v2+V05upqmRRgSsqi3ChVw0yL6PC4vDMNVR3W7UkL7h7yo8cDxSvWbFfU0I/DaWBVVXQyN872RjTgcW+7DxguBsxIAcXEqHkAD07SRNFJp96vSiX0fs+HarLjQrRsDqnK3H4sQts9/E77AZgRGzZtc8yhnPuE2X82kDBMQ2Iux3QZ8z6U3UQFWB4+NtJlFqKXPNRyeD4TDnEVsMTuKdrPsKMJd3Nmg3xKZ/RV1lRMB81LH07ENrkZhE8F3IHiQ==
Received: from CY5P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::39) by
 DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.21; Tue, 19 May 2026 03:39:55 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:930:b:cafe::88) by CY5P221CA0035.outlook.office365.com
 (2603:10b6:930:b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 03:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:41 -0700
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
Subject: [PATCH v4 15/24] iommu/arm-smmu-v3: Co-clear pending CMDQ_ERR when CMD_SYNC times out
Date: Mon, 18 May 2026 20:38:58 -0700
Message-ID: <31fddf88d78e830a7cfd407d44c15c0c536fd0d6.1779161849.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779161849.git.nicolinc@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: b96fb4f7-9ab3-43cb-01e5-08deb5584ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LxyfaRP8xDCwGp1UxNGPPp9IKnM8LjMsh/za9mmwJQhMu9oMo1TFbdig6ki/v2qhcPLTPTOYQ+To2Tld9NxBQCcGgPigH2D3dgW4r8fs9ImbrDqEy+z0jvMoku4Jtzs0Yr49Fut+49cqXG8Z8OwM6SGYrNxEMdt7sG1xU/sM0B9y0JuRX7IHrVnTMPEtN451ibUngZmaw//JiW/LBKYb2tnY3qLGWkFqPRckFdPMpGpxRhwa09PITGwL4BVgd8SBfjvWYnFJdR+asiPAi1JXuEki/OCQHnGI2wS01jOlR2F4a0bz3oRMugpceMlpgxWXy/qLDcsVq/E6KJ3ziGO7E9soR4KHCdGFVT41oCrckNEhoPYaShM45vIW+Z+WfkD6KFK1SGFrp//o4Xo9+B+lWZSUtsDnuDQUCv0Jf0w1MJLiHaY0/VU3vcU6Sd6gG/pYJUp2m5B8xqZtv/RgiZXtDyjhPatRoCaxoZygc2ZBjY8etwwzdRcQOLOEQKvxGAWccxAlbIK1EGCFT6e2/lplQEjtWb+aMLfQrUHXpN43rdUZIP/+GUWaNAkc8QN3iwxRApKNxEtvWjeBu9oYEHJB0qUbmpwbuSti9Y/mBxUiAq194VpyLW1a5J2GO2HQymN3RK7w3J+++qm48iZWPNP8k+YB9ljXK9QoUVgtkKFyI201mJF6b+tE7Cd32haXUrB5I7YJEQze5whZf3uXxIqYY85l2Mp0i3Lu/KfYPNjWLak=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xb4KwECbP/3cl4R6La3ttOK7pdJXpf/308jsgFYW1Q8UQJ2g+YBfugvMPYy1Rl6gn2I2v2MrDuOgNKHFGXCwPSkxeOVv9EQ4dRiF4GH0NPbba5N76vDAFkF543FgXBK/ljZub0kTRZS/2etSmYRenvxwVdBqUGhxxraWPDHYlvwTwpUs4Qt2Q52EzaBZpnjoX9GQQ3CEoiEQ/0TtZ72QPLqBJspyNqQHO0VcihHuaQVebky1aqSQEoAFIIM6k0wwbdDCqKQAs60Y3tnXYtXT5cE3ltAc5CH3+MQ6fEPwwp4SHTJ2HzeQb1qdh2eeKYJ2R3lyruncJMH+uCmfAq2lDZcscf7w1OphNamUaELZ8OI8pG5sz3dvfhJwZS3MWOpfbtlDDZM3/mt6fWDKpEDgkmfoGjFTTnen5SKTEK/LUOY6qvBBtkdDd3iIxa69dDPm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:54.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fb4f7-9ab3-43cb-01e5-08deb5584ad3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 36 ++++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 23 +++++++++++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fc0757359b783..7f81fd2e92480 100644
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
 		 * Test atc_sync_timeouts first and see if there is ATC timeout
 		 * resulted from this cmdlist. Return -EIO to separate from the
@@ -2251,6 +2260,31 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
+/*
+ * Drain a pending CMDQ_ERR on the primary cmdq. Installed as the primary
+ * cmdq's cmdq_err_handler so arm_smmu_cmdq_issue_cmdlist() can drain after
+ * a CMD_SYNC poll timeout; serialized against arm_smmu_gerror_handler() by
+ * cmdq->cmdq_err_lock.
+ */
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
@@ -4399,7 +4433,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, arm_smmu_cmdq_err_handler);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index fb2f8f68fa344..e04107f0490c9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -337,6 +337,27 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 	}
 }
 
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
@@ -652,7 +673,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
+	return arm_smmu_cmdq_init(smmu, cmdq, tegra241_vcmdq_handle_cmdq_err);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

