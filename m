Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618934;
	b=FVznXmAVMinCbiY4X/Ru5VLjaQ9BFp4LTLeQk/a0nuzYcpDT6wQJItw3/3gOd4FncbcP
	 6x4kjJJHpbJnSx7GvUm2u5ZajJo9H4lmwsJrGji7UqStbV5Z4IwiB3ZoGMo33rxXVblON
	 e4odRDDs46/EjSGa9vhovSjdfW55y6Rnas5WIJB/Rdpd4L/OsbBnd15BQQZy8qpYyFBeM
	 aR41Y8mm79ieRRKY7fB0vX4E/x0yYWDmlL4gcKPCYfzehhya/J8nOrbtM7wg/FuPPer8c
	 jx7SYccvGoZy866VL7ItKvmhV5qV5R9/ela5lcParbWHe3k3BH7V3rVzsl7V1Svdwzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618934;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZppGsGKlNwD7OXBjy1/Lu2Ax9rFM6iy+73aA0KRV9bs=;
	b=rRmlS+v6JJ8ZDlwPHm4yhJsvJaZMGSkNMSaRajzva5rKt7GeQlSIA9wR6/CF9K/Ktt5w
	 3KROLxy/eQLmpV0CyA3woD1TPb6WG2DW7QUPO896S/6EImvUesQJGAX19mD5lX6NEXo7e
	 Wyju6X4j1VoocK0Z/8TtRyrhM8x7AdCpNjGmawNF70o2IGU+DM0SPveJy7kTZfIE14dMe
	 Jwe1DIf2xWEOBjnb42+urnCRNkgWIc2TH4kvMNRbVuKR3F/+gPF4PxvKzflzpO+sdGdpr
	 l1S2E2l2h0ocGok5g3D5EQ5EzIQtXZ+i/TIioe0AfnGfO97b9t1TOjn2tKJlG9nZHFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPI4Q1GH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.41
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062F60A383A;
	Mon,  2 Nov 2026 11:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8062F60A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BPI4Q1GH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmbEgE5EPITJDwommlY+CTv4XIElcorrz6/te7EfoWQDVUUjEFC1PlTIDrQ5AMuQKMN9xC9t6PLeiO3Td2euGsDa0sb8xpWQNVVcxG5waidTpf7DwekL+Z9DHPNKmofSBYN+yO7JdOIyXXF5BLkiT61SVtTvLZYzgKWYSga6LHeARrTajJClwM3Dae3oimfJi9F8OUgWN8SSSBvax3+xZgRPDq5HD1rDbXiDyXdWQTQODMcR9ByV1Fa9bMtXq7S+Iw7cpJK024hsdmGKpnmZxuhYHklaGR6T+6NlIEG2hr2pJTpxpyEnKBBONoh/NCJ3WSOi2fnonGflF4QM+l+kYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZppGsGKlNwD7OXBjy1/Lu2Ax9rFM6iy+73aA0KRV9bs=;
 b=SAjdB6VYCrYqQfBy/dOPgoTaUIBb9mzonDSx0Zjgng/nXR9znCoQRZ1Cwt0/484bKIwKT6TgHSNy/HTZZXcGM4jPc8TD6QfxTR1jSDqnEmrukg5mO6+C3JWvjLDTTGTe+6f3vjkwa2FONBRdnPj4YLwYuX2nTRk6vz8jfPgU6nxmlX/RL442P2UMOYxmISt7Z9cB04QObXnDqNNDTIvwRajG4E42HV78AJHY0tDxL+Pm3sy5cB+1UJQr8ls6AbPbjoF5UspJgUe3SkrWpOFDRjc+2lFn/toycum9EoZt54M9jtO1sEfN5nk74Y0xiPwQtHZLBb1TVg5xxLCfsnrzSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZppGsGKlNwD7OXBjy1/Lu2Ax9rFM6iy+73aA0KRV9bs=;
 b=BPI4Q1GHwJZ1zPAGa3PDnCa1A4Ch+YLGs2GBk5h2jEGcs34PX0yhbn43TUIrzM2AFBoE0yA8cNAeqCql8kt4ZCho7mYTHotggu9NEuFwW0JCPWa61qomMOEAysuhdzCJ5hM2GGlvwOVc2OI0kh7QR5AbbKm8ZQga14ollmlMIvqA6ErgIwyepHrqG+CCs9F4nxR3TodqfCwFDIw1GOd2MkEBR3PDEVfVEmI6xmx3PK+9JVmg1o9OXwYzz2YPo/eFJxoybewSOiI3QekBw+wet/yqDdpMTBZfLOArhaRrHdVfN8l6l3AKakldDW0VanG2Eef2DjZ7idUGDY7lp7ISMA==
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 11:28:49 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::56) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 11:28:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 11:28:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 03:28:35 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 03:28:29 -0800
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <robh@kernel.org>, <thierry.reding@kernel.org>, <jonathanh@nvidia.com>,
	<kishon@kernel.org>, <Frank.Li@kernel.org>, <vidyas@nvidia.com>,
	<cassel@kernel.org>, <den@valinux.co.jp>, <marco.crivellari@suse.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mmaddireddy@nvidia.com>, Frank Li
	<Frank.Li@nxp.com>
Subject: [PATCH v3 10/10] PCI: tegra194: Reject zero MSI interrupt number
Date: Mon, 2 Nov 2026 16:57:19 +0530
Message-ID: <20261102112719.4022633-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
References: <20261102112719.4022633-1-mmaddireddy@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ab31f3-e0bf-441a-1ed3-08df38d47776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261028144727099003|261021123027099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uzOehV7xnqsFcvaqxPsW/3whxoTRRE/Z2taBjjQCo2sRcDDvZdh6ULDd71v6vooxv1fcli6fVHdMl5UhKpvk87S1UDp5s8SuqQWA4EdLu6RgqeayYkhe/hoFaiQ7nfK4wbhaaWKkmPkeWbe0d0u3lEpeBFCwcUKseoSyUclmov4fN7hedDPqRJFLmMLaykndoqhgRwQ1nh7/sDQFcaIWQ4RuwKCFyfbcumtAnLbQ0qcuu7JuWFi1Rz18ogywvKMMLBxQ36ixaetei11amiTR/BGOjw5ZD28qtk3k1q0EDLlXT2607f8Ts0Yap+33cWHg9OlmX+7dmiYUgDjoOyUdxdpq5RzVgFDk5BFJjmwE2Kktz9prU1zpnCrqNc8pmeumMjVaG4nkov668YwiAVk/VbplT5OlHzTdfA9pQpnyLcKJ6E2p6JmCP9h7cMEoBRVOuo8xoQa09muQ84wscmGw0Vsyrr1jLVRP3GO6M8hfT5fOwikI3H2o0PJ+N53gs8nK3dRMEG3hDBcLsB1k4JAmRPIpC9IzBpVqcaW73tg7kNimObonJ2ir4funij+vgBAJT/inCyX0PYnr2lqpFHk+lUXaRGY19TDpaAzecbckv0euEyqyFn+i0Ef+xy2HVz3frtzHNqmQDpPTIrVJ26h0m9WRB/fMgahy1oDGbQtsYp8AZ1PW7HXncB/JuFPVIGQHSNO0Z/SEEw93KQgK2nbWTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8RB1Qwaqr1L1BgrBrRBe+Llde9RWtej8d8QMVgirCbNbo232VkyW71er720u0GCqdq5bsv+yxSOMlutc246xTJ1Aii46MX9vx6uXAEBsN7WU92EgIfMHtSlAnRPWSq+2pUrl0ssRSl/ZgF/9iOY8qlhLyjz7KXSkfGRHM6zXcrW4/yAla6Slmc+xUgbP93qonj4rTo/1Xxa98nwlg5cJ7KNfwnWw2w0LvlmxkWeg5ICkHDK9SsK1l3CttVGXzyb+/itHaNoPtd5hGKH7duRLSqtUAEjpZzkEYnzQMCNCop+8mNbNLoUwLbBW5yMUc3Oe65q5U+iQchlGIpdjWHyJzLtQr/pLjyISRGyEDmn6SABPFb6VSMWn6kd29VPceVNxB0jkYCMl8yJIXX2BSxdKZ2aEh3SoOCfrqa1q4552LxX7wk6BLhmGzwJIDRp+Wrei
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:28:49.6705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab31f3-e0bf-441a-1ed3-08df38d47776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646

Reject interrupt number zero before computing BIT(irq - 1). The endpoint
IRQ API uses interrupt numbers in the range 1-N, and existing EPF drivers
already follow that convention. This is defensive validation rather than
a correction to the MSI numbering used by those drivers.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes V2 -> V3: None apart from rebasing.

Changes V1 -> V2:
- Retain only MSI interrupt-number-zero validation from v1 patch 10.
- Rewrite the title and commit message around defensive MSI validation,
  and remove the Fixes tag.

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 981cff740cd2..72158fc5c639 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2021,7 +2021,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	if (unlikely(irq > 32))
+	if (unlikely(!irq || irq > 32))
 		return -EINVAL;
 
 	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
-- 
2.34.1

