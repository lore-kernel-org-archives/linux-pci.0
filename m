Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C831197C;
	Mon, 26 Jan 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413586; cv=fail; b=VyTYVi5Hwl5XyYDWJmdUe/r2h44BBA/sWDE4crhOnXSfQmh4rjVlvC3/lPMTsWVCcO1MilYldVNjZwWvUjr5e2hTQo8T958ScBGH7oKGqjBPqldzc7DRotvjSRem++8Q6ZF1nmJd//Inm0aA7uC9dR5xTd51WC/79gmnrQzV80g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413586; c=relaxed/simple;
	bh=DbVzkD6NyQu6lAovoX5YMF5Yzg9KptE029YEdMckpbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POjeGzwOEhFHrW2WIPewbnRPjkVI0A+wkNSj1yL7LYbxc4Dwaq39KBG0ycRxN6s2k3RwF/pFaLNl8ZCjjwpk5ptotvAgAoU4vXozNsalNIAFu89hWWOrSf8tVUko0KXrjuoltaWfCP9vj+vqmXE+T2xWh8WCzkTKYH4TxLaat7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+74hQ1N; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+74hQ1N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYTWRo1rApWCQOL21iiCx5e27ohUyetYQB35bPdyYiTmonF3m+UoBFYWHb+ndHEtWjh11SUcgKW+BLjSJ53pUZsOLsL7+ugoT/MvazHAQ3CovQ1dBlSteIq09/NW3d9vhWjQbnAA0IHykv/mgNNHS/pERDeZCOxSOO1eu4B/zP+DS9oEhR/qQVLw3pyt0TCDKYH53/PGhkEUynRkbyyvO4gCSXcBSaknS7Hw9Ze5RjLCmDQvGCyuVHtJzbdd09DyKpSxywP0WDZ9MiUXaIHncP9Ak0H0P3GlY9Qki+6kYyjTeJzuvD5iJfhL1bXn+RPYkNAIqONYzUt07vdJJEdoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HTEqbI4vQvY8dAVw9WHsH+ClR1ePIHz/o8GB/ktQec=;
 b=R2qkZ3go3fVQqjeMBnGAVTNm5grHX6VxlZtGtynA86G/1u37BPkJ9zbmZi/G0llYHINEK+scqajTFYIBl0mMy0iRAZDTKFyHG5jr1JiOYY7pKkytnQWR5Smg73EUCGym3PsvD8KAYnrksYQ6LAzfO6+DUAEUz6XWtIFwttStdQEzDMCAMmf/iFgUxWTqBKq/e/JZPWK3U6/ZUcHOttwX6PD2cHFLHf/QEyCFzbuO70+2DIDT6FWiXGGVslI6X6OFabq62gdkgqxmPW1yYuKvITYIc/B1S4UjKouXsmVAsWlbplTLqtLPufJpxXXhqUcKztxQPR4fDKCS0JA566Iy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HTEqbI4vQvY8dAVw9WHsH+ClR1ePIHz/o8GB/ktQec=;
 b=o+74hQ1NwRVNHh9PYH0LjWHRdWsFGv2dkiXjyQXd1lHgdX7IbgYeWesh0yaW6cjIf/jGFlQhHbPQF9IA4Uvizzmmvs2777Kv3blMRPMeCmnDogabDAQW6MW7Qe0XoOQPtOutloxg0k2YYLBdbG6UdibeyOivfhzA2oHq1VJ9oCNmN0Qz4aWCPTr9Yf+yRPTXPpA1YAJr/P0la0cBdpmdsd3SrM+Al0viA/Ep8/RyZ5Lzb8fVc7jP1wfxZUt0S/lVXwyw8lHWGSGh8BcPKV1UgLjYYGIMpm+TFZGGzydgKDTJ6c+JCtvaPVFXs0lIUs27XC2CfNphyxyXrNfbuf33oQ==
Received: from BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 07:46:21 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::2a) by BYAPR07CA0101.outlook.office365.com
 (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:46:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:08 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:01 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 03/22] PCI: tegra194: Fix polling delay for L2 state
Date: Mon, 26 Jan 2026 13:15:00 +0530
Message-ID: <20260126074519.3426742-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
References: <20260126074519.3426742-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|MN2PR12MB4191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3b6335-9265-4aa7-908a-08de5caeff58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPbSQKwzK7P3/klScBB3LD35pyd9v0vQb4MSzkZ1QAPlOxIyFJiroJFkpgK9?=
 =?us-ascii?Q?KlCYt3ie010nbaBHJGnaf8inJbYT/8GacbQX40fI/G6I4yutKDxQ/1BAp19f?=
 =?us-ascii?Q?7PIRmghw3QRW3qnKRgjtV9hBeIs2WizpfnrtiaoWGh2tmqmPzJcVRWDh4ywC?=
 =?us-ascii?Q?amEJLuBKOENFVRu8vGlGpsBlKf+p/T/cu6Zgxu/0sxX4vBYlTzBVcWxBZJKL?=
 =?us-ascii?Q?yw+/s6aPBTBW6qvFBUs0YRy0STjshMgwEyl9Ectx+OpClEeIqwimQAp6yQZW?=
 =?us-ascii?Q?Wz35vx7CIv0yhFWyLBhAyUlQxeHvdMEAxoRtizVi4kU4aH6UG157D3+Ylp4e?=
 =?us-ascii?Q?UJn7ToM1yt+tNxrNj8DGIvtmjBHBTxk5WJ01Z3HlugBoPw529/WCYbpN9wR4?=
 =?us-ascii?Q?zK6BYW6GYXoje9s0dQp5QY+RwyjNpSyPtYBALguVNo5tLM3p1xx2BIYd3vYx?=
 =?us-ascii?Q?2bgxADPmI8qRyKz3mbijOGvaE8rs6gsIkEPd0IxfuBj0P/RRIvX3y74DRENa?=
 =?us-ascii?Q?WunFIxgKACJmTu8CBk3rBhbMJw6HKw7R9oshePWNQu7Khk8hy4n4qtjRBvMb?=
 =?us-ascii?Q?6dJB7WnczPOE9EeI8vXnaOF9dMmPNkm91rqElmyRrjWKVrKmoysznRInnZH/?=
 =?us-ascii?Q?VdL5rR7hbs2jby3S0+tAJ6khp9jGyGB0hGK5w5bAh6kcOTYaOI9o+KxMcWxh?=
 =?us-ascii?Q?xWCkksfj5VqO5pn+5YemHttLUF4cO7jZ0mG6dKOknMg+W5bXi4OW+for50EA?=
 =?us-ascii?Q?bTa5vOO3Wc4DRQWHLCVq67z84/evgnp61TsZnMFKmC0pqNrqPhI/LivVM5d7?=
 =?us-ascii?Q?pET04ksgaxvu8S2vZhfo4VwUOxzMvYDHnjZP/jDXQfLNEWVggtTVmQ6owze7?=
 =?us-ascii?Q?2Ri4Qa3NJNo9RQh83ZTkUxooUAkrIdkSsW3A1QZ5RGMh3NRcSgBNfEtOPVyF?=
 =?us-ascii?Q?UuHThvAXc3to7Rjsf77KZFPKp2yLBNOo6/2HSggndkU+9M4r1y468h4k03+C?=
 =?us-ascii?Q?Wp6kwCSHHq6pVZCn5Ie80NwyiqCVRgfjAIUxhVkNK5p/uOoh30VRJ1I3a1/Y?=
 =?us-ascii?Q?WPD4R5ikinYujNvvjh1RWznoa9PcOVgpSxOzjSAn1pr5lZj8uUATi0XJ7MH6?=
 =?us-ascii?Q?5WByu+GAMaYsJdH/hw5sn2QPKvG36elbVOYFRslOQtbZ252CpkoEOpbE5a2Z?=
 =?us-ascii?Q?AfqOVUBGFEgBq2gOXHiU5ihQQdGZPqav+JNz7wz+p2k70Y9ojrnzFCXfsMDy?=
 =?us-ascii?Q?JwL4lA2eJdAAAEo0mRbBwE5dr2kQOfDIyGgno3NxKw5gcDH57+fHgF+2iJKV?=
 =?us-ascii?Q?s/ImGqyaRoLzSfC4aYnioUuFXuTC5amQLL/+MfPC4WqYUF9Vho5ZTbx2eff3?=
 =?us-ascii?Q?raZ3TuEjTndHcLDhMC59GCn4nNNk5gmPSwTJ4CZmNgLiVNpbR4bcdJBqM5VN?=
 =?us-ascii?Q?JpepGY2R5mlImzaRSoz0mqqfYc5ilR6zr1i7Uz1Wpb1E+aO2ejz+kodVagcN?=
 =?us-ascii?Q?ESTfYYZ4NAEFSaXVkQaijzBgB98ihgk2m2CN7zryFQPbT0reJXx/Z+go+jvI?=
 =?us-ascii?Q?uYlkWAFjZdQhwVeAiSUs5Gahagxuc2XGNPi3KeO8guQdC4sRXD/4Q1dBbxhF?=
 =?us-ascii?Q?VCxs0932v18/2gl6Ft9JFXYkT5h9lO++Sb+mUScxRkF613jhtLbSyRD6c++l?=
 =?us-ascii?Q?pP1lgCpy91hkDcEs5srBV5tcUhU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:46:21.0938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3b6335-9265-4aa7-908a-08de5caeff58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191

From: Vidya Sagar <vidyas@nvidia.com>

As per PCIe spec r6.0, sec 5.3.3.2.1, after sending PME_Turn_Off message,
Root port should wait for 1~10 msec for PME_TO_Ack message. Currently,
driver is polling for 10 msec with 1 usec delay which is aggressive.
Change it to 10 msec polling with 100 usec delay. Since this function
is used in non-atomic context only, use non-atomic poll function.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* Changed atomic call to non-atomic call
* Reworded the commit message

V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ab2c3f07ed4f..0b8c1a7ca232 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -199,7 +199,8 @@
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK	GENMASK(11, 8)
 #define CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT	8
 
-#define PME_ACK_TIMEOUT 10000
+#define PME_ACK_DELAY		100   /* 100 us */
+#define PME_ACK_TIMEOUT		10000 /* 10 ms */
 
 #define LTSSM_TIMEOUT 50000	/* 50ms */
 
@@ -1555,9 +1556,9 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 	val |= APPL_PM_XMT_TURNOFF_STATE;
 	appl_writel(pcie, val, APPL_RADM_STATUS);
 
-	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
-				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
-				 1, PME_ACK_TIMEOUT);
+	return readl_poll_timeout(pcie->appl_base + APPL_DEBUG, val,
+				  val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
+				  PME_ACK_DELAY, PME_ACK_TIMEOUT);
 }
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
-- 
2.34.1

