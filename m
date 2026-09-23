Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B9582BA4;
	Wed, 23 Sep 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194386; cv=fail; b=QCgnvJXTP+ubGo5Dw1yUDjG1vO3pppPyr/lddK/d2cApA0FUo2fnwDH84GDbWJfJcCjWm92A0yASOY4RpfmAuUtRC2PIS/qLEi7L0Dp5iENpBTEoIxazgfhIKhXoCAjbkSEpl85aemwjcSqZjm7zZ09PO1U9LiFQ+SAUhU6yVKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194386; c=relaxed/simple;
	bh=JmdAk5V9HknuaiTvAf3qrJjKk4+peMfBY92BnKZsNoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efq4Qq/lmugsF55tcKPDKkcoGZyKdWrGpr2UWsETd3L9q3T7gkuvSo1BE4T64zp++R9YWqPr8p0VEMozPmCnhS7ne6QanLHLsl6AXZM6mr5zSw4tZeqJXrtT7Pnc+nNMle3HliWwC32YRYV8mzsG2HG/CGkq7vTMDKYJhEVNw/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoM32b2Q; arc=fail smtp.client-ip=40.93.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoM32b2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5NjUKiJX1zIriPorGVJVUVVzsit/W4id4mXeEH+YPpy7W0lXhowIxlj+zWa5ngJlYfaKORU2LEp0SY5Bn0vN7meJ2f1746TXj/1k47w6bAvzJ818HlGzFG3cMUr4gWPiGT1i3klHDGW4ZjRIQk+QBDUFS0PG1n1r1jKYiEPjflR9MYzInbqPaHXgF/xo5ZBv0aBzkpcKXNEJP8m21s2xGl5eLBy0VYJ8nTVZ9oR3uEomRx5dHO2eXmvtYpDsLo605JVt7KN9il6G+/nH+ljyj3Azh/Np+5w9nEzw27hyRrAa/0qV8FpkeK/Y0eWw/OaOPrjDu1CJTuNDWZQ4lgmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NompFMrJjp9dyC2H1q2YLEbvKKFSxLnyekmKsYKbaBg=;
 b=mwOIh+rBGQwJCH1mqeWV1jpBOE6fB5q/MftPVbKLUly1vkNHqvcE+P/u3ctED3Nlxuh2x8Kni2P/ZE/5Aui+4D+KGOR8La8FLMPTGMJfEvPYDKkFXYccooiz3cCZCcu/zol85T5slKJ+RCIMy6yC6wCMITjIXF2HZQsix1/6OT+uY9JUpHF+FMHUhAiTzuCD4j0YJPRmfHPcV5LQ0wlmS42PjzFzZE6GbVZz8BtCFFy1OT0kPs7bN9OYjEJj74enG/gLdyZIwWbEMUYO4wq3r2GPe6YTfcW0z4bA+N6SajJro7ozROmydte9jEv7Xq1Cp0MfEhuBR0tgbaz5AAMiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NompFMrJjp9dyC2H1q2YLEbvKKFSxLnyekmKsYKbaBg=;
 b=qoM32b2QIaFZvjGQ6tZ5hezqjfv9kB8u1stqiQUygE0eMELbs4M6JYePZMDv+17fbbE3NrB5MK/nJhhd7Rv/3ubRa5VpUl6RECDbI/2GoKQbpQu86dS9L7B0I7WLSOb1U+mRGRAKOFIecOafmWpodyoWpa80s9cdy25kjGkmbqoMWWGNnAFmQ0doVEOWuEVW2pJJsK92c+dpma73W2l+QylIp7QXow6BKyrEoKdRptS0pH8CC3rXz/doT9MWdXHw2nX/IU4Evg59OSFe2RMjHQJytFcfXupqFSnRZ3Vtxf8FHV32VKOD42b77KGexhtxeUL3TBVb1wKUAYyhSVodeQ==
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 20:12:34 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::9c) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:09 -0700
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
Subject: [PATCH v6 14/17] iommu/arm-smmu-v3: Add has_ats to struct arm_smmu_cmdq_batch
Date: Wed, 23 Sep 2026 13:11:33 -0700
Message-ID: <5560b3d2aff6f2cb3839f6cb854a1ed27b2dfb69.1790188511.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 289d661c-62c3-4f2d-9b0b-08df19af0176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FhTgisNim96Wwy3J2Ie/2ZLl3xHeAkaye/jET10n/VCHOvG+TMlY7d0u1s7pHlfulRvqQCe5lsy1CVLm3KHcSXYVILRmjmQA5BrNQBr/mXqu05UcAVBxv3fIGBlMFU1m1yWGNo7mWsU4/qnF+KQDUcQzlo1l3ypey0VQyxqAOvItvUHM9FWRAYEv6UwQvuQ/YbBXeKNhBsWt5VnE53r3BUT3rnaqcN3lorfyLyhVr+WQ/c1zLnKSiVIFOxEkxvoHTQoTBzjTgLGPyC9oowEzATBTZj0xZnayHq1sGsPqAFaCBvSqfbVoBSE33VFasQ2bT3IQt6nZuoamvmMW+0XRueuk3kvoYeVTj8G+Hm8Z3NaRfhEVGtOgq+Cmnq3DYLI5a1wj1+aI4R8Q+Fwa7MBM5Rh1rhBGpnyZMNBza9cs++nT4FT2L6SGEhp64UcRa1fdu8zVvniWmfmuXpGxY2XJF+anF63knyS71xZcqXlUr52y1Dkxffv6i3r0DPvHntSu4wvwE9TbFiVNWZnOFxJVQc+6kN2xB/VDqBs7nStujA0JSQEP0VYjTfoA9CEc++rNqwdGJhoVj+QXHsHDpXBK7mJHLbWFoZkV7ATPd6cjNYHZqYqLBXwB025ohWd88ZnDmkevxGP4mP71VMdZ0J4T4oQOvI8OzPklvPWjEr+l+b2kih05dgZuv/fVBIxfXNHKxJK1YIlN320VPN3prGapWA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xezt9ctYAPfP/eXpMf4on6F8BKg9dYcEx7z+oB82Vs6tz5Bplep6L9CUBIQLsIVnqLc2YkvR+ItwuB2cTnlXO/1fIES8VFA84pk5jY6ww+oDNfru4RN0zYYivp8co7F+3LIBltkewey6HrjwZhM9mC4LadauhM58xG3D4n8iO0n93bfgHKvRIe3dp5J86YFLClXtKQF19mtf/cdXBsQ2xelgfzFlPGFOQ6csFL+rqqrqdX/H6TeVhY5pFxPp1nnkYbvRzxnEnSYuNhYVcjRDHrf80TKTAH+rHf1Y7h2xN6pAuhE9zCxyg0pZvu8Q6MZNfOfesF378QpvYCCXjJqphzULn3xSsVsMvaPZwu8V8ZiEZ635YR1c6Cn+qKUkiewcmmILzMNG5NeS8J78JnvQ9NearOFQdhP5rczRbIlDBSQ3cMz2Ka9HwG4U0c9BjGo+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:34.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289d661c-62c3-4f2d-9b0b-08df19af0176
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

The arm_smmu_cmdq_batch_add_cmd_p() might flush a sub-batch mid-way, when
the ARM_SMMU_OPT_CMDQ_FORCE_SYNC is set or when a batch is full. To allow
a future change to retry these sub-batch flushes on a timeout and identify
the broken master, the batch needs to know whether it holds an ATC_INV.

Add a "has_ats" flag, set by arm_smmu_cmdq_batch_add_cmd_p() when it queues
an ATC_INV command.

No functional changes.

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2f8d22cc404ac..6fa4f390ad133 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -724,6 +724,8 @@ static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
 struct arm_smmu_cmdq_batch {
 	struct arm_smmu_cmd		cmds[CMDQ_BATCH_ENTRIES];
 	struct arm_smmu_cmdq		*cmdq;
+	/* Set when an ATC_INV is queued; gates the retry-aware sync decision */
+	bool				has_ats;
 	int				num;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6f217e916ab0c..607246a965a91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -963,6 +963,7 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 {
 	cmds->num = 0;
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
+	cmds->has_ats = false;
 }
 
 static int arm_smmu_cmdq_batch_issue(struct arm_smmu_device *smmu,
@@ -1011,6 +1012,8 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
+	if (FIELD_GET(CMDQ_0_OP, cmd->data[0]) == CMDQ_OP_ATC_INV)
+		cmds->has_ats = true;
 	cmds->cmds[cmds->num++] = *cmd;
 }
 
-- 
2.43.0

