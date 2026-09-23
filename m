Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8C580386;
	Wed, 23 Sep 2026 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194370; cv=fail; b=YEsQLs0EptutvCVQD/LFRSfPMBldkHQVrHVtVTJiQFZtlFgj8CpGoHGJVoiC/zl3/MaWMHNQANTgkQLb0n28a7UR/VJ74OIf/3voyTUfLLW5hT8NzEaoO/+zRvaipdIxmfczNj35zx9qUpDA2I5jVcUeOYG1OrB3IcdZtdwNIck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194370; c=relaxed/simple;
	bh=P4iJygIWJ06Xvr/Sdk1vmPl28R3t67XzrljBOghJcjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBW0EoglTOl2GmCya9AxlYZD4pkqF1gwChWX4A454QS1dkQYDIVP8nz8scwUL7jfO/uCaDNISChME75h8LHeYvOXmh4Rwk5QnMEWiuSZJjPOr3eQ7jdMSxmQfgmCY10N3mmMlCDBdUhNdTvkKS8jufUWzNML6NSfXWxOM4orqbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s4WSMI3Y; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s4WSMI3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyHOARpdhR1ng/7yDiiyBJ1dT0GE3nd3JghxJKhIOjYcg1xxxoGp0irIJbSfnY6X77pIyeShCA6WvFum+vREMyRqKSskdYjR2ew+voJ8QmRAjZnVUxE+85gVDV6Y5PkcbQK2Cnp2i+aaWV9wCDPvMdQo38N5skat0yZIe6qpJ0C87fij3/gba8SMRthpHqR/MPwq6bCkhLk9Dc5AcBTH1R5o5sUUT/60cdHMO3oPi4On6koDkkA2MB/0rMCkBYoavzsAuDPlFfqcbIFkGCRNai+KSRpeAUbWv4zZr7hK7W4tcEb/bpnFD1ToeWsOluo5ZTZsyb9SSK+YVSLk/bYKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umtw04yLgXussBOqZyYk6WWuw6V4MxU7f6dKWKQ3n44=;
 b=wOUUJkTzZidJCt2Ou8hDxXDeHu28di+PMqC+z/hUgPOTaRgLIMFM3b4E2FUcdHfX3Ap/OvMUfapGL05oebPQkcesFyk73ZUy8yAMbviJZKMRB55acCgqK6S7gFsyVYw26G3hvAKbngj57CcX/iIuymuLYIg6WrribZdwdfUolRtzPNOl3YYy5pLtz6/UDWA2PHLxEo1HFL+3hCVpe1TXf4h1BYBp0kNKERRHdDrRVGJ8jMKSLaOo8/cULEDR1/dLUNrLmgtut0DTfHxCr/Ul4s3B+RmZ7okSDhQ4ZO4X3f7iTrpNsU7sR8cR/MewX/oUdRFGKgWlrZgOKQgNoJm0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umtw04yLgXussBOqZyYk6WWuw6V4MxU7f6dKWKQ3n44=;
 b=s4WSMI3YLL6lQxSYbQHdgIO39CJxEIw2dhgntpFq5sWH/md3YJ68dJMT2zavrU+/mETJ3rwDZ4pjGtJ4nlMoPVCWt79QATHJOKdh/goYuLsDZwqeif/CdVZpvDGWr+E9PTr1yiQZctBHE+wqBvg3GowsOA22gi2eO+OKrIF6zbeIXkOPm2hckfKLDlf+//dF0cXcQQVa6gynAfufcV9/4LzoP8CQIZDdilEhYxyUxZIs+hEoqnMEUNObBAra2Z2s+FqsRN5GSBSeqWd8QuX9JCLDT5J3mFL8LCJ2iGhablT/IEowwCL2qEUghGqlla6e4Ha+uzZ6lnWu6nKIl5B0OA==
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:12:29 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::7b) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:01 -0700
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
Subject: [PATCH v6 09/17] iommu/arm-smmu-v3: Introduce per-cmdq cmdq_err_handler callback
Date: Wed, 23 Sep 2026 13:11:28 -0700
Message-ID: <805f64a69c8a6e9aca32d66a0fbe60f333e40865.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c598164-44d5-4505-1155-08df19aefe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QlHBhWrzq/YwqsinlytInJ1U90yl9XQDLqKqBFY85/xkFUlKdJxM6zkswCnEPZeF5KZSW1KtHZy96LxzN8zHaMy0wxQ8nfPuJMqH6Fsi+Z8DBxxz7oPsC48cEBJNekKHYxQ2F8Z7iIHzKr9MzNMco0Exvi2nWTRUctb5RBVs3bXoFhzq+MGQReEnNiKB05gnsQGv9Px313i5wiXIQi7GCLzbLd+fMlH4B872XIwReezAZ4XuEk3/qEQHtqUKtMTt+l5vAvGzSooCQIKxRxV7olsTsSYMbPfBrwyXFApRJnzgE2oHEjZ99yQW5IYO0kVeZUBx4raP4L9IycBsyCsyjrECxbYHDkHl9L8iz/yIax43vKsW5qfkQ0bwlo6m+vGYfN51zoBiRqkoQWNhgaSHKB2fKLLrIB0iT/KiJ/BEIZJevWU7I4tmjnm4yAG4vOnhca8t+ZFhSSsZeG1TMeq1N3RyCMEvoCqS6z2RIrIZ2wD4POnd2LKIVa6JuKIMu+BnwHYw/P5Sw91Nswog2PcvnCzAO+tBHFYm9t78K03ryR652rZRGCBMsFg6hry2QcUfx4g+ZPaO7EHkxJOq98kqjScmDTHqfo4Tk3KeXzo8IQanwMWsjP229d7C7zwuJDpIJU5eYgywQv+47A7pFed0chSTZeMxN1S1wmnEvY5eQsW09UOrsdbp7k9dOBfCN1Z/5+mBKavFfZuY76Pt9pVyKw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H9TQv6/8Vs22Rv5idH7ZNY0BQI+EPQroE5ua7omUmFHig29u5IbRd86B98RHjYzWO7RU8AiVQQeNKijm2lPIEXbf70vNYHDonpVsIl4gX2kTzvQLHD80jQtByiz3PUCVLmxx0Tf4wwTlO0o/0rHlPV+jTOGZ05b6sP/0WbtN52vi4OaPu+8KDlx5HVH601hpvriKqB06EYoG/uMQ8iGgy0RiV42ImJ5uXwIxT+6RdPOeqGhUzy1ZlfcFM23HNQoGQh1ODV4p0sf2WgP8UNmFWM76/QXD1hhmPGP5Vds/XbNeRitEn+DpK5QMtbUyKlTMB97fMiXU+VK7Mplw3GIbue5NWbsorfR2z3uJf7lQ9nFAEnscAZWLFL7bljwzHrsRGduxO+qlWP6CPF+0EKSwoZ/tdYSbe5hP9NrCtl2JQb/OxZRpiJwCgVJCnuoD+PNb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:28.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c598164-44d5-4505-1155-08df19aefe33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458

A subsequent change will need arm_smmu_cmdq_issue_cmdlist() to co-clear a
pending CMDQ_ERR after a CMD_SYNC poll timeout. And this needs to be done
for both smmu->cmdq and tegra241-cmdq.

Add a cmdq_err_handler and a paired cmdq_err_lock to struct arm_smmu_cmdq.
arm_smmu_gerror_handler() now takes the per-cmdq cmdq_err_lock when acking
CMDQ_ERR. It already covers a concurrent ack from cmdq_err_handler via its
existing early-exit on no-active-bits.

Impl functions and caller will be added in the subsequent change.

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    | 12 ++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    | 17 +++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  2 +-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b8c3fd7aeea45..ca8f52142b07f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -698,6 +698,10 @@ struct arm_smmu_queue_poll {
 	bool				wfe;
 };
 
+struct arm_smmu_cmdq;
+typedef void (*arm_smmu_cmdq_err_fn)(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq *cmdq);
+
 struct arm_smmu_cmdq {
 	struct arm_smmu_queue		q;
 	atomic_long_t			*valid_map;
@@ -705,6 +709,10 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 	unsigned long			*atc_sync_timeouts;
 	bool				(*supports_cmd)(struct arm_smmu_cmd *cmd);
+
+	/* Drain a pending CMDQ_ERR; will hold cmdq_err_lock with irqsave */
+	arm_smmu_cmdq_err_fn		cmdq_err_handler;
+	raw_spinlock_t			cmdq_err_lock;
 };
 
 static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
@@ -1170,8 +1178,8 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
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
index 24f286e994e6e..409ee1be76815 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2367,13 +2367,18 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
@@ -2382,6 +2387,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_SFM_ERR) {
 		/* SMMU is being disabled, so other errors don't matter */
 		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+		raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
 		return IRQ_HANDLED;
@@ -2409,6 +2415,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	raw_spin_unlock_irqrestore(&smmu->cmdq.cmdq_err_lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -4529,13 +4536,15 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
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
@@ -4575,7 +4584,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq, NULL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 6644075c1431e..a595769e7ecd6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -676,7 +676,7 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
 
-	return arm_smmu_cmdq_init(smmu, cmdq);
+	return arm_smmu_cmdq_init(smmu, cmdq, NULL);
 }
 
 /* VINTF Logical VCMDQ Resource Helpers */
-- 
2.43.0

