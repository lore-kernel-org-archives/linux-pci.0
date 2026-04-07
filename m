Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319233A9FF;
	Tue,  7 Apr 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573921; cv=fail; b=LprHRik43u/MgcALUqumCjaWIuCSZN9uJUmLaknYY+ILUcMzLFGp/hqFuyL85DJM6brIpivyXG+AUU7fDa/7kq16IRg2UrnEk078+fOGgiJddCUcs9su1G+TAbLTXY8fYYZ8DkXBuzjbegvcieuYc6Es8RAV4M6iDk7qZ12WX4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573921; c=relaxed/simple;
	bh=VjHfqXxk8soi06glmrAgasFQXeXgXBsE42QPh3Awpiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NVRUydoOTwteUs8qChLidlC+oUAVYNAIBCT3Jy6+eY+J7/Cqs8y5JmYdo8LT/ih6+JN9O3gDzFGz8b7zZpZcVvRGBiZwPTUBc7HwCLQzQ8SK5QdkewGzmRKNsoz3LWH8ZCTUVBGmqAN2j1QZL5+X1fxp4fawUOGTprQlx7NBsJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FyVhl8WC; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FyVhl8WC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlObNrJduEUjwY6AAB7Fjxqn4m5rerQPNlHYmD3TlY+2dDgcCp99flqiDuOfXUQCSnQmBtk+qh+nlpBPXCl2x9yM6op8rjsURWfbsGCbNtwR/4pob7Ab7KtP1Vjphl46FpgaC58SP/Zdm+RxNtyZKoQewp0Sm/rKiNhdIx8DTA2TIhVtGjC3gVbVo+ujgBrXy39hi7PH8Lf7rOFVR6YcaWYQFh6BO4pmzs42D8H6AvFkXWEU5Ka7EizxhgVLkYXopRdCsQkqeoh/LKjZeV6hOeiIEB23BZlTesYaroTwnQw2HHkyK0CXTMGwOH3v222kBJrpFrw00LztUm3jny8MNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtzmhv6fdDxkgOXy0Ju1IY/ydOn31v18AYR/1veZCy8=;
 b=VpblMsCjoxehQy537BVtF0S5s0DOa0stWj0aevd2ydaZi0+7UZEtOuxJkGQM3FFilblrMgakER82nLWaalPUlxfxsnfMe7SaVPR73FoOciM56VTmG/2OKKdSizLUhw826xYnHAs5y16c4LIPFscAKik+abN9qUlhdM/WQdhVHMgI1/RwCkNy2fObBMBhDiklx8I6tmgf+R8z+KidcQ9L0kUPF2BQbLSp05cra1KYRPZkJNiaLbsse0PjGWtZeMXeCxNl0qht3ZoZo+BwX9lmY4LGehfb8+tvbKsfWR2UNnZ7ECXwzfDrea1DM8ANdu9/KEFCyoYch0sjxBrO8ln+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtzmhv6fdDxkgOXy0Ju1IY/ydOn31v18AYR/1veZCy8=;
 b=FyVhl8WCOVJsaO/L1vIG40Ky9FJuICWNHcXxraImTUMeJwZ3gnb40kl0i1bLemmnPngXfAgbwApT/vJHSaz5F3cVmN2WJW2bLhzty0taeLcpDeUrvBAutwUGdmGcowKSD7UXEasm/WKhxZz1ZZI/20KuSu1qbyx8XUeIqd7pJM2FCVQHZTKljp+Hxjlm6eNZLKNBtBUhd88lH9La0U8RE2WLwCaBKKNBtekPT28TbNVGT7tYSDO0cUdQ5FLFgieMls7k6JVdQIrFMCr2iLeg8CLVMOq9TfjlMhZdD7SS02wvnh8pSWMknwhLY9ocTuwOA31cfrUCIAgIgRzSibJhQA==
Received: from BL1PR13CA0416.namprd13.prod.outlook.com (2603:10b6:208:2c2::31)
 by PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 14:58:34 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::74) by BL1PR13CA0416.outlook.office365.com
 (2603:10b6:208:2c2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 14:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 14:58:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 07:58:15 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Apr 2026 07:58:08 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy
	<mmaddireddy@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] PCI: tegra194: fix min() signedness when capping ASPM L1 entrance latency
Date: Tue, 7 Apr 2026 20:27:49 +0530
Message-ID: <20260407145749.130753-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f155b15-1921-4422-73d7-08de94b623c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n6SqJRwJ0VRs7vcu/Ae4ktzEi3klnYAbfIsL1iciWZzg1uCmhlxIX5msKkvz8yN0XizGnpxeo++bGn0FTvcnj7cwtiw0acGG3XbJcv0LRdkXPU6hpSGkFaB6DrH03geQVPI99TWcdojfn8c2u5J7cavKfBSL5q/LDSPiilh5WuEWiI3tM30OzWaB0U92uNRh+L8dQQDIu3Qx5MgDizKng3V923eNCbKe1UEvb+yUUOIX6C1uz27gaTANcFIffLXalUZcPq2CYmaJGbKYUDmgdEsBTM0iYQD06OpkwFwY5Lc2g8kRYXoG+mQk+zLzJdA7Kw7pbRavheCMsadfwrQPSd5Mva+4v+W4TUcpmk5+Wrs4NE5U9Ce5Hag9rSVyYIQBBlmt79wTcQ/FFLdPA+icl2PImrBEm3OQ9/jHaaoqMJH40XtcQDPw8lGkTXWRZS7j1vdafezExL2i8UHzabQJgZfwC66SiagJGmTNYhcMsAGZlxI0HVugE1aDmDm/eS21QiG5GvVPEIhi4jHS8KEonG3jwnRQjE0WoHU9tJy0zMP/CvpuGcP63MhaWS6fejc5V152c7I3/u2YuGgfEV9rI8IqXmR+3xmFdE+ACqkuoOQhw7KvCBmDDIzraQYdGXRifcK0cgq5FMVmxtXw8dShh/BAux98Agst5GuSFokOdf17LHXoVrnxMyxQMozfXUI/EwL2fhH5MoUT7YlLQTa21Y3KQRrzmoa+qpI1SkEHgI5T7UyrAH+81p8mQavU8wQhH9a/d9g66o3OCaCoM9yLqpoN+N5hIo/Me+mtut/IfxUcADaQiU+/gBwIxLdFWxFEY5Pb/JGGKyN9Ujp3A5NOxA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RcpUn0h9EITYNm5NGDulaXxn7icRbyEIs6wkvaDrNZuBaIXMpHSgUpPmKFSt/Q0b4XlCGCmWXRXXArXEGRihBlPrD+czO+slkMg05ZtHTyVmt1ZtGi5LMmlgPssB1x2uISi7PlO/TbobLEj2X7q7uIw+CeKL47nxcfcTgt5hvDpCAIPhhQfM9pQoUZfJEU/oaJgep0KYe90dPlC8Q6Xjo2fOFCTqzbxMUtwrniNoqYFUu8htSsUQv+uA5h7RbPPBN/nwdeKXRiFFWIhIAiBlnAqmQDBDz3vtQfJh/gIidedOROoxgEe6Zyq3i6m2CmCvCRbOIFgZ0EnH2usPWr/F28W7o1Nr3ZRgj2vQcBEJUNmib39xawAdbp6YJHaJ2rFgvGOjIFxoQgkYh5BSx1A7zpGRbw/8A42Sv+olGLrfIFu29fiLzJvyHz/8l+34qK4Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:58:33.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f155b15-1921-4422-73d7-08de94b623c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

The DT property "aspm-l1-entry-delay-ns" is converted to microseconds,
then encoded for the L1 entrance latency register field as ilog2(us) + 1,
clamped to the hardware maximum of 7.

ilog2() returns int type, while the upper bound is 7U (unsigned int).
The min() macro is implemented with __careful_cmp(), which rejects mixed
signed and unsigned operands at compile time via BUILD_BUG_ON_MSG in
minmax.h; that check trips on this pair, notably when building with W=1.

This combination fails to build (e.g. parisc allyesconfig, GCC 15, as
reported by the 0-day bot).

Use min_t(u32, ilog2(us) + 1U, 7U) so both sides of the comparison are
unsigned and consistent with aspm_l1_enter_lat.

Fixes: 4a44cd65c9dd ("PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 393f75ce3df3..93d3452ac117 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1147,7 +1147,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
 	if (!ret) {
 		u32 us = max(val / 1000, 1U);
 
-		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
+		pcie->aspm_l1_enter_lat = min_t(u32, ilog2(us) + 1U, 7U);
 	}
 
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
-- 
2.34.1

