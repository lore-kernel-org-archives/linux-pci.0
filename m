Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F444B0C8A;
	Tue, 15 Sep 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490378; cv=fail; b=qI/fgd47R0zjpg46sWp+WTXU4e8vBprmslEjTVOUQSO/q8WliCIxJRhz1l7Ga5kOfrVwiI99qMCtELyfFQ1CCGtlep1nc1TZmqBv7Ub6jecCEydvy/ISVV+hKpgewZzlF49x2hTQ7z7pJd5vABKimtN5yUUjQ7fz+nWwq1IGbx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490378; c=relaxed/simple;
	bh=vAYkV/e1L5+0HkImYOMbboWUTofuskCvKtoihKNfJFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm20lZJ1aVJt55YSXb6c8njmMY0uwPz5pZV2pOYnelPgT/0PHkxDc7y3CqAW75TAp6WkptyFM5XzusGqPLHRIjnSZ9Nhc8YIeHf+jG4Wc76Hm4u7Sw4muRtNiWQMrb78yxadpPjuRhqCwP/mciV0UUiF7KOGQMJVHVk2W39aka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XSkpMAKs; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XSkpMAKs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkncnBv0cKuzGx8TqI1fdG74UuyNU9z1arVA3UADc9j8O3WuiPbxhSVBtzJ1rVnxUiopHj3anwYex0pWCJ1H9ev1o4ypJag+kqwcMaeyrivQb+iWWXWq05DOsS8Qm2pCt+khYnvZaKtXodkEjHqw+Z1kmYTtvXXUzAs40Ad5YNWYgggsGgYD2ODXhYK0GGwPYnJVyn6BNMKNrcAeLU9wDhHgar7mMK3YHHnvyx6Nf3emJExRnJQygw6cv0y2F3bSCrBpxPF6IfOkDOl5nPsSCL0w1JOqcgJN549ulFTALcaYbykasl7mYMwatnDAK1aL2JL3E2u3W8zlQ9P9ghBz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujW25ZrUkoF5v8uQDnC+wvy8zrA92aF7zSzIULC1dUo=;
 b=mfvec5LXzfM3j3N73d2z7WwYWz0M45mr72cFWoGwzRJqNWiQhJ+ns8AhvR4SxxYxFYHqL8+hkC+q3fNA9q0T0b1hFNsFCcVz3RajiVjtvWvoSnoBaLZxHsyET+6V9U4/n6RPhGRGGVK4KXbA7HV11BA2FH6I5qLqZ79s13npkJjYnhuQgTNw2Xzwwd0NQ8n7Ib90R6vb9PRiY/yxuBd9iyyswEQDDIRIcb+VMcd9JOdI+7P3iUjSggXlBrYGgE00kICutjjakbnnHikMkZktPwhiElDq5872kUy6ZrPdtUxIWRftKpG8GE44vogQs5IYMxpHJDmlktva1O2V2Rg7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujW25ZrUkoF5v8uQDnC+wvy8zrA92aF7zSzIULC1dUo=;
 b=XSkpMAKs0j/L7QPYUqcMANW6NtRIXI5a8EOL+HFDARVb8TBP6AwDKASmJAdof+NZfzpRuFndtbAvqt3X/J4kZc/xFtJLAOwQjv02YXJlL6KoX985NrGKyuU2t07MvFHr9t7ANeEzoxUXSkFu6sxdsYuYsPNNEd/aGjN3gfZNWPSTdMgStAEIGXvMLBFT0m1iJBoEzJ2+Bmo7q1VgvzCYpiDRIqQbEqU6fXKCy0Nco4BjDeVOHSZzQCEOwUgigJMJ9VEZ5jprJNxW3m0uAP9SicTf5BYKc1rlldHopkvu+cXtaHI98zJsDGeSNnl0D6xG8DF59F9ewWv+7qeVteX4VQ==
Received: from CH2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:5a::32)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:39:05 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::17) by CH2PR08CA0022.outlook.office365.com
 (2603:10b6:610:5a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:38:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:36 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v5 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Date: Tue, 15 Sep 2026 09:38:15 -0700
Message-ID: <1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: acfb8685-7943-4b00-af38-08df1347db38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	0L8kvmiHs7MEax9gf8zxTrJa6bIjIEeckWIxbxG5a6O9PkpuRMztsaCbBtGzmWvTHylIYT96DuZngaYRGHXcAqNeki5RAtU7qi5e1N/+PkmqOLGLYvPh5yS3QH/CH6yxfR6QKXEV8zzKzVy2k5nwgTm2GoLDmq9m3T56ltWZS5C0Ei1M7fLHH3cV8a6c/hzv81QYKh6ZdtQI6nmC+q515i2upNCNclWUHN0+ycIRU9IMF/OWNlBByxoX++mNCUVb84knlkF6DDdC1YXnRHF27USposyNSyU0NtsOBV7vt3GSoicj+tst5kqcUNozQyQ8y5vgt6bVl6+J0rOsxLaYwcgePKI0aEE5xPh5eYHwirKI/KLBtfONPxwjWsA4yNPMpHdSLED+X46gEjLCGV++3z67CuAuz3MSKeN+A1ms6eVJObuQ28Wgk6ojZRhPEWmbkBpo92S8hgQi6OGV7IjHB6KSydlP2Y50wTRMjyELDsH7E3euH8syrjTuSyi08Fd+V+NzGzh5/Qc5YK36rzd37FzTJ6JL4H28XREsFnjMLa7NUTUlgM/gNXVxGRmxCyDfsNWptNHxZv5By4Ebu2Qktxu+i1W05bedWI970Kn0bw3lgWgwzILANJxXy/LZdxIvNEtz4wuZowbJV9Jbfw3mSdLT0/Tp4pdMN3avereGkx/zbloF1BZNJzBv7SoaqRjlkDKZVu8Lj2O/PRJiT8aB/w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	todoNaYhuxfmad5k+QkA66tDjQWfjhFFGVntSQbljD/iBCASWiowNPw0+dE/iMWvBvnIp9or3beANVB6nVTPAMCNPH+QmBBLj2Q6R8V6sbDY/A2Xx8Z11TCqVA+C8h9VQBgMsDcuY62+ybaqnD/Wo3NItT7B+HWslZ9+aKv1B2yB4N/QMQKMkMmjNpey85q1tyEbiNtP7FsZNx3LaBssnTZmVFNVcKJvs8FhbSyOKLNXE3dZtAgAx4wgJooCvbAQerHI4IkXe8KSq0xEO5Nwa8jKu7OZfN9C2rV1VXA6k3P9vqC5klG1wDnL/FwNhbPLsUWEC9Xb0kdIfRW09QWqv2+Ggn5GpjtQs942T7lVdimjQAAVAhGe8j8m2AZjLJ5BAGli6XT3h6Emnv9QEhOz+xT4MQ/vmUMRMTOHAGy6n+iKtTW9F5tK+rrwiEpmvyHw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:04.9616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acfb8685-7943-4b00-af38-08df1347db38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066

A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
compute such positions by open-coding the two macros at each call site.

Add a Q_POS() macro and switch the open-coded sites to it.

A subsequent change will build a Q_DIFF() on it, to count the entries that
a queue pointer moved past.

No functional change intended.

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5b89bad71c102..de7e4284658a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -187,6 +187,8 @@ struct arm_vsmmu;
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
+/* A position is Q_WRP | Q_IDX, wrapping at twice the queue capacity */
+#define Q_POS(llq, p)			(Q_WRP(llq, p) | Q_IDX(llq, p))
 #define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 759d0e1126b30..b908a8af31442 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -181,8 +181,8 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 
 static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	u32 cons = Q_POS(q, q->cons) + 1;
+	q->cons = Q_OVF(q->cons) | Q_POS(q, cons);
 }
 
 static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
@@ -192,8 +192,7 @@ static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
 	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
 		return;
 
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
+	llq->cons = Q_OVF(llq->prod) | Q_POS(llq, llq->cons);
 	queue_sync_cons_out(q);
 }
 
@@ -218,8 +217,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	u32 prod = Q_POS(q, q->prod) + n;
+	return Q_OVF(q->prod) | Q_POS(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
-- 
2.43.0

