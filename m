Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342ED31B803;
	Fri,  3 Jul 2026 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051708; cv=fail; b=nLPDDfWiopEDl3b8z0rXbatuDkrMi1VMR+fEyRVg5dKCxxqSA9ylaHou+LIlXvUuiNN0hGQM4eJHgdNSENslLtLzJytpCQ9IwAhdij/qAk2bEvy0l8ixEq6VmMlvPHchDk1j61bMAIihHJzkTwc3azl67oAUgRJqB+a15s4D0ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051708; c=relaxed/simple;
	bh=sCf0ek8fkIKr21zg4DmxRRz5e4Dl+u1/5y/gQOI9ajI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJlM6t1BkJ8AueoWBsBMH1p8K5UqRS9WySyuQazfw6O4c++RRnV8J6oTmgiXufnVYnqN6ugzx6u79fUKntwFN5j8EzRPosNUxmbxvIeYqHpDnCPNpErRuJaZlLFPnRbwcJo2hwHFK1UL22bEzwXLpGg9CvkQJM0dqg0Sd856BuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJnBb+Rz; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJnBb+Rz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgfWCxRQShNNuLKPZSQ3bnADjyX61Gp8wPxJ4FgOA3M7SYZGmHTCmnYe6/bR6woJaUFBW1MVajDM+rAesL0MlXRR5pxVPf8kpW1abjAR3fZoWbh0dxZ4fT578MRzYK+NzIiX1FUurZXaZApjocE/5gElapPrbtxCSNsAyPZeb8ENswVTh3fAbv6ANKl6zN3/XvIC0UcrUAM+sG2kRVXSDrf96sK0JzqnuT3Qi1FDQLNu305fquXljWdSuSZ/qnBRj2tgejS9zFii0FBz+5ZIpjJttb+clLbiF7SNuMHp0Teiocp9HM/6FuRdPY20pFVBTPR1iK4yRPze42vF6CHF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ot9zEdKdQ5AVQ4OIzZzs472D37YtdKIf/AvzG2LPps=;
 b=hw50DwHs+vvQusGLf1BjCnhzlP6S7vDKowJqCgy7rFdBoeGCDAUOILD2DUoy8lAAaNBs4DzW5qt90yV6hNxUirWIdRTBKV+euOxvtKk94KUirFycH8++QwNHnVfV/iROPeX046fNSWsU0IlWWILq6GTgY7B3/nnkt+EucfJQ8EGAJUM8PYK2hhUttnHv7RVyAt7eUAe6A+uQV0Z93Y48M76nf9GOiSfTFp3qUGJrXcn/nTcavyq/cWm9au+niRmHKLxf8QIiqnWKYi1mECUAYd7SidKYLOV+almjqyC09+ZqZUWSgFvVGGjD/6R+hb5a68GOQkWXY506OF8F2r7Fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ot9zEdKdQ5AVQ4OIzZzs472D37YtdKIf/AvzG2LPps=;
 b=GJnBb+RzZnRBnFKisWYABYAI/Yp8AzdhGysyYtO8AvzhS7/KjTTpohL1nk4md3t5XRL4tgW3cKUAgyr5DcQaNY1aYmIB3Zsh4TLdaZrnRvW50cfu96AbkxZIXGVjJQ6sZ06C9jvWTOElJVGEGyGFIZj4d9yu2zSkLJZdHkbZwt9ANB0zfjqGA74YlwNTxrlZqsG5WpVxeEJf7ivXr8BJI3CzztBX/U2nII9zBQPbNy+AxMhu1HJV55iIMZhxabrfTAf1xB4j5GK4sMxSt8Oxl6RXzGoQAU3PzU9hmakOd01Ue6Q/qU779E4ZYcZsWBRFAJRbWff/fHDn9Pa7aTCLXA==
Received: from PH8P221CA0066.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::6)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 04:08:05 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::95) by PH8P221CA0066.outlook.office365.com
 (2603:10b6:510:349::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:49 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:48 -0700
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
Subject: [PATCH v5 12/18] iommu/arm-smmu-v3: Introduce arm_smmu_cmdq_batch_issue() wrapper
Date: Thu, 2 Jul 2026 21:06:37 -0700
Message-ID: <0abc2e92551aeb483091a975915eb5dfe07dc007.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 09545dc1-9ae6-416f-e46c-08ded8b8aeb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|1800799024|376014|23010399003|3023799007|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OR2CN3ty9vBEvBHFbt8A5xR7jGLi9TF7PEQ9P1lLAT5IPR+tHOjMqmr7/SPaqYevTqfQnp0YWTmfO8WqcfkrXgROJEtNHfqTHCqu4AzOpxaQ/AKWywoZCT9oB7cC3d95O8vuAmIZg8kdCGx9DKtXoXfvglOEu3fERCAZVeJk3XxX+j1UxF4GLeIwdMIy208CBPImF7kX7uJr/4rjhSNNaj39d5FLWSBEaPPAq3dq1HPwpv0iEsQhaMyvyF79eHaAinSZIYU52reFwX1KWzRfyQKzmkjBlKrDVX/RZTxPYehLjJlOPq7aMo+Cc8QbUqxBMWjG30NhP47r9lMCY0m2k2LaRnOdsfG5+Vic8ATped2fUb6jHIbWQ6gLSLZYzz8HwCOWp7myVzbVE+fi/zAI3v0RzYPaYENWhTerSSMHmn/Xg62qHbOgsZG93fj8RkELolvApJ1YETJjdagzMUkAWjtuDrLRApvDn1ETiT3HQb3AdrX2JZFeqfhcdsy6bLI3gnsDneiJiSfuJrsXHSVmcqbMN4D0BPf+GI0Rh+aPOvTOa4z0FUu4jbTMbwpnhaN9HB3U0fagaa5FjB98XsIEPcEAxTiyaFcJ8rELvc+FlJRlg9pjPSpPiOplBhcoNPdIrlu4UtfJcC4e+fl3FMfn2/d1FsYdLsBoFoh/nzqSNeXDFwVHsdLpKIzq3hg3V8oZvqKs+yOoqG+JuIkP6jwQiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(1800799024)(376014)(23010399003)(3023799007)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3J1/wrmUIRLpLt07nOKStEdnyWYsEg6dynzQEknHb1RDDQhIP7f0zv9XA0xcIeMbyZMMS5dGu4aeQqVzI7vfsmLW2e0B5zEKVvAmyA2v/93rZK2prCxF4L0mT/4pCRQi61NHWeR4pcwWYhPs68HyUDWX6L/6lXsovi/gtQzUBx0X1IRtXnNLXZbaryaheNWJxQO272pHS9KJ1L7NdwoZ063prRIG5qPzbBWbezQW5za/TSfec3bf3D1sNmh22oFujTpUkUnvTpm9I/0JpNK5SLuacIMeKbtfzNe4iRZlQYvk+ZpFJJRCFdINxpjlyquYCLRiVEROEkjEIhQUayi6+HLsKBiLb7S3M26CYbigrWSnMguZcHpH8WJvrqDVWTkul9qQI/mwq+FK+TS2YS8ims9Kyn0f35DIl3o7610nRDZ9DOKXqKMYagaJQ31/46i6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:04.8525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09545dc1-9ae6-416f-e46c-08ded8b8aeb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575

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
index 4b4e8108d5944..6c099338a17ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -919,6 +919,14 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
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
@@ -929,14 +937,12 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 
 	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
 	if (force_sync || unsupported_cmd) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, true);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, false);
+		arm_smmu_cmdq_batch_issue(smmu, cmds, false);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
@@ -952,8 +958,7 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
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

