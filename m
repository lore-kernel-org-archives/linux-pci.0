Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583093C0600;
	Tue, 24 Mar 2026 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379394; cv=fail; b=KRKKGEMFwqUMEA77NzcvIEJv18hTbZ8cwUf1ULcSga8IDy69R0oj5o9mWxQUo+6Wlbqr7MEYR+hjjTteBN+D4mrtjYJ1RluBiAzK/Qcq52O3XjaHl2zTF7juLCZLK0hXGS53nG7Q1o7bP7vOvLD84HaWaJaaROjaPuK2WIcalzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379394; c=relaxed/simple;
	bh=tzPkzDpYlzGLzHSHWmmvHSdf57ctUyhUM9l36QOhQq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7PdFPVvUhmNDaFWF7eqOyik/wJh2KPHkWDrkD4F91KqTkKvNQ/TG1/GiiG9o7bzu6Ks70NsLCmetofjNxf+vVUmhyM3D/DaMQGDH0FaYRT+DlXcU/tDcebnjSzsRl8GvpGtSwns67CpQykcIdG8YJXShFX6Oo6pa6n4iDkm8UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z43/2gX4; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z43/2gX4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJIZWUuF+GzFKRfKaVH5SiS3hEO2ifsbLieMNt2K61Se8/bXDf68Tx8+9YuKUPXbLzhOUnansp295W50sz+A5FuoczraO/ozAPHOokg8EIJUyTVuybjk2hlr6aTpL8kbJxHxLB3aNs+mNuhGWMUrIlH4QZpXlEzm2Vyo5ufhe89UM03Y4mOJCemd99bY0pDfMrFmDl1bSW2ORxm2EdmMgSG9fyi8K5zJAYGoZ2rRIheT9J2H26ubV3Wuf06IgmMJngb7w4n8vETOtGnQLrdKYpuFT2KFdMEXywePD7g20hzuDGAGl4RFY7DBCH7GGEEo19gwuSzAXkH3aEY3mqlXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXCqYP494RE2FVOaWj862R7tfdg5c4uxjaTfcKr2mfM=;
 b=aLqawW8aYVOrwnrkWj6ReKiI/jckPvgrCGT4RBvjHfX94S23Fz4Ai0fzFEXKHLd3boWOKZrBkvfctEf4IKu9pQ4ezN4vVX+1cvB2Ue4c94kYZXcMRjhpQmsPIkbfSk8XTH/hqofgRErzrC0EYFjRWL+XMqtQ3X70eYAI0MROe/HlA1aVGZoYc3z6GmOn9h3+mRD4OIa9XYk+cg/yxvFhF76xI48djL2fQo8MPXPfWegwzmBCciKnlr0pxG+Wms9rFUW6Y03oLsVQkx4kkLsoXiSwY4ep8oscC4dpdh5n9Bm1ChVI7vB9JzbyF0+syu/rkAd56xFaAUrH2mwVg8lF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXCqYP494RE2FVOaWj862R7tfdg5c4uxjaTfcKr2mfM=;
 b=Z43/2gX47yvMbX4r4ZykkHD8E9dxLKvVRvhJQHST6dR/n6l3GLxVt+i8FiCMDEYMGY3VTMAUa2OfJfK+VIFvwKvRJgFqxiDDzwz5W83+jxTYN6iJIVgFDWboq9BWetqfN9/n/NndSv9NNIPccWO6PIdm+YWPDg2c6/XgPcNkE3QQtgY+Tc/tk6lJa1znzt5faQtZ5kjX/sCOyU2rfO9TQ3KcOsG9+x3tscpSZo3bSQpdep9S9aVvG9owwIMyKz32O5MG3b/pLRIV6gPIQJMPlKBzFRccSz1+ZlE7eVPUBPbQoP2jWtRBjALxvvciTe4I40dZp2Wkmc/yvqOGG9eEGQ==
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:42 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::11) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:09:25 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:09:18 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>, <den@valinux.co.jp>, <hongxing.zhu@nxp.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH v8 11/14] PCI: tegra194: Use DWC IP core version
Date: Wed, 25 Mar 2026 00:37:52 +0530
Message-ID: <20260324190755.1094879-12-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6266448d-1b27-40fb-0bc4-08de89d8e796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|18002099003|921020|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	PvY9ig6Jachg9fpm1NWP0RH/jYo7oyieXqMHxAT4gymxNYb8S/xNy999qR9SulcdTz6vh1MXCMYMrpMIoO+qGtcu/AriTHO2tElR89VT9wR4X7VH+LVHMkScEs1xflYkFbt/1kNVowfTvy+BUBPQIXQQXtNAoSLiQ3GcQVBlsbGQgf/BI3jgg+LM5UzqcKWQtDcjh4ehmJkobzM6WPuRaz5ot5rbDVHB73L6uGGghivfdLYyENveWMCebSQ00goL/HWl8pAjwTwvGhnbZ4Rzg1cGe3vdnDkCpDwGVIj78shEKV73v5AAnxSZ8AsUPkY4RcbZq6ArQ0ge+pPvZGKGFq0bwYccNP+17UcCyr1Vo9T0g3UIiqqvvlUtCxqhZ5hcElDYsMnKuIC0ekQIZea3wS5EdHj4XllcQFSBCyn5m7Ru+vJMnn4rvBTl/PqJSHIbEZuFMnngwoW/QlcvBfg0pez/L4UKvpAqGHderedgNeECPE+bAhlliw+bVBumy/6KufHX4GW3UXCc6VqnrHPeWHZqD6EFnq6hnJ0Npj5LfSPUJayNt9+jnBS6NqiWOaVZTqGmFbQdgHrW/1ArKABdHnDnBOHl/yNJswJCjJxVXbBuBm0+SBzH6JTvt3gE23XlcfHlvR9U1C5v1ePGJNlP6f7GP8oGIriLtvGn49mVfpFmAp62pAZg2zhc3qFSuqbePXG5kxdsXRseEvP+5WbxadMSfUr/2f8vGwLkL97/pLn88UK2UTPi4g+O7wKTvjAdJ/66mSlppiyaPnKTKxLHR2/rektT6NBQi97uN0GyrNJUhGq2w5jYNtrnqWnAL4ig
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(18002099003)(921020)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8i+vvfGrTU0Sov3j+PDRZY9UYoH2SCKhqmd2uD3ic0uifM29JX6KzjaSrZqYusqtzOJTRXVz8t68z0gFuBsPQOpUap4ZocfSG3Z4bYNhAx0vaDkW7Avz50QD4kMrWo+EERM131ZvhhGBX7xughdSAWgVxT8CuGUzZ4x955sA1XGfvBKtB7eockSwuj5MOD+hepDvAhwmIEr2n2NDerTNMjbOUzc5mMyPr778fIaNKseJdv2Soe3jOw6yotvJHO6zk5Lukuem1+Prjhv61UXG1kq0v++/uj/9RUWs0k+fYRCl3ZUvHiNmNz1SH3/0UGjLuewKKBWg/89c6tzZZkCK/Qb5OEgQFktIVH4VmlWvFJ6ppnHTnKwhdxhC5DJ0NQ01c+1bJ2dALvUoiMoxb1iRCETyGm/HRF7XPjVScw1FpCnB6C/O58O2U9dCZ/9dpTcm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:42.4126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6266448d-1b27-40fb-0bc4-08de89d8e796
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

Tegra194 PCIe driver uses custom version number to detect Tegra194 and
Tegra234 IPs. With version detect logic added, version check results
in mismatch warnings.

  tegra194-pcie 14100000.pcie: Versions don't match (0000562a != 3536322a)

Use HW version numbers which matches to PORT_LOGIC.PCIE_VERSION_OFF in
Tegra194 driver to avoid this kernel warnings.

Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Split into two patches
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f4cf1602cc99..5bceadbd2c9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -34,8 +34,10 @@
 #define DW_PCIE_VER_470A		0x3437302a
 #define DW_PCIE_VER_480A		0x3438302a
 #define DW_PCIE_VER_490A		0x3439302a
+#define DW_PCIE_VER_500A		0x3530302a
 #define DW_PCIE_VER_520A		0x3532302a
 #define DW_PCIE_VER_540A		0x3534302a
+#define DW_PCIE_VER_562A		0x3536322a
 
 #define __dw_pcie_ver_cmp(_pci, _ver, _op) \
 	((_pci)->version _op DW_PCIE_VER_ ## _ver)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1cc80f3065d5..4cc0bdb0b9da 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -35,8 +35,8 @@
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
 
-#define TEGRA194_DWC_IP_VER			0x490A
-#define TEGRA234_DWC_IP_VER			0x562A
+#define TEGRA194_DWC_IP_VER			DW_PCIE_VER_500A
+#define TEGRA234_DWC_IP_VER			DW_PCIE_VER_562A
 
 #define APPL_PINMUX				0x0
 #define APPL_PINMUX_PEX_RST			BIT(0)
-- 
2.34.1

