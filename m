Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173831196A;
	Mon, 26 Jan 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413633; cv=fail; b=cfb26HNpiI3An/S2F8De/rquCBayH9CT/vXxC7pROwSgoYhhUxgd0lropISsbPzwS+OnG77REhsLOHSq5lUkfYH76H1bMmE7JCNt88fHmPS0u68xS7rq+qJqwOx3tFRusUZT5wLEIJ0kkhApjCuRB8syFFbUu130A+nHUaIJ8Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413633; c=relaxed/simple;
	bh=0wYyGoRvlE/9NzJ8hQFlyy1xTjLYORJ5CS/vcTtiDxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6+qVjCrungRDsOs7aZkXEKdnJZSgobKgLlu7UwK9Zo7oRqfd/rcIzZXzw2tfgBvoDkbg2Z8JuImCYpUgKXJ0pb3B00IuvaAVNVW2s6At6N4Rc4mMg7S+ypclbQEAQEnejlDNwl6uuHr4Q/zs3vAdoZPQzWDykwZ1yyCBV+f/58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+KiNyP7; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+KiNyP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz3PPJF3xdsq1oND7ZBpPMcyVfxtlwaNmS6F+tLvGClwaNzHkXzkSnJuZhKluGIBxZZvZvtc0JiVeUrcig2gViLHaUYrk3d1rMS4ri3rg+LK/ntU5N3+C014ySTMpcQsc2BLL2PKf6EHIwRhe71vmzqKkNcFfnTw3J+NXsRwGDxGpHosyIYXCPlTi9HoJPIlx/E3TMTUr68/TFYqgmpDGSggge9wfBg4ugmGidff2KihndfQuoWXMj8oh7SmGkoCmNnsCt3ktqWPFYWlkr1VIzABRTNwxxC+OQw3hlX2kYZsoEdwr3es3Dz4QnuAgjTVmRzPmWyTLun+RpGrd5E0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz2TdlhlCnurpBdTeATPQmXcra/9BkuXcyRjCGIeHLc=;
 b=hew4pAFgDWXYvwEl6A+4Jj1gT1yxi7sqXdD539nvLn94tiMrXRukX5Yj04R9/9yBcJ4EMQxzE3hbhG9oVfLwdk/GmDASSOYDsa8mjr/46761JZcXa0X16/yTGCrxwfee4LJxelRZdFnYLvJy7AElmEMYbFJRT64vjFJwO4CyJwAzA1InWn33BRLKTyRR8WLi0+EJZLRHxHTVa6br6wlYePweApz1OMFGVsgTUM2AAtNROzMz/VS+tB906OwNVmL670IQMzEgson46+jJc419lMdXBvz8Uka5N2QIX9ZsPuy1iYYEr4dkeN9SITUmg3qKYJABsykH3BuHdeAI7uKHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz2TdlhlCnurpBdTeATPQmXcra/9BkuXcyRjCGIeHLc=;
 b=I+KiNyP77XOmCwmk35LR97cPuyCuriEHkhSoliKPU/gOe20dmhUx28rYDWfs3PWuQ5yNJZ0O7dkqZyfhyLE/+w7jYP+zg4gMiQNft5pb6wjTmyYhzpejlRNqkVssmpbj/cFgOicfP+bbeeCmbH3SmGQOGShEVEkEMcXaBo3+mMnOvc+hLqoOkrNd4PCiJ04fXV8iR9J12NuO5odijXqkHQBZoFJUYoPolKLnXbdfqgNbHHhjR2Bbw7ZN+5c6m8+W1QQbnOe8tJ++m7CzXx2ODYmfqeZihwDHVsLEoV0SZP8hLNBb06fGrFW9jYp/AWNeH/KBd9dJQqz85VUwCV3e2g==
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:09 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::c2) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:46:55 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:46:49 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 11/22] PCI: tegra194: Enable hardware hot reset mode in Endpoint
Date: Mon, 26 Jan 2026 13:15:08 +0530
Message-ID: <20260126074519.3426742-12-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: ca75233d-933a-409e-1b40-08de5caf1c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yATGqTH7EdnqWR2PCmtx61vHb6hO0sLoWNSzbrMin4XvPLN8aeV0DNO6FTm?=
 =?us-ascii?Q?BN58WmLtQviS1wZxO3dAX3vM8e+5BM7co/KunD8Y/hkeALAnh8c3dlu7RZRf?=
 =?us-ascii?Q?YjNx1sHPxaq9tbZ2+ofTePO42peItV6PN2JjP1Z8heSI+JQUrRntOHbPzQRN?=
 =?us-ascii?Q?4ryT6VQzciMayb8vW4uKVFbZ0VZkmZeQBbfKZ5eVUl48chfTEgt4AtfzxNxX?=
 =?us-ascii?Q?tmUL1yACM8M8e6yH2Qr2yeFavixoT9/OWpdoYanaRRdK8T5lqCAEHc/K3wCT?=
 =?us-ascii?Q?PT3tMZtFBGQpH+/Eeh9+Bp4pr9AwCnY+GngkiPjJP+aRvFhwGOhV3ye4IWXT?=
 =?us-ascii?Q?ae0p6WolSmKwtxonaWfPAS+xsZHCN8n7YNDlituefXium2VVUj+HSiX2kOQU?=
 =?us-ascii?Q?Ttn9e2jQ16olKvqikc8r7PZSzwF/NmUmjMRvzrf9NeqP5PBYkQCCkAuXNAvj?=
 =?us-ascii?Q?KxrGTUd5F/vDdlXxNAXb189WAhCrMseV6LmSY5YSwBGtBrvW+VgKRweQMZc2?=
 =?us-ascii?Q?H7DTg0Y9sZWw6QnYIb4WYZXjMCt+EfdVfrYiecmHUrZTw0ASn+pmUTIQ40zb?=
 =?us-ascii?Q?UJ57werjT9xKvkEQycAlQkgMUsHm6cTVpkeOPY+S3aQ8s9gBPYCPlNw4xpQj?=
 =?us-ascii?Q?Bgmdftk7oNz1a8wwjX7ohWAJFsMjVkeLm5GNOtnpwLvbe8Lyf648Wr+RF9lI?=
 =?us-ascii?Q?7wYf452eveZ75lW//djg9Wpph8r+18+mEaq16QtkUCvIrPpauYwJGkudWMxj?=
 =?us-ascii?Q?2cSW918Uhg33Hxdm/VOdvI8Rl+tVmbcJNIO4f7maqcy9HjUFMqPpyqtG6nxK?=
 =?us-ascii?Q?rQTTfLfoG7KFjBwtsch73SKVfEwEMjRL3cvyWYC66085p+C/Zn7vCcLKSZoB?=
 =?us-ascii?Q?dvUJsXHyzME7sVX8YnOVBwwbBX8xzZRdUz+yGEgRxQX6KgC/6+c2XWZnDHg/?=
 =?us-ascii?Q?wDWcw6LHjddICglBU+VMEF+iArSJuxZdIySvdqhdZ8ugAfjWZaI+IqZw2Bxl?=
 =?us-ascii?Q?13Dn1UImYxMMuiPGZcO8RA2syEI3TmpT+n6XcLJV8eOJMdx78L+08AzFCk4t?=
 =?us-ascii?Q?O63sZKMEZkYTOzyllXI799EOm9UFiaNscbvdQI+7GI3C1RcCAtwuGIXLgriT?=
 =?us-ascii?Q?EiWmzGbl4EsoSVNHkx5Hb3MWVPzXS4t2xMJ0RYMCUHNEwAwTEw8iKtztZDxv?=
 =?us-ascii?Q?apQss8qUo4864U70dIRCEeu8AnwGH9dJmXPv5p4uce7yITI0Y3zdR41pTzRj?=
 =?us-ascii?Q?dmPGYy2WzFAr1zNX2/zG4GlE8KOEQAveHJD97HQ57wlPHTwUNSrj42CCFpt7?=
 =?us-ascii?Q?WFGMlB7/vRCx6uK0gHV8JCYjhqIyxaESuFerLdZbGRF1OqKAz9YOR1vmTLYQ?=
 =?us-ascii?Q?ZuOu3oCtuCGcwlI+O2bUuMAZXVfIwOkWghQWUbrRvyzjtMHdB6liE1AXh/pb?=
 =?us-ascii?Q?j/cABD+Dlrydok8hJ6BksuN9a1hX4mfUAvc2sMWwb/d0QUEgrOyqmTOnI30j?=
 =?us-ascii?Q?fbO1LVT5rUvBG8/XALe0BM1yEfYwi5cAnnFPROuD3yNvG8aqhTUu/HFoKnGT?=
 =?us-ascii?Q?UJZNvq47irvzhe6b3qxm/Q83JrchdJMansMHHhw4d638ww4SVzYV+O1JNb6k?=
 =?us-ascii?Q?xoN62HaGDdivvrOi4m3ReSUx1UYIZnkadn22fSOWVZskwQT9N9BVFXKM+cz3?=
 =?us-ascii?Q?rL53N8G4ug/lgREBwZVDI0legIg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:09.4074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca75233d-933a-409e-1b40-08de5caf1c25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560

From: Vidya Sagar <vidyas@nvidia.com>

When PCIe link goes down, hardware can retrain the link and try to link up.
To enable this feature, program the APPL_CTRL register with hardware hot
reset with immediate LTSSM enable mode.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e5168754b92d..5fa4d2adf64e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1825,6 +1825,8 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = appl_readl(pcie, APPL_CTRL);
 	val |= APPL_CTRL_SYS_PRE_DET_STATE;
 	val |= APPL_CTRL_HW_HOT_RST_EN;
+	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
+	val |= (APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST_LTSSM_EN << APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
 	appl_writel(pcie, val, APPL_CTRL);
 
 	val = appl_readl(pcie, APPL_CFG_MISC);
-- 
2.34.1

