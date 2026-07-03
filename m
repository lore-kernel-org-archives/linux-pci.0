Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA2318146;
	Fri,  3 Jul 2026 04:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051716; cv=fail; b=Kdl3vDbe8dVLXVbC/alTafwV8jGIKk4LjtDTKPI4RkA91pldEMMjJAknCXYN2hiZS/n5lFug4v8BWVn+ON+/qacaF2B1fEHsXBYgM6aXQ0pDwrkYGMrzgRwLFyABVkf1MIfJkKt3MWR0IHFi7qbKhjKYJe/bbUshMX1ocN5tTXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051716; c=relaxed/simple;
	bh=cW9E++BWNJ7ljibq0F9uZwRcJbexZgQUGGMvqwHj2Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnOq0W9yFIe16DKQRVGgtGUCLAeYHdIoyJ5HEl0QQ0e4tPJi/XHFC6ocwTul3L+X0++3NgJTenNylQfbykSgmChblJf6aGENNd1VX9rDPQsMl7VuqBmvR2v7ggZGJSFdZ1N8ii4EKgicBRmE6QNKw+MVBal8BogAkbmBiB33PMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pEM21umj; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pEM21umj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7zaO+s72SdhQ9oH/89SvEjvoOx9JPHIbe8zRce/Xhb7rLIs3oYn7JE5EdlCRcMIQVarPyJMxYQ3WBoupyg/Rs6h+85Ap2WCTrBlNvUQ7kC9enVpzvl9PlFUPtnL5VwUw0V2w81xZOm8SiK3yrct6Q+hfGdXN0Ot5apw8dXusXYx4w91h385xgXlu/tDX45AKnhC7+XYgX1ZD1IePS5qjAb8uH/vVmKUnbEOcTteBUOHjXMri+HQo+wJr3JyRP31hiFaIPdo2yWAre+JlN6shPqKkLFo4SAuMVcnHlx9BwtZw39E881/WLuRJWqZ3+R6zOHpWlwUlz3wAZPbn4dzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbcStzUawcDx9O2gqvI8GLvUzQwXwJE1IOiNbhOJ56A=;
 b=sxX/njxQGm2e0Gvfugen4urcWyfWmowJSEhjxmtOkGnWV5/KPWyK9cs43gbIzGzk2KrPOQul+9n+fZI+yuhaaobqrR4tB64XxYPaHzobappmwkX2V+DpMdBl6L6o0YFRpIJ99eIi04xGL/DZGk813tvhcPJTpWCDdPu5Oa91QUBpo2alREauyJJghFe5gaskO8LZ39fGkD90Eas9iZ9nxgY/2dqZMo4X5XhXJQ52WJLjRQJh/syKQIFLxCK6lL4GtZZFhqE8PRRQ2VXQizVlps6IftaLH0XXNQ7nY1q9cM7YvpMIn+7W8+TM6ZgvYcg+TRMXDA3zdoD5UCCzLDO6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbcStzUawcDx9O2gqvI8GLvUzQwXwJE1IOiNbhOJ56A=;
 b=pEM21umjdNzaFNFodxBDuffJn4RGTve+gvqNxn5/V8oPeJR4KNEpw8mlJPbL1kQDZUjuca65yvjo3vUGcrgQE/cwIG2nxvV3We0rE6wl181qZH62XO+98OD9j+tDcKtOpirozIVoXoQsjnqSuedruHhxg+l6QEh1Qllnh3VJCT7vEdx3DTdyKZk7O8Ove5rHuGSWypA3P03F1MDgcQaXXEYo+0wc58fYIv3EMAjOGEnhENo/yJxjx/XSfeHY93RuIPjUvs2TLcoqAC5yZKX+ndvMu9ntMWaRS4eTViIWfBcmkDuXemQlHXgwd0eUQvZaoj1Trc6GoNs1rRq1vNhgGQ==
Received: from CY8PR10CA0015.namprd10.prod.outlook.com (2603:10b6:930:4f::13)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Fri, 3 Jul 2026 04:08:11 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::7e) by CY8PR10CA0015.outlook.office365.com
 (2603:10b6:930:4f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:55 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:55 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:54 -0700
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
Subject: [PATCH v5 16/18] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
Date: Thu, 2 Jul 2026 21:06:41 -0700
Message-ID: <3499c9990bfdfa3580abb5972c816f32d037d6f5.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f552f9-f539-4601-b038-08ded8b8b2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WWoAu8mEJ5JgU1JAM23Fx0BVgP1MDS3J0i7BnIj6+OdYJ8yQLUFf+DCw4q7uiO2/LTSD9kZDw7XoPNnfAA/6vkjE/T+y1usOi0dIoTi6Zrr+2TqBwa+SStJhGdJHwI9B/uEEnfEKWAlBUDLLT3Mwcp1/eNCbK1N89mViOqKuGwTAwu2fkZxNTEZjMKHoINAmoqUTy5FrpM+uT+cYzOo2VouoPLmvYBHt1xLzJnIzANjmAuU5O6D5A1WS0qC9h61K9K8KN+cOF8DTe8wHldShcBZuRUkmdhq3f6CchRAsNz0tAsuVm92Ma6p1n42mia1kiETaYHInIKgE/gc95A/poLC+L+mAod7RTblb+TZ3x+x158/eCjwIpVZGwP0566EH4bqfCfgbA5VJnB4uX6Js5nkMs/lSgWnbhcW6BgSmtUOOlO0dFpuK3R1ijAPfzbWFzhFnjHINqsmXw7XgvdBv/976JgZIiOUaqP0uPF1gkiymTzIlxY7xeJgGc4355DL1KcY6v/h/cj3VvSJRjb8a85Nby22xsERkc/Vk5Cd63DiaNz+ZS4je2pG9R8A/Z/1CNPw+uXvlRsY3M52SbXYS68OhJwXKziiIti4olWmsVL1gpXLQxzHYFhkWsfDI5vNZQ2xC4iMgf62g37Zcg8TBd7tM/jD8T5INYq+IcQv+9dOuxw6DjgQz3HDbKanP5cHTvuZ9Bgl78j61UC7DBYfP+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mp4xN3dzIvftL5SRKdiOc80Bp5nlbey7l6tS08ipN1wNkQxjwn/XUwJlQFBCt6sq8JHpSuGXjmIWN/8oQkIDfizlUvH/tIhEoMK7+URB5RiLqrE92yjleT29AE3QEYV2LIJ5VlkNGvfNZ6n88DSvpQvyR9FG3go02NvUCZM64aiDMERFfcoDXxYgrjSk44/IBCgyNsyomYLN6CPKJS28nSz2EguFSjKjo2j2EkxnbI4FkNwYID/ClbyY75KEfrSmTN/8UCdPb+7ho4/QoO1HeTeYeanfT6EzD9j87FiX4LQiN9Vy19igxH6uV5iTtNO1BZMte81PKQZhLr3pKU/JR5xqsyzT28HKZg4eexC7GnOIjIxrRjOQDXF25u++59KtN7D+S/oJ3NRr3onZuvTq3dVDUA1OEMWSxYdnqG3l0eMfqDvgJWnS4dr4lWApkLO9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:11.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f552f9-f539-4601-b038-08ded8b8b2a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for flushing
the current batch with a CMD_SYNC before appending the new command:

  - The batch's pre-assigned cmdq does not support the new command.
  - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
    forces a SYNC at one entry before the batch is full.

Factor those checks into a new arm_smmu_cmdq_batch_force_sync() helper so
that adding another force-sync condition becomes a one-line addition.

No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a18a56ceeb7fb..0697bbc558d0e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -928,16 +928,27 @@ static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
 					   cmds->num, sync);
 }
 
+static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
+					   struct arm_smmu_cmdq_batch *cmds,
+					   struct arm_smmu_cmd *cmd)
+{
+	/* The batch's pre-assigned cmdq doesn't support the new command */
+	if (!arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd))
+		return true;
+
+	/* Arm erratum 2812531 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return true;
+
+	return false;
+}
+
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmdq_batch *cmds,
 					  struct arm_smmu_cmd *cmd)
 {
-	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
-			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
-	bool unsupported_cmd;
-
-	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
-	if (force_sync || unsupported_cmd) {
+	if (arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd)) {
 		arm_smmu_cmdq_batch_issue(smmu, cmds, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
-- 
2.43.0

