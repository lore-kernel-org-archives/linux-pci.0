Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041613195FC;
	Tue, 19 May 2026 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162003; cv=fail; b=b0BZGY7LyI4fLDTriSL7sv+1dcNtJLd7i+dtYVxZOB7nVNSIhmmC92rvXA8YLPUOQwlXif6aS7aq+j7ogwCivdxXEYghMK/9OEf1zSnsT8wskeRXmbN7WmRNSBK/FhQrlfMWBYb9fHVZ3mFNILl7uS8hTQALZ4gw8oqiZsH11YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162003; c=relaxed/simple;
	bh=zNmTU4A/fhv0rwClQSwFSln9xYuPfnKx6BzKUCWwmns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOxt3wyhtnRry/r9coaSGjN0lyM671QPidoB94k7nUrx3g4Hy5LAo2mASyM/XVMvy15Q0LLFBbYJbQ6TqSiOjTVSw079vGPFnybqdZ9tnvyDVmDMjLpZmiejRu3SAtw1eTA0eC90XXAWGyihcNyJ5ncRDYsGHftGGZmT1g5cVLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kNuUfJU7; arc=fail smtp.client-ip=40.93.196.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNuUfJU7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4S2wTHI8720Ozl2/nGQM4Ze3YIy5SR5STjlmNZBayoQd8d4vx2JMy0BmheZjDPb6dTkMfm4wLyFyYUE/JdM2+OaWIUqjpCYHn3C1mZ3EwfXv7PAEmDfTWJy7gClPEzEi1IPoIUh5YFFANeCj/hq+sL8TBQARErs1cZtpwkF3SfwDWVo2NpD3lIvq9Q4oqvrrhA1cds5iC6LDXvHgalPwpltrQegw7FRvMCDfCrWLNp3aboSaxiPYmko8c50sPCb9o3AUwdDj+QImBBfQLSGGZm9I1KRZ/cF94LmSqy8ezc9csi6utrbu3RBCVkKUrrrGpcZmr08yg7OJ8WicgDiNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSChhWkHn4PYaB5jcOfQcyKxUT28m9kV7EnN16lLbZg=;
 b=VjJg3Mb/Oj/lhOqZNa1y3sWVziLGpYnWpbfGTZjts+CKK30gfmKK5PzHHzzWEZ0U7/v/sMZK4fueq5XGoAD9BIu/ofXFYVlQMGrDteFtqpFDkLam2OXFdh5ntZOeKQN3iqbynFn4f7FA/9jVdvKnX6gOHhrIQigWF8mxOzvMf1RyQDULtZQV3K0+mW4T5MqFyNH6xeUMkEZsVob3PhgtJtj1uydWc2kcQSCjuu/vku3ID4l09tuihFOPslzCXU0tr1QquBeAVXAL5VUQigN6NwATESgQkj1HC83B1pAcAPIQkMiElWV1dlDhm5xJVV3zy5MA+84mIr8lBGIely/tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSChhWkHn4PYaB5jcOfQcyKxUT28m9kV7EnN16lLbZg=;
 b=kNuUfJU7wzfLXv6KUIYsB7Fjwpo7dBkptWnffNELfIkbRW165anjV6rhnfcFOeciC/kORoiuvrCR2stzUD5AzzTYhyp3fpZYwk3ZB0p0EdnJd2NbRFW6Vy5ohr9NXuFR8zAevtRiMXLJXeR+Fhoiou9YuTrdDd101Iq3I3/dONEZpJNuKqUE1XEa4sHLSSyAr7xS+DRSNK4ZytKcD1qZZrpRvD1BkEKCo/qBVHBmSNxHPQVS6evGOPMN3i8hrUlZhIoodfM8VZXbTbRjd6qmrt2ogG+NyM0pBNzYzzSH7rkzzQVuJGHdxuADqTAiqj8JlUqUJmsSZksbsQieqWCZOQ==
Received: from CY5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::12) by
 DS2PR12MB9640.namprd12.prod.outlook.com (2603:10b6:8:27d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 19 May 2026 03:39:54 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:930:b:cafe::7e) by CY5P221CA0004.outlook.office365.com
 (2603:10b6:930:b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 03:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:39:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:39 -0700
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
Subject: [PATCH v4 14/24] iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
Date: Mon, 18 May 2026 20:38:57 -0700
Message-ID: <c5a10cf76339bf8349b5db4c0bb0728db4073f8a.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS2PR12MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc3af91-4b75-4e6b-1c68-08deb5584a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GdYEmVLrgqWSqLEcjPr7iKILm0RCzf+FkY1dNLTGJH/lMfUdGSOupNhE7ic00Tc56dmQaP3apwUTc8hWkC/sc/+VdUOEQBjJwxZkdnPDMmK6fl76ecdkMjk6AOuarll/9/QKfyDQw+1/zbRK5radqDLZSiTWX0rOpF2H1iKVHpyyA/vHGf4BhsN1JEKD3nS0RjVJJ2jmbKLKTmEOTgOoh1CgT7P9tZi8/8koBVjarxPrP6WywuQj2ybxoYlnYPCbgyFtInvzkOkUnH+dn6a3Vvam5o8E7+P7JPoQ+i8D1Ccx0Za1xjb5mEAQvjxYolJJxt5AfQUwgmAWDrbwC/pp0n5UzTNKuSDn38RNzYs8UWSj3aBL1kXCW9J4uBUGf5bgjpb8+tvHk248Kmwyq4cACoBJgBbAwSQw4kcTgJMK84VvboD/aisrfJeq2XtO2Ms7Iizw61CuCyNtTLEofeKTsKvHadC+2gdvpsavZI61txaSQSNtxcBH1D5MC3Uu1LfyiaVqdS7G4qI530ndYLkvKie0wPXuo7ThvfGT8EM0F5h3OywMqIJi4LjfVLi9Ego6Ri6ANEYSrD/l8KQL6XXLlWMuM0wGkZlD63wh8Mzr2d2/n9z5YhUANVV/z+QuxkEZOJW9z7pVLIrHvGWRy1b+tzsp1ZjU/fgyht8Z3AgHRbRjBYMIWsITHdlnOeXqd2UgSP7zopSLTcezYHX/gBgBjEs6CBGGXlNmaD8qFxzhAbE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4rQbU+yDNy62M8tgmbEn5pzl3pv9yPjC5N0LYXX6iqc2H/jQZqS585SLWcBHy/UyG9xGcNM8pWOaj5NVhMdDlwaxCK4lVOFYIYRzPKAhxUgGxMMjMXj7+9eEQfRw4toTsFRFA8L/0pGQ4Pd2fUntU54VnXPbXxB8UWUPJwKtyfGQSYZvIkuZ2o7Z8tteL0JLIXQ3MI0wXMs6ZWAL2gaGawbRtVonUEltZ1gnZgEZuy/3mEh4yXZL3fiWardFfyVUJ0zi/Btdt0uKc+w9COoky89ayn5rrWMhWvHBfalRYsoTHfIQGsKjh/nh7/9F/41r2dyjAJhgtukZ/KSIv4yk9aR00NE8gPzwk5+c7zSb3poOPfeF6MwRzQKedv5tmUgSPVgAq91wjIu5/aJYAFt6n+2GfA4D2Zz534SQowwz2UuuC6X9ocJYJAKzlYw15XXl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:39:53.7467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc3af91-4b75-4e6b-1c68-08deb5584a26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9640

A subsequent change will need arm_smmu_cmdq_issue_cmdlist() to co-clear a
pending CMDQ_ERR after a CMD_SYNC poll timeout. And this needs to be done
for both smmu->cmdq and tegra241-cmdq.

Add a cmdq_err_handler and a paired cmdq_err_lock to struct arm_smmu_cmdq.
arm_smmu_gerror_handler() and tegra241_vintf0_handle_error() now take the
per-cmdq cmdq_err_lock when acking CMDQ_ERR.

tegra241_vintf0_handle_error() also checks (gerror ^ gerrorn) inside the
cmdq_err_lock since a concurrent cmdq_err_handler may have already acked
the error. arm_smmu_gerror_handler() already covers this via its existing
early-exit on no-active-bits.

Impl functions and caller will be added in the subsequent change.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    | 12 ++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 18 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 15 ++++++++++++---
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 46f9e292a1cc8..604f7edf54158 100644
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
@@ -1163,8 +1171,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
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
index d9fe48989fcd7..fc0757359b783 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2255,13 +2255,18 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
@@ -2270,6 +2275,8 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_SFM_ERR) {
 		/* SMMU is being disabled, so other errors don't matter */
 		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+		/* Release before arm_smmu_device_disable() that sleeps */
+		raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
 		return IRQ_HANDLED;
@@ -2297,6 +2304,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -4357,13 +4365,15 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
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
@@ -4389,7 +4399,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 67be62a6e7640..fb2f8f68fa344 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -319,10 +319,19 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 		while (map) {
 			unsigned long lidx = __ffs64(map);
 			struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
-			u32 gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+			struct arm_smmu_cmdq *cmdq = &vcmdq->cmdq;
+			unsigned long flags;
+			u32 gerror, gerrorn;
 
-			__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu, &vcmdq->cmdq);
+			raw_spin_lock_irqsave(&cmdq->cmdq_err_lock, flags);
+			gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
+			gerrorn = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+
+			if ((gerror ^ gerrorn) & GERROR_CMDQ_ERR)
+				__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu,
+							 cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
+			raw_spin_unlock_irqrestore(&cmdq->cmdq_err_lock, flags);
 			map &= ~BIT_ULL(lidx);
 		}
 	}
@@ -643,7 +652,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq);
+	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

