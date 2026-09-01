Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB53806C8;
	Tue,  1 Sep 2026 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222889; cv=fail; b=KtWeaFPukDuaUTetrhtCic6mH4SGy8Gmj4tedD/qyowPs2sxvhEqpSpyGptXKTF8hnzYTYGWWR1XcW0ItIL9rq5pSnLSF+bXPkxh9iph02EByuj1jRhbhKBELB5qYCvsxqMSSkIUdovd01OQWmhWc3zK6plRTrJh33VDFlm8upI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222889; c=relaxed/simple;
	bh=6uT9o7qTmZpdcUFix1M5WZinYUQoou6Re37Npn0BYAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shKvh0RAtna0SX085aKv9W9+ECIYD17AERKtyIAjNr/viALXPjBSQnlNU0djwDfy9QEWi2GBZJxOiRHDFXcrjOUizjYPCC41EFMfSwrh4li3yyHxinyHUgTb/u7y73i7m2WJYitS6jtmmpG+Qp1fMuw5fJNTXNdb8z+RCD28ZK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COu8Wipz; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COu8Wipz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjuYq+IPY7QVFfB1JONloZZZiiOHckUQmRS/CvbdHjDOZrctJ0XKEya6QasvxCmvln7QVzbjpip1qdkoRhoX23rrCYnzsa1AKH3MVhr3JnIB9+Z/Ju4obxq1NuEzsyGPPNkzZq99+D5CqlDlYhLyRlVT89H1lj8vUxgznFUOMJSjUxpyT/80s+VrFntTe6HSJQfq74Juz0byUQGSE113M18Wy8c1Et0BVoAXOKeUDjg2G1oTIbvAjAmLpLQYyqARvAnDIKnt5VipTtQUjEQR6bUG3RJSHduP/iB5bfdMKideEf51md+QB4Fl4ENCHmIqAC7D4dtDiD6H3UQE367hYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX5jBEj43mVnkBhVab7TIJEnTrMhjvDYlQMHbaak5us=;
 b=qIANE0kFdvB3Ew1BXt8CHe7w/7m8R+UpBcdueUjYHHIM3mFCSIJXkAaH/RpoR+yb991ce6lxr0pqQKhY1wAFW1i/yJoYASS0pdPl+9b9zw5Sn/ETKuZ6hjNDjD8Cb8c6GtdR18EXOZRedg/LdmgG/mFQNms33qwcr/tYDTZqnUoSl2UGVG/LCEANkQypoDmH1pcNK7FU0a2kWhkOydHCys78kv9VEaUciCXeAhhrzVAkZ/hV0a11G8szT8GKUGQWYDkQTvVPxck3Pxw9Apvit9aPHf69B+vp8K8J/26bBv9ljDg4U10vJwLo12ZJNwaFwFxxC92yhfZoL6jA6sKzUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX5jBEj43mVnkBhVab7TIJEnTrMhjvDYlQMHbaak5us=;
 b=COu8WipzqmYSS5bvtwJU/6/hhWkiJ1YhM5rG177/2Wt/7FSwwRKQ4UySbJA6PXV0UusNFet5PHSYqYARGgWTcbwO3iDTEWaQX7XFbD1ibOi+vVElqedBAMTvq7Zrlb9ds7OgSRzGMmp2ZZniSJvfoM3v3p/u3r1lKrpnR7HvZwRGW+d/uF3RFaoIfr0qYVTXedYEA6/1Hhtgly/aW4nqV2sOLZV67I5cDalFmGQfIPJFbF91x+gIeqIiBZm/fCmh9HVhDwxoWCIQPkHtLk15klSL5DfwSQeTudO3wPIPj3Lhka2UPzbRRP/wKUt/xBof6UDeJjRfBEULush4x1vdZw==
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 00:34:40 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::71) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 00:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 00:34:39 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 17:34:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 17:34:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
	<kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <skaestle@nvidia.com>, <mmarrid@nvidia.com>,
	<skolothumtho@nvidia.com>, <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: [PATCH v3 10/13] iommu/arm-smmu-v3: Allocate IOPF queue for ARM_SMMU_FEAT_PRI
Date: Mon, 31 Aug 2026 17:33:35 -0700
Message-ID: <37a4e140ae26b1f58a08b9274937dcc9fa1e5e57.1788222486.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c88e15-ae77-4444-4f16-08df07c0cf10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BiuzTXtiED/yEHeBeYd2xql7KmLfkMhBvQ54moiS1S3mvb3MY6y7+GYSuBqtelJ54mMOViCWIwguPTQqfteVR8T2KbnKfWxpRaLCBDfn1WSUMHf/STvZk8JtyzBz5FqIQ0DIL62zpi3bnCUJejCRl6QYkvueXT0Lfdqf7OVp/xy2sq7lFkidUAXZaAqil3AVgutJ4cJ14TnnYzLEel0sZ7RdcNEU+kX6xGbREoD/oKHpfnHSK/U5QTsoOnmovGppJR9Sv6kwnCz6n9+xfWcZ8huoXuEzh/ACfFRAMzyFZmXIXomLZAwv3v8G/z9LP4mjbtGxSMGPfm/RiAYTZ4+Kl2/rKibWvcNMLOWe3hW/bTq/9Hdcat2EIRlqCkdOdO7zDU9YJ3vGF8TFtlziyzhv1kQe2utg7a5obwDAdwmsi62bYvzXdHWAH5k1tcABOZnFpopzSQ4ITxEn2r1410m7hj5CiJXIH0RImGuUy2jH1xsX6K74TXul83XWVW2bgd8I10vImksEAKjvUKlqtwKJg5vMERkReF9y0GqtTsLCDbk62n1x8cxnvmPNa6UYxWZLxazf3nL1uLzKNmFDiTHOV0uAn/BxNgymJmgkwMMgXN9hbxVo92J3pFKpQEMWiy9bQm7QGZFoEEOv8m/ud/74U84I0GaJoJPCAXT7myf/LiaZtP2MO1GSA88pnb42DTAjBrNg4P+To1/1qHQWQ92BmA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2nxLQOhKrmfbuE1O/bvBEyrtLZix2uP2PP49Is+yyaAtPTAowV5i/tT2xi4XsITRgX8Ms7tftuViaxfV1WkPGMXSR8AHwzVbB8Itsjb3bYpCXIoe+Ak5YsQ8dPvs8lBZ/FtA+LvlBc+Asjscu9rEjEagzYcWcwrtlCAk3tIqzeuArRkRoBV3qxYG31psFlk6Qj5HcqXUjUsTtpL7guSgCBBWl9JY0hRK31DreMFqBOoYgHhr2kfSc6sQFdncoIR4V6FA+TTAmG8VeQw5GhToAaO1JwbdUB8ywA7jREaDTxZ8/cOERjH3WFfNO06CNPwth3gD6wZ79nBHYUgp47VccHVd7HRjhA7CWeM1WR8EyNG/cEuqicqsdnrCsSEghYhOVNxyH0HlahdUjeOV939q4odTf/tEBkeM7m8nOj3hdBW0JuufAQkVkBSZz7C9AvE/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 00:34:39.7393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c88e15-ae77-4444-4f16-08df07c0cf10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048

After the previous change drops the FEAT_SVA gate, arm_smmu_init_queues()
allocates smmu->evtq.iopf when the SMMU advertises FEAT_STALLS. PRI support
is being added on top of the IOPF infrastructure, so extend the allocation
condition to cover SMMUs that advertise FEAT_PRI without FEAT_STALLS.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 502b5c7673bc9..47c95b691503b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4741,7 +4741,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	if (smmu->features & ARM_SMMU_FEAT_STALLS) {
+	if (smmu->features & (ARM_SMMU_FEAT_STALLS | ARM_SMMU_FEAT_PRI)) {
 		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
 		if (!smmu->evtq.iopf)
 			return -ENOMEM;
-- 
2.43.0

