Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB22F6184;
	Sun,  8 Feb 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770574256; cv=fail; b=V5wfFlehXzoHlMBWv1S3wGnSkRXboJx9uAOkMCXOLoTbynMrnHZQhOHo8R5Tx+c1vkQegKhCw1MdtwpV9ePPKaOl/ZIneAzVbDY2bXirGh4F+CsdekkzSdRR5d4cFi7ODclVFEgwIVM/LT25DxbYn8MEEuD3xMT789eatWGz//U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770574256; c=relaxed/simple;
	bh=ocdUsrE0sj6M9T9xXyQXQukceDRMOktni2k/zBr5DGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEy6lAIBxoVnDdN07NuMZCrs93mmm4UBZDvl1edzHYL2loURymzba7Oxz7mNB0byvAUlTqAFZJKXxnwKyQ9Qjqv98UO6uMcvKqqp7uIMxbAWbc7PWQEImYPF0EyPVOtcSxnc2hcjQ7ZIE1yByNU2ITQeFOT0mGZKBWSZkFQZoqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cHpGa81a; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cHpGa81a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yl+gQVQR4lceuoQ0oCdvypTq0NE3YYpICPINMzn4FoEHgywPcfEUhReoFCEw1z7UspkJpvesox2yJ8fwQmbBpVzFq1OzdR+6iHBBPP8GsBzGMtCnGRbGOXaUdhpos7D8bXhD860m98KSutI6eUmSTXA9CfhUQwEOTr53t6XHuYKEcJC/uOYxXeWNrmB6N6c6cktNR2wm51bHAbr7uVDvR8Hv18jCofo18n8nkDj8v66pKHayulOgZTgTRr5CsPwbj+h91wgvXTME+9+QlXZ8lJP+6fb7GewI3f52g6w+jCFVf0AEW+G3bhiu85tkfyv6DvpbULUSxfFIr7a0+fomng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3rle2Abw57JI0fEORkN6p1yHSjnEBx4u+gdwjsSONU=;
 b=b+x3O0+h7hKBgQN6ZiFu4hlkA/rzn89QiEcFUwjZZHGLMz4xk7XzF32GUhayzCi+L+Hw7MfwUt10g+hN1W2SqvXSEgPow0xyc+ybL2+gC5+3Uv5KeucnqwqcsjSF0zdhlZfOEMl/t9Nk5NzxF02NX4uQbCmWqDhrkDnnFKLqbepaPrMgBzrumtRA0DtuqFc/T9xlXGUNbmytNZZLN3g/FTZaeF60tD5fi+FByi1nvbK+9dIwPdRnURpoZDTcA0xAbRh5p9snf9FuzoZEU/J9wuCdDcJygzfFU+vSPvQjNcj1CIgDwgtIagTpVgohKotTJ7oC25QzUbbj9aQwoJ+H/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3rle2Abw57JI0fEORkN6p1yHSjnEBx4u+gdwjsSONU=;
 b=cHpGa81afYhAWwF1rl2omf2isYV7BtYB3Qs4wARmNi6aCRWQO0dlI+UNYUGLLj28QeIdHeQrAXvzOEQWrPQyehUrChwGfzx8KK/nSruo/t6VSBVcBR/BAYh5DWVoKrz3HIKmYpxUI747ATAsHPScrjSAgvbF/9NA0iTtEkjllV1YjbtdGP9Zv2eO0TUt/p79nrzM8L8u3wEZLpmnISAfwX7AkTNa4spm0Fi/yLTbbYxpmj/+EliHM90jiOrfAsgN57PgDCMYcAsEy4p2I9/Cxq+OwIujlquZHubM9JxRqVEF+YdlbvNLCQdtljJtTU5kla4Y2paxiom3Kb7UelC1bw==
Received: from BY5PR20CA0029.namprd20.prod.outlook.com (2603:10b6:a03:1f4::42)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 18:10:51 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::c1) by BY5PR20CA0029.outlook.office365.com
 (2603:10b6:a03:1f4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 18:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 18:10:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 10:10:36 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 8 Feb 2026 10:10:30 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<jingoohan1@gmail.com>, <vidyas@nvidia.com>, <cassel@kernel.org>,
	<18255117159@163.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manikanta
 Maddireddy" <mmaddireddy@nvidia.com>
Subject: [V5,7/9] dt-bindings: PCI: tegra194: Add monitor clock support
Date: Sun, 8 Feb 2026 23:39:34 +0530
Message-ID: <20260208180936.2026329-8-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
References: <20260208180936.2026329-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ef72a8-89f5-403d-3815-08de673d64c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aamd+3QiPTzWSt0n2m9acSA4/YYHipCTF/jKb4l9D+zI/Yts7jMLVBl+Pka7?=
 =?us-ascii?Q?bNQI9+ypJyeX/IfOpbJpEv4XJkuueTHjYYOHF/e4XwT18sndR6WEOdlqhkwz?=
 =?us-ascii?Q?kCtGD7W8TZD9OSRBr2cNmzoKnEBVhkvh1CE3Zq9iGJJaVXJR46odDN1c+G3d?=
 =?us-ascii?Q?zA/JjIYtpRw24cGPjUsKmRdNw4/cRPvd0rD0cIJocAwAZDk2UCklaL3nedwU?=
 =?us-ascii?Q?tGc5ZnJkXaqeCDYhBkCDSGNDEcJoVsorWUQchjBStRWY7vF/LyJNmJj8AIZM?=
 =?us-ascii?Q?EKySV3FOBjtZRqAtEOStQnq+nfHkD2vUrkzWzL9zmiyBw4QJlKFPnYAMBZor?=
 =?us-ascii?Q?k0e9JpMNefSmzUfd1349zsyTUDy2ZXJGWbMF0hCDaCu3BL3LefcGTnYe5pbs?=
 =?us-ascii?Q?b/dmFyjYFPNRW9+jc1odpVnM507Qn4wxse0RqE2J3h0A3OywWiZJIb9x9XtT?=
 =?us-ascii?Q?9O9MsQH5rXzBFtd6EyPuBybXqEcJGktO5SMbhZ/SGhKGn2sjKdMpGkLOaN08?=
 =?us-ascii?Q?M/+IEbyUnffH30Ctw2Hw4Dd6pjt5xY8U8UvlVlG6Dqn6cg1z62N2FwCfldA+?=
 =?us-ascii?Q?ixfc4LMepoXILWoAbFzW7Mj1yRYBK9BbNYjH6JUVlx4uHJK22+v5jZC9S5kL?=
 =?us-ascii?Q?98aLNcfM3/NdKLr8y6dtO/2DlkPkK1J6WzmOv44HQxco0v8kmoMnhIO4DYv0?=
 =?us-ascii?Q?9EGmiOfD4+rNOYKwYluCF3olcuEwiWGT4LvgGt4mtZ1OwCcnGvky7/QUl+aM?=
 =?us-ascii?Q?kuRZKdsvNcKb1tRUICpOSlBEQSuvBOrCkUPYvHVa9G/xQc9wYK9fUmM7HrGc?=
 =?us-ascii?Q?cTADIysiU5NAs43PUav4wYt5JtfHglV6I58K5uJVFXH2LCIZlgXcZWQ4D65b?=
 =?us-ascii?Q?N5B4CdMrAE0qHtLawCTlVHLqGPg7gkNy/62lUfUYj4ftpjJxXfl0APBR68cS?=
 =?us-ascii?Q?F2apgxc2QN18+zgx85Pd8PFEFxDHKljD2qkpyB9zaBzFXvTQrvcXuRBqlj4B?=
 =?us-ascii?Q?VVj+L84X3A0FbtDbP9YdjrMCoNdNZkezuLf2i9hL77C52W5OHet0iytag2sc?=
 =?us-ascii?Q?Zu4p0uch0GQUaZ161jrPMzXnFNkyj/SrP9K/tmkSdslFlPCm9G4lFXpFzXVQ?=
 =?us-ascii?Q?ljWEsmyUyYvuHOS/znf3ysDnjMvPGTIZxOIy0MXauc6Eh6D+JyecSig5sE5o?=
 =?us-ascii?Q?1NDTITLFCzEN0eT+2noixn5NAIDGfo+3eFU4UPbSWFCJO1xjGwQ5JrlnMBKP?=
 =?us-ascii?Q?uzovHG4CbY0EyrvdxEr5m1u//5SmhOTo55x2DZ5OQhCH9xbN5y2KX01piCbv?=
 =?us-ascii?Q?GOq+VylDtt5brj/Y2KRULLtW4qnnORYDVThNMYRZ8M/ziNNjRHMloTwfeOGc?=
 =?us-ascii?Q?pptOjmQFLvR54Z7IoLG83UEJIE/EKxgABw2sC7JmAMCSMqQRZIRZbuOBmpkA?=
 =?us-ascii?Q?ZxJ/p5tjDvF2D+pgejapsBQjoy5a0Xw688yNoPvcs/GzTBefLtA6MRHyLILJ?=
 =?us-ascii?Q?BEUte/mpT1pROEDJFfrXhF1k9EtBJI2ipTCmAsXFLOEeYJ5LHHs4XnY0FuXv?=
 =?us-ascii?Q?R7v25KmM+NaLifzgPdLzKCs0ik54O1byA4Po11fjYky/RHqVs64RzY3ZpCsm?=
 =?us-ascii?Q?Ifqk5i5cLSmMrx7+S5nal3JwZET3p+isTqMFRNAYEZn5gqVzMo8fn+3Lv0ZU?=
 =?us-ascii?Q?r4Aix+DeQDYMhx4FWfhnZnMlImE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9qdjYMLT7K0GVwZXE5+xI+E09vGTDQHs7kaMYyk7qtXjFPNNbUUr8RcQBzFg/DvtuVacLFU9NZ2FT3Yr6cJDNciSDIDRxCA6Um0ddBDTWCW46CiUu7HS0Oo7Q3YfI2C5Fb2KRdCsLBu2F8Y9oRknK2e++O5jXVPsKXjytdgCcAaNo6emFJH3C+DH2qvWIV+8TYamb9RjCLU5Z04V6JDTOjV2uwqQiQLHDfiZuBuaosCzxtg6qK8aQYP+YKEsYt0XT5x3NHjVYJx88sl9wyvSoHUphqwCaxP2ARyBEZA0AaNEdXN7Pt+sPnh5wsmP9z25dajEFNWrXE+qVBOmGytooDWNdLWU8qmpTpNxQdMBSijAbBnlJNV18vLZvyx/nhurXqwa7ICdlGUirVJI9ltJ7dCD/uWpO0nUxHke0pJilL0x+gCECA6unPWG4trjEMt2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 18:10:51.2967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ef72a8-89f5-403d-3815-08de673d64c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

From: Vidya Sagar <vidyas@nvidia.com>

Tegra supports PCIe core clock monitoring for any rate changes that may be
happening because of the link speed changes. This is useful in tracking
any changes in the core clock that are not initiated by the software.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
V5:
* Fixed review comments

V4:
* None

V3:
* None

V2:
* None

 .../devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml    | 6 +++++-
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml       | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 6d6052a2748f..7805757f2e2d 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -55,12 +55,16 @@ properties:
       - const: intr
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: core clock
+      - description: monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index fe81d52c7277..41041ae7e0a4 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -58,12 +58,16 @@ properties:
       - const: msi
 
   clocks:
+    minItems: 1
     items:
-      - description: module clock
+      - description: core clock
+      - description: monitor clock
 
   clock-names:
+    minItems: 1
     items:
       - const: core
+      - const: core_m
 
   resets:
     items:
-- 
2.34.1

