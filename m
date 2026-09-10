Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9473546C6;
	Thu, 10 Sep 2026 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082360; cv=fail; b=GG6Lk6nSSs7AZa+r1O8PJy5PI5+aoGbIHSzX5eLC18f8p1sMBt37fGS2Rj5bHZO9RaQqktib4+T0YVGRPh1tzyQVfhaNqhzAokyzwcvWjfhk5VzXhHC9tphrOnPVzSsMqR3OxWZMys0B0Mo3AzSvS4b79txeKCIzxXNzfNR+PjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082360; c=relaxed/simple;
	bh=ZIDuWfBSXDPtGuneoj/aJWPE7SgsraoI6rFPb4UB468=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oa2nAQVKQ7idMo4zGUc9Ck7RA+ZNah67TjfhmZLIrtNexxzBpRJTMICP5zAlW6oGNfjcEo3fm0Y8F9EdOYHskumMUjjjPuB8dRZ3nULyk80jUfikb8ptlxir5zdyY3w68PIJeszE9J66wc47C6eoWouXNhwcYOGVH+iF6s3oXBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RN2LLzaa; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RN2LLzaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdItOeHREdQuPTYp8X/3QHeQ3cW8I9ms/oDDHIaUBagwOcgfqrn8QEZGFG0zIAo0Vhczo2lbcUZ7emMsdnSCRMJvRGk6TOhsJFDO93OSSffTmzSIn9Gf+sCaP9T9OjCmXtwU8k2R9VVV4UCyXh8bAbjsus/k3yTy0zrqBAgSIQzEV24p94eZ16ocCdVT3/F812tvdK0RgWY45/fNZvEDp/2Z9SKbgsKmV7TznZqg4zaWyXOFExPgSK9lIwm+kdafe6RoUpjvjGTdAGIfOhi0H/wG4l7kTB8Gef1z9h997O2C7iAtQkBPvyd/qn3nOHiP5mGjZ60OnuYQjBstspMqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjjp9peiZW18i4SNLIhRvRf5o+Ruk8hpXu7uZ8Bn5UM=;
 b=PANzbXC2szdYtCoo1UEEm+JbCM6r42SPFLgmRcpA521ZfkYdTOH7n6oD+8UkafRJqIOkR2RO4pnAIyQU8h5MP1nB0yBX1fQEakjZFqNxgyOhYN7i8+A0VscLy5fMU+rdG5R8R1Yqh8NEThp6wiQI2iSxE2RNYY/G5WV1EVBu7JT6FY1BBfwcDB2dFSp0U3HCVRJ02/pzCqd/ObltqzEa9ed19tdQvUBEpYwI5ZUjKc3ka+0DJCWRfNhrP7oFyCGtBQvgSR/F11ZPaOevvO9CUsJtWS64zVd4OtAhCEefd5HdY4YeIf/pDhpU6nebDRe0p+wM8gXJO3KjKrMtvs66JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjjp9peiZW18i4SNLIhRvRf5o+Ruk8hpXu7uZ8Bn5UM=;
 b=RN2LLzaaMpi7Y3bZdgEgsBjCPgg5fOkdwxjDM1uA27bqnvYiVy0RqdyfZ4+7n/MyZfqTaDX2MJOQXpL2o02HXXwPIq8LnQhurVeJM22zEYy/8bUHlvansZsFVBzCoe75qlxjCtqWdq6C+MdX60Qa0BGETX6BZalK/T7Bi6FS1+xpeqKl8PC+xUxbhRpbUckZ8UyojGGXlQOiAXHTUZ5eEnnv8pc8xlBX5BRpZK+YLXC/kvZDGePBfK5OOvPPm4q+6uVSrHutE1t7uvsaKvourZ45IGDuAP0WaoUR6jhuRsH6RtuUH3bdJEonmSFVqxDLVNSndf8VGvJWJXtomr1ziQ==
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 23:17:58 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::56) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 23:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 23:17:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:36 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 16:17:36 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 16:17:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>, "Jonathan
 Cameron" <jonathan.cameron@oss.qualcomm.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v4 12/15] iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
Date: Thu, 10 Sep 2026 16:17:04 -0700
Message-ID: <c277db2589bf38ef5f251a58dcc87a22c751336e.1789081084.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: aee1ada6-fdfe-486b-9637-08df0f91c0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|82310400026|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7eAhxhgjelzQ7K21A26iMus48vlJedwjFAC7CTEn+iGi5O4L9HbHCH5lzTahZcqCZpr8WGTj0vpBAUVpkR7Tb5hkyRZnX+O9rScaFf2OQdfexvPDCANZ8p6akNE6mQPckmpq/O+2ue5qthOaDJ8ZUEwGuCyO9z1imhGet/9o1sti1EGJM464wxqMIpclxG8lxytzSE7V/kjdx3MLX56NvxWuWWzS2YLguo+iPytcTAqpty8EPBKw5fMtNqd3KPAUmZwkCee8jzTX1kQlfEkFajfBV6zB2nnCZTZHomL2Hnjc67QEB3GrouFXAZ0iaR7q7OMj59CjB/Wq4mUIgJ3g5SYTvtUd8sdB80rgMNHU8mX4gpZ6/79pImX8iWKLdU2lPRqlCk27+oW98iU5TA5fJdjXqjmxX2wkjUQaHpMcjrF1jtO309VatqY6M8e0g64MCc8dtqRYRooD3QyM9p3NPHOVcDV0wTvScPVXDbv1YEmlpD2XB5jX5fg6KQwifwbpG/sSjYsTbrjIcFNLw1NxDPn3kGTk4kJ2Jxk7MOqo2yEWWsPMqN59dVhQX+xt0Ws9bVn8vuzDJpcRy6ZP1aKNhFHT0YlaEe3IgbG/MWVlLRq8KxR7gpnuSo0mj3fo7HKkgDmKs9ZB/XLhRi1L6s7LjVO+uEjk6FQrKqErmgoPQ0vbbo/vraUKmAh6tkcccVbvLV2iqNkSRmavLXqNV6MNsw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fXVCNPC0Zc9s05UhiasYVt+hptVniqBdXN7o2G3ICT9k/oB3oKFHGw/tP20IZX1wNK3CxzXhH/2qjMmUmwQPjUFqWD2NcIR30J5Gbf9keGSBa6KSdCWdOhQfUgnm1g7O0DpUo6Cng0CBK5Bp+fhpoHUEFjKRsqtbhoEA0b9SMjj3LKmqdHQcqqs8c/IJk/ZUBYTE952FTVnHmeuu/E7GXk7YHeAoOxd+dZuoVS+jqARCtLpKNMAZgl9SUq7RDKMPxIJLXZgMzJivLkIHd7npiVXAW+BONlbpq0dDqmmdg0BQ3UvcuMu/Xqwjb9vG1BWwKgYE+/t+tmv7ToN8+MAK6wq690vff8nVTr7Y+UvNMspo/4be9hrYpYOuq4PNNF8rZlJyqDOf8HycX55aoGZjrz4Ry2UNhvQhOFy3i/du28eX/hHa28/GfAI1xLOkgb8I
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:17:58.4893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee1ada6-fdfe-486b-9637-08df0f91c0a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

After the previous change drops the FEAT_SVA gate, arm_smmu_init_queues()
allocates smmu->evtq.iopf when the SMMU advertises FEAT_STALLS. PRI support
is being added on top of the IOPF infrastructure, so extend the allocation
condition to cover SMMUs that advertise FEAT_PRI without FEAT_STALLS.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0a15556c9a558..3cc2d365d2d66 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4740,7 +4740,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	if (smmu->features & ARM_SMMU_FEAT_STALLS) {
+	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
 		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 		if (!smmu->evtq.iopf)
 			return -ENOMEM;
-- 
2.43.0

