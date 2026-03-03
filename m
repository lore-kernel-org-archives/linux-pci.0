Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DCF347510;
	Tue,  3 Mar 2026 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521137; cv=fail; b=eforQjfHLG8kaMdsJBees9YExoFfOV/a89BdxM1841B4BeW3Pf2zwbe/sRYYS05sAYaz1j42mRA8sRAjlWusBq9D5mi3f5IOWU96mlOBWzMGU5t+AeVKCFlaBv3YDDx7cEux49QQ/eWQNTUHydG2E4R4wTrww1d9QzrjyW8HrVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521137; c=relaxed/simple;
	bh=a/bo7uIRmBu6kC7BrauZ4cNKugRcINQmKjLD5pcdh1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THW2dHXQB8nksfvYB1o2SfoQEdh0YGtK+Ko013UU3XYj89QDukBzXlfYRyK2yRrgztORqDRUX5zXHrJVY3JqBqClkO8tb8Lk/7yEoeadyyzBMaRytUOdhhfxGidfHWw6upDe0RWqlDJqVIPfor3tQUMGKAiBwaC/jZeMTLIM5to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E618Xzs4; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E618Xzs4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W18kvf/vJKzIAhg6r4vKpFb8NSQT5S22RZj49mRXhHmpzWM/riLJn0tAM+lsBDRBPqAdV6dCfbYYXmgDP0dCVO9xOPHKXPxXJI8zWzbU8wxNaHfp8H9/Owf7czqAgus82YGpHQaoFFRPCha/rmRSSxCSnAvpnSelz5sompnPwn1UiupZ1hB0ifbQRgQ2aczHwfHdi7l/7mAeMLI1L1x6Bn85Amu7SVIfiT01BEgRqKFEqHVk9HN/fm8n5Hf5I9EN0RvlIQfNfmHTYVYsts31Tb4IHqHrd6y3awifS41lWpES3/AUaXaECC2VrcCLow4rAXXGlpt402O8/UCtSQJygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp2Ud3KS6lSraZUauoaT1QYHpjHxDbiDPfE09TpmiPY=;
 b=y9gwjC1mcBMdelqj+IB9zbCiRgay72232tbatIsHNOJp5Pif0MZ0nE93oBDWS6PeOFs+r1wJ01TuD9PNBLQF8n64FSJ1+JzXt01bCTB3fDw6TNzTzmE7bbaRGCXAGtN3naIg9OGkho1kZvnzc4Ro8DbJO5P0x4kTEvCZYIi4w+RKk10RCEGg4oMWIy3sxplKGLPpaa4s28l/V/cunbMizZt16ncy4YXko814ydQMuN4w2kLj83xdUPNG2v8/EMZt5laHyok6yNXVY99reNQT60WJ/6D6uqMLRXLTjlJpXqFekkpfPEg3JKT/3CKJ1cfEI7fN2TvaQLWPyVmAnO0WKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp2Ud3KS6lSraZUauoaT1QYHpjHxDbiDPfE09TpmiPY=;
 b=E618Xzs41TQzUzwFF+q7k0zUbm1vAGM0i1rNSzzfufQicTAWbUKxMf+8rj5oRoST2hkJj//4jodBKlxX/Um5RFfVXFHNUfhbaL3ISi/ZDi7h0pzLxEAVerypfey6b/5kKG9RNm0F51HwJAHDtAn9Pi3q7bFGJzz1u3YTzoX7Mo9eppaM3aW+HcyMDE5MCW5IcMFb9zvgBI37ccQfbYIEU4m0bCZtYj0sbO8AEAu5Mna7u3f8ZbHxHcwr3OmpoiWg3kMYaktDuFhqWWu6R8/b202FGNbvPL8LgXE4O4laVjObsP3wRvfvitDEfLafNR5GUEK+G/6sXF5djFPsQL27IQ==
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Tue, 3 Mar
 2026 06:58:46 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::d6) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 06:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:58:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:58:32 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:58:25 -0800
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
Subject: [PATCH v7 2/9] PCI: tegra194: Calibrate P2U for Endpoint mode
Date: Tue, 3 Mar 2026 12:27:51 +0530
Message-ID: <20260303065758.2364340-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8336b0-3547-4c6c-3468-08de78f250d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	RTtGsERi3qfVeoxPOtDj/fkNbvRGRUPgFoOx/loCLeNlTuUpXO1MsKGQSxTk09W/QDFj+sY+lCp08dhivYv0VSFd3dllHjYIUX1Rsk4sKzcoogH7qDLr9iWLRal1TvAlkhiU9/lM7vnTXqqJibLg4vUZLYDMPiDO7kTlDMr/u25AlXv23td01sNKLwtv/6WZzrlMpR74qBOVL5pXkdDEDbs5QHI99qIsqconHaxn/jQcXUze+8P76DkbkldEqKsIgfVz65YNCvNp6qwoh1YlT5p9ENUK1tCNj1AMH+/ApU/75jSrwr85Mb0t6Aw0DFYG9GzT2KFBtbBZDjC0tjaIkCIv061RGyyf2giJ0YIjnQewVJxFpcSOTHCG01GkPZaUcQEy9cso3GctASJzHAHCHI9ontgBmGH62QbJeqczkcpXtVqCd+O8Wj9o8zKy9xQAqJpjLyYAphGPgIteOqe7ee8mrvAPmw9opN6m4dWlLArZE1w1R9jt376migmZppYgdIkhweRBDaafM97AZJkqonCUqWVWJJydBdjHD8WK3xCUTPJlTgM3lx8SpJebrvRx9H6glyRLDqDgcSukOa1OrhC43thRRNYPNEILFfzwMZJgn4syKHN9/SPhRfZyHkqfoP3AoQk3rhEpdUDIrz8UtCk096q2s/2K9SYpMrVOaVW/wlsBYYphN7oQSfo+CpxhQI4EDW/mv0dU6FQHTgXhisYPzpvFcgh1XD+vlLVA2JNpAsSn0m+Qvrijli8QCQVMgHKkLPaGZ/hF+u/mt3aY2Keeg28aFNzrgO5suP184apLLdzuNUVoymLB55HRnTFxxXt3OXg7OLIi0aHCVR8IJQSn8Hivv+vVwNMQqNaD3k8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o7SzXODrLzENguE/BCGzpC6G6eJ6AocS60qAJq5uPMjLQGeWyJ3PiSHUwNzRvqFmGx4UotVhKdGMEPIw9lnETS/K7Q/ZKL7cD8gsUYf7rle/QKUkHKXHoTQQvnWyKESQn9Z2/8+19akwNc5L9aRPC7nqo3gMZS85a2HqeYv2kfybNDhTGFJXJCbQHnnOW2V61YzjVmu5FW/CUZx53rSFM4ZckXZYTN8iVOGH/AuaR6uaGe1fpF78iuFXplCgAlzWV2DATLZwxWB2wQbXdWUzhlz110B2TOXdjOrp5XdXV3E9fbkfwDnRHMMBkypksq2M6Ip0G/3/WLk5D3NnHrXd5M62JcRopTkivu/gAW+foVx8/2eYRFzgUbkIOKnANRwhtIiW76M7eydpIG9n/jXtupYJ30cjGou1POIK9irKD0jRbgtACxDYIZR9VHkaCDRX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:58:46.5178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8336b0-3547-4c6c-3468-08de78f250d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900

From: Vidya Sagar <vidyas@nvidia.com>

Calibrate P2U for Endpoint controller to request UPHY PLL rate change to
Gen1 during initialization. This helps to reset stale PLL state from the
previous bad link state.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2f1f882fc737..980988b7499c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1054,6 +1054,9 @@ static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
 		ret = phy_power_on(pcie->phys[i]);
 		if (ret < 0)
 			goto phy_exit;
+
+		if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+			phy_calibrate(pcie->phys[i]);
 	}
 
 	return 0;
-- 
2.34.1

