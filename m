Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596263290A6;
	Fri,  3 Jul 2026 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051709; cv=fail; b=jopRi+m8rY+xMIlll+BCctolH0zTpTr7ACMBAn28uMJYrIdZDDx0Ou9z+fkcjPYnp/WySTmMsGjspuh8bFS/UBR8+VTS5WHqTTEe0ypYWeVu27Q/qceTPzE8Sk4QS9xEobKhhkWQSXaJDJcLVTTXzhhkrzsDV0Fqq2qlnjKl/hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051709; c=relaxed/simple;
	bh=+U1ZIajlV9VFbHeDVkL1ilhddh6iy/YrXlQrVJP6j8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff+yzGPPlaRTMRNqispT6o1QHtmY/owyH0tu+tH1o8cZhRptNJ8vNfkVTT5eb/l026rE2iHzx3YyRs0I3VRaPWD5H6Gi3l78DkB2SOWKM620lLH8Watm5MgBZzhJg0KnwvYv+tKXzxxrwLJho5G/k8GNCKlr81C0R1aaSI7zeAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SjGd1zAe; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SjGd1zAe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+3iVx6nKqUcbmtQYoBp6J6HnbkD7Cs7jCxL9f61zfFRRFw8uKHwu9n1PRKnGxqaTYrUQ5Q7KzxRgf1vB+mGovKIejI0Kg/B7YRFbQO1IgO9YQbWzBx54xY+9V5v1XlXQVPnVs/90W8p5tMWWw8FPe+7VfrDtqqm+u67dQ5/CDNB7YGV7knoO7E6IvWMzFIVkGcaaStjlqYeq+1pLNwMDRTrN8DBndoA4l+kUOi+mfcB95fyONf5qXfBe+ajEcF+S79Eraf2Q3X2am+coR4LEsoRzm7Am9oA8Bi0VeIA67GC/64Qp3KKkh5mjhg1zqwuXg/Aq2yIoDbaqWiJxwNADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHAJiTbPsyd5FDehWx8tDYCbwHqOgdviWwAcvH/UbUk=;
 b=E8vnTLk/qPaST7MFGS2heNWFdjotBVJFI9Zd5sl/qC1OshNv3iifUybnxZB3iwfz2gWj7gOZwnrFuFza9URjUlUGMkM8I3Oj+a2VbfBODouMrbKdPXp3tppUzBcAd9uEx+R7RdhvdKnJGLuVYnLiLxXm9htpyxoEx1/PWa/M+S88bJsE2b/DD9XPzqF+na3mJt2J84rxJKTMfDpJXmAemJrnjBJA9AJxC9cB/wAXMkbmCzQd4gyliinQ7HB+2fKcVLCrhW+5x6AtQSbxHegcmm2+zrGHWRHes79kpAmLx4kLvh33FYhitpGH5s90fuwopoGXdJFU4fxcREfBrXlpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHAJiTbPsyd5FDehWx8tDYCbwHqOgdviWwAcvH/UbUk=;
 b=SjGd1zAeyeI+jEmcexbyT2zl9bKt7UY/PB42dUQe4R11b8AY+0wyVZg2xLTcSJtVUlLfnFIH3p8XxVTNWg7bSFy1WUW5INIMrgRr0bPuMGYYS9DvHouR2gf3aBCU2ilupxK1ECVfFjZmAQUNNRoLIGIPUT6b1UL5PoJh6C53yb1/RbEU6RjMz0JI3CB5j54XCCHXrHqcWv6LrKa3yGu1fK/jfesAf0AvTghOmCm0jI74M5JzHWv68mfgP8cTEJyRE2aB6p7yoxJ6QwsWE4UbmD4aZTkvgacBcrFTA9xJTHXHusBENAFe8tHvtV5pXDTWk9581w8ZXCrhxs8ee8qRAw==
Received: from PH8P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::11)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 04:08:08 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:349:cafe::8) by PH8P221CA0056.outlook.office365.com
 (2603:10b6:510:349::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:08:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:52 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:51 -0700
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
Subject: [PATCH v5 14/18] iommu/arm-smmu-v3: Add has_ats to struct arm_smmu_cmdq_batch
Date: Thu, 2 Jul 2026 21:06:39 -0700
Message-ID: <b947f52231c35c89d5ad427070918a6ee5c0fb27.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d542507-47e3-4eef-4079-08ded8b8b0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|7416014|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+Xooq5k/xtt0QIW6BIvNvY8nAqwMtEqlM/0Br4cyyeMbb6Q0+KUQ+wqDRjj6vSQKoScqKC6yWuTxWvHXkYa1ueBzGZt8wYk3po+d/DCkAaaqCIWEjQoOL84X8wD0B9uAL53gRy0qPy98PutBQz1mBUB/HuhNyyY6PNHW8VK2GNU/7InwOst5Z4uqn6SaRKVUn5cD+KVXrVv6Rc/HEKx5dejHIPPAUGVJww87poUzgfs6GQDoYUkQZ1nVz9LVV2AfPfQXk4jZXH7hWrTYhl7GfJNyHAcRm6SXKUA79lV5ijuaa1eVDYWPt0tJ7KJUYi2Yp4he4A0PsRp4uyPgQ0gJzPYMUM3z/iXJtqeuUFTyGq3xQdwfYedrFzUQi3BKwR4PVpNZksIWQMN2yX07EQhjxkJApxXStVu4rWOSRL7rLq5zTrI2qpR+oanhvgTphMBUEY/UZ8gQ2/s3NSeJ2IN252vISTzNWbalR75v6vxTuYYT86qCgx4tdB21auEkPh+pg0fqDV3X5oFCLZ70fz/qb3BdwdaJlMM6saC8gzIF3a384CHX5U7UKy3lzYJUYxvD6D2/o21sPk+3qd6qN3XqTvzG2+h0OORfhZWVcYPReu0QIBkbFPlrgQaVOMfpIwb9iE3mh5XMbKgHMRZULltuvACWcDjx1b2n9NiN4tIfgWTkrsiiqQejXUyg/aRhc9kud2BTxEwrNgFRtFFuQMdY/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(7416014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y5kB1MJJ2ooDjPRgeOFFUOoINvFkSLN77NdV4nknjJgeBZL9S4JwwL8PuJlqasLvvt+3louapno18X/CEKoKbw+F5OlC1uSdbCQ4eRfSMz2gKkCRh21+Wp4IGQk7YMtrE4vZ6hnYDiOgDN0d04HF4TO97YQf/efzr+OkxeB4Ih2tiluCqOBfWP1Jliv7s3jM7TPIf54wAFO1muJ4hnPZ1u1QPNqzXiCiSAiyGD2R7Fg/b/cAL71CnI+SvEYN8Sr8IiUMaCiD2ta2axLzh63y0hZ9k8drlYsyjLomrLsSvaaqnrfYhcBD4bAsUgIuYDTBMeF2iV+T0hngTGxUcvyEnXDaeTvdZP6w27XSMVQBeptVTLQ3c4TeCtDuA8IXWklntTm/gl7PwzNsTUOKy2UzAuGYjhNggROEye/8HCCaLqFpmILhG7/b8tyeAlTcaNPg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:08:08.1104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d542507-47e3-4eef-4079-08ded8b8b0a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135

The arm_smmu_cmdq_batch_add_cmd_p() might flush a sub-batch mid-way, when
the ARM_SMMU_OPT_CMDQ_FORCE_SYNC is set or when a batch is full. To allow
a future change to retry these sub-batch flushes on a timeout and identify
the broken master, the batch needs to know whether it holds an ATC_INV.

Add a "has_ats" flag, set by arm_smmu_cmdq_batch_add_cmd_p() when it queues
an ATC_INV command.

No functional changes.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c34be7c59ad45..56e9a94826a12 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,8 @@ static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
 struct arm_smmu_cmdq_batch {
 	struct arm_smmu_cmd		cmds[CMDQ_BATCH_ENTRIES];
 	struct arm_smmu_cmdq		*cmdq;
+	/* Set when an ATC_INV is queued; gates the retry-aware sync decision */
+	bool				has_ats;
 	int				num;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e2fa9d27c6586..78e2559bdc491 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -917,6 +917,7 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 {
 	cmds->num = 0;
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
+	cmds->has_ats = false;
 }
 
 static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
@@ -946,6 +947,8 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
+	if (FIELD_GET(CMDQ_0_OP, cmd->data[0]) == CMDQ_OP_ATC_INV)
+		cmds->has_ats = true;
 	cmds->cmds[cmds->num++] = *cmd;
 }
 
-- 
2.43.0

