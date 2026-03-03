Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4807385527;
	Tue,  3 Mar 2026 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521035; cv=fail; b=lHyoA85qMojZ5xD8+B4QPNPPaQxvmdejYy6msXKdrB+Kym3W69HiQDdQ4DdqW8r3TZr87MhSLWEho4rRa+eY4zqp3iNtkJX8zZpfe8kAXd+3jCZZXlCp0MtF0HRijMrupQbQV+wp72/uoyTl4oOeN/7g6qiNnLj45HcHZNxy/sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521035; c=relaxed/simple;
	bh=BAsRI4RrCDD5G6d0YpP4P3cVrC7+ltI1d+SYx2dVa6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L43JOccUJ9bjFSHRfA+0LRebt1Jia53Anpv94Ydm8e0kXCaPomwgZS5Xp2T7m2g05QzpYl3F6U3H2N7S81ebcKfiBu4f7Z+iZMbvPzChrKyfy5ao4BPiKdogbDEaM9hxbkRtA6WFkVNnAMQvy/qM2A+hPDPgfItqiKF/0Kt3BtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQNci0W5; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQNci0W5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBBbPMRgnXUljtU2CA3T3kiZC16GcBvE8IpmfPSHAPqLdAxJBUDOLdPVnZ4mbe8k0FRZwz5o7yISHKqu2iNx4nwUKqkvguYRJNV1wEPktcjD3aNRsVvEPjnNV1JKWowoYmQGipniNOpqNg0cjDl7lstbCsk/sWHkBcwGrBH8bF6QlO5K4LxooE18LIkJXaJX3NO1+vNGXyzN4Y6VgQCR0Kh/sX44vdJzEIceoYrF7WSB3UsaORXe1l2lqeKt6nudIZSKfvAaJCuFuxvBggz2bs4YNCCfuA3sbaGwOuMZSAKw1JfB9gTP0GSuHnisOWsuSa5fPntszjvvcQNWP/fSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BbQg5yhyQlxzdr8GzWQ4xrjhqsMoQ6jQOI3CY92qE4=;
 b=XRSJ4Q3IFwPDCk9hBzDkM6191pvXSWjvo0Yust6goFlJG6IpgnjpLrf4CIIjByjw75pvWocswCd6p/peA8f4YM792xbgrc6iR2ejp5JbwsUfL1ZmdbYedyDx3gfHcFXTcE6dwFCcqjM86wg8UYEzHATHrr8LgMqtcQA3v1nPSOoHGucUP0OjUtvM217DqB8UYM04OzNiJS7AybuDLcl59UgLZJhnRYEACtVpfley04WqTMbg0zS7Aw5WxoA0u9VjToE+YOZ9LJsp8WTcYbwVNPHx4DyGvcMRo1traT+nM6L5YCJ2kug8tiL33PYt1UIKjgi3GdaSI3PkzOkw1banvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BbQg5yhyQlxzdr8GzWQ4xrjhqsMoQ6jQOI3CY92qE4=;
 b=pQNci0W5U8RBCqYVxHxnU+M/Etg+kKuAJcjlNlggkVrTB0fvz+QSMNR4JKIvZrjGBWj547myvRodroD8lpLX0JHSDwPXGF0rcgDPGkfvJtzMNYyQfY/xQcAwzUS+xwho1CZK8r9Tk5TaHprQrQPhdYskzo998865P9vcNUC8h6cPQfH4b0HOyabrHNT0Bwe6qKYCwdPl0Xq301O3q/OpAIOif85iYOtmX3sBTTCj5gQfWKOu4SygTdkdZT2zkl/HQOP4C3dvS0JVoebInGzROhS3kc0WWOayOWCYt0HyKPgR5Hwhs47erK04wcx2Z3r4RxZB1o3V93HRbFnWWk1rRg==
Received: from BLAPR03CA0054.namprd03.prod.outlook.com (2603:10b6:208:32d::29)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:55:34 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::5d) by BLAPR03CA0054.outlook.office365.com
 (2603:10b6:208:32d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:55:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:55:22 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:55:15 -0800
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
Subject: [PATCH v7 01/13] PCI: tegra194: Fix polling delay for L2 state
Date: Tue, 3 Mar 2026 12:24:36 +0530
Message-ID: <20260303065448.2361488-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: ad092662-eca3-459f-ef26-08de78f1de19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	9GugbsglXSXmxs7sJ7/dprstZ2D5FKHtm4Ym6wdqp4ptNLLx4RFT/MBSEDzYAGgcN0ysxjoSUCW0xjVMepsEcgSwXMYrFo99WrhgiEMHbRfj8mmry55cPjwet6b4SxqJN0MH1hVhLbj1pEJS5E9wIaBK+2ej+SmW8b9J2fUt5tIEL8kG1gChuKRPC7OgjHdPRbd/6Zv0x/54UVKkhXmmCSBAu8PbNOqJulHOiUmWqdIT1E2XEM2CDM8kvK/cx4AoXaW57nUAWym+qX3Wgaz75CTwPFrLpx4xD2lzz1fFjxkQA9TKFiiuee3fbvQVT6gnd8VPldrL7BejTNSM2UpJDsAEH8L0cvQVYK1Lj59OaEijedAlCGoAEE3EWRXK1NEOpwXjU+eR0yGt+zBXcBh+CCHxIyDu5HUPXLgIz+oMrVGYOLz1V4znyAW/o+pbGKcFbLnGFYwTHOsm9mnbKSl2xKPepuwepweEi/qOdHqJ1BsZPlSW7uKXINEPGWK5hPB9E7kKe279TWbpXQnVB+r4aAyBQfj/Oh+2cJOimpk7iz1jjuZN8v7iZgJHak8IFSaXhifuhdE8YEVDlZ3Bsyk9eL9Mm/F1yWkxuW3cuyPEsmaGHcADRiGT4gusv4W1aGgXzEIPyEEm1cRYnNf/c/mIWpfYTEEtFqHDdUAGYYzcxc0DYsu1QaQpNT0F/WyehY0opSHNlCkzt5UpELFquSSDaEwSkig+ABr17d1+9XYQVsE8Bc258Hkxi1oVBzrRwKZMxnn1Nx9iXegZi2ldCQxj3MEieK8uVZXFbOD+rZIcxivsFocVKBjTjNXV5kSPmj5Gl3K/lrtXco1KsJ+VMjXN9GMKi7+lWCb1Y/XgfSGW1Fw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	itcS7Gs+DcF5EKU8cJP1BrfPkTljBBA57LsGvNL+yMm1FsItyqOoDd2tAxYvDQrqY18sWrZcowNeWaGSXg+HGjXqNCxUOPizXau5ZIWKNaUWtaC5ZQ/hCztiQeKoSqed45UnnkN86Z+Ridlq63KcGDPzCGqD2fGOlwe8/0FdMnx4b+2iRrRAlvXY26i7kXiPF28xbeA5MEflF28poG+dszZfTytZWinMVghjr0JzrrF/sswoLoU6xiNI0ULIB+YEUa5zLAyKxNMLXmEwOOAksLqO+G3KDeXZuXLqih/kD0s2Q+1pFR8pp8/Aow1INiJiqqnIhqTQDnHj3XbD+G9+gHu4LUpBuZLFjk3BG4YtUUKC92LEkSMiZcELio7ImkiSmRN9+mVxqRgth3ngcsjbvbhffZDghaMERjTOZVJeUZZuXAR0o3I5O3eM/nAmmCwY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:55:33.9918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad092662-eca3-459f-ef26-08de78f1de19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe spec r7.0, sec 5.3.3.2.1, after sending PME_Turn_Off message,
Root Port should wait for 1~10 msec for PME_TO_Ack message. Currently,
driver is polling for 10 msec with 1 usec delay which is aggressive.
Use existing macro PCIE_PME_TO_L2_TIMEOUT_US to poll for 10 msec with
1 msec delay. Since this function is used in non-atomic context only,
use non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V6 -> V7: Use PCIE_PME_TO_L2_TIMEOUT_US instead PME_ACK_TIMEOUT
Changes V1 -> V6: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ddeef70726d..d6c6bd512b51 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -198,8 +198,6 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define PME_ACK_TIMEOUT 10000
-
 #define LTSSM_TIMEOUT 50000	/* 50ms */
 
 #define GEN3_GEN4_EQ_PRESET_INIT	5
@@ -1553,9 +1551,10 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 	val |= APPL_PM_XMT_TURNOFF_STATE;
 	appl_writel(pcie, val, APPL_RADM_STATUS);
 
-	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
-				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
-				 1, PME_ACK_TIMEOUT);
+	return readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				  val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
+				  PCIE_PME_TO_L2_TIMEOUT_US/10,
+				  PCIE_PME_TO_L2_TIMEOUT_US);
 }
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
-- 
2.34.1

