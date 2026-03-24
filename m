Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6663750A2;
	Tue, 24 Mar 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774315855; cv=fail; b=pJQwloUfVu1Rkw6LhPThFH2Mu4tkzJEJU7z3YmI9BQHxyDXN5fKMTvhARR/pD0VOk/OkeAOAnqnlOSGnQ1MBocvj1s1PIDO9DBhhxb9R0XsRFd6HBo/D0Djqr9WWrODdKFy3HUj8H+42NRc3C7nINMbMcbQY3pQNoivuRyN0VQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774315855; c=relaxed/simple;
	bh=cIhQMFQvRKF7KVieu1ZFGTOizXUCCSywviTQh8bvTKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF4n7v7z21lUmnEIhqqbrP3P69AyXRLntd9eM218KSy9oUoJOUipkddndtlgA6U+FNfBUPkCgE3C/DwinPhH4VhsIEX5jaUEp3OYoguwILxHt3kLumGT90J/gfEn1WVOXtw+iF/g/1FYYd+4laR1YmlyeaSv6BBhXVk3ayjjqyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDupJ+ZX; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDupJ+ZX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcMnTP3h7e+bnip2nQEI5nmimA5fawPptR9+1yaFq2MupgMZXOVPC+lXDsJVSs6BeFfUdalAjpHw0zyxoSkW/2aZ5TxqLkLeIt+WwsrfgHsckBA6qOK87GbEAJeHm88bkk9QOBhSSRiI0EMKyvrZup4f0Zd3k2y7YhcdRhPoJNs8L/h37nBwx+fxJBtBplF/hr38QDrZAU8H9CPt/wAOWYheibGSRDrNkbvNR6et8TDcwZvkjpFj/E49U4Pi89uUYEZ5sm90vYHvKARNKECNdcw0SiqMREBxo7Z6POWm4NTeE4u/3iRMz2PM+/U1iHoQjvXYsdM1H+Om/iAmUOEnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnmCTrDMeHYriH5d6Xmzv7d4/3KX92c2SKYbVpbkJ6w=;
 b=Mb/Vf3KxuHUxqk13FkIlQ4ulRMoV/vnqDMNWnzTctJPuMPsIO3P1ZXNlv3DTlStFBm0NFvYyhY7Wkmr0XeH9N/O3TtFGuIQsQAYwBHYps2QMRoK9eThh1Y8pdy7pSQUseAj4jDcx5PX5zaMzo1Sz9hFmn+3JV3Y/wbhbbeh2V4U++JHz740p8VbgEqDcSiTbSKPfDDhtr57eRqhjQEgnEJQbxspWC5/3NOi7OU4aEZWgtCtzX2xsNwNjat3+Nfy2Ej7FPHWholwzUWNyyXb7A8B4/zPyQ87EAyz/oTG+zJxopnImKZV+PhRBMoheSf94vGLKjK/eMnf1l+q9edD+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnmCTrDMeHYriH5d6Xmzv7d4/3KX92c2SKYbVpbkJ6w=;
 b=pDupJ+ZXh0tShdySQCGIYdy5R4mActcYUQFq1c5G0/mGus56AC4cCyxY21MH22vDBke1Mguj6uJnxwMwMVxLFv10iNn7Uf+CoaGEnbl33Xey8WZfomuUvjRamuLXugqlr0irh53Y89f+ibmpwD2QR5KUj0/EUhe6rYTT/dDISUmMm71cZRbhp5HL0XhV26dMinUfWbiPx4QO35wXt+Nhb49i++nKGSyr/4iYi7ygY6IMPZPdArTEe5L6v0UZhBipU0XFjZy1zhCUEo1SWWJDpHYoQi5OBE8Uj/PDK9bxt4TeBHDI/ZaEREFpweFvUS3ID9GyGB5/Wv2w/K2kMvaYNw==
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 01:30:44 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::49) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 01:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 01:30:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 18:30:25 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 18:30:25 -0700
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 23 Mar 2026 18:30:24 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <will@kernel.org>, <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
	<ilkka@os.amperecomputing.com>, <jonathan.cameron@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <mark.rutland@arm.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<sdonthineni@nvidia.com>, <skelley@nvidia.com>, <mochs@nvidia.com>,
	<nirmoyd@nvidia.com>, <bhelgaas@google.com>, <wangyushan12@huawei.com>,
	<shiju.jose@huawei.com>, <linux-pci@vger.kernel.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v3 8/8] arm64: defconfig: Enable NVIDIA TEGRA410 PMU
Date: Tue, 24 Mar 2026 01:29:52 +0000
Message-ID: <20260324012952.1923296-9-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324012952.1923296-1-bwicaksono@nvidia.com>
References: <20260324012952.1923296-1-bwicaksono@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cc17bc-cbf4-40d2-b86c-08de8944f804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UlX0+F8ZXdYSv49fUzPeLJg/86IF88RJPu6nlZRKtS68TZDuR6aMAgrDnG0l/NlrSx9uKPUbBKu3hsWv36O567/mPyaPWmS85TRGNMS4iOgaZIWDOGye8yL7lFUUHm9Zz6YQHRWcWsPq3194GCanOX+vDtv2ZHIzxmqc/iwFVVHPI9HOjtYlePghTePqCHRpum25L2oSh0NEt9GdLXof5/k2KLdqHlu5uTzVSIMqmFqeBDi00kcJfiqjzPr9EGVKorcWcg+SoiobyyGJMCd32QmsNwu3qDy46SDAn+kJiMgrw5kqtB/um7hGP5Lr7/AUULsxu1ZlQF3N2wdCQ0pnQh9jVTrmq10dOFmcG7mFxLRDbzWVoG900c8RuAKEPyQhwXuiO6tnmILhiR74Xr/nBpRGlzgxPez6u6n5xKyFrYafbjBpmlZ9VCAOskQk8KKnADp1+WQQWkIxiSCJjX78sMuOait6lbycnnryz4btzkievRCyU+7FimOK2D9ic4Fib/unddL6JTByoEpFX6GAqyzDcQyT6wN+N95nFVIz0YYGSEwgAoL9wGkSR/sJW2YwMgRgCZ26w4YP0shhAWSSWUUHRMpkeRo8I4zgClNEKnSz7+sKtki+7DQC1mpUjfD4qGucBlnp+0L+DEc1B5s08WgXaHQiQw9wp0tNsIQFeggND1uz1pPaYYb2kvgVgqO1rki8j4KpGrvc3v2tEjSkrluMn9Xvi0BVNnzg5yPDirkq3paDIK9imx4ZlfwQBx46pMKUR2PFfhW1bFhf6jgA7g==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L/7JJI5Bh8Pbmv5+n/i4xCvsPoX6pzL4wd8tHO8KjdK2ye+WnSURh46rg9bPuUyLupK6igAl7Bxd5XrII4gzTUDjmmcYeG1XZIjm7l4oGl8di6G9G1TC8XyUM3u1tMeeN3wjRTiV3/Aity//b/rjxfQGQ7iXMNa1I2r0+zIJQzq6ZmlSomeE/587Z9lLmuyuL+vDzymtjtNrnqzFxe+cWeV7UudqYw88KiZTYg2UudlQyOd5GD0P2kUi84JFZrqUT7KvZw45Q3p63VOnGd4Hp4hFD3Zqd87c+lUb3XXnIxYBkaaOxs27tQ0VuB3wK5x+vjG0Ip6s1CHAK6o/yX70q8Y0NXUd29/+b4UkTn/kkFxjbOP5FXKCLO6m8xbJs4Z7CU2g/ShYm2w4F+gvWtpUdJOJov96R6Wh3I0KVTIwFn7IS+0iKLoQcMiF3BXPwTQ9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 01:30:44.3244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cc17bc-cbf4-40d2-b86c-08de8944f804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

Enable the driver for NVIDIA TEGRA410 CMEM Latency and C2C PMU
present in Tegra410 SOC, which is an ACPI-based ARM64 platform.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 45288ec9eaf7..3d0e438cb997 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1723,6 +1723,8 @@ CONFIG_ARM_DMC620_PMU=m
 CONFIG_HISI_PMU=y
 CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
+CONFIG_NVIDIA_TEGRA410_CMEM_LATENCY_PMU=m
+CONFIG_NVIDIA_TEGRA410_C2C_PMU=m
 CONFIG_MESON_DDR_PMU=m
 CONFIG_NVMEM_LAYOUT_SL28_VPD=m
 CONFIG_NVMEM_IMX_OCOTP=y
-- 
2.43.0

