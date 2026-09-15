Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228B4A8FEC;
	Tue, 15 Sep 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490351; cv=fail; b=n6lX5tSWpL0Lm0+Fycig6bQXHxatKXdniSsyauz+fKe2skWAxjeuU+7gDTZYnXw1cWmiIM1CTeeTk4kHWNBUJjyAFJb2ocQUYM7AOJHqrQ5Wrg93hkIMMnHLQFAy8vLp/WLchSLiA5KEGR8FhNdccpi9DYgEp11VaOIyOev0BJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490351; c=relaxed/simple;
	bh=JmmsKWBKQSDv9BdB1kqyuOMBz8qOXlOzyAkI/VWUcSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKVwmhgXJrHfQLuiCYdkfGCVVI4vbmu2bgNC0VmJtlsrOicg06xBta+3HZfofKaGa6kEJhaeK3HIgJUWW1z7HP5DbLqsiHEt4Q8074KD0B8c4W5U7qEVHNz0EibyfpWAQZaO1xXLfxq+VCL/cftyjIF7MTs248K44NDfQPucaXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCpK3FYR; arc=fail smtp.client-ip=52.101.52.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCpK3FYR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVcYXU6JvvrBDfNWZcB/1laREcfGPvfa33YcoLPIklNqcVicZfFbRfAdMcvkKmRwwXt1CxgW7ipohzdOcJme0ZLOxtSogPVXTqNS0lPSByn79QaRtWexaA+21+RnV3ZdBnPsVs2BAIDLG2ks3JK+Vblk8eKki2vG4VoZGItzl2L/NEvPosMMyPCuf/HvsCmT7zcChpceDfWLWfjOr0y8F8rqcdbH2E5qCPKUNSOF+RqWn8TiqPNU2eJj9sDisBgj+6QBTM3ezhUNzxieLqSgvY0F6FSQS6s+xLHKNs1exsfDAa2PYW/FzI7IPT1SjbCmQ9M6oXva2Ob6OXBmftvesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=impFxQxxgsyX6QED2fmE+ctggluPe9CnUh1LjpZ0iio=;
 b=Kx98RCYKOuq19zyBN5ZSZKg/ZNbssmBfyCvvV4FUFZSc4hEmcv2dbN/0JWNkcAcE7DLGq5rvhYfAQbNnLvfkwnyhqcP7uejKWlACJmPhmRcAUjAdDAdbsKYeqTQNFil3hP4WuFaDBWu0xJLyPKib74IpXzCpQWhCiDM5Ysgd3EKX1p+NGG8G7o4TdFoTvajAcCeOZOtoZcB0CA2ckqyyGh6G3hyuLimsdZ43XuVjJTv4umDvNfg0udbvt0ABnmY/aFD4UQ+qEWuX1Q7vC0uJZ88PXSdPgwsHJEUM3hexQ1UsJVkpGW6+MhjmzVR2Twab3VxIR+GqYbYfYsMuB6VFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=impFxQxxgsyX6QED2fmE+ctggluPe9CnUh1LjpZ0iio=;
 b=cCpK3FYRtsSOor1VyKMYd3aOFKakZUwJnVES2j+4PpIYDvThQguCTW3cO4t/Ly4Xqgh+lXrlcl9hUWat/QtFptiI+SDnYgcs8sOQbKJiT8hzpfVsR+r/XfCkwejXJJMCCy5rO58ARZZWseuQYtVuz/rS0GmZ2VHytb7Vofu7liwtlOYaGBu+xBdZOX2HBwuroQx/h6IzQPqvtwYCXIw1PCDzpqpC4hylNKmVm9DKoqwXxvWW8j8rWf/qfzYgSiH+eFjZ8y0dGpS8H3jrYr9LjQEMdDBJeeOeja3dk9hP3J0VRUYomlYJgx/j5lPOufSM6NF2RRVuDDAaJSJhVKKgqQ==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:39:03 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::45) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:39:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:38:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 09:38:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:38:34 -0700
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
Subject: [PATCH v5 01/15] iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown
Date: Tue, 15 Sep 2026 09:38:13 -0700
Message-ID: <3747b39aa5898f450535847760d9cebde37684e1.1789446520.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c18d032-def1-4e68-0315-08df1347d9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PYeC1WSknQDkHtJC4JjXKJrAFNSS81mYv4q4rLhREnJXeFChiZBQSfGol/j54JPa95k2UkDzkxFQgp8MxLGiDHITtKonObYRr8UmN2xKi9MJA/quk6DcVuo4l5bg1ItDjRYQKBEdfUSuWcn/Yv98qDC0UTmwr94BFvhyAe1tO+O0b1Gg7WzcOcvRPOUOkXhuh3Ho4fWiY+CrZKpFzLtMzLTdYLUuq1aMD/RWfxdTsJKYTnn7AUtRNTumwpnnbphTFcIjuiSL7rvLHIeNkS7+/WZ/AwRpnuyjVjmKapC3sCksknUuoYd5Pv2rOzGhVn4b08LgehPa9YIPQiEvkOHBRlEbQ3u8rxE4/3ozojsXHsZsqZL/o6U+sZP3QTkeVFFZqb6NazJ+Pxu/fQ6USvtvxNO5QngWs+0kD8xpMmBlDBzPpao826qXy/E+fjuCe1yEK3WEkAvayQjdleOCBkZVAboDTYSmciDJJeHi7ubF9BogQdb0Pk7yNrF12tnIhUUQez+Tj/MOL5fvjzPe7vDazgISZER0d4K2+F8juz927TEVrsrTW3mbMYOcwhULsC7AWW/HU9dHq/5w45fE51xlF9wMA4+QSZAm7HXYn75w6oYty2Y2bK6Lh30FBiCCF2iezn9/sDeovlQT0RpT5xXppWgXtHsApLNkzZCVD0t4655gTyXLq+WlcDhTBUyx2zcq6u2TlbSdmxGWMgr/5Ft6iQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VsE3ne4bJveisvu33juOwkBqqDWNZKFrqgfzmNq+bfKEuBuvijma5c4Nk5wsiz/EvIvGgycYZQSA+fztDMq9b1Lh8NkA+N/ERuJcrOUBJOe+CEBERxFCsN+T51czatX53aCHOYENwAWwKEW9RGfDdY3IhapyzaBE7g0rImCO2tX5ckRmsREX3W7CmLgYHmz8Na4u1bWPX8Kr5DhhtTZatAes2jvG3/70zypAFMuDfagaq8SUnBNZAx0Y9036K2gzq98m84NuDzdcy/NhIErkc01QbufIIA6hDqKC1PB9h3vg9Tu+twFLtGk6WVR2DhTZmtyakO2ySSXGquJkqgoS3IhnIjUU9fahu5fFzdEyDx6X7UYtvcg/FIr5vP9pMFgOTl9tkrRKagaH4MeO6hFO3oGtJxeSismo04S9JUDwgEVUeY/zhWz7hknxfAp2PfF1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:39:02.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c18d032-def1-4e68-0315-08df1347d9ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

arm_smmu_device_shutdown() only calls arm_smmu_device_disable(), and never
the impl_ops->device_disable() hook. On tegra241-cmdqv, that hook quiesces
every VINTF through tegra241_vintf_hw_deinit(), which issues a CMD_SYNC on
the shared CMDQ while it is still enabled.

arm_smmu_disable_action() already runs this hook before disabling the SMMU,
to cover an unbind or a probe failure, and no devres release ever follows a
reboot or a kexec to run it again. Have arm_smmu_device_shutdown() call it
directly, instead of reimplementing part of what it already does.

Fixes: 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
Cc: stable@vger.kernel.org
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..81baafaffc410 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5633,7 +5633,7 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	arm_smmu_device_disable(smmu);
+	arm_smmu_disable_action(smmu);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
-- 
2.43.0

