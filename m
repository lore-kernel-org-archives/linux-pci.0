Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A12E62B4;
	Tue, 19 May 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779162016; cv=fail; b=sonutgCB594ILTfDctqtZyG/bpfdIqkf7GOPNWUcURhGyrjIupZoBGEXMWKeufn7Riv9jLyaHApMNG7KX0LPkD6JGoHwsZ2CEcaaK14AWAPClyyz08BkX6ERhZLmj0kYWSILlxYbQSgsRoYwID5FHHlRcvfN7kcCZ7gvrjFNlPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779162016; c=relaxed/simple;
	bh=8a9Pr9gPcInzX68T/TLkQvN8YwuC9dh3yyltQulBUBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQHdYnO5oJBMvxYSzF9ozuqJmnvNIXcG6rPGdQOd5WReK6DjkwfQ7KdZN6wGiGwiXhIgUgQo48OUq16N/x/zWWWkbDluzb/6HKEnSq2QUCg3Am7droMi261qu6qZRA9XllQ100U0qDdaIjrM4VO9Texm/elM7YdNcPjzLpVzDhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sN7kYBvo; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sN7kYBvo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx4/Ptmp1BtXBoiRLBDno9N1o2p0MzMHQ1DaKc1r7lSOPATPRWklMiURjqDbP6aHmVCFzhhDzGIBy5YR89zWzPjL2LoAiBrS7QZyPgTbs+vwinSeVGJQRms7rQ1e86dgLCyfROMHuKzQzD4A3RyKGsGSREbkRE20/2A3TyeIorCNNcJyRYR+K4Pv0daexjjauVCvBp8FFBqnUrZo8t4XG7wjGGi8ecIXEm2SEeERe9OkwTiWXFGiJj01YluBONSj6CSwu22t5ILatRlfWflnynpVe7ARfX2a7o9XXtrp5DiaVvUMRL8vykhgSAgAcs6RHA9+adriSRz/cIoWlMN2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvysJblaNZsdvyabbisUSFdn2oKeYZ4kQ0eE5JY0VIk=;
 b=a1rVTmN6gy55KTKjrJi71PiYfG/5xkGIDNSSOkjYnbe9rXl8W8EYoXsAfIOnbH0Y0GlBRzB4P+QRBrgWQSAodj0S8DFTYUbFGVFPmaXZ2WDpeIhN0io28HRv5UH+Eyx2XubUlxM9qNVasmfc+HCw/a5LcK1rsfFdmZrVosLk9JlM+G37m2FB2K20ez/H7lwhyEskwDN4vRTnm1swfZDCdCY3OGwV7Y7WUVfYVWNGaVhpvkwQ7CpDjY8WbL05pubIDvG3uFDH64bcvsZ2dGrPcWTcf8qm4axXX4FTpTePCoP2lTKOGbDWpQVNnGmeWVu/e1OoB45yEnt8AJmcqBD93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvysJblaNZsdvyabbisUSFdn2oKeYZ4kQ0eE5JY0VIk=;
 b=sN7kYBvocLfzrkhcpNt5otKAhD6prpZUYGIyAkcOLtz2+jWaqPlWfK83m13AtekPbYsN5IRD3MZTgjH9aaP8Pq4pSP1TjgVsmzuqULh5vPk8qOGu1TEmKttyL9flCLNitq8FTo1pm8G7G+F0jerRYhDLcPxGuBVlWdkAXK9IVv55NQZqK5or4yZlGjPFiuRVBHXdskJSssOaziBBC4Pec5Lko2xz3R2Zww9HcLHSf6mPuAPrBhrPR/Cn4RwF2TbRevONY+HEwEILjVbe3Oy4U3YSClIs55phTKVdaR5DgsJlRBqO2p1TFHWafHEEjwt1ISqxuycpxgu5ZusH0yXACQ==
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 03:40:08 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::51) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Tue,
 19 May 2026 03:40:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 03:40:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 18 May
 2026 20:39:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 18 May 2026 20:39:47 -0700
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
Subject: [PATCH v4 19/24] iommu/arm-smmu-v3: Add invs and has_ats to struct arm_smmu_cmdq_batch
Date: Mon, 18 May 2026 20:39:02 -0700
Message-ID: <713ce34e90e836e32f484e214cb6941a6973a962.1779161849.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e94531-8920-474d-726a-08deb55852a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	PhUPDOgP7J1ZwKjYVqHRIm4P3no7GX/6Lxe1Xbspib9KC2CSgS9Ktj9dyznRS5ftukGPPk5BzVR+ZIUEB7wKenUIEnRU3L8mzoIOW34kXWhZC+m4QE00e2OZXgQN8UX/JvOBanAyuemJKlxOaw2gIaUbN8dkjwjoJZToal9SsRmxRKUQH7AIaHLTcwtxiMK0cVgpNgWS6pWCk9uz/AMTEfhQ9d5ybqXVmSEf8EGH4I/JyPC/ueeXNMRDIkXFRjDALsbJ/ZVr0d24sVKBP+7KnFQ0efqv9uudMWnHkFCiTTjhjDt7yYM3KSuMWQFA5j+EqmNtG0cZ4lAybdNz/yYYm0459s5A+Vq4N9o4geJLgmaWjhFtCyZ/C/cVe3aI9A1693L8R/dAV6diBivoma1AaCV5PmMPF6/lQiSIldXDZN1g7Urj3ksR74q/aFVCCG0jW8pcKWMVL0K8uSqIcQW0j2TLo7DAWV+8tJoFDQkkk1ZwbRAdIpECBcxRJ43mp9N5wZS4YXSyj5sYqgTOx2FlfKozQNd138c+Lyp/iiPo+a39sBp9i+W/Ih82A7yYEudtSemK49IQiLexsMNQ/CXk2m6VNSL8i9snoImeSF307eQfHHZPjzfezwZjEGFI+GmclO6kZGzv/WX8eoPl+LCezmxxzirE81JDIOJyZ62oXKRFG9vShETm3S9lqnH9aVzfIyD1YFdJoAwydIpoYYBvPc6S50WJqYb7Z3RLhbUnMCc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ee9baZlIoB61yabbd7oy6RsBxxgQT639Vx0FDiCnjYqmF0526VATJMCAb6CAYng/0U3gz8CzVCjRPLkRNkQg+d0k+mEuIJ2GAkQBwuheTFYKX6LqxgL/ig9yl/sg9kHiutS2JCvwJ59GWY6mO0VC4vcW4szy9/cLy/3+4WqaYtKuL77ZesDf7SlUkQ6OAnTmlYyhjhYabGA7zhfTlwqpZxTL1YGxp8awaZ1yiqvRYBMJdsPua7TqSjcXc7SRGE3z/qfUzVGaJ485wvpXNZxSwQYeCk+eC8qIsGr+50W0ReJcJvoCcg6xNtVWbGvtvCSC1w4z9qRaVwlOdsVFk6Fl4ROVd2GownAW4wxg5zonciHSxQ0k8wVP66Su/vxYAMtHNXT2N+nVz5BQfysMO3US5eIAPyJXrAbM8JF0pUEH1BzwJ+eiaFzxM5BoJHNVem/C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 03:40:08.0210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e94531-8920-474d-726a-08deb55852a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

The arm_smmu_cmdq_batch_add_cmd_p() might flush a sub-batch mid-way, when
the ARM_SMMU_OPT_CMDQ_FORCE_SYNC is set or when a batch is full. To allow
a future change to retry these sub-batch flushes on a timeout and identify
the broken master, the batch needs to carry both the per-domain invs and
a per-batch indicator of whether the batch contains an ATC_INV.

Add an "invs" pointer to record the per-domain invalidation array (set via
a new arm_smmu_cmdq_batch_init_cmd() parameter), and a "has_ats" flag set
in arm_smmu_cmdq_batch_add_cmd_p() when an ATC_INV command is queued. Any
caller that does not associate a batch with an invs array can pass NULL.

No functional changes.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 44956daf83dfa..2074814534fef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,10 @@ static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
 struct arm_smmu_cmdq_batch {
 	struct arm_smmu_cmd		cmds[CMDQ_BATCH_ENTRIES];
 	struct arm_smmu_cmdq		*cmdq;
+	/* Per-domain invalidation array, for sub-batch retry-on-EIO lookup */
+	struct arm_smmu_invs		*invs;
+	/* Set when an ATC_INV is queued; gates the retry-aware sync decision */
+	bool				has_ats;
 	int				num;
 };
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 638956e2535b4..a31f8b1a94979 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -892,10 +892,13 @@ static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 
 static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq_batch *cmds,
-					 struct arm_smmu_cmd *cmd)
+					 struct arm_smmu_cmd *cmd,
+					 struct arm_smmu_invs *invs)
 {
 	cmds->num = 0;
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
+	cmds->invs = invs;
+	cmds->has_ats = false;
 }
 
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
@@ -910,15 +913,17 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 	if (force_sync || unsupported_cmd) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
-		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
+		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd, cmds->invs);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, false);
-		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
+		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd, cmds->invs);
 	}
 
+	if (FIELD_GET(CMDQ_0_OP, cmd->data[0]) == CMDQ_OP_ATC_INV)
+		cmds->has_ats = true;
 	cmds->cmds[cmds->num++] = *cmd;
 }
 
@@ -1486,7 +1491,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_cd(0, ssid, leaf);
 
-	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
+	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd, NULL);
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
@@ -2434,7 +2439,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 		return 0;
 
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
-	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
+	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd, NULL);
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			master->smmu, &cmds,
@@ -2630,7 +2635,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 		struct arm_smmu_inv *next;
 
 		if (!cmds.num)
-			arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
+			arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd, invs);
 
 		switch (cur->type) {
 		case INV_TYPE_S1_ASID:
-- 
2.43.0

