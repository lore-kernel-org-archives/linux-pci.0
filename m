Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599957D20C;
	Wed, 23 Sep 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194373; cv=fail; b=aps31hu0xekgAwq/vWHc6T+qqt7p6OAMhuWt88ZjMzLQPKJ9PSO6/MiOcUeLDLIqKuDt8vjolFZWXT+R5L8JEyqh/FxgIs3HYUgxquE7go4ZqAKMEsoSfZCZCeTkjDvucdarP/w0ttWVUFam9HnzQ7/Wos58JRAHfQy+khJZnr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194373; c=relaxed/simple;
	bh=z6FBZ/Kahq0vrK8d3QBuhkv9gZfWK0o1MlqVqk+LSn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAESJ8ToQombFUxAEQHvRqMzZCnKLwYroi55/35RDI3+C/sBXwqtXK1OJZgdzq7+K9VJftwvT4gwsPTd7D2nRBX7Rx0joKRUIVczkmW5R6F1/Q0fIKsiuPrwwnvyMcxAKi6IKR+o53syDpdTcuM7FlRGVe4/zb2dGVqt4iAe5R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KoLOgXd3; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KoLOgXd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8Lc7yD2n14DpKrYDoYplaKy2+S/HJ+PT4kDIftzE+du9yvgLpKgaF/UANC81ZL6DTihorB5bnQZyz2j5de0HPyv4mJkc6+gLZ5M3AmdRqBCErtWsKqCO/nXjxmido38ZDSWx3vQ9PcjKLqV64j7lx4LvyS1Ihct2HDGVAxx0gKDjDtey2EfrpmcDQaI/4cONlRCQx7CgprlUn4BToC6il/eWmToWcXAwt/bptVfaMAXIMUQ+IIieuf47eJiFSXR0l/6qfhYF45bz4e5HHz6pIT5zjYQSNQhfF1aHtXp8TTdEr/cFp6W1ysY06PMoaQqaxroJnzV5MEEB/x4g/Fo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWegaLQckmeQjJQ3sCb+KDo26A2Ed8Ef++pB/PEAUFs=;
 b=hscVZwZnn1D2fzxg0wGalEPFigZDGgq1rXGz3KcxW6LlXylH3V4exKim5zFnQ/lJcu4CK0oi/joRmR6+dJ/U4CxQGYsEHS+O367E9AY14/6bGBZCipYP01qt/FkspNXlaK2SKkII0ImW3Buw5crRH0txybEZOevqxwPqlrB4QKByfwS7zzQUHITZMk0seeAuJpV+DmRckC7Ep3pIyIf0gPk2qMW7jb4WHr+GhGQD77aIws4Gme40epiUqnu/w1DtZDH7KdXvE+zDpD9VLRvl+97OHmahoqeYlaJYxLqm7KH4uypg0RYK8tKv2nC1AMQBWq29IjcF3Q7Td2Iqnux9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWegaLQckmeQjJQ3sCb+KDo26A2Ed8Ef++pB/PEAUFs=;
 b=KoLOgXd3v4e6ED9z2JLeWSDeH8M6lM6CtA7wKH/cOieTQeLzMtvG1RtLWCOh2+Rmy6OF/SLj8sRLKeZIhMImvyOmahkhIAc+VKadnfVR6HtWSdnQwAL8JlhXEW2xwzm2jplh9sP22uQw81Isiaqr9RS/7L6e4wfw/8U6bHLOEO9zprLqYdY2vSXsRFaTDoHE4fSn4n8QHtpLP7FJB6pJdfmCZmRK+2WMPgkTSFG+AZM85V16C+Quy1d1C3n9YqhUBAth5qBF/MTQFD6ecbTXfYEulFX8fYPEvQLz3yWhbvh9NA4XQcwVq9YXjrerIhur+7arFD8NUGs2rXJQ/vTnSA==
Received: from MW4PR03CA0217.namprd03.prod.outlook.com (2603:10b6:303:b9::12)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 23 Sep
 2026 20:12:27 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::72) by MW4PR03CA0217.outlook.office365.com
 (2603:10b6:303:b9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 20:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 20:12:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 13:12:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:12:00 -0700
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
Subject: [PATCH v6 08/17] iommu/arm-smmu-v3: Skip remaining GERROR causes on SFM
Date: Wed, 23 Sep 2026 13:11:27 -0700
Message-ID: <bcd606d06beb726ab936e004ad23a2fe81c757b7.1790188510.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 0423442f-ffb3-4ef1-7fd0-08df19aefd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Edh/VT5sHGkBOxDfdFnXkVKZA3TfBQ56UMb3lrtVUrRJVDni44dw0VXyInTpprV0esQmUCAh6Tpc+VRYit0e1CABKg964L+X5j5yAaEmozltcQX5aPJ6cvuDcIVQdVyyuOpwhwnRsttZ5NjOsxn0hzuTmuodDqkLUrALZrqSvAaTiniPZi/ol+JX+NXh8dW49H0JxOxYnz7bUWsf7LFQCUAZTZeXJgaiEkIF5hDn/f468sKGUzAG57GrX9HVa2JpwVyPiV6rPE/1jrZoNlsdV09w6Vx6VQBsNIf5UKHDiZ2B98v9LTSPrWvS2gZiW/1ZHsUyVepmtFmAFBOZeUADiDoDRUCGWq4jk15ZwKyfNRI8MeSt6ekrcNOMPxjCqUU6/VFyh2w1DcsvwgAlv87OFuLkrp7ttkriNybIu1yIg0ji8x906FAgs3m3UL4jHyNVchPNGWlLWj1in+olL4CkNK9kJ05FiW/d736mNgorXPOXfhJX0gX5IOI3TshcqMNrExs7gI6P7dMK4kae2qbT091Lb8tmdaYzWbeAG0q6pi+8l3odmvehwE4oihdedRHm//O5+I1bn57MKa4yNkIiwykZ3DNtr9wDXPoUeKGAvMRFTiRTKzT0d/8jtDYl8Zf3PdH1JL43qpp28/v8C0A2/3sTsK8QdmEozBCh0d86dugm+278d32ihcoDMxDXwmNWzHRYYGIQCevZiKoxSClaew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r+6D5XkVcBxTxs8iE+aZNt6wLLRvEN+2PxtBen/Ge32ip+1P4sCbb3Baa4c3tR57tAfxqg62rQC9HMhW72ZXIfhTQ31bdMadUC47DIejFfYVVJiFmX5QZyZQ09MS7GwUhzQPaxGNOaP22d6muwqQl4/GCSuun6qtCuSPh1EHRCCCvHj1kgkTiyJWAZXZc5h3uE3rkA+R3xs7fvL8sPcJUBkymw5wlfMzbp1/yAM71WERNauqmvrkGhFhErVIW+zYJIbdbZg0+7+sRzN2Zmk+yor3AhahhoVLsXaNj+JItIPgg0vHisNaklMG4gPZhisT9/Pfb4p9bH+CUyoOJYZL9yV6XpPFrpvsAYu612IF0G6VbtKG92wSXW9CGTxuHw44D0MUf8an56vPf7j6lE4CPRBom9HbTxZvv6g/ubHcMrSBePhroUo66Ih4F1dAboXa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:12:27.1608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0423442f-ffb3-4ef1-7fd0-08df19aefd2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111

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

Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index eff60674c9f05..24f286e994e6e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2380,8 +2380,11 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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

