Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011323431F5;
	Tue, 19 May 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162016; cv=fail; b=eFLUrFxx0vUW5hIcxSt98b/X6b5UfHV3HIIJwivTIkA1suA0IKXzbderaL5wFFOfdRt5wKaKMFX2OCQE4kg5MhsnRW4BZvv+KU/7/9UosJsZgjKErl6HgAhDn3FCtVOGqhBLH+s1yecbvoEqxQPmi1HycMZJYx0+B19SX+uADJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162016; c=relaxed/simple;
	bh=O68Sv5EeP8m8dm8kljOWKQKUwUBJfjef92y1xiaqffo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+Uf5i9QWmOgKX883FR8eaSulwRhvdt2/Oj6odvzV+tJvMgHIEihAA1bgptDJJuG/xYrm64FnwmsS3XUV8gkKDFkhF83THirslxsnSawZwX8fOVpXTv/peTbDHhUymbFrQPCuV08l0+yszs70peLZgopb5be+f1b29oA/EOqMlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=frNDfGPX; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="frNDfGPX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAXNlKXGTkzHZohuWOzppckEV5QYG+wdW6gtyFW+kX12mrpgijP5RzVyrFigz6+Alsj9qQex1O3xbD7GhwGH5KLEYb9jmoN7tX+dVJQjgoTQhRMwu84pUg58r7q7uYhFUc0KtMvJSFA1Tj/J1J+igJ0+51ocCYqTAVu/iAeMGi4sUC8vH3cQHNm6XyeRlWvz096k2YlejBWDUvG06iqrihsmypdEt2UXa67vJoNoqk7XYgOsamzHtAnP0ykqfxORGX8zrGarmxApEy7Bm44WuhysyLUgwZrO2JtwLodqfhAWBsc3N1J3l/iP9YvhD+8nzwoi9E9M8iVsvB0ete+J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+x7/5/Fy/6rOv1uQrlZpDhuNb19EVA1fGM1kMxpquA=;
 b=j2k/KfzChP8QuLOWx9PtVh23tVSa7BTHZPiZalbowctZ7PBQueePvUGHygoNfYiiEeHP01ZS5T7iQ2BzFJPJFyzjpEFsqEtHNZYGHTroCsgLZr27LyYw4CqeSmd6aznAW9ddcXIjbPgWcehiNoByfcntvkfUg3/nQ5qj1//qWcQ9EBVNvsj9mXpdLpLDYGwC39BBhkZkj/ARSMFnGwZUa8cMr5COxrkT11RXjMiU0xdw0X7G6RBKTuQ8RKYvZnQtP7sOm21DVGLrWKX/ZzKGggNPunBYtqmU4j+wn9Dgzy6PAXHmJ4WHJvhWe4XVIU93b2G0avZjT7Lp4HE+qVQcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+x7/5/Fy/6rOv1uQrlZpDhuNb19EVA1fGM1kMxpquA=;
 b=frNDfGPXIH0iJAzMR8FNffrMr+FWWiBVkDMbF9SV1fk7shI8qYCMxMOds9HUpPgEkK3IGbB9j/h1nteBi1DdEiBYVzWhEox7eIKeGPzG1KJQ0EyB3Z+7Igeix+gP6vhRbBUjmE9IkYCf6+OliHfI+RH3502EB8bRQwoJyNdWp8CqDebJhVIEMJpl8SZvi5x3f94Ac4tPxhNkMYT36vUoFMaiwfCB/OI3b0MaqVqaIkM4EHoq02v65bRAsmB247kC/gkDtAbS1ngeo3KDnchlZ9VXk03TFfIKIy3notPdr2F8qAQLCMIDJUnO7XqFZzTcNVRUbTYpeJ865/9mgwKuOQ==
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by DS3PR12MB999215.namprd12.prod.outlook.com (2603:10b6:8:38f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:40:09 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::36) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13 via Frontend Transport; Tue, 19
 May 2026 03:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:48 -0700
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
Subject: [PATCH v4 20/24] iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
Date: Mon, 18 May 2026 20:39:03 -0700
Message-ID: <5c12fbeb30c621fa096d8639e5737cae665359fb.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS3PR12MB999215:EE_
X-MS-Office365-Filtering-Correlation-Id: f659b4fa-bded-4562-0197-08deb5585358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|18002099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	03Lidcxnm/M/bkQcAfqaVp46K9x3XjLKDvXHqz17vrbUMrYvpC6rMqM+5zcLHGPr3+XRTSm2NCe1K4rl/8UVh9ptg6dfUEOPhVmqVWQkTTPXzfRKbchJO2ra3JdxKzQ3KvEy1V+wkCBhDacAsRGsmkpqJRHyAwT31jKkHTTwbD/YP+CGZ/owkV2GVJwt1w2gfgZh+m6UdAgTTEoIlO37R38IZ/RzsyCiL0YGHq9UJgXLiSTcsem+4qfCq155xEHfuCo3njD+Rkz7dXk8309ebd5ZTXgDBLDZTKu/EUv/4FYgCSUD8YfoA2pyl7WOw/xB6l+BqTQ8G1LRExllO8ugQMVO0BPfHL80VEWp3b4jYxgt8dFOpqnvrArt8tNodErXAUR40j+DxHYPVgNWwLIz06Z6GuGEm/B7dQJamCR5AOEQm0GHC5pPMCIL5KCiOConKEXMqoVOD3smJdkTl6asU8vRzfpP5MX9VLRwAr/NJ+p4ZJ+0WtVY0VH3FsAf99QzzZVwiupZT/SkkkpMY43q3++yQIkcyQhxaG0ggW5UPCAIzrpkY8vXoBZgJ/9xTVCI8x2EaENNqnS/yR23xNZS5mHfljMa3YS/m2IQiUFNvxsCZlA6FDj/HizatOpUuslSgrtZ8ZIL8/AFfg0NhWqRfU77F8vqbpIqDNjQUBaiss2fZ1LzfBZj1k+B73Fw7wLrTjyzRVYejLtVnyHoq56ZZ5n/rpV2x6WiOOmkDMo3ctQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mVjtgrccAfPXL0lsrUmUoJLsCAy8u/MQtrMbPc6B3MQnS14FBZfgUnad9Z0qRKDjp8LSDUedQoEo7nrflHpQzlYzyF31f6lnickpknegb0QLn5hrWK/bGlXnALYporkrPGm96yhY0VxYqX3ndfXx0+mS5BF80rRTx1RXtSllYWD8GLYGAAQIKnjElKrbqolz3v9J7iHQe5WD79VNatjcCt9CH5+8qPJTYTz7NjExc60xTyv62U0aaznJWRzWyT2a/ELEOu65uM9/kkUG/Pzt5ketSbH3cuQpv7XhcaIhqXYQnt1qspm0CujRGRUo/8FdzuyOX+/vjm6bIGeShSlRzQKJx5ud0sXkdTqqFCJI5sJWQp0fcL4ylUMUCIHVEVi2JAftb5eTzjCvKFUMrCd3csI2FGnuVa+hZNrl4vaX6Kfqmt10ffh6R1rwjRUeepaW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:09.1874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f659b4fa-bded-4562-0197-08deb5585358
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999215

Both arm_smmu_cmdq_batch_submit() and arm_smmu_cmdq_batch_add_cmd_p() call
arm_smmu_cmdq_issue_cmdlist() to flush batches. A future change will retry
the issued commands on -EIO, using the arm_smmu_invs carried in the batch.
So, a single hook point is preferred.

Introduce an arm_smmu_cmdq_batch_issue() wrapper, so a retry logic will be
simply filled into the wrapper.

No functional changes.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31f8b1a94979..4f2b23b1e8163 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -901,6 +901,14 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->has_ats = false;
 }
 
+static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_batch *cmds,
+				     bool sync)
+{
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					   cmds->num, sync);
+}
+
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmdq_batch *cmds,
 					  struct arm_smmu_cmd *cmd)
@@ -911,14 +919,12 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 
 	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
 	if (force_sync || unsupported_cmd) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, true);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd, cmds->invs);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, false);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, false);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd, cmds->invs);
 	}
 
@@ -936,8 +942,7 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					   cmds->num, true);
+	return arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
-- 
2.43.0

