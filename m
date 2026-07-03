Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04F31B837;
	Fri,  3 Jul 2026 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051699; cv=fail; b=baUgpTThMFAetTo7aeBhO2C4RESdYtB2b2oBo0IBrXG+1jipE8Cs55wJCxs0JNQTJ3Qm0HsnN3+d3g97feikQF2Ep1CfTb08tjgOYI6FRfnSVborGJZofe22h/HvxH+KLGHDz6Zd3fLHH8a+pxZbM342hcPpaWGdbkPHy4FZpAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051699; c=relaxed/simple;
	bh=dgjCHlWdW4c1FsxbRi7rzWSNNnUyS8wRFUYqO9Ca8pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnxeyqXTRE6w/il2opL9zR02iYr8UeUTkf1Dudipi02Wl+tPZs1KsBodZBe7ZTAZB59KsnmFgcZetXZebs7cpnI15fsqVDogARpXNMer2Ng0fhPp4feAj/UqiW+NDAzVxfGF0YseQ1FlxKOITwZvX+iW17VMU0ulro3I/pNNGFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6pG8peW; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6pG8peW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rr7BkfM08K+i47GF/lIA1FrO0+JnmsYggu67FW4Dc4jiyx+oNlbZn0hfoHT/7Wp5lRwat5U3thhi/U7w4pfsqtXWHfioACRMwLIK74IkFAYTGUmKFj4oARQFwZgIALvY4ADjT+g4ndzScEyScRoPtvFD8P02llmYXniwaXlnHJrvMsEq75MmU+ezwcXiL1J4hPVLJOOigeH1kSR2EBFX71s8nQdxhUA5trdVhKWNzOxhAZPWIxu5ObSU28Z4zMjZQ1e/BRO1fOlv58RnKpzsNERHwMWkq0Mrq1Lj2/JFodWpOLQfpKZhrqAKjzGjMWol0wQLFDP/9CagWqj5ycTOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8phYxe2oZX5gFeHZ6L4BL+FSqa9OgTY7oCLF+wu9QXg=;
 b=W4mvXfT+ChA+0CCs1xBSgDvDKeT4+e7TVS8tIK13qaSa2iB5o1/MEMA3E/MNLgAp57K3WtrpUdtrtsj/cWs5dh9ab30u7bifJR8omX8fOmNd26ULIuYB6jwratOxFdmuz90oHeuJ4+Xx2JlanNN9/PqOCvyFt2ChBbbNy+TFsInSOflzMs1D8TmolPmAcYvblmswOOE/T5FZYOU2Tc5YYFHX+NVgutADM4IsS+ofGM0CsRaSrrg7RLdo/rMvCqe7FBYwLJPp0BBSnCtp3XjageAhlfE2+b/A8sOmrN/FFLLoBHCxx0iT30aYdwze/mO5hpgD85+f1LYwE3wJOC7j8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8phYxe2oZX5gFeHZ6L4BL+FSqa9OgTY7oCLF+wu9QXg=;
 b=D6pG8peWiZLvX1M2rOaAU8kc6+Sf0xpG+JroFQdVm4QXOD2SL/fsYEV+S4iP0eyNcVhCJArqfWq7p8gaStKDzMsuW19ky+v0hU2rpnY7UAsgxXu5Fp+bn+SGdMOr46f90Rz3Muw3glMcrSx6b30D+FhbmTeYC6d2fHtMaKgYb2iUQkuvt0ZR5ek0cKdOKT9fMHCvLwZPLbbSqEwjV0KZ7v+9sMjtP+aRfzEpV5EqHAQ25RgaraYx+c7ac53fUxM759LvoWJdz+Il+i6nuti4tzGDG/8VvCGgpOEAz34NRorFvzoW7SWXLChAbeoAAVauEMBphIhCMJR9aFDaZJ/8wA==
Received: from DS7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::11) by
 DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Fri, 3 Jul 2026 04:07:57 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::33) by DS7P220CA0119.outlook.office365.com
 (2603:10b6:8:25f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 04:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 04:07:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 21:07:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 21:07:41 -0700
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
Subject: [PATCH v5 08/18] iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
Date: Thu, 2 Jul 2026 21:06:33 -0700
Message-ID: <87ac4c46207f8e9903cc6a6f6f1b46995145cb64.1783044582.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: aa37bb83-00ab-4b6d-230e-08ded8b8aa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wCMNeWX3hc+W/U/K/DeGSqX9SuY/i62o2GAOtdbZZq+Upy1RKiendI/kETXb2lKCjWK0jRQietj4EqoX4R3AS/EoLNUBiM8YYoKI5zgiXXBOVu7HnLaZUUEH8Q29XMl8Dr7Oc2TIXyIVZR8s68ZbZDIVZ9HDDa++Ux0iIr7C/jD2dX/93V/IfA9Pgp/2pcR3dGcEKmVm/pommu7OndDijtUtyI5u7jzcZlgVQqvx5gthSm1c9MCNOJYo7i3xBpeIipDQGRccPLcvau5bJLbOWBStQ73Eaw6cFqOrsNuRjGPptS1hmO0vXu+BiDheFcuaiB1sQZCaUdi4sBfE57lNp9Q5yUlPAEyhYGSKSShgaJvFEnJEgF/YkwKK8lsINnrgXoxZgpPVkMapj/aSgAZschqgxrv0ObI+fovYTJOB+n3iCJFHxPcoCfDWJZDoJo+UyfiXluhSa9pozyfLShePp3QlVuKQCYQ+E+Hd1uakkhD5SWWVkUIHv5sD1iFW+e34nXeQhpiyZR5LpVs7CyM6P+pSGRvZZpZDbW30lx9YLdvJTEj9/K4gNrTW+S7z7X4ZyVouiyrJsMG4tZAns2OjG8Aw5ZsWFaXBTGpCKNiq0PA3Ib09ZIIlkdmAQCxXR1lg9vUl3ElgsdS+Ri3kHCQv9jUns1DOlAa1oPNzs1EwPUBVwYaHA1s7SY2i8nz5MTxBAxogiXPLoMThet2gvw7s7w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5lohrFsqCxMCleY4rz54GodPXK6dI13Zj15etSWVeorQh9IubJukPxroDiXEq+K7RPso1SNtRhynXD3D7K21neG9YmxBz455XOM2MweYVfbbQKziC0aeB96kZwu/d4roUWiL2Sz+K2NW+KVR+YhQdxYt8SrQjUeDqyVSgQiuVqN+Pv5qw9hUiUucOOgEx4B9WtOgDG2XYrYDoRwVc7dIc8bBLHXRctBHZYKSDzScM0tfxuDSSPSTAcifsSxbuniUdGXcHU8mihn9qquitAe+vGv1heH1qhfHQbc1knk0kRaBlqudls00zCBvboX5GqFLzQWSykjDglqsNz+aVeEE1pYXveW8OWdNa/FOdtDLDXmMVhAyQeUgq+UsiqCQCj3/w9Uk22c0Lz+50o9GygpbyvXWgCTZvTHFQeQ184vA2AX57HpcNp8nTEpD/PofspvQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:07:57.6034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa37bb83-00ab-4b6d-230e-08ded8b8aa5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204

When the SMMU enters Service Failure Mode (SFM), arm_smmu_device_disable()
clears CR0 and the SMMU stops processing requests entirely. The remaining
GERROR causes (MSI write aborts, PRIQ/EVTQ aborts, CMDQ_ERR) are moot at
that point: the cmdq is dead so arm_smmu_cmdq_skip_err() would just twiddle
bookkeeping for a queue nobody's reading, and the per-cause dev_warn lines
add little diagnostic value beyond the SFM message itself.

Ack the GERROR before arm_smmu_device_disable() and return. Acking before
the multi-ms disable wait keeps a level-triggered IRQ source from re-firing
the handler. The writel+return here duplicates the non-SFM tail because a
subsequent commit will give the two paths different locking. SFM is one-way
and the SMMU does not generate new GERROR causes, so the ack is final.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index da29e523d78b7..8a4edefeec770 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2315,8 +2315,11 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		 active);
 
 	if (active & GERROR_SFM_ERR) {
+		/* SMMU is being disabled, so other errors don't matter */
+		writel(gerror, smmu->base + ARM_SMMU_GERRORN);
 		dev_err(smmu->dev, "device has entered Service Failure Mode!\n");
 		arm_smmu_device_disable(smmu);
+		return IRQ_HANDLED;
 	}
 
 	if (active & GERROR_MSI_GERROR_ABT_ERR)
-- 
2.43.0

