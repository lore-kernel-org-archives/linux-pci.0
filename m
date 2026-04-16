Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B343A3822;
	Thu, 16 Apr 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382209; cv=fail; b=TiDuTRO7ZaHGKeS/KE+Zh0g+3A8cntleTcCB/4Dm8q5RykrzSc83d5ySX3EnWi8OWa3vluXx0eANJl9BFuMkZdE74QSAO2PIaIjlyLfTCo0kVJDuD9tMppRqocL421fDHMDp/omDCBOLwT8ARMxsjqIsHbYziG6J6H6j2oiBGtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382209; c=relaxed/simple;
	bh=9a6VyMaWHeTUg+MgSaZyzwz5ShpzrGB6JUucfnO30Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egBkUJEu2Mce97K+Gtdd/KTK76M4YVhBsw5cBw5w8pxULwsU8Y4nYXFImuXgyQLfeBo6Z1gyD+vJg21q7dk9O7uMRrA2nQXxlDsxAWUBntWJj+cTdsP6hjwES1ZptjP+ajvAi5p5dAUe3gB2zLq+NKjgZ6WnUr9RUc+S7yTMZ7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YkXpY61a; arc=fail smtp.client-ip=52.101.52.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YkXpY61a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpW17sVkjHOfBz7cQptxWlYsGUorjYHIwtArNI1uRsG3yM3Upma4tjS+hEpqltyKgVpH/gjod1o4EBwOtAG6hjyW14Bk6B7d06I714TWuZ2JAY0dUTF1TCCpeCQ18CqhcEdlocpsI7VQcFYJUfKK0LK8K9O1h42gUZlhtYk7SK61nc0drB28XdmvPmrjh/rS0+inkrsDyRK5PaVzj5mNrn11E+Q52iUMNUqYQBQJFZXC0Ks1VrYGXOqWTGajXQ4zhWE58pf2djAkYcioUQgWoCq44Mk793K6jMEZYtQIsULxmfEs0wDWOQ1PA/oUSEtqxOF666niCGZ0RwbyfBhJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryIQAqZQ+teoToUHrd8M8czPbYcUDfapm5njbOlsiRk=;
 b=dYVfVzwkuhUES7ZbtX1PZNHrzevvCgY8UY6ls2I7vxuoG3ChYxJNYX8Wh3l6I4HqpziaPY0AlmLd3VVguBOEwRNhLuqyWU/AlNIJXRAemMrPUqGdXBQAPQMyNexQcThHw3y+XuH4OeZPI33G9QJFgdegiqZe44UOsX/TlwkBUZZf53xK0pojXHGPeUcD4rCisrULfVAIhFd++gVMXbuOjTbd+1asFFsubYZU8Noj4Nns7uh2agEIwor4VeVqr+kXrFOIAF0tSJAKxQYh7u3Snhs2nWu6zASdPFR30N6rEKiasaugoJUdM3W4bC3XyvgWD6d8wnTVQcVM1JeDxVfBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryIQAqZQ+teoToUHrd8M8czPbYcUDfapm5njbOlsiRk=;
 b=YkXpY61a+nIJP4iuiiA3ioJPTzCmsDU6UCh7YEiHWn/6Jd3lCPJXXcuvd/9phANRZXI8zYX3qZqMquJ+BYfro3f50vyGz3i1FwGqwMt8faZp5bGgEcQaEzONMPdziEf6j+DkI7gbbb1BpOuhDzu0HB5QN3hJj70a0FxtfnB4N8VsQC4u9FVntnbSMlEkWHcbVSBkMK2Wpvu6138cRjRi5U9Mjh4KCKFEEQUSt4Ka0UEUerJEHBgZelEusTu7pxr2AC0TcDORaGlQHZjl8TF+O0zCgXQZjuzv8V4ISwjLilXpTk/q0TogcN8+JIOrDG414cHr3aU30+ReN0w7Qz2QRQ==
Received: from BY5PR17CA0039.namprd17.prod.outlook.com (2603:10b6:a03:167::16)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 23:29:56 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::b) by BY5PR17CA0039.outlook.office365.com
 (2603:10b6:a03:167::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 23:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 23:29:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 16:29:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 16:29:21 -0700
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
Subject: [PATCH v3 09/11] iommu/arm-smmu-v3: Replace smmu with master in arm_smmu_inv
Date: Thu, 16 Apr 2026 16:28:38 -0700
Message-ID: <492f57418f134cc402d249591293d9c44526ad53.1776381841.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776381841.git.nicolinc@nvidia.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: a16bd79d-40c4-46d5-2faa-08de9c101162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	22WVXzQGPy5XueFSrvfNHR/liNT0Ghv1Ke71Y+IGCja1Joa+FkE1XfqYxsIqoz7Krhz0R4LixGPICGdl47zjFLqO/eNSGT3v6XA5bjaX+1R2WW2ge1346jPsRmxA+5NRYZjBONTaU6B58g/Uu6LQ8/YWZZy7xvRObEVFLUUe7BcaJB7CSS7LRYG1FPUcZ6RnJGotPSBxFNyx2fGHPHYocxSoeY3PDAXu2MbCWRp6+mZS/sxAvti9Ls6HPtdLZQH86g0mU6g6+JyvaA9QFxHDEoc1QACp1jsCAihfqgsiR1+i+5GKT4YR5AH8ZC6e+c+2XQMiHNQ3PpZcM1U+Xds8iMOyUAFQARbo8LF6ftqQYl3bYwevrGEdlyTREoxiAtyL1NYfY1SwreSzL3m1vEBTQkni94hzPvntbzndTFCfecQz2VubFpmIIsqGOCtAN1WMViwJtI7NzMAEMoazG8u7IM5XiRRiVvZ4hGkQMUR+TAAg+jYIFGJSGqgqKJ1QOMrJmxAGCduzCK1i0vAaTMlqW9is2URRhjglIWZ//3K63QZuyB6W7Sj2y/Mny49HKjibwQFUpS6+NltKIM/ZgzxQvD/XZp22SWhvXkP+hn2AEf3XlY5QqtJcsbdUpvVZxUlTVkB4Z7AF4Q4FnCJvRLnO/JKhytB4sQhy/xDxn5RqERp7S4zNBD1oPWeagKf3Z7atbNBftUk+GA2ziXgAsEBkfcnKTiXnMW7h7cAriHGAFxktxN6mvTKwOEM2/ggMPeNAkfFSZJpWO592cMlMlQGf3Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rQ7irSzsByIcC6YOTWeFY8quBzI6EeKK1cYdlghIFqgCJScMWYvSm9eInjHVq7yeQJ7TUnnZYrtjBDcsY8O1PL6ds9jdZR90XS0qTu5jk9eU7B125JFwvDNNUiYWyEWgUURiG9GKiLLtUMOm27YBHio6/uFim/ANPHw6m2zauVeHem5PUqdH+95nMPSiRVzmeRH6VbSwzxOx5BKemaDbnVvnuILyLHdjj3Tdb1ba8rGgxkKq68wiehymI52jA/9N7COQDBnhCaIv0CjOjgQ10JWuXMQiWCGHHa8v/z1T9pSL71fQGEPwnP7+UCE6kxdNAz8xyOCeZJUrcSR5Bn2NYrxbUoe7NjWVw30iPXun1swjXYM/T8Fd6f5rqZTzpjvQfzWyxid5uaRkhKKos6M1Ew5Bq2P75OVhJ78cpp8G8/a0gPcMwDZqH033si2ySWZR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:29:55.7302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16bd79d-40c4-46d5-2faa-08de9c101162
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215

Storing master allows to backtrack the master pointer from an invalidation
entry, which will be useful when handling ATC invalidation time outs.

No functional changes.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 34 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 +++++++------
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1d72e5040ea97..26e0ee0bb5b45 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -662,7 +662,7 @@ enum arm_smmu_inv_type {
 };
 
 struct arm_smmu_inv {
-	struct arm_smmu_device *smmu;
+	struct arm_smmu_master *master;
 	u8 type;
 	u8 size_opcode;
 	u8 nsize_opcode;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c828..ef0c0bfe44206 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -653,39 +653,43 @@ static void arm_smmu_v3_invs_test_verify(struct kunit *test,
 	}
 }
 
+static struct arm_smmu_master invs_master = {
+	.smmu = &smmu,
+};
+
 static struct arm_smmu_invs invs1 = {
 	.num_invs = 3,
-	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, },
-		 { .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
-		 { .type = INV_TYPE_ATS, .id = 3, }, },
+	.inv = { { .master = &invs_master, .type = INV_TYPE_S2_VMID, .id = 1, },
+		 { .master = &invs_master, .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 3, }, },
 };
 
 static struct arm_smmu_invs invs2 = {
 	.num_invs = 3,
-	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
-		 { .type = INV_TYPE_ATS, .id = 4, },
-		 { .type = INV_TYPE_ATS, .id = 5, }, },
+	.inv = { { .master = &invs_master, .type = INV_TYPE_S2_VMID, .id = 1, }, /* dup */
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 4, },
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 5, }, },
 };
 
 static struct arm_smmu_invs invs3 = {
 	.num_invs = 3,
-	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
-		 { .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
-		 { .type = INV_TYPE_ATS, .id = 6, }, },
+	.inv = { { .master = &invs_master, .type = INV_TYPE_S2_VMID, .id = 1, }, /* dup */
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 6, }, },
 };
 
 static struct arm_smmu_invs invs4 = {
 	.num_invs = 3,
-	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 1 },
-		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 },
-		 { .type = INV_TYPE_ATS, .id = 12, .ssid = 1 }, },
+	.inv = { { .master = &invs_master, .type = INV_TYPE_ATS, .id = 10, .ssid = 1 },
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 10, .ssid = 3 },
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 12, .ssid = 1 }, },
 };
 
 static struct arm_smmu_invs invs5 = {
 	.num_invs = 3,
-	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 2 },
-		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 }, /* duplicate */
-		 { .type = INV_TYPE_ATS, .id = 12, .ssid = 2 }, },
+	.inv = { { .master = &invs_master, .type = INV_TYPE_ATS, .id = 10, .ssid = 2 },
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 10, .ssid = 3 }, /* dup */
+		 { .master = &invs_master, .type = INV_TYPE_ATS, .id = 12, .ssid = 2 }, },
 };
 
 static void arm_smmu_v3_invs_test(struct kunit *test)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f47943f860f3d..13f225f704e73 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1092,8 +1092,9 @@ arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
 static int arm_smmu_inv_cmp(const struct arm_smmu_inv *inv_l,
 			    const struct arm_smmu_inv *inv_r)
 {
-	if (inv_l->smmu != inv_r->smmu)
-		return cmp_int((uintptr_t)inv_l->smmu, (uintptr_t)inv_r->smmu);
+	if (inv_l->master->smmu != inv_r->master->smmu)
+		return cmp_int((uintptr_t)inv_l->master->smmu,
+			       (uintptr_t)inv_r->master->smmu);
 	if (inv_l->type != inv_r->type)
 		return cmp_int(inv_l->type, inv_r->type);
 	if (inv_l->id != inv_r->id)
@@ -2650,22 +2651,22 @@ static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
 				       unsigned long iova, size_t size,
 				       unsigned int granule)
 {
-	if (arm_smmu_inv_size_too_big(inv->smmu, size, granule)) {
+	if (arm_smmu_inv_size_too_big(inv->master->smmu, size, granule)) {
 		cmd->opcode = inv->nsize_opcode;
-		arm_smmu_cmdq_batch_add(inv->smmu, cmds, cmd);
+		arm_smmu_cmdq_batch_add(inv->master->smmu, cmds, cmd);
 		return;
 	}
 
 	cmd->opcode = inv->size_opcode;
-	arm_smmu_cmdq_batch_add_range(inv->smmu, cmds, cmd, iova, size, granule,
-				      inv->pgsize);
+	arm_smmu_cmdq_batch_add_range(inv->master->smmu, cmds, cmd, iova, size,
+				      granule, inv->pgsize);
 }
 
 static inline bool arm_smmu_invs_end_batch(struct arm_smmu_inv *cur,
 					   struct arm_smmu_inv *next)
 {
 	/* Changing smmu means changing command queue */
-	if (cur->smmu != next->smmu)
+	if (cur->master->smmu != next->master->smmu)
 		return true;
 	/* The batch for S2 TLBI must be done before nested S1 ASIDs */
 	if (cur->type != INV_TYPE_S2_VMID_S1_CLEAR &&
@@ -2692,7 +2693,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		if (READ_ONCE(cur->users))
 			break;
 	while (cur != end) {
-		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_device *smmu = cur->master->smmu;
 		struct arm_smmu_cmdq_ent cmd = {
 			/*
 			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
@@ -2721,7 +2722,8 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 			break;
 		case INV_TYPE_S2_VMID_S1_CLEAR:
 			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
-			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+			if (arm_smmu_inv_size_too_big(cur->master->smmu, size,
+						      granule))
 				break;
 			cmd.tlbi.vmid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -3246,7 +3248,7 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 {
 	struct arm_smmu_invs *build_invs = master->build_invs;
 	struct arm_smmu_inv *cur, inv = {
-		.smmu = master->smmu,
+		.master = master,
 		.type = type,
 		.id = id,
 		.pgsize = pgsize,
@@ -3478,7 +3480,7 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
 	}
 
 	cmd.opcode = inv->nsize_opcode;
-	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
+	arm_smmu_cmdq_issue_cmd_with_sync(inv->master->smmu, &cmd);
 }
 
 /* Should be installed after arm_smmu_install_ste_for_dev() */
-- 
2.43.0

