Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE97C311C19;
	Mon, 26 Jan 2026 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413667; cv=fail; b=h5jTJPdWEgQxT+lviye9Rb+7GV6YavByWXFrobhuZSUBqlUXPArbGlwdl5FPmbDgk/ajgyZtS2VjoDV8qn4h6/dTtXgF5nXKaFiT8oJbOcCDWoy5Gxtga5vAPjtJluNGK5fmf012iE8icj60VtEAu1r1qnKK/rKkGS7nfYZE5y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413667; c=relaxed/simple;
	bh=0677VWNhZLFsgHvzUhFg8p1PEIukUk+QW1NYMJsMsOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odWjYFCQQsJbezVMWY+3lhcmsSTM5HqM1KqCoNfEUTTBX+i9zXhGu7VAzA9N1YGFt2QofsOkMAa2OVoQiiQ44EdDsYXcMp/kgkgpFtrW8rnjx5WTDorBrwhGB3GXiZLsyXAnSVtyLBeNRr5iADNRtzRJQ2l2P7R6OIdcZjaiGV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nuvl8RgH; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nuvl8RgH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDOe2ABCCJt0vXzJ3F+GoTqYisoX7yuyMv6e9/ZrbmV6I8mnjrij8JjLKy5cGvBunEg/Z6Z863d3e76FeSMaso5aUg2hw+86eK67LWwhtqLWo4F05hghtDMWF4wB75T0xPgLmSaNqLwGnep4fUvromedoICcaCE+0KXz7cMghOAieHsmC7PNs/Ixh/gi8G79lkrFZOJ4R5T3DexsI88U0osYf4A9pXISfErAkvFcSyNxpmDCvW/ovvoRcU159yRkQb3eHdZusPifjPzdL3LrS1SQNAH43UMKXN1gYV1v8d5ybKbF0bQw3efxcY2djuOWUVcNSdbmnqZh5072UvWUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQivtombwWN5oPk6YUaBWciLkgm19vzOSLD2iW5MOQ=;
 b=yCr+Po9gDOCHgKvEynvrHPGXBWsBhmuDtcNwc4JIJf7xJ6tZgbBcIJT6DUDXrfu/5QXvCu+sc6bTC0YYCja+aVgal2Sam/baSWQbOFiHZV/UsvWO+eEBTtgJMYzTzsA/MZffC0lu1ju5MTK5wjn1L6lIK+fBHGUa7Zj16QYq8mrAn8zbHsZDhQGqdg1m5e2bKIwloX/QN/1yGkEJxIesKYnuz2gBoy4chDCR6h5dYJoIXW7ax42okLytmP52k4uJC6MqlApaf4SEh8ifY4MxBIKVX5Qt6PqcS11cRvDHxR75vKnxoagqu1C2ykPJolSYH86aZC609BrKEBTHUx+2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQivtombwWN5oPk6YUaBWciLkgm19vzOSLD2iW5MOQ=;
 b=Nuvl8RgHEamYwE4Vk8f/EkdNHHHSE34fcIZ8f6cAI+mxOda59AkZ5+IUsa4fPfLEeFYrQKAEsgmQTudPeC/O3WqjqZCXixnca857TelhJ2yPcdcXGBMS+dpp2zb61floLVaZLENgYRbGSRljEAI1LtuJRgvmw96zv2Sk5x8hVQj+RPSsLl0gCbMClXqarWdR5xg0ay1ZpvEiIJNKtst9FTnK8++yJvuuUvP1zKvzktjsHlZdmLQC/N5if3UNwIrxLfZfrAply60bTGgi6RTqkQ5bcz+VmWG1FZm+nhSuHH7Pz2C8aiXaGvf8gJcXB2fkyAbUI4jlmCtLqaoATD5+0w==
Received: from BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:47:42 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::f4) by BYAPR04CA0007.outlook.office365.com
 (2603:10b6:a03:40::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:47:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:47:30 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:47:24 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [PATCH V4 17/22] dt-bindings: PCI: tegra194: Add monitor clock support
Date: Mon, 26 Jan 2026 13:15:14 +0530
Message-ID: <20260126074519.3426742-18-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f3723c-3ec6-4da5-58cc-08de5caf2f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UvgRKQOAbgGVjJLRsmZCRGIA0s673DCbKdUNN34UZS1KpGjeZyZ68nL/Ri6j?=
 =?us-ascii?Q?2AUlHDcnmhuaic33XXqrmfz82W35m+U7w/RGhLqzBcor5LvciW+tKZI9kaud?=
 =?us-ascii?Q?muqGRrO+ceRkVWygiHyyfAi+om+BtzCfgCooQGkp0f6i49HksPJMOtklihDa?=
 =?us-ascii?Q?hf+XCfa0D+E2WnwwJdrvjnka5gipYQAcdcm0UEH6pZmwasNmldv2NRJibkcU?=
 =?us-ascii?Q?bun11W9nJ+BpnlF77rKNONas4SblNGE9AX5e0R2TpXQ7OLWGWVyOSv6C+xHb?=
 =?us-ascii?Q?pLmAiqXrstFmez8543p0aERX5ZYUPehBdcyY4+GDVk5/eJXSeFOJEsfnsrcr?=
 =?us-ascii?Q?7pY0CoKb3zivZsag4Vpf4etupVvCAS8qcYcxPjXa61dHfJeHsqQFx61wKlGF?=
 =?us-ascii?Q?/c6ADd1hosj2gl7dxhN6xGbtx2s7sE0vjvBrzN+LiXjYYeSKT/wZLbXPe6qb?=
 =?us-ascii?Q?nYV0wsnnWDo5Reg6Ixx1OBVu5rzmJ8uldeFTSDce0Fnn2VwH5GjsaoGHxwCE?=
 =?us-ascii?Q?BTmqAb6v/MzfZbXY4l3xEFCh8ChXrsolgkDbcs2sunqWz/Yxd+ITFoYMrWGq?=
 =?us-ascii?Q?qiX37ZiUu6v/Wssbin6dAegF+cex/0l4cCPrq8d983Kf+BO11o+V1wiSLG3V?=
 =?us-ascii?Q?TrtDFOqtWkv30dTW6jmY6glHcIJIK60/ilVVBpWHYJpv3F+UR3mIhz2vECur?=
 =?us-ascii?Q?PvE8GAmCPVw9drno1ynopncv+/PSXIVqQy0XaxXmDTj7q9Y2EQMQn2ToK4Yv?=
 =?us-ascii?Q?/RmZYFaCHzlO25YyptceefZIXTWbsFJ4G6r4BrqUl6LeEbkNIL/3yMTHVPPJ?=
 =?us-ascii?Q?Un01gF1vYiV8o3yPMBJt+4tjyTxZd2xlckrIl5D1zpF2P06S2Hsel0ojZAUV?=
 =?us-ascii?Q?frGSfFxqcPf6ObSbfpt1N7V6+/4pWpUYBUkWpQEa5Sog/jejO2yaoRNkp7O2?=
 =?us-ascii?Q?j0XBerEQar7OdQZRYjyhuLvxuu9Q0beHQtZq+uQGWfJHXbRRcHAmbGhtf1tT?=
 =?us-ascii?Q?pMK11Z9tc2/oOwlA3ZUR28yU1UGKxkxrvSnMcdHF72qQ8DiJ7uN6qkS6O+1w?=
 =?us-ascii?Q?m6WBGaPixz7uWbKhh+cxM1myIfMagaayyS/H8mtQNwCFz3M0Ls3Y4WYdBnZU?=
 =?us-ascii?Q?kFIWS/LdWjLblmc36wlsxzw8IZUbUEvRAYzBIaS4U/YXMd7PXcanevFu/VKy?=
 =?us-ascii?Q?kmybyp9kCWEJAlcrceVFSt9nEDrivRZeck9VSvkXijk+pB6R8+nyBiMpi/V8?=
 =?us-ascii?Q?ucJAtVKIbfAk7vd1hPpKLNNjGbuu4k4JZiu9o350vDI0vMQXnnHw7meyVfZa?=
 =?us-ascii?Q?NWZpnhDr1SIYZireqG4Uq2k2l45Ws/mmChYro0IspOsdSMSGnfvZKBaJ+FFh?=
 =?us-ascii?Q?PnFUgPjWUJnC8irz0W0dQdHgFs6uyuY6Mr2HkIvSzJoUvagecOmgqzPqUEj8?=
 =?us-ascii?Q?/q+pEOvSOMect8vpd2ycQB5hbEsGBiQ9aOnlNbcA8URjOB1+WNApL2gcZIjA?=
 =?us-ascii?Q?NUv01bV42jX1ZoNw0bSFGYdQ748HU6ZbK4NsGV7usUpXjmdA+bh1pwRUZvuf?=
 =?us-ascii?Q?25iWn1Bu+AGH65AYQxU7mn+a2a38iWGFbD5dIeIdiZ3WURf0PMbtmJlyO84f?=
 =?us-ascii?Q?xOGtwQ73a6znefc9tkf4yAi0FS1E76FnapdaN0hMnjxiguVFMrIOpXiEk+uP?=
 =?us-ascii?Q?D7FosQs+4fimqe6NkYSCMvbo2pk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:47:41.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f3723c-3ec6-4da5-58cc-08de5caf2f81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
V4:
* None

V3:
* This is a new patch in this series

 .../devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml    | 6 +++++-
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml       | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 6d6052a2748f..ca5da919c347 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -55,12 +55,16 @@ properties:
       - const: intr
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: module's core clock
+      - description: module's monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index fe81d52c7277..d0f5f18f5b9f 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -58,12 +58,16 @@ properties:
       - const: msi
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: module's core clock
+      - description: module's monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
-- 
2.34.1

