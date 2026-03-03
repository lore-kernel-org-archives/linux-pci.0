Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97132D0DE;
	Tue,  3 Mar 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521006; cv=fail; b=dCgkdxGYAPg8lQZks31knezap+2vzbwxMpboRCxRifyquMr5UQAuDUisigAHNWjK45zwpdu5eHpwt5oHLfacBPAsTEp/HAg/JPhjsgXg+96S5ey4BiCFxR8FtGh8BxRXOEed1KQESfPIcdyXDw9y64/3AY1MFyTtahklb160xp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521006; c=relaxed/simple;
	bh=3OB7UB44JPaV6BYkpKzfld8Hs7QAfyG+nirRP2zcSzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjbbyFauA2phqm9QrWDBtaKQC5eKnTqLAatsyPck2eBVkx0O9OcyAub43+ugOZutKq54GhVko4tvxDftZMWEhUGqcE24KoSRa5qC+Q81esJ6ONlIC/uP30FeeD0MmHurAgMY1Uv6wqIRec0YMF+0xH0zVNPF8y5YY37OWo4SCfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlRiOIVM; arc=fail smtp.client-ip=40.107.200.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlRiOIVM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va9neVM1twkMlkh4acszJ7F6ZSvhQ5frZYVsleB04V/aGMJvL3t8aJgmRzc+fTTbDoUL/cH2QWvjOdpnkwHuKE0kQNNk1YmZh67mpK/yNtQF/qdQMHY7F/m28r7xe1p4nO4yNZPkh2QMNmt2pGFQVS7TaIGnHl2RZQOvBbS8myR+jFPmK5EeOe6W/bYClosPmAr0lK7PPhVEc2vDONcKk/sppNSoq9J7HFBflZ517VweAtFHy2gjqAj4NzoEtomiGXZMIbvZ8Y+S1dQEcQEVYTGOQPgVWSVzV3NWLZxgmpa+3+WQua4dazKGwdJFu31mwZT3qCYZiQmhCGGfSoYjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8YBOj0tLHn0ILffjS80mzSaWoughxh1QP/DIPl2dvY=;
 b=OyB7w3Z2zQbbl7KOdm08IiC12AOIggAYWz6CN7r1hj457e4y/rMLV+0Nw7n02UOzmKEJp7cQBROB/zNsMQrKezncRTwTIKzFczYXlcdpOO8rRWUm8knuC8H7+dRRemciTLnZCd/YEqToc2tHcIiGNQK8a3n+qdWx8Ubz5nPMjq7G3MVc2LlnevktT+3bV13GPAdVFZ+WsRIOjyBS+jMvzLkrR8YMUvqx3d5SSEkHxAULUw1ppzIcww1mtv3rGDAL3+8TJpVTMJPGOMGyCnkbPPfkmm5qf3+IslKEAAC3kaqBY5kok++tqsmJa+xthVFc3Xo8QvRZZd/xBbs6TfgBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8YBOj0tLHn0ILffjS80mzSaWoughxh1QP/DIPl2dvY=;
 b=SlRiOIVMO0hMKzstePxg1dS8VzPL+3XwTQH2ehMxcvwvCAAalaBthDGXMUt4rwtqWstYkND/FVCjJO0UIFkVuvP7J2WuzCj14aXTC651gKj1UumtxQKsNbWnA65ojUN2BlPH/QW9f7C4PWFlQ7P16bTnyZY271c+xb49sOZ5kG495uSYTXZzlvoaXpUnSvbXdV7Dg0zS2QYcjTEc1vB8JvQtmq2K6ytifKTtQod9fsQJJgyLZt3b1E/nWYYH60hBRpHlqsEyJ8k3guJcbdg3tu7vIgFksX8NugWCq/HKjO3Chfycz2Ln5h9LMBn909xQxBHsuCG01AJBSx/7ocUZuw==
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:56:41 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::4) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 06:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 06:56:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 22:56:25 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Mar 2026 22:56:18 -0800
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
Subject: [PATCH v7 10/13] PCI: tegra194: Free up EP resources during remove()
Date: Tue, 3 Mar 2026 12:24:45 +0530
Message-ID: <20260303065448.2361488-11-mmaddireddy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: afdfcbd6-bbb3-4778-c958-08de78f205fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	7ATGtmlN4Nej6ghIFiqtkGqw7/4CkDuLKUVCJ/GvXnUYhAkOzUirUHNcYfeDTe7zqrdTQC3L6+vr6YGxlYzHMfpBvRmDyHEwDu7pPPI/8Rm4v0Sh8rl4HrX3XGFyZq/aBBpfiqIz/rMeElZZZw/mxl4zJtgA5XECHS8I8fBTJyOXFcEIqpSsuulhE3eeuru6VOvFCyOD9b1HqM3KmyJEzbPEoIybHEMeLvlOnt4wltcPnw0ZohH9p04gdEm1N285R6h0lSr8Mw7d9IZE6A98aCUFkX/vqTExr92wAp7jlAxSe8yO2YdREACJGyoUIZ52nO7SD9kgUIDVpHL0JapQ8tct3m0tbKsW2HDmUWUCpoyNu35bsBL8Y7ZiyeVKj4kHrFnEitSFbSr76bM6cqKzOfni188Cmq6HiIrZskby8CDTONcPCWupYqrmRG5bwhMAyDpiJ3Ud4m6vXqI9mayGfr6IoO2LEkOUuoJOqzRnnAgLWwJmXU4h4aOXo+vODdDEYl+wpcbPVhDoc7tWcecvPDrSHHaFBe6BJCG0iPUQKDYx0LLiFiiPYFKlqfyrWYNyJBM9lDIYlISCGxKSnJpXGRfD1ZO7rEcmemjP2fIYoKJjInzjRzbMYrFjgQA4tEj6iwGgBJPPo9iMg/M7fGaFOpBmtpTuau2sfGhe+obQwwMf769xPPiZ72DLi8gdqbNmUvfZp0bsC1xa2skrjDsD/boK0x5WBbyqG2S/IITYeVMargTkvyGWe9MEnr42Hhk1MAyNzMKiqD2p1IGPnkleSIDKDvpna5EylAkTBWy0/5YaTM2UPhHKSkHQZhXc8v+V+vSVuhC9eqUJFmCclwHufQJcUGs0ry1QjnmNEW2OWMc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z63SR4YoWzQpzNLybrEu8qmP+EUAtmgwrSmdKGb4NssboBwYU/qkwPYeLZksMwp22k5UIBL1RIZYmyaTBpAxg2E/34p4zGl79TEJJCPBHchf5O/b9tI6YwrRklEtLjnwcaJ2uFVtFEzQT2BsKTEbIpwPJ3GD9N90MoTn9koG5wW9iYy3FiBZBNe2Y4VBFjSZ6Dp0ixKgrbMGeo3nFLgrgWv/gxhnbKZyp9LYL4FqAV99FvzDyt+EYxwoTqdHdO8exVw8yeqbsDFxTetWM1asjQcYkuUTmUuhKL0Uv8zfX+u+AYcVrf75M+GLOr2xxSvE6Jfvv7UQZtgMceky2fh6lzve++mmFFvySq7/S3BzdmMRrhxA1de4k3Kn1LDH0G8vWPVQvmvmW67uFL59xBnm0A9/AyO1N4EjXsEBLPdh1zlsBlR/HM8gavASTPX0Z24E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:56:40.8891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdfcbd6-bbb3-4778-c958-08de78f205fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663

From: Vidya Sagar <vidyas@nvidia.com>

Free up the resources during remove() that were acquired by the DesignWare
driver for the Endpoint mode during probe().

Fixes: bb617cbd8151 ("PCI: tegra194: Clean up the exit path for Endpoint mode")
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
Changes V1 -> V7: None

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b2794be35cfe..1963165967b9 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2248,6 +2248,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie_ep *ep = &pcie->pci.ep;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2259,6 +2260,7 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 	} else {
 		disable_irq(pcie->pex_rst_irq);
 		pex_ep_event_pex_rst_assert(pcie);
+		dw_pcie_ep_deinit(ep);
 	}
 
 	pm_runtime_disable(pcie->dev);
-- 
2.34.1

