Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59733A3825;
	Tue, 24 Mar 2026 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379372; cv=fail; b=qaeniQNNh/Vu2R32vJTiYXeQ1J8GXLVk0eQBY1ELVxAYGUfC0WmbjaO0RDAslOmTuxvewzSSMyFvz1u+tVbJJE+ydGrVS2gSkrDNOZ0lFzXMW5SeyQeeSJy0yUahG4k2+I/DPaI6XN+VmZmUlDfKK6tgge+Iaj7legIWhqlzYPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379372; c=relaxed/simple;
	bh=nySaP5Tnfdm09M91/Zv2FKvaVpq0zHCUnoIdB3t5EVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly2RIHARYz5oiqAIUfjL7FudRPo/NUbCmuU7+GB3EO1JTKahO4H3JOrU8nKeRH+J2oiF5Ub15AthQePHN2pTjq+nINZY/GDPjZVW7kMpy65213WT5VGb2xERKa8flRxLnCfy0BVO5FdVVZolkgMwT38URLgssvYAM48Kypgr19I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJNR6jJr; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJNR6jJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjALOzZzunjvp3MgfixJoYiI1Xb96+9p+7LiHN+EV70mVB9pA6TzwR4HS8HPnCGF+/seiskC0Uph0vvrJZh8Ss4FnzRCzweEOiZICcPjAuyam/xwWWCXjbgw0CfVQsJCe7kPz+Tn+zqs4ZfrS/KwMrGcoTk0QqkAxsG/PZxCHCO2PW+QR6KtHBZDAVwcZITctBpgiXv/kn7dXRZUh1CE+ScZlB2y0KhcWqtJZlaMgSSFOKrNaVKYytNNr/a4+/XALI56ouaz1CJ4/wJd+VwjeBtFreUHhjT0JElq1BY1aq5ajRxU9qEd6H0Ot5+spWrT49AKC9eMamSZI+/nMKocnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvljGlMkahkbLxGMs+4rzA3V7sFmK7JJRaDlLLVXufM=;
 b=e6QEppeiWe5b+Dwa79EaGurpdjZQnA8/ouxYgjI8WnyBRmwKF1WygbrGqLL4XgwsMKOkSwoXil2hvUT09DB8VoCr6vSB5BFq/JIUqrdLkkpw6KUmSW0O8hglS0I1Y/HzsRVtSCux4lKZ7jYTSH32c9R16Evl3RymSMCYVhk8ziSagGGuRi/9MRxUdhn4PHZREZo+ueymNPmU0v8to07viwjvWpPyXb4mm7pqLADkaB7Fla0iOVSzycbbLYj+aTifSpweZv6F9BlAFswyf/yUc55qhyyrKPWoh5nJ/i6hO3joHLMnZh4pozoz3kuo0rgcqA25n4UoVsRiGlh8qq4h/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvljGlMkahkbLxGMs+4rzA3V7sFmK7JJRaDlLLVXufM=;
 b=pJNR6jJrKs6rp5BW0zxi2XBG9tUin0Fg9oYxnI05dPC/lRrcN/MTCK/KZIahhFF81tX/HqlG1JEMN8hSUViNg8TbCdKqX50eoLiyfjN3cgxTJyDU8tNY9wgHXcHQOgw1pwknLnIKQwnw4yfN4V+mk4PpFa/HPYu2TSp0EE37eCJ4tyzwC1jZmvsmfYMYBE17xyswWgxdrKByvCufgGU31f1PsdFdR8cBiJVoyDzNO/d9vzjBEzgj1pM2Cnijk2iNe73DPX/+msUgbTk52wb/XIPiNgnQhuodqnsiocXCb/QJRDaMnn89GFEuLoS1w5NCuw076mVGp4+rZMpc+rB+sg==
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 19:09:20 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::72) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 19:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 19:09:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 12:08:59 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 24 Mar 2026 12:08:53 -0700
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
Subject: [PATCH v8 07/14] PCI: tegra194: Disable direct speed change for Endpoint
Date: Wed, 25 Mar 2026 00:37:48 +0530
Message-ID: <20260324190755.1094879-8-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a0cedc-5aa4-48bd-a1d3-08de89d8da66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Xs3tKcKMwUXaBHDUmM8riI76Q8nq0bZczRwCrYieUnPz2qopN/CUfY7TZGw9fWdxFaaKWQmRkPcifip8pX0VwQdmiPaHl+ipvfciqsEO4eQdFTlQokd/RrxPkAUjbVA99l/E+OTTfPYwvDNA4/XSCW85r1GBLd9VrG9WXHOYESsaUeWPGkoSIT0rj/y+3+0kiSNXxvFvVFcEI9H9PqfB3oMk04/qoDoOgz3yEXt8JICGePTq0uAhEN112OyysKfquuAH7su+TnAwrYtuRtC5Jijmwwukrz2NTbOAVm5WzDqm+QYu54BPI24PGhjlwCK3suMs42drP1bKg0YgvI+8o3UGuN+NmUGQWgDuMsW/CXV3vCpiLQsXHprSBTANdj/9VIzzysFoAIbyDU7IepIcZtduWv22CTJlcrQ6hP5OspFH37pIMhL4vT7+j2eN80BD8ln1ZzntFGeA/sVHGViDYzAbXJg0T/klDY0O8X7w0kFRY5pagplxeVwlOJKESKsNCmugfxF3KtcwQDT7Qg1akRtJ5VNzx7naBWD9ovaptvLfDHi/5F1U5It8jZWMd+6jjhnunDGlu46MMC6r6wDjcUv6f31RxJ9QXtT7h7TjonFD6VMgjJDaAQ/pzF8HcjAwtGph0MTsAcqRoCUtyjWKrkIUBdMeD+aUAr2P8PsQ0fuMiogvk4NB+6GPDxMJhZj0AK7MONeUz5F9ua6rSNqlQGFw8UeOkA+9Age4F/N20s5kP20Z2OLL4iGEsmiafu4lPFZXH61y8k+JbdsBmCj/agmVFwWWCN4TIwHuhw/fd84WMWVOCo1rquayx1YKBe0B
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nBIrYOD+3CoWPr+QhhmItjCB8KURzYjrE0TdPIwJLZzJQ7wsWmNyzLAZWduTfhrpJgL2E3vo2MAWwImLK9s/3M7iDvDxCS/s9VfhebGqrpPnKqosj8+aQeAOeOWws/hOClwJwIZ2LfObRrWtZBS+m3albc5uZAHQR45LdE0rs84MxPJoC4jovJxY1/prfIisUhderndQiGyG6VN2YogbwDRORxMIqtEZlxMdoJD9E9UYPN72q19q9Zqes722mqrx0+pDniceAT9w2PqhRuRTI88j23uA6S+tfDChTw3njp7FYav6DvalAHXlmNSnhS9f3c4ENwjtIa5FiewPw3SPUmNCjVMzuW/97pCyRpuqTv57GENbepr/VfqPWYJ2N/J10rGmb9jYiIB5R2JMaLwYfQi3eOEDV02rjJpJndnYaI7TJvvX7UA9/s5QDqWa+eQR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 19:09:20.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a0cedc-5aa4-48bd-a1d3-08de89d8da66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

From: Vidya Sagar <vidyas@nvidia.com>

Pre-silicon simulation showed the Endpoint initiating speed change after
secondary bus reset; the HW team recommended disabling this feature in the
Endpoint. Disable direct speed change for the Endpoint so it does not
initiate speed change after physical layer link up at gen1, leaving speed
change ownership with the host.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V8: Fix commit mesaage
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index e0b17ad3052d..0be701e58238 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1805,6 +1805,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+
 	if (pcie->update_fc_fixup) {
 		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
 		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-- 
2.34.1

