Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434333E37D;
	Tue, 17 Mar 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775001; cv=fail; b=oxtV1Mnwk3XFL8veqVpzMzcqI/CvxafqCiqQPL1goIyzi8jPw9ytUWUVvtGlNar9p+ge3/UNuiI3UPmQh7jruCqMn+dDxWSOaENHBaKAAUcL4x8gZyL1Cx72ZSqJiKqIAG+sIxQtfbmV1jbjISqWIrHFey/TmBCgul3VsAMgjgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775001; c=relaxed/simple;
	bh=8IdppG3r7uOoEfFHkHQKgtLcnrlI8FjDafZvkgte9PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2HisPSZhsEIZInlUip68AXH7IG54fY/W/bBVPMJtK1ZRHX/y+K4sgso57SynbEK2Sd4FElO/UEsNekLGVLsqejb+eoi/kkuKDIWlH2j1oGbQGOYz+18GQRC3s7wWjkR/s7K0eRe1XHT6vqyDxBBOtsh7x0z/X45yozHZld2Onc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rH1GUDw8; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rH1GUDw8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZcxTEafvMCMaMOv9SxNEaEgSn8nfB0ezSnVNbeuyPy7WiH3pcCouXDzULn7V67ufbBGNQCYNOpWBBirgdrcyXiG4nL95qlkrExzxf+RjOj0ZLr/uvLuVh9W+s6aYqjFHJ0xCJB1w6eNkPaqAEYgJ1swm87dz1+WVpxnFGFOXr0eUQDMrPFfxGyXo6OzUiIPMgh9Jb+IcZmTHQOCyKkg6Hx1IiQzHIYR6Htq+AO1TXtC+MeJ3A1sEPbNyCRseu/tidk33HCpmGpY64b+i8bwJevST136nbI/iY1eg0lj1ebYWvHgd6Pc4KCj2qCIBvH3fwBryWGEgeevk7AQsW4EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs7IkxuxaIp1J9S0YBd/xcF7iWQbDGAPWJc01CZ+7To=;
 b=CkuQb5nFtfPqhzkvGNtOmeFv+jD3SnTcRAjC4bLPKmAqEJwdGAWaUTGnIRc9wi0iG20Cq4OYGWM9+5XvVqCGu93r/5PJyIO1GF8Tnm61b3Zzw/ryJutXrYoCDIoUSC2NANXB9/lS7oLmHHwIjgRV+9mOSDr45YDJIYCPw/086KYEYWfdsQEI2iVutG+swOLoC06q6Htnwh7rEnfD8MZJ4LM7iw73N1Y+iSfIHVU1T5LH9o1slp/Sb8uMLcBP/JL85ZWFIpKN2AOjviiF/6ktKfEBGr9dxszHNx0qlSPJk+MDN5Vp4ac76T+kNyALauWd6C/8akV5CuDM88DjqE/rqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs7IkxuxaIp1J9S0YBd/xcF7iWQbDGAPWJc01CZ+7To=;
 b=rH1GUDw8UtgYft8vHuLtV4aKv3fKOz6reo49BVQ+lYZlN3ikeZZo5TKzG52v05+ELWiX6NT3mXIexzPYrHMmTWT5SdxhWb6s0tBwWyYIdJsRouvCzFTeCOmgnOneVWhKwsYAukeXmM0MIFKkGAn8lGyiXWPCTzunRTgvtxTTyfSZ3SUnOle1Hp3Zx2CBzuzU9v50J4Se5JupOZjvzeyzB88wpoEKNmOGGHRqwtrSgEGM4LS+/SQErBUzW87l2j1z9H/plaL0nG9wIwOQI8OLMLBrxqMcIJoJxiIBATnT7hSmeKMu8AQzKh44akNEY5lk4cR8N3s2GIo8xnhBEWhN6w==
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 19:16:34 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6d) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 19:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 19:16:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 12:16:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 12:16:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <jgg@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <xueshuai@linux.alibaba.com>,
	<kevin.tian@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vsethi@nvidia.com>
Subject: [PATCH v2 5/7] iommu/arm-smmu-v3: Replace smmu with master in arm_smmu_inv
Date: Tue, 17 Mar 2026 12:15:38 -0700
Message-ID: <5ea483632238b353cf491904cb0e81f51a9f8327.1773774441.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773774441.git.nicolinc@nvidia.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 762dd030-2f12-4f99-2d0a-08de8459b443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	t/BCP2Rn3NNpjqnu/G+Byort8X6Guwjn5kh82lgACodDfZsE3Y2ND1pc7WBY1HaxUwLFSu0QFCCAA+iw1LcuuRymz6kB8W3Uc0/A1S3vXpTV55cViKU1F0VjEjd40N17jomgyjOuM6aZrrKTM0rXv1Md0wyGFUQXQKwx4Fjp9EtSZzDFILYb0wLMHTIQtAjhfT4c/SOSEIqMhA9X54ooMx4PIK8qaalObnxpN1wRaGlwJxtrrhrXHz9SH494cbzXoNaBsMl5eS9U2D0GaBqn6u6GInV9yO140FH2YpO33NUHdTHzaE3rtu3sZAL2g5OulAX6eEexjgR4WN27+zZwtQao4hLjRHyKSanYdjlhtmUWm6NfVoMyAC8wKgFc6nHbJT+DbDKUVJ1wPosRptS044+YRN4VdevHMkbrB/QzmgxPVqMGWLZxeVQd898RnR1DCesXmxoIi6lz1rNM/53cCHWZ+76GbjAJ/eSh2Exiig8iBa659zyRN2/GZSmMGDhaC4zFdfI4EblLTjLEC34EOPO/h2mnkN8HF7JQL9pz+4t+VuTynWSSgJ9vJ1JDqhtvB0526teiRsxqE+znFtdfbNXS6yOI5+phqDjvbRyBJhJA4zIjgnnRmKAvUSbyyh8kZLcqN6WtrclxOHkvHCxi7usPDKIh43ORurCyf+2mv8RI98HpacvYC6sNRcsybT1bnt8sY8sxh3ePjv2Pxwt6JZob+cS1eFmiqcaVrogMh//H2z2ThaN8rFjP5noKnQ4PpI6W4tz8+IClGUj22ebvrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+mEUP2ZhP09u7Ldj5TirQPMomcYPIFXpR7XN/BrGa9ljGA2MElfvhCYM/u9LIEZVTUXRal11ewEcQPfR0gyV3XwbEP83pxkdUOcSJgicXMULDPHSVvhgcrQC/ci3UJkfv1OHBser4Wjmbf+/tiBsxMYH4c90jntpgsZ2OCdzpT+9/YWoIOIAwxg0ZzuNxq2YHtYN+f69Sv6QkpBGeQLBrZzqWDY4jyutqr6SKNTLRpA8Sx1UlaaoIhZ6CLO8MKrj7WSUYxv6zAwxHckoqq+a96ntUTXgQXy0Q5LpD8M5Df8O902r4ydODvd4vE1/SRQmkAgwIYjvjpd1t/aKwkZtKpMntka3V6UOI2RHodkh6W09HSO4IU/1SoTiQroU4QUmUcIwwEhGjTttpFRUj0DhIbtnhtmqwAdIuPaB96DDroa/RsuvcKEfev4fYxNTi9n/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:16:34.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 762dd030-2f12-4f99-2d0a-08de8459b443
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

Storing master allows to backtrack the master pointer from an invalidation
entry, which will be useful when handling ATC invalidation time outs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 34 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++------
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3eb12a34b086a..cb83ea1f3407f 100644
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
index 9c8972ebc94f9..aa42fe39d66b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1071,8 +1071,9 @@ arm_smmu_invs_iter_next(struct arm_smmu_invs *invs, size_t next, size_t *idx)
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
@@ -2629,22 +2630,22 @@ static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
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
@@ -2671,7 +2672,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		if (READ_ONCE(cur->users))
 			break;
 	while (cur != end) {
-		struct arm_smmu_device *smmu = cur->smmu;
+		struct arm_smmu_device *smmu = cur->master->smmu;
 		struct arm_smmu_cmdq_ent cmd = {
 			/*
 			 * Pick size_opcode to run arm_smmu_get_cmdq(). This can
@@ -2700,7 +2701,8 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 			break;
 		case INV_TYPE_S2_VMID_S1_CLEAR:
 			/* CMDQ_OP_TLBI_S12_VMALL already flushed S1 entries */
-			if (arm_smmu_inv_size_too_big(cur->smmu, size, granule))
+			if (arm_smmu_inv_size_too_big(cur->master->smmu, size,
+						      granule))
 				continue;
 			cmd.tlbi.vmid = cur->id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -3225,7 +3227,7 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 {
 	struct arm_smmu_invs *build_invs = master->build_invs;
 	struct arm_smmu_inv *cur, inv = {
-		.smmu = master->smmu,
+		.master = master,
 		.type = type,
 		.id = id,
 		.pgsize = pgsize,
@@ -3261,6 +3263,7 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 	case INV_TYPE_ATS:
 	case INV_TYPE_ATS_FULL:
 		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
+		cur->master = master;
 		cur->ssid = ssid;
 		break;
 	}
@@ -3457,7 +3460,7 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
 	}
 
 	cmd.opcode = inv->nsize_opcode;
-	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
+	arm_smmu_cmdq_issue_cmd_with_sync(inv->master->smmu, &cmd);
 }
 
 /* Should be installed after arm_smmu_install_ste_for_dev() */
-- 
2.43.0

